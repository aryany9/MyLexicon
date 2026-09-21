import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/core/services/sample_data_service.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';

void main() {
  late Directory tempDir;
  late Box<LexiconEntry> entriesBox;
  late Box<LexiconCollection> collectionsBox;
  late DatabaseService dbService;

  setUpAll(() {
    Hive.registerAdapter(LexiconTypeAdapter());
    Hive.registerAdapter(LexiconEntryAdapter());
    Hive.registerAdapter(LexiconCollectionAdapter());
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('sample_data_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('sample_test_entries');
    collectionsBox = await Hive.openBox<LexiconCollection>('sample_test_collections');
    dbService = DatabaseService(
      entriesBox: entriesBox,
      collectionsBox: collectionsBox,
    );
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('SampleDataService seeds exactly 10 items in each category (40 total) and 2 collections', () async {
    final result = await SampleDataService.loadSampleData(dbService);
    expect(result.added, 40);
    expect(result.updated, 0);
    expect(result.skipped, 0);

    final entries = dbService.getEntries();
    expect(entries.length, 40);

    final words = entries.where((e) => e.type == LexiconType.word).toList();
    final phrases = entries.where((e) => e.type == LexiconType.phrase).toList();
    final idioms = entries.where((e) => e.type == LexiconType.idiom).toList();
    final quotes = entries.where((e) => e.type == LexiconType.quote).toList();

    expect(words.length, 10);
    expect(phrases.length, 10);
    expect(idioms.length, 10);
    expect(quotes.length, 10);

    final collections = dbService.getCollections();
    expect(collections.length, 2);

    // Verify calling again refreshes existing sample entries without duplicates
    final secondRun = await SampleDataService.loadSampleData(dbService);
    expect(secondRun.added, 0);
    expect(secondRun.updated, 40);
    expect(secondRun.skipped, 0);
    expect(dbService.getEntries().length, 40);

    // Export sample JSON to project root
    final collectionsList = SampleDataService.sampleCollections;
    final entriesList = SampleDataService.getSampleEntries();
    final jsonContent = {
      'version': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'collections': collectionsList.map((c) => {
        'id': c.id,
        'name': c.name,
        'description': c.description,
        'colorValue': c.colorValue,
        'createdAt': c.createdAt.toUtc().toIso8601String(),
      }).toList(),
      'entries': entriesList.map((e) => {
        'id': e.id,
        'term': e.term,
        'definition': e.definition,
        'type': e.type.name,
        'examples': e.examples,
        'notes': e.notes,
        'tags': e.tags,
        'collectionId': e.collectionId,
        'collectionIds': e.collectionIds,
        'isFavorite': e.isFavorite,
        'createdAt': e.createdAt.toUtc().toIso8601String(),
      }).toList(),
    };

    final file = File('sample_lexicon_data.json');
    await file.writeAsString(
      JsonEncoder.withIndent('  ').convert(jsonContent),
    );
    expect(await file.exists(), isTrue);

    // Verify hasSampleData is true
    expect(SampleDataService.hasSampleData(dbService), isTrue);

    // Add a custom user entry that shouldn't be deleted
    final userEntry = LexiconEntry(
      id: 'custom_user_1',
      term: 'My Custom Word',
      definition: 'A word I created myself',
      type: LexiconType.word,
      tags: const [],
      isFavorite: false,
      createdAt: DateTime.now(),
    );
    await dbService.saveEntry(userEntry);
    expect(dbService.getEntries().length, 41);

    // Delete sample data
    final deletedCount = await SampleDataService.deleteSampleData(dbService);
    expect(deletedCount, 40);

    // Verify only custom entry remains
    final remainingEntries = dbService.getEntries();
    expect(remainingEntries.length, 1);
    expect(remainingEntries.first.id, 'custom_user_1');

    // Verify sample collections were also deleted
    expect(dbService.getCollections().isEmpty, isTrue);

    // Verify hasSampleData is now false
    expect(SampleDataService.hasSampleData(dbService), isFalse);
  });
}
