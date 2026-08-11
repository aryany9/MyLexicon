import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mylexicon/core/providers/sort_order_provider.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
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
    tempDir = await Directory.systemTemp.createTemp('mylexicon_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('test_entries');
    collectionsBox = await Hive.openBox<LexiconCollection>('test_collections');
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

  test(
    'Collection deletion orphans entries rather than deleting them',
    () async {
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
    },
  );

  test('Sort order cases: A-Z, Z-A, oldestFirst, newestFirst', () async {
    final now = DateTime.now();
    final entry1 = LexiconEntry(
      id: 'e1',
      term: 'Banana',
      definition: 'Fruit',
      type: LexiconType.word,
      tags: const [],
      isFavorite: false,
      createdAt: now.subtract(const Duration(hours: 2)),
    );
    final entry2 = LexiconEntry(
      id: 'e2',
      term: 'Apple',
      definition: 'Fruit',
      type: LexiconType.word,
      tags: const [],
      isFavorite: false,
      createdAt: now.subtract(const Duration(hours: 1)),
    );
    final entry3 = LexiconEntry(
      id: 'e3',
      term: 'Cherry',
      definition: 'Fruit',
      type: LexiconType.word,
      tags: const [],
      isFavorite: false,
      createdAt: now,
    );

    // Save directly to box to bypass saveEntry validation/timing
    await entriesBox.put(entry1.id, entry1);
    await entriesBox.put(entry2.id, entry2);
    await entriesBox.put(entry3.id, entry3);

    // Newest first (default): Cherry, Apple, Banana
    final newest = dbService.searchAndFilter(sortOrder: SortOrder.newestFirst);
    expect(newest.map((e) => e.term).toList(), ['Cherry', 'Apple', 'Banana']);

    // Oldest first: Banana, Apple, Cherry
    final oldest = dbService.searchAndFilter(sortOrder: SortOrder.oldestFirst);
    expect(oldest.map((e) => e.term).toList(), ['Banana', 'Apple', 'Cherry']);

    // A to Z: Apple, Banana, Cherry
    final aToZ = dbService.searchAndFilter(sortOrder: SortOrder.aToZ);
    expect(aToZ.map((e) => e.term).toList(), ['Apple', 'Banana', 'Cherry']);

    // Z to A: Cherry, Banana, Apple
    final zToA = dbService.searchAndFilter(sortOrder: SortOrder.zToA);
    expect(zToA.map((e) => e.term).toList(), ['Cherry', 'Banana', 'Apple']);
  });

  test('Collection-aware duplicate detection rules', () async {
    // 1. Both unassigned entries with same term + type → duplicate (findDuplicateEntry returns non-null)
    final unassigned = LexiconEntry(
      id: 'e1',
      term: 'Ephemeral',
      definition: 'Transient',
      type: LexiconType.word,
      tags: const [],
      isFavorite: false,
      createdAt: DateTime.now(),
    );
    await dbService.saveEntry(unassigned);

    expect(
      dbService.findDuplicateEntry(
        'Ephemeral',
        LexiconType.word,
        incomingCollectionIds: [],
      ),
      isNotNull,
    );

    // 2. One assigned, one unassigned → allowed (returns null)
    expect(
      dbService.findDuplicateEntry(
        'Ephemeral',
        LexiconType.word,
        incomingCollectionIds: ['col1'],
      ),
      isNull,
    );

    // Add entry in col1
    final inCol1 = LexiconEntry(
      id: 'e2',
      term: 'Ephemeral',
      definition: 'Transient',
      type: LexiconType.word,
      tags: const [],
      isFavorite: false,
      collectionId: 'col1',
      collectionIds: ['col1'],
      createdAt: DateTime.now(),
    );
    await dbService.saveEntry(inCol1);

    // 3. Same term + type + same collection → duplicate (rejected)
    expect(
      dbService.findDuplicateEntry(
        'Ephemeral',
        LexiconType.word,
        incomingCollectionIds: ['col1'],
      ),
      isNotNull,
    );

    // 4. Same term + type + different collections → allowed
    expect(
      dbService.findDuplicateEntry(
        'Ephemeral',
        LexiconType.word,
        incomingCollectionIds: ['col2'],
      ),
      isNull,
    );

    // 5. Overlapping collections → duplicate (rejected)
    expect(
      dbService.findDuplicateEntry(
        'Ephemeral',
        LexiconType.word,
        incomingCollectionIds: ['col1', 'col2'],
      ),
      isNotNull,
    );

    // 6. Different type → allowed even in same collection
    expect(
      dbService.findDuplicateEntry(
        'Ephemeral',
        LexiconType.quote,
        incomingCollectionIds: ['col1'],
      ),
      isNull,
    );
  });
}

