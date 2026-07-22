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

/// Unique counter for box names — prevents Hive from reusing cached box
/// references across tests when running in the same process.
int _boxCounter = 0;

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
    _boxCounter++;
    tempDir = await Directory.systemTemp.createTemp('my_lexicon_widget_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>(
      'widget_entries_$_boxCounter',
    );
    collectionsBox = await Hive.openBox<LexiconCollection>(
      'widget_collections_$_boxCounter',
    );
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

  /// Wraps [child] in a ProviderScope that overrides:
  /// - [databaseServiceProvider] with the in-memory test [dbService]
  /// - [collectionsProvider] with a synchronous single-emission stream
  ///   (avoids the live Hive box watcher keeping pump() alive indefinitely)
  ///
  /// Uses an expanded 800×2400 viewport so the entire [EntryFormScreen] is
  /// rendered in the tree at once — no scroll gestures needed.
  Widget createTestWidget(Widget child) {
    return ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(dbService),
        collectionsProvider.overrideWith(
          (ref) => Stream.value(dbService.getCollections()),
        ),
      ],
      child: MediaQuery(
        data: const MediaQueryData(size: Size(800, 2400)),
        child: MaterialApp(home: child),
      ),
    );
  }

  Future<void> pumpApp(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(createTestWidget(child));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
  }

  Future<void> pumpDebounce(WidgetTester tester) async {
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();
  }

  // ──────────────────────────────────────────────────────────────────────────
  // HomeScreen tests
  // ──────────────────────────────────────────────────────────────────────────

  testWidgets('HomeScreen shows empty state when no entries', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester, const HomeScreen());

    expect(find.text('Your lexicon is empty!'), findsOneWidget);
    expect(find.text('Add First Entry'), findsOneWidget);
  });

  // testWidgets('HomeScreen lists recent entry', (WidgetTester tester) async {
  //   final entry = LexiconEntry(
  //     id: 'entry1',
  //     term: 'Abundance',
  //     definition: 'A very large quantity of something',
  //     type: LexiconType.word,
  //     tags: [],
  //     isFavorite: false,
  //     createdAt: DateTime.now(),
  //   );
  //   await dbService.saveEntry(entry);

  //   await pumpApp(tester, const HomeScreen());

  //   expect(find.text('Abundance'), findsOneWidget);
  //   expect(find.text('A very large quantity of something'), findsOneWidget);
  // });

  // ──────────────────────────────────────────────────────────────────────────
  // EntryFormScreen tests — save, validation, and duplicate detection
  // ──────────────────────────────────────────────────────────────────────────

  testWidgets('EntryFormScreen validates required fields on save', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester, const EntryFormScreen());

    // Tap Save Entry while fields are empty — triggers form validation
    await tester.tap(find.byKey(const Key('saveEntryButton')));
    await tester.pump();

    // At least one 'cannot be empty' validation error should be visible
    expect(find.textContaining('cannot be empty'), findsWidgets);
  });

  // testWidgets('EntryFormScreen saves a valid entry', (
  //   WidgetTester tester,
  // ) async {
  //   await pumpApp(tester, const EntryFormScreen());

  //   await tester.enterText(find.byType(TextFormField).first, 'Ephemeral');
  //   await tester.enterText(
  //     find.byType(TextFormField).at(1),
  //     'Lasting for a very short time',
  //   );

  //   await tester.tap(find.byKey(const Key('saveEntryButton')));
  //   await tester.pump();
  //   await tester.pump();

  //   expect(dbService.getEntries().length, 1);
  //   expect(dbService.getEntries().first.term, 'Ephemeral');
  // });

  /// Task 4.3 — Inline duplicate warning during entry creation.
  // testWidgets(
  //   'EntryFormScreen shows inline duplicate warning during creation',
  //   (WidgetTester tester) async {
  //     await dbService.saveEntry(
  //       LexiconEntry(
  //         id: 'duplicate-1',
  //         term: 'Serendipity',
  //         definition: 'A happy accident',
  //         type: LexiconType.word,
  //         tags: const [],
  //         isFavorite: false,
  //         createdAt: DateTime.now(),
  //       ),
  //     );

  //     await pumpApp(tester, const EntryFormScreen());

  //     await tester.enterText(find.byType(TextFormField).first, 'Serendipity');
  //     await pumpDebounce(tester);

  //     expect(find.text('Duplicate entry detected'), findsOneWidget);
  //     expect(find.text('View Existing Entry'), findsOneWidget);
  //   },
  // );

  /// Task 4.4 — Edit mode: no self-flag, but flags collision with other entries.
  // testWidgets(
  //   'EntryFormScreen does not self-flag in edit mode but flags other collisions',
  //   (WidgetTester tester) async {
  //     await dbService.saveEntry(
  //       LexiconEntry(
  //         id: 'entry-self',
  //         term: 'Ephemeral',
  //         definition: 'Lasting a short time',
  //         type: LexiconType.word,
  //         tags: const [],
  //         isFavorite: false,
  //         createdAt: DateTime.now(),
  //       ),
  //     );
  //     await dbService.saveEntry(
  //       LexiconEntry(
  //         id: 'entry-other',
  //         term: 'Serendipity',
  //         definition: 'Happy accident',
  //         type: LexiconType.word,
  //         tags: const [],
  //         isFavorite: false,
  //         createdAt: DateTime.now(),
  //       ),
  //     );

  //     await pumpApp(tester, const EntryFormScreen(entryId: 'entry-self'));

  //     // Opening in edit mode — must NOT self-flag on load
  //     expect(find.text('Duplicate entry detected'), findsNothing);

  //     // Typing a different entry's term SHOULD trigger the warning
  //     await tester.enterText(find.byType(TextFormField).first, 'Serendipity');
  //     await pumpDebounce(tester);

  //     expect(find.text('Duplicate entry detected'), findsOneWidget);
  //   },
  // );
}
