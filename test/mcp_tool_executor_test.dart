import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mylexicon/core/mcp/executors/mcp_tool_executor.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_type.dart';

void main() {
  late Directory tempDir;
  late Box<LexiconEntry> entriesBox;
  late Box<LexiconCollection> collectionsBox;
  late DatabaseService dbService;
  late McpToolExecutor executor;

  setUpAll(() {
    Hive.registerAdapter(LexiconTypeAdapter());
    Hive.registerAdapter(LexiconEntryAdapter());
    Hive.registerAdapter(LexiconCollectionAdapter());
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('mylexicon_mcp_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('test_entries');
    collectionsBox = await Hive.openBox<LexiconCollection>('test_collections');
    dbService = DatabaseService(
      entriesBox: entriesBox,
      collectionsBox: collectionsBox,
    );
    executor = McpToolExecutor(dbService);
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('list_collections returns collections', () async {
    final col = LexiconCollection(
      id: 'col1',
      name: 'GRE Words',
      colorValue: 0xFFFFFFFF,
      createdAt: DateTime.now(),
    );
    await dbService.saveCollection(col);

    final result = await executor.executeTool('list_collections', {});
    final text = result['content'][0]['text'] as String;
    expect(text, contains('GRE Words'));
    expect(text, contains('col1'));
  });

  test('add_entry adds an entry to collection', () async {
    final col = LexiconCollection(
      id: 'col1',
      name: 'My Col',
      colorValue: 0,
      createdAt: DateTime.now(),
    );
    await dbService.saveCollection(col);

    final result = await executor.executeTool('add_entry', {
      'term': 'hello',
      'definition': 'a greeting',
      'type': 'word',
      'collectionName': 'My Col',
    });

    final text = result['content'][0]['text'] as String;
    expect(text, contains('Successfully added entry'));

    final entries = dbService.getEntries();
    expect(entries.length, 1);
    expect(entries.first.term, 'hello');
  });

  test('add_entry fails on duplicate', () async {
    final col = LexiconCollection(
      id: 'col1',
      name: 'My Col',
      colorValue: 0,
      createdAt: DateTime.now(),
    );
    await dbService.saveCollection(col);

    await executor.executeTool('add_entry', {
      'term': 'hello',
      'definition': 'a greeting',
      'type': 'word',
      'collectionName': 'My Col',
    });

    // Add duplicate
    final result = await executor.executeTool('add_entry', {
      'term': 'hello',
      'definition': 'another greeting',
      'type': 'word',
      'collectionName': 'My Col',
    });

    expect(result['isError'], isTrue);
    final text = result['content'][0]['text'] as String;
    expect(text, contains('duplicate entry already exists'));
  });

  test('search_entries finds entry', () async {
    final col = LexiconCollection(
      id: 'col1',
      name: 'My Col',
      colorValue: 0,
      createdAt: DateTime.now(),
    );
    await dbService.saveCollection(col);

    await dbService.saveEntry(LexiconEntry(
      id: 'e1',
      term: 'apple',
      definition: 'fruit',
      type: LexiconType.word,
      collectionId: 'col1',
      collectionIds: ['col1'],
      tags: [],
      isFavorite: false,
      createdAt: DateTime.now(),
    ));

    final result = await executor.executeTool('search_entries', {
      'query': 'fruit',
    });

    final text = result['content'][0]['text'] as String;
    expect(text, contains('apple'));
  });

  test('delete_entry deletes entry', () async {
    final col = LexiconCollection(
      id: 'col1',
      name: 'My Col',
      colorValue: 0,
      createdAt: DateTime.now(),
    );
    await dbService.saveCollection(col);

    await dbService.saveEntry(LexiconEntry(
      id: 'e1',
      term: 'apple',
      definition: 'fruit',
      type: LexiconType.word,
      collectionId: 'col1',
      collectionIds: ['col1'],
      tags: [],
      isFavorite: false,
      createdAt: DateTime.now(),
    ));

    expect(dbService.getEntries().length, 1);

    await executor.executeTool('delete_entry', {'id': 'e1'});

    expect(dbService.getEntries().length, 0);
  });
}
