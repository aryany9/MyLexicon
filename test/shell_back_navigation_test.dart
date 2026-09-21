import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';
import 'package:mylexicon/routes/app_router.dart';
import 'package:mylexicon/features/settings/sub_pages/appearance_settings_page.dart';

int _shellNavTestCounter = 0;

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
    _shellNavTestCounter++;
    tempDir = await Directory.systemTemp.createTemp('shell_nav_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('entries_$_shellNavTestCounter');
    collectionsBox =
        await Hive.openBox<LexiconCollection>('cols_$_shellNavTestCounter');
    dbService = DatabaseService(
      entriesBox: entriesBox,
      collectionsBox: collectionsBox,
    );

    // Seed one word for testing selection mode
    await dbService.saveEntry(
      LexiconEntry(
        id: 'w1',
        term: 'Serendipity',
        definition: 'Finding good things without looking for them.',
        type: LexiconType.word,
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
      'Pressing back button on Settings screen moves back to Dashboard',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = createAppRouter(initialLocation: '/settings');

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

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Settings')),
      findsOneWidget,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('MyLexicon')),
      findsOneWidget,
    );
  });

  testWidgets(
      'Pressing back button on Collections screen moves back to Dashboard',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = createAppRouter(initialLocation: '/collections');

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

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Collections')),
      findsOneWidget,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('MyLexicon')),
      findsOneWidget,
    );
  });

  testWidgets(
      'Pressing back button on Category screen (Words) moves back to Dashboard',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = createAppRouter(initialLocation: '/category/word');

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

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Words')),
      findsOneWidget,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('MyLexicon')),
      findsOneWidget,
    );
  });

  testWidgets(
      'On Category screen in selection mode, back exits selection mode, then next back moves to Dashboard',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = createAppRouter(initialLocation: '/category/word');

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

    // Long press to enter selection mode
    await tester.longPress(find.text('Serendipity'));
    await tester.pumpAndSettle();
    expect(find.text('1 selected'), findsOneWidget);

    // 1st back: should exit selection mode, remaining on Words screen
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Words')),
      findsOneWidget,
    );
    expect(find.byType(Checkbox), findsNothing);

    // 2nd back: should move to Dashboard
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('MyLexicon')),
      findsOneWidget,
    );
  });

  testWidgets(
      'Pressing back button in Settings sub-page returns to Settings, and next back moves to Dashboard',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = createAppRouter(initialLocation: '/settings');

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

    await tester.tap(find.text('Appearance'));
    await tester.pumpAndSettle();

    expect(find.byType(AppearanceSettingsPage), findsOneWidget);

    // 1st back: pops Appearance sub-page back to Settings
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.byType(AppearanceSettingsPage), findsNothing);
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Settings')),
      findsOneWidget,
    );

    // 2nd back: moves to Dashboard
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('MyLexicon')),
      findsOneWidget,
    );
  });
}
