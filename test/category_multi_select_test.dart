import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/routes/app_router.dart';
import 'package:mylexicon/features/dictionary/category_list_screen.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';

int _multiSelectBoxCounter = 0;

void main() {
  late Directory tempDir;
  late Box<LexiconEntry> entriesBox;
  late Box<LexiconCollection> collectionsBox;
  late DatabaseService dbService;

  setUpAll(() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LexiconTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(LexiconEntryAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(LexiconCollectionAdapter());
    }
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    _multiSelectBoxCounter++;
    tempDir = await Directory.systemTemp.createTemp('multi_select_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('entries_$_multiSelectBoxCounter');
    collectionsBox =
        await Hive.openBox<LexiconCollection>('cols_$_multiSelectBoxCounter');
    dbService = DatabaseService(
      entriesBox: entriesBox,
      collectionsBox: collectionsBox,
    );

    // Seed 3 words
    await dbService.saveEntry(
      LexiconEntry(
        id: 'w1',
        term: 'Ephemeral',
        definition: 'Lasting for a very short time.',
        type: LexiconType.word,
        tags: const ['nature'],
        isFavorite: false,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    );
    await dbService.saveEntry(
      LexiconEntry(
        id: 'w2',
        term: 'Luminescence',
        definition: 'Light produced by chemical, electrical, or physiological means.',
        type: LexiconType.word,
        tags: const ['science'],
        isFavorite: false,
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
    );
    await dbService.saveEntry(
      LexiconEntry(
        id: 'w3',
        term: 'Petrichor',
        definition: 'Pleasant smell that accompanies the first rain after a dry spell.',
        type: LexiconType.word,
        tags: const ['weather'],
        isFavorite: false,
        createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
    );

    // Seed 2 phrases
    await dbService.saveEntry(
      LexiconEntry(
        id: 'p1',
        term: 'Break the ice',
        definition: 'To do or say something that makes people feel more relaxed.',
        type: LexiconType.phrase,
        tags: const [],
        isFavorite: false,
        createdAt: DateTime.now(),
      ),
    );
    await dbService.saveEntry(
      LexiconEntry(
        id: 'p2',
        term: 'Bite the bullet',
        definition: 'To force yourself to do something unpleasant or difficult.',
        type: LexiconType.phrase,
        tags: const [],
        isFavorite: false,
        createdAt: DateTime.now(),
      ),
    );
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets(
      'CategoryListScreen enters selection mode via select icon and cancels with close button',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
        ],
        child: const MaterialApp(
          home: CategoryListScreen(type: LexiconType.word),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify initial screen state
    expect(find.text('Words'), findsOneWidget);
    expect(find.byIcon(Icons.checklist_rounded), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);

    // Tap "Select items" action button
    await tester.tap(find.byIcon(Icons.checklist_rounded));
    await tester.pumpAndSettle();

    // Selection mode is now active
    expect(find.text('0 selected'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.select_all_rounded), findsOneWidget);
    expect(find.byType(Checkbox), findsNWidgets(3));

    // Tap Ephemeral to select it
    await tester.tap(find.text('Ephemeral'));
    await tester.pumpAndSettle();
    expect(find.text('1 selected'), findsOneWidget);

    // Tap Luminescence to select it
    await tester.tap(find.text('Luminescence'));
    await tester.pumpAndSettle();
    expect(find.text('2 selected'), findsOneWidget);

    // Tap Ephemeral again to deselect
    await tester.tap(find.text('Ephemeral'));
    await tester.pumpAndSettle();
    expect(find.text('1 selected'), findsOneWidget);

    // Tap Cancel (close button)
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Back to normal mode
    expect(find.text('Words'), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);
  });

  testWidgets(
      'CategoryListScreen enters selection mode via long press and toggles Select All',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
        ],
        child: const MaterialApp(
          home: CategoryListScreen(type: LexiconType.word),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Long press on Petrichor
    await tester.longPress(find.text('Petrichor'));
    await tester.pumpAndSettle();

    // Now in selection mode with Petrichor selected
    expect(find.text('1 selected'), findsOneWidget);
    expect(find.byType(Checkbox), findsNWidgets(3));

    // Tap Toggle Select All
    await tester.tap(find.byIcon(Icons.select_all_rounded));
    await tester.pumpAndSettle();
    expect(find.text('3 selected'), findsOneWidget);

    // Tap Toggle Select All again to deselect all
    await tester.tap(find.byIcon(Icons.select_all_rounded));
    await tester.pumpAndSettle();
    expect(find.text('0 selected'), findsOneWidget);
  });

  testWidgets(
      'CategoryListScreen batch deletes selected items with confirmation dialog',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
        ],
        child: const MaterialApp(
          home: CategoryListScreen(type: LexiconType.phrase),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Phrases'), findsOneWidget);
    expect(find.text('Break the ice'), findsOneWidget);
    expect(find.text('Bite the bullet'), findsOneWidget);

    // Long press Break the ice
    await tester.longPress(find.text('Break the ice'));
    await tester.pumpAndSettle();
    expect(find.text('1 selected'), findsOneWidget);

    // Tap delete button
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    // Confirmation dialog appears
    expect(find.text('Delete 1 phrase?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);

    // Tap Cancel
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Nothing deleted yet
    expect(find.text('Break the ice'), findsOneWidget);
    expect(dbService.getEntries().where((e) => e.type == LexiconType.phrase).length, 2);

    // Tap delete button again
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    // Confirm delete inside runAsync so Hive I/O runs in Zone.root
    await tester.runAsync(() async {
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await Future.delayed(const Duration(milliseconds: 500));
    });
    await tester.pumpAndSettle();

    // Selection mode should be exited
    expect(find.text('Phrases'), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);

    // Let SnackBar dismiss cleanly so no timer is pending
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });

  testWidgets(
      'Pressing back button after dismissing delete confirmation dialog exits selection mode instead of popping screen',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
        ],
        child: const MaterialApp(
          home: CategoryListScreen(type: LexiconType.phrase),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Long press to enter selection mode
    await tester.longPress(find.text('Break the ice'));
    await tester.pumpAndSettle();
    expect(find.text('1 selected'), findsOneWidget);

    // 2. Tap delete to open dialog
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Delete 1 phrase?'), findsOneWidget);

    // 3. Press back button -> closes dialog
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Delete 1 phrase?'), findsNothing);
    // Selection mode should still be active
    expect(find.text('1 selected'), findsOneWidget);

    // 4. Press back button again -> should exit selection mode!
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    // Selection mode should now be exited!
    expect(find.text('Phrases'), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);
  });

  testWidgets(
      'Pressing back button after dismissing delete confirmation dialog exits selection mode instead of popping screen with GoRouter',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = createAppRouter(initialLocation: '/category/phrase');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
        ],
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Long press to enter selection mode
    await tester.longPress(find.text('Break the ice'));
    await tester.pumpAndSettle();
    expect(find.text('1 selected'), findsOneWidget);

    // 2. Tap delete to open dialog
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Delete 1 phrase?'), findsOneWidget);

    // 3. Press back button -> closes dialog
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Delete 1 phrase?'), findsNothing);
    expect(find.text('1 selected'), findsOneWidget);

    // 4. Press back button again -> should exit selection mode!
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    // Selection mode should now be exited!
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Phrases')),
      findsOneWidget,
    );
    expect(find.byType(Checkbox), findsNothing);
  });
}

