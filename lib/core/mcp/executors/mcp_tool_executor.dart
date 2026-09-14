import 'dart:convert';
import 'package:uuid/uuid.dart';

import '../../../models/lexicon_entry.dart';
import '../../../models/lexicon_collection.dart';
import '../../../models/lexicon_type.dart';
import '../../services/database_service.dart';

class McpToolExecutor {
  final DatabaseService _dbService;
  final _uuid = const Uuid();

  McpToolExecutor(this._dbService);

  Future<Map<String, dynamic>> executeTool(
      String name, Map<String, dynamic>? params) async {
    final args = params ?? {};

    switch (name) {
      case 'search_entries':
        return _searchEntries(args);
      case 'get_entry':
        return _getEntry(args);
      case 'add_entry':
        return _addEntry(args);
      case 'update_entry':
        return _updateEntry(args);
      case 'delete_entry':
        return _deleteEntry(args);
      case 'list_collections':
        return _listCollections();
      case 'create_collection':
        return _createCollection(args);
      default:
        throw Exception('Unknown tool: $name');
    }
  }

  Map<String, dynamic> _searchEntries(Map<String, dynamic> args) {
    final query = (args['query'] as String?)?.toLowerCase() ?? '';
    final collectionName = args['collectionName'] as String?;

    String? collectionId;
    if (collectionName != null && collectionName.isNotEmpty) {
      final col = _dbService.getCollections().cast().firstWhere(
            (c) => c.name.toLowerCase() == collectionName.toLowerCase(),
            orElse: () => null,
          );
      if (col != null) {
        collectionId = col.id;
      }
    }

    final entries = _dbService.getEntries().cast<LexiconEntry>().where((e) {
      if (collectionId != null &&
          e.collectionId != collectionId &&
          !e.collectionIds.contains(collectionId)) {
        return false;
      }
      if (query.isNotEmpty) {
        final termMatch = e.term.toLowerCase().contains(query);
        final defMatch = e.definition.toLowerCase().contains(query);
        final tagMatch = e.tags.any((t) => t.toLowerCase().contains(query));
        if (!termMatch && !defMatch && !tagMatch) {
          return false;
        }
      }
      return true;
    }).toList();

    return {
      'content': [
        {
          'type': 'text',
          'text': _formatEntriesList(entries),
        }
      ]
    };
  }

  Map<String, dynamic> _getEntry(Map<String, dynamic> args) {
    final id = args['id'] as String?;
    if (id == null) throw Exception('Missing id parameter');

    final entries = _dbService.getEntries().cast<LexiconEntry>();
    final entry = entries.firstWhere((e) => e.id == id, orElse: () => throw Exception('Entry not found'));

    return {
      'content': [
        {
          'type': 'text',
          'text': _formatEntryDetail(entry),
        }
      ]
    };
  }

  Future<Map<String, dynamic>> _addEntry(Map<String, dynamic> args) async {
    final term = args['term'] as String?;
    final definition = args['definition'] as String?;
    final typeStr = args['type'] as String?;
    final collectionName = args['collectionName'] as String?;

    if (term == null || definition == null || typeStr == null) {
      throw Exception('Missing required parameters');
    }

    final type = _parseType(typeStr);
    String? collectionId;

    if (collectionName != null && collectionName.isNotEmpty && collectionName != 'null') {
      var cols = _dbService.getCollections().cast();
      var col = cols.firstWhere(
        (c) => c.name.toLowerCase() == collectionName.toLowerCase(),
        orElse: () => null,
      );

      if (col == null) {
         throw Exception('Collection "$collectionName" not found. Please use the "create_collection" tool to create it first, or use list_collections to see available collections.');
      }
      collectionId = col.id;
    }

    final existing = _dbService.findDuplicateEntry(
      term,
      type,
      incomingCollectionIds: collectionId != null ? [collectionId] : [],
    );

    if (existing != null) {
      return {
        'isError': true,
        'content': [
          {
            'type': 'text',
            'text': 'A duplicate entry already exists in this collection.\nExisting Entry ID: ${existing.id}\nTerm: ${existing.term}\nConsider using update_entry instead.'
          }
        ]
      };
    }

    List<String> parseList(dynamic val) {
      if (val == null) return [];
      if (val is List) return val.map((e) => e.toString()).toList();
      if (val is String) {
        try {
          final decoded = jsonDecode(val);
          if (decoded is List) return decoded.map((e) => e.toString()).toList();
        } catch (_) {}
      }
      return [];
    }

    final newEntry = LexiconEntry(
      id: _uuid.v4(),
      term: term,
      definition: definition,
      type: type,
      collectionId: collectionId,
      collectionIds: collectionId != null ? [collectionId] : [],
      tags: parseList(args['tags']),
      examples: parseList(args['examples']),
      notes: args['notes'] as String?,
      isFavorite: args['isFavorite'] as bool? ?? false,
      createdAt: DateTime.now(),
    );

    await _dbService.saveEntry(newEntry);

    return {
      'content': [
        {
          'type': 'text',
          'text': 'Successfully added entry with ID: ${newEntry.id}',
        }
      ]
    };
  }

  Future<Map<String, dynamic>> _updateEntry(Map<String, dynamic> args) async {
    final id = args['id'] as String?;
    if (id == null) throw Exception('Missing id parameter');

    final entries = _dbService.getEntries().cast<LexiconEntry>();
    final existing = entries.firstWhere((e) => e.id == id, orElse: () => throw Exception('Entry not found'));

    String? newCollectionId = existing.collectionId;
    List<String> newCollectionIds = List.from(existing.collectionIds);

    if (args['collectionName'] != null) {
      final cname = args['collectionName'] as String;
      final cols = _dbService.getCollections().cast();
      final col = cols.firstWhere(
        (c) => c.name.toLowerCase() == cname.toLowerCase(),
        orElse: () => throw Exception('Collection "$cname" not found. Please use the "create_collection" tool to create it first.'),
      );
      newCollectionId = col.id;
      if (!newCollectionIds.contains(col.id)) {
        newCollectionIds.add(col.id);
      }
    }

    List<String> parseList(dynamic val, List<String> fallback) {
      if (val == null) return fallback;
      if (val is List) return val.map((e) => e.toString()).toList();
      if (val is String) {
        try {
          final decoded = jsonDecode(val);
          if (decoded is List) return decoded.map((e) => e.toString()).toList();
        } catch (_) {}
      }
      return fallback;
    }

    final updated = LexiconEntry(
      id: existing.id,
      term: args['term'] as String? ?? existing.term,
      definition: args['definition'] as String? ?? existing.definition,
      type: args['type'] != null ? _parseType(args['type'] as String) : existing.type,
      collectionId: newCollectionId,
      collectionIds: newCollectionIds,
      tags: parseList(args['tags'], existing.tags),
      examples: parseList(args['examples'], existing.examples),
      notes: args['notes'] as String? ?? existing.notes,
      isFavorite: args['isFavorite'] as bool? ?? existing.isFavorite,
      createdAt: existing.createdAt,
    );

    await _dbService.saveEntry(updated);

    return {
      'content': [
        {
          'type': 'text',
          'text': 'Successfully updated entry with ID: ${updated.id}',
        }
      ]
    };
  }

  Future<Map<String, dynamic>> _deleteEntry(Map<String, dynamic> args) async {
    final id = args['id'] as String?;
    if (id == null) throw Exception('Missing id parameter');

    await _dbService.deleteEntry(id);

    return {
      'content': [
        {
          'type': 'text',
          'text': 'Successfully deleted entry with ID: $id',
        }
      ]
    };
  }

  Future<Map<String, dynamic>> _createCollection(Map<String, dynamic> args) async {
    final name = args['name'] as String?;
    if (name == null || name.trim().isEmpty) {
      throw Exception('Collection name cannot be empty');
    }

    final description = args['description'] as String?;

    final existingCols = _dbService.getCollections().cast();
    if (existingCols.any((c) => c.name.toLowerCase() == name.trim().toLowerCase())) {
      throw Exception('A collection with the name "${name.trim()}" already exists.');
    }

    final newCollection = LexiconCollection(
      id: _uuid.v4(),
      name: name.trim(),
      description: description,
      colorValue: 0xFF1976D2, // Default blue color
      createdAt: DateTime.now(),
    );

    await _dbService.saveCollection(newCollection);

    return {
      'content': [
        {
          'type': 'text',
          'text': 'Successfully created collection: "${newCollection.name}" with ID: ${newCollection.id}',
        }
      ]
    };
  }

  Map<String, dynamic> _listCollections() {
    final collections = _dbService.getCollections().cast();
    final buffer = StringBuffer();
    for (final c in collections) {
      buffer.writeln('- ID: ${c.id} | Name: ${c.name}');
    }

    return {
      'content': [
        {
          'type': 'text',
          'text': buffer.isEmpty ? 'No collections found.' : buffer.toString(),
        }
      ]
    };
  }

  LexiconType _parseType(String typeStr) {
    switch (typeStr.toLowerCase()) {
      case 'word':
        return LexiconType.word;
      case 'phrase':
        return LexiconType.phrase;
      case 'idiom':
        return LexiconType.idiom;
      case 'quote':
        return LexiconType.quote;
      default:
        throw Exception('Invalid type: $typeStr');
    }
  }

  String _formatEntriesList(List<LexiconEntry> entries) {
    if (entries.isEmpty) return 'No entries found.';
    final buffer = StringBuffer();
    for (final e in entries) {
      final fav = e.isFavorite ? '⭐ ' : '';
      buffer.writeln('- ID: ${e.id} | Term: $fav${e.term} | Type: ${e.type.name} | Notes: ${e.notes ?? ""}');
    }
    return buffer.toString();
  }

  String _formatEntryDetail(LexiconEntry entry) {
    return '''
ID: ${entry.id}
Term: ${entry.term}
Type: ${entry.type.name}
Definition: ${entry.definition}
Examples: ${entry.examples.join(' | ')}
Notes: ${entry.notes ?? ''}
Favorite: ${entry.isFavorite}
Tags: ${entry.tags.join(', ')}
Created At: ${entry.createdAt.toIso8601String()}
''';
  }
}
