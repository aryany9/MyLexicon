import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:my_lexicon/core/services/database_service.dart';
import 'package:my_lexicon/models/lexicon_entry.dart';
import 'package:my_lexicon/models/lexicon_collection.dart';
import 'package:my_lexicon/models/lexicon_type.dart';

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
    tempDir = await Directory.systemTemp.createTemp('my_lexicon_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('test_entries');
    collectionsBox = await Hive.openBox<LexiconCollection>('test_collections');
    dbService = DatabaseService(entriesBox: entriesBox, collectionsBox: collectionsBox);
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('Save and retrieve collection', () async {
    final col = LexiconCollection(
      id: 'col1',
      name: 'GRE Words',
      colorValue: 0xFFFFFFFF,
      createdAt: DateTime.now(),
    );

    await dbService.saveCollection(col);
    final cols = dbService.getCollections();
    expect(cols.length, 1);
    expect(cols.first.name, 'GRE Words');
  });

  test('Save and retrieve entry', () async {
    final entry = LexiconEntry(
      id: 'entry1',
      term: 'Serendipity',
      definition: 'Happy accident',
      type: LexiconType.word,
      tags: ['vocab'],
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await dbService.saveEntry(entry);
    final entries = dbService.getEntries();
    expect(entries.length, 1);
    expect(entries.first.term, 'Serendipity');
  });

  test('Search and filter works', () async {
    final entry1 = LexiconEntry(
      id: 'entry1',
      term: 'Serendipity',
      definition: 'Happy accident',
      type: LexiconType.word,
      tags: ['vocab', 'happy'],
      isFavorite: true,
      createdAt: DateTime.now(),
    );
    final entry2 = LexiconEntry(
      id: 'entry2',
      term: 'Shakespeare Quote',
      definition: 'To be or not to be',
      type: LexiconType.quote,
      tags: ['quote', 'play'],
      isFavorite: false,
      createdAt: DateTime.now().add(const Duration(seconds: 1)),
    );

    await dbService.saveEntry(entry1);
    await dbService.saveEntry(entry2);

    // Search query matches definition (case-insensitive)
    final searchResults = dbService.searchAndFilter(query: 'accident');
    expect(searchResults.length, 1);
    expect(searchResults.first.term, 'Serendipity');

    // Search type
    final typeResults = dbService.searchAndFilter(type: LexiconType.quote);
    expect(typeResults.length, 1);
    expect(typeResults.first.term, 'Shakespeare Quote');

    // Search tag
    final tagResults = dbService.searchAndFilter(tag: 'vocab');
    expect(tagResults.length, 1);
    expect(tagResults.first.id, 'entry1');

    // Search favorite
    final favResults = dbService.searchAndFilter(isFavorite: true);
    expect(favResults.length, 1);
    expect(favResults.first.id, 'entry1');
  });

  test('Collection deletion orphans entries rather than deleting them', () async {
    final col = LexiconCollection(
      id: 'col1',
      name: 'GRE Words',
      colorValue: 0xFFFFFFFF,
      createdAt: DateTime.now(),
    );
    final entry = LexiconEntry(
      id: 'entry1',
      term: 'Serendipity',
      definition: 'Happy accident',
      type: LexiconType.word,
      tags: [],
      collectionId: 'col1',
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await dbService.saveCollection(col);
    await dbService.saveEntry(entry);

    expect(dbService.getEntries().first.collectionId, 'col1');

    await dbService.deleteCollection('col1');

    expect(dbService.getCollections().length, 0);
    expect(dbService.getEntries().length, 1);
    expect(dbService.getEntries().first.collectionId, isNull);
  });
}
