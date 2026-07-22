import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:my_lexicon/core/services/database_service.dart';
import 'package:my_lexicon/core/services/export_import_service.dart';
import 'package:my_lexicon/models/lexicon_collection.dart';
import 'package:my_lexicon/models/lexicon_entry.dart';
import 'package:my_lexicon/models/lexicon_type.dart';

Future<DatabaseService> _openDatabaseService(Directory directory) async {
  Hive.init(directory.path);
  final entriesBox = await Hive.openBox<LexiconEntry>('test_entries');
  final collectionsBox = await Hive.openBox<LexiconCollection>(
    'test_collections',
  );
  return DatabaseService(
    entriesBox: entriesBox,
    collectionsBox: collectionsBox,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory sourceDir;
  late Directory targetDir;

  setUpAll(() {
    Hive.registerAdapter(LexiconTypeAdapter());
    Hive.registerAdapter(LexiconEntryAdapter());
    Hive.registerAdapter(LexiconCollectionAdapter());
  });

  setUp(() async {
    sourceDir = await Directory.systemTemp.createTemp(
      'my_lexicon_export_source',
    );
    targetDir = await Directory.systemTemp.createTemp(
      'my_lexicon_export_target',
    );
  });

  tearDown(() async {
    await Hive.close();
    if (await sourceDir.exists()) {
      await sourceDir.delete(recursive: true);
    }
    if (await targetDir.exists()) {
      await targetDir.delete(recursive: true);
    }
  });

  test('JSON export and import round trips collections and entries', () async {
    final sourceDb = await _openDatabaseService(sourceDir);
    final sourceService = ExportImportService(databaseService: sourceDb);

    final collection = LexiconCollection(
      id: 'collection-1',
      name: 'GRE Words',
      colorValue: 0xFF3366FF,
      createdAt: DateTime.parse('2026-07-22T12:00:00Z'),
    );
    final entry = LexiconEntry(
      id: 'entry-1',
      term: 'Serendipity',
      definition: 'A fortunate accident',
      type: LexiconType.word,
      example: 'Finding the book was pure serendipity.',
      notes: 'Used in study set',
      tags: ['happy', 'vocab'],
      collectionId: collection.id,
      collectionIds: [collection.id],
      isFavorite: true,
      createdAt: DateTime.parse('2026-07-22T12:01:00Z'),
    );

    await sourceDb.saveCollection(collection);
    await sourceDb.saveEntry(entry);

    final exportPackage = await sourceService.exportAll(ExportFormat.json);
    final exportFile = await sourceService.writeExportToTempFile(exportPackage);

    await Hive.close();

    final targetDb = await _openDatabaseService(targetDir);
    final targetService = ExportImportService(databaseService: targetDb);
    final preview = await targetService.analyzeImportFile(exportFile);

    expect(preview.totalEntries, 1);
    expect(preview.totalCollections, 1);
    expect(preview.duplicateCount, 0);

    final result = await targetService.importPreview(
      preview,
      ImportConflictStrategy.skip,
    );

    expect(result.result.added, 1);
    expect(targetDb.getCollections(), hasLength(1));
    expect(targetDb.getEntries(), hasLength(1));
    expect(targetDb.getEntries().single.collectionIds, contains(collection.id));
  });

  test('CSV import supports skip, overwrite, and merge strategies', () async {
    final sourceDb = await _openDatabaseService(sourceDir);
    final sourceService = ExportImportService(databaseService: sourceDb);

    final collection = LexiconCollection(
      id: 'collection-source',
      name: 'GRE Words',
      colorValue: 0xFF3366FF,
      createdAt: DateTime.parse('2026-07-22T12:00:00Z'),
    );
    final entry = LexiconEntry(
      id: 'entry-source',
      term: 'Serendipity',
      definition: 'Incoming definition',
      type: LexiconType.word,
      example: 'Incoming example',
      notes: 'Incoming notes',
      tags: ['incoming', 'shared'],
      collectionId: collection.id,
      collectionIds: [collection.id],
      isFavorite: true,
      createdAt: DateTime.parse('2026-07-22T12:01:00Z'),
    );

    await sourceDb.saveCollection(collection);
    await sourceDb.saveEntry(entry);

    final exportPackage = await sourceService.exportAll(ExportFormat.csv);
    final exportFile = await sourceService.writeExportToTempFile(exportPackage);

    await Hive.close();

    Future<void> verifyStrategy(
      ImportConflictStrategy strategy, {
      required String expectedDefinition,
      required bool expectUnion,
      required bool expectSkip,
      required bool expectOverwrite,
      required bool expectMerge,
    }) async {
      final strategyDir = await Directory.systemTemp.createTemp(
        'my_lexicon_strategy',
      );
      final strategyDb = await _openDatabaseService(strategyDir);
      final strategyService = ExportImportService(databaseService: strategyDb);

      await strategyDb.saveCollection(
        LexiconCollection(
          id: 'collection-existing',
          name: 'Archive',
          colorValue: 0xFF999999,
          createdAt: DateTime.parse('2026-07-21T12:00:00Z'),
        ),
      );
      await strategyDb.saveCollection(
        LexiconCollection(
          id: 'collection-target',
          name: 'GRE Words',
          colorValue: 0xFF3366FF,
          createdAt: DateTime.parse('2026-07-22T12:00:00Z'),
        ),
      );

      final existingEntry = LexiconEntry(
        id: 'entry-existing',
        term: 'Serendipity',
        definition: 'Existing definition',
        type: LexiconType.word,
        example: 'Existing example',
        notes: 'Existing notes',
        tags: ['existing'],
        collectionId: 'collection-existing',
        collectionIds: ['collection-existing'],
        isFavorite: false,
        createdAt: DateTime.parse('2026-07-20T12:00:00Z'),
      );
      await strategyDb.saveEntry(existingEntry);

      final preview = await strategyService.analyzeImportFile(exportFile);
      final result = await strategyService.importPreview(preview, strategy);

      expect(result.result.added, expectSkip ? 0 : 0);
      if (expectSkip) {
        expect(result.result.skipped, 1);
        expect(
          strategyDb.getEntries().single.definition,
          'Existing definition',
        );
        expect(strategyDb.getEntries().single.tags, contains('existing'));
      }

      if (expectOverwrite) {
        expect(result.result.overwritten, 1);
        final updated = strategyDb.getEntries().single;
        expect(updated.id, 'entry-existing');
        expect(updated.definition, expectedDefinition);
        expect(updated.isFavorite, isTrue);
        expect(updated.collectionIds, contains('collection-target'));
      }

      if (expectMerge) {
        expect(result.result.merged, 1);
        final updated = strategyDb.getEntries().single;
        expect(updated.id, 'entry-existing');
        expect(updated.definition, 'Existing definition');
        expect(updated.tags, containsAll(['existing', 'incoming', 'shared']));
        expect(
          updated.collectionIds,
          containsAll(['collection-existing', 'collection-target']),
        );
        expect(updated.isFavorite, isFalse);
      }

      await Hive.close();
      await strategyDir.delete(recursive: true);
    }

    await verifyStrategy(
      ImportConflictStrategy.skip,
      expectedDefinition: 'Existing definition',
      expectUnion: false,
      expectSkip: true,
      expectOverwrite: false,
      expectMerge: false,
    );
    await verifyStrategy(
      ImportConflictStrategy.overwrite,
      expectedDefinition: 'Incoming definition',
      expectUnion: false,
      expectSkip: false,
      expectOverwrite: true,
      expectMerge: false,
    );
    await verifyStrategy(
      ImportConflictStrategy.merge,
      expectedDefinition: 'Existing definition',
      expectUnion: true,
      expectSkip: false,
      expectOverwrite: false,
      expectMerge: true,
    );
  });

  test('Invalid import files are rejected before preview', () async {
    final db = await _openDatabaseService(sourceDir);
    final service = ExportImportService(databaseService: db);
    final invalidFile = File('${sourceDir.path}/invalid.json');
    await invalidFile.writeAsString('{"unexpected": true}');

    expect(
      () async => service.analyzeImportFile(invalidFile),
      throwsA(isA<InvalidImportFormatException>()),
    );
  });
}
