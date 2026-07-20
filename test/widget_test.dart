import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:my_lexicon/core/services/database_service.dart';
import 'package:my_lexicon/models/lexicon_entry.dart';
import 'package:my_lexicon/models/lexicon_collection.dart';
import 'package:my_lexicon/models/lexicon_type.dart';
import 'package:my_lexicon/features/home/home_screen.dart';
import 'package:my_lexicon/features/dictionary/entry_form_screen.dart';

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
    tempDir = await Directory.systemTemp.createTemp('my_lexicon_widget_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('widget_entries');
    collectionsBox = await Hive.openBox<LexiconCollection>('widget_collections');
    dbService = DatabaseService(entriesBox: entriesBox, collectionsBox: collectionsBox);
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  Widget createTestWidget(Widget child) {
    return ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(dbService),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('HomeScreen shows empty state when no entries', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Your lexicon is empty!'), findsOneWidget);
    expect(find.text('Add First Entry'), findsOneWidget);
  });

  testWidgets('HomeScreen lists recent entry', (WidgetTester tester) async {
    final entry = LexiconEntry(
      id: 'entry1',
      term: 'Abundance',
      definition: 'A very large quantity of something',
      type: LexiconType.word,
      tags: [],
      isFavorite: false,
      createdAt: DateTime.now(),
    );
    await dbService.saveEntry(entry);

    await tester.pumpWidget(createTestWidget(const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Abundance'), findsOneWidget);
    expect(find.text('A very large quantity of something'), findsOneWidget);
  });

  testWidgets('EntryFormScreen saves entry and validates inputs', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const EntryFormScreen()));
    await tester.pumpAndSettle();

    // Tap Save Entry button while fields are empty to trigger validation
    await tester.tap(find.text('Save Entry'));
    await tester.pumpAndSettle();

    expect(find.text('Word cannot be empty'), findsOneWidget);

    // Enter details
    await tester.enterText(find.byType(TextFormField).first, 'Ephemeral');
    await tester.enterText(find.byType(TextFormField).at(1), 'Lasting for a very short time');
    
    // Tap Save Entry
    await tester.tap(find.text('Save Entry'));
    await tester.pumpAndSettle();

    expect(dbService.getEntries().length, 1);
    expect(dbService.getEntries().first.term, 'Ephemeral');
  });
}
