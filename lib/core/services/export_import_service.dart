import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/lexicon_collection.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';
import 'database_service.dart';

const int kExportImportComputeThresholdBytes = 64 * 1024;

enum ExportFormat { json, csv }

class ExportPackage {
  final ExportFormat format;
  final String fileName;
  final String mimeType;
  final String content;

  const ExportPackage({
    required this.format,
    required this.fileName,
    required this.mimeType,
    required this.content,
  });
}

class ImportDuplicateMatch {
  final LexiconEntry incomingEntry;
  final LexiconEntry existingEntry;

  const ImportDuplicateMatch({
    required this.incomingEntry,
    required this.existingEntry,
  });
}

class ImportPreviewData {
  final String fileName;
  final ExportFormat format;
  final List<LexiconCollection> collections;
  final List<LexiconEntry> entries;
  final List<ImportDuplicateMatch> duplicates;
  final String rawContent;

  const ImportPreviewData({
    required this.fileName,
    required this.format,
    required this.collections,
    required this.entries,
    required this.duplicates,
    required this.rawContent,
  });

  int get totalEntries => entries.length;
  int get totalCollections => collections.length;
  int get duplicateCount => duplicates.length;
}

class ImportPreviewResult {
  final ImportPreviewData previewData;
  final ImportResult result;

  const ImportPreviewResult({required this.previewData, required this.result});
}

class InvalidImportFormatException implements Exception {
  final String message;

  const InvalidImportFormatException(this.message);

  @override
  String toString() => message;
}

Future<String> _encodeExportJson(Map<String, Object?> payload) async {
  return jsonEncode(payload);
}

Future<String> _encodeExportCsv(Map<String, Object?> payload) async {
  final rows = payload['rows'] as List<List<dynamic>>;
  return Csv().encoder.convert(rows);
}

Future<Map<String, Object?>> _parseImportJson(String content) async {
  final decoded = jsonDecode(content);
  if (decoded is! Map<String, dynamic>) {
    throw const InvalidImportFormatException(
      'Invalid JSON file format selected.',
    );
  }
  return decoded;
}

Future<List<List<dynamic>>> _parseImportCsv(String content) async {
  return Csv().decode(content);
}

class ExportImportService {
  ExportImportService({required DatabaseService databaseService})
    : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<ExportPackage> exportAll(ExportFormat format) async {
    final entries = _databaseService.getEntries();
    final collections = _databaseService.getCollections();

    switch (format) {
      case ExportFormat.json:
        final payload = <String, Object?>{
          'version': 1,
          'exportedAt': DateTime.now().toUtc().toIso8601String(),
          'collections': collections.map(_collectionToJson).toList(),
          'entries': entries.map(_entryToJson).toList(),
        };
        final content = await _maybeComputeJson(payload);
        return ExportPackage(
          format: format,
          fileName:
              'my_lexicon_export_${DateTime.now().millisecondsSinceEpoch}.json',
          mimeType: 'application/json',
          content: content,
        );
      case ExportFormat.csv:
        final rows = <List<dynamic>>[
          <dynamic>[
            'id',
            'term',
            'definition',
            'type',
            'tags',
            'examples',
            'collectionName',
            'isFavorite',
          ],
          ...entries.map((entry) => _entryToCsvRow(entry, collections)),
        ];
        final content = await _maybeComputeCsv({'rows': rows});
        return ExportPackage(
          format: format,
          fileName:
              'my_lexicon_export_${DateTime.now().millisecondsSinceEpoch}.csv',
          mimeType: 'text/csv',
          content: content,
        );
    }
  }

  Future<File> writeExportToTempFile(
    ExportPackage exportPackage, {
    Directory? overrideDirectory,
  }) async {
    Directory directory;
    if (overrideDirectory != null) {
      directory = overrideDirectory;
    } else {
      try {
        directory = await getTemporaryDirectory();
      } catch (_) {
        directory = Directory.systemTemp;
      }
    }
    final file = File(p.join(directory.path, exportPackage.fileName));
    await file.writeAsString(exportPackage.content);
    return file;
  }

  Future<ImportPreviewData> analyzeImportFile(File file) async {
    final content = await file.readAsString();
    final format = _inferFormat(file.path, content);
    return _parsePreview(format, file.path, content);
  }

  Future<ImportPreviewResult> importPreview(
    ImportPreviewData previewData,
    ImportConflictStrategy strategy,
  ) async {
    for (final collection in previewData.collections) {
      await _databaseService.saveCollection(collection);
    }
    final result = await _databaseService.importEntries(
      previewData.entries,
      strategy: strategy,
    );
    return ImportPreviewResult(previewData: previewData, result: result);
  }

  Future<String> _maybeComputeJson(Map<String, Object?> payload) async {
    final sizeEstimate = _estimateSize(payload);
    if (sizeEstimate > kExportImportComputeThresholdBytes) {
      return compute(_encodeExportJson, payload);
    }
    return jsonEncode(payload);
  }

  Future<String> _maybeComputeCsv(Map<String, Object?> payload) async {
    final sizeEstimate = _estimateSize(payload);
    if (sizeEstimate > kExportImportComputeThresholdBytes) {
      return compute(_encodeExportCsv, payload);
    }
    final rows = payload['rows'] as List<List<dynamic>>;
    return Csv().encoder.convert(rows);
  }

  int _estimateSize(Map<String, Object?> payload) {
    return utf8.encode(jsonEncode(payload)).length;
  }

  Future<ImportPreviewData> _parsePreview(
    ExportFormat format,
    String filePath,
    String content,
  ) async {
    final parsed = await _parseWithThreshold(format, content);
    switch (format) {
      case ExportFormat.json:
        return _buildJsonPreview(
          filePath,
          parsed as Map<String, dynamic>,
          content,
        );
      case ExportFormat.csv:
        return _buildCsvPreview(
          filePath,
          parsed as List<List<dynamic>>,
          content,
        );
    }
  }

  Future<Object> _parseWithThreshold(
    ExportFormat format,
    String content,
  ) async {
    if (utf8.encode(content).length > kExportImportComputeThresholdBytes) {
      switch (format) {
        case ExportFormat.json:
          return compute(_parseImportJson, content);
        case ExportFormat.csv:
          return compute(_parseImportCsv, content);
      }
    }

    switch (format) {
      case ExportFormat.json:
        return jsonDecode(content) as Map<String, dynamic>;
      case ExportFormat.csv:
        return Csv().decode(content);
    }
  }

  ImportPreviewData _buildJsonPreview(
    String filePath,
    Map<String, dynamic> parsed,
    String rawContent,
  ) {
    if (parsed['entries'] is! List) {
      throw const InvalidImportFormatException(
        'Invalid JSON file format selected. Missing entries list.',
      );
    }

    final collections = (parsed['collections'] as List<dynamic>? ?? const [])
        .map((item) => _collectionFromJson(item as Map<String, dynamic>))
        .toList();
    final entries = (parsed['entries'] as List<dynamic>)
        .map((item) => _entryFromJson(item as Map<String, dynamic>))
        .toList();
    final duplicates = _findDuplicates(entries);

    return ImportPreviewData(
      fileName: p.basename(filePath),
      format: ExportFormat.json,
      collections: collections,
      entries: entries,
      duplicates: duplicates,
      rawContent: rawContent,
    );
  }

  ImportPreviewData _buildCsvPreview(
    String filePath,
    List<List<dynamic>> rows,
    String rawContent,
  ) {
    if (rows.isEmpty) {
      throw const InvalidImportFormatException(
        'Invalid CSV file format selected. The file is empty.',
      );
    }

    final header = rows.first
        .map((value) => value.toString().trim().toLowerCase())
        .toList();
    final requiredFields = <String>[
      'id',
      'term',
      'definition',
      'type',
      'tags',
      'examples',
      'collectionname',
      'isfavorite',
    ];
    final missingFields = requiredFields
        .where((field) => !header.contains(field))
        .toList();
    if (missingFields.isNotEmpty) {
      throw InvalidImportFormatException(
        'Invalid CSV file format selected. Missing fields: ${missingFields.join(', ')}.',
      );
    }

    final entries = <LexiconEntry>[];
    for (final row in rows.skip(1)) {
      if (row.isEmpty || row.every((cell) => cell.toString().trim().isEmpty)) {
        continue;
      }
      final map = <String, String>{};
      for (var i = 0; i < header.length && i < row.length; i += 1) {
        map[header[i]] = row[i].toString();
      }
      entries.add(_entryFromCsvRow(map));
    }

    final duplicates = _findDuplicates(entries);
    return ImportPreviewData(
      fileName: p.basename(filePath),
      format: ExportFormat.csv,
      collections: const [],
      entries: entries,
      duplicates: duplicates,
      rawContent: rawContent,
    );
  }

  List<ImportDuplicateMatch> _findDuplicates(List<LexiconEntry> entries) {
    final matches = <ImportDuplicateMatch>[];
    for (final entry in entries) {
      final existing = _databaseService.findDuplicateEntry(
        entry.term,
        entry.type,
      );
      if (existing != null) {
        matches.add(
          ImportDuplicateMatch(incomingEntry: entry, existingEntry: existing),
        );
      }
    }
    return matches;
  }

  Map<String, dynamic> _entryToJson(LexiconEntry entry) {
    return {
      'id': entry.id,
      'term': entry.term,
      'definition': entry.definition,
      'type': entry.type.name,
      'example': entry.example,
      'notes': entry.notes,
      'tags': entry.tags,
      'collectionId': entry.collectionId,
      'collectionIds': entry.collectionIds,
      'isFavorite': entry.isFavorite,
      'createdAt': entry.createdAt.toUtc().toIso8601String(),
    };
  }

  Map<String, dynamic> _collectionToJson(LexiconCollection collection) {
    return {
      'id': collection.id,
      'name': collection.name,
      'description': collection.description,
      'colorValue': collection.colorValue,
      'createdAt': collection.createdAt.toUtc().toIso8601String(),
    };
  }

  List<dynamic> _entryToCsvRow(
    LexiconEntry entry,
    List<LexiconCollection> collections,
  ) {
    return [
      entry.id,
      entry.term,
      entry.definition,
      entry.type.name,
      entry.tags.join('|'),
      entry.example == null || entry.example!.trim().isEmpty
          ? ''
          : entry.example!.trim(),
      _collectionNamesForEntry(entry, collections).join('|'),
      entry.isFavorite,
    ];
  }

  List<String> _collectionNamesForEntry(
    LexiconEntry entry,
    List<LexiconCollection> collections,
  ) {
    final ids = <String>{
      ...entry.collectionIds,
      if (entry.collectionId != null) entry.collectionId!,
    };
    return collections
        .where((collection) => ids.contains(collection.id))
        .map((collection) => collection.name)
        .toList();
  }

  LexiconEntry _entryFromJson(Map<String, dynamic> json) {
    return LexiconEntry(
      id: json['id']?.toString() ?? const Uuid().v4(),
      term: json['term']?.toString() ?? '',
      definition: json['definition']?.toString() ?? '',
      type: _typeFromString(json['type']?.toString()),
      example: _optionalString(json['example']),
      notes: _optionalString(json['notes']),
      tags: _parseDelimitedValues(json['tags']),
      collectionId: _optionalString(json['collectionId']),
      collectionIds: _parseDelimitedValues(json['collectionIds']),
      isFavorite: json['isFavorite'] == true,
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  LexiconEntry _entryFromCsvRow(Map<String, String> row) {
    final collectionNames = _parseDelimitedString(row['collectionname']);
    final collectionIds = <String>[];

    for (final collectionName in collectionNames) {
      final existing = _databaseService
          .getCollections()
          .where(
            (collection) =>
                collection.name.trim().toLowerCase() ==
                collectionName.trim().toLowerCase(),
          )
          .toList();
      if (existing.isNotEmpty) {
        collectionIds.add(existing.first.id);
      }
    }

    return LexiconEntry(
      id: row['id']?.trim().isNotEmpty == true
          ? row['id']!.trim()
          : const Uuid().v4(),
      term: row['term']?.trim() ?? '',
      definition: row['definition']?.trim() ?? '',
      type: _typeFromString(row['type']),
      example: _optionalString(row['examples']),
      notes: null,
      tags: _parseDelimitedString(row['tags']),
      collectionId: collectionIds.isNotEmpty ? collectionIds.first : null,
      collectionIds: collectionIds,
      isFavorite: _parseBool(row['isfavorite']),
      createdAt: DateTime.now(),
    );
  }

  LexiconCollection _collectionFromJson(Map<String, dynamic> json) {
    return LexiconCollection(
      id: json['id']?.toString() ?? const Uuid().v4(),
      name: json['name']?.toString() ?? '',
      description: _optionalString(json['description']),
      colorValue:
          int.tryParse(json['colorValue']?.toString() ?? '') ?? 0xFF607D8B,
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  ExportFormat _inferFormat(String filePath, String content) {
    final extension = p.extension(filePath).toLowerCase();
    if (extension == '.csv') {
      return ExportFormat.csv;
    }
    if (extension == '.json') {
      return ExportFormat.json;
    }

    final trimmed = content.trimLeft();
    if (trimmed.startsWith('{')) {
      return ExportFormat.json;
    }
    if (trimmed.contains(',')) {
      return ExportFormat.csv;
    }

    throw const InvalidImportFormatException(
      'Unsupported file format selected. Please choose a JSON or CSV file.',
    );
  }

  String? _optionalString(dynamic value) {
    final stringValue = value?.toString().trim();
    if (stringValue == null || stringValue.isEmpty || stringValue == 'null') {
      return null;
    }
    return stringValue;
  }

  bool _parseBool(String? value) {
    final normalized = value?.trim().toLowerCase();
    return normalized == 'true' || normalized == '1' || normalized == 'yes';
  }

  DateTime _parseDateTime(dynamic value) {
    final stringValue = value?.toString();
    if (stringValue == null || stringValue.isEmpty) {
      return DateTime.now();
    }
    return DateTime.tryParse(stringValue) ?? DateTime.now();
  }

  LexiconType _typeFromString(String? value) {
    switch ((value ?? '').trim().toLowerCase()) {
      case 'quote':
        return LexiconType.quote;
      case 'phrase':
        return LexiconType.phrase;
      case 'idiom':
        return LexiconType.idiom;
      case 'word':
      default:
        return LexiconType.word;
    }
  }

  List<String> _parseDelimitedValues(dynamic value) {
    if (value == null) {
      return <String>[];
    }
    if (value is List) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList();
    }
    return _parseDelimitedString(value.toString());
  }

  List<String> _parseDelimitedString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return <String>[];
    }

    return value
        .split(RegExp(r'[|,;]'))
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList();
  }
}
