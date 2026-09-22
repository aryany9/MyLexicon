import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/features/settings/sub_pages/data_settings_page.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';

int _dsBoxCounter = 0;

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
    _dsBoxCounter++;
    tempDir = await Directory.systemTemp.createTemp('data_settings_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('ds_entries_$_dsBoxCounter');
    collectionsBox =
        await Hive.openBox<LexiconCollection>('ds_collections_$_dsBoxCounter');
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

  Widget buildTestApp() {
    return ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(dbService),
      ],
      child: const MaterialApp(
        home: DataSettingsPage(),
      ),
    );
  }

  testWidgets(
      'DataSettingsPage renders Load and Delete Sample Data in debug mode and executes actions',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Verify Developer (Debug Mode) section exists
    expect(find.text('Developer (Debug Mode)'), findsOneWidget);
    expect(find.byKey(const ValueKey('load_sample_data_tile')), findsOneWidget);
    expect(find.byKey(const ValueKey('delete_sample_data_tile')), findsOneWidget);

    // Tap Load Sample Data tile
    await tester.tap(find.byKey(const ValueKey('load_sample_data_tile')));
    await tester.pumpAndSettle();

    expect(find.text('Load Sample Data?'), findsOneWidget);

    // Confirm load inside runAsync so Hive I/O runs in Zone.root
    await tester.runAsync(() async {
      await tester.tap(find.widgetWithText(FilledButton, 'Load Sample Data'));
      for (int i = 0; i < 40; i++) {
        if (dbService.getEntries().length == 40) break;
        await Future.delayed(const Duration(milliseconds: 50));
      }
    });
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Verify 40 entries were loaded
    expect(dbService.getEntries().length, 40);
    expect(find.text('Loaded 40 sample entries across all categories!'), findsOneWidget);

    // Tap Delete Sample Data tile
    await tester.tap(find.byKey(const ValueKey('delete_sample_data_tile')));
    await tester.pumpAndSettle();

    expect(find.text('Delete Sample Data?'), findsOneWidget);

    // Confirm delete inside runAsync so Hive I/O runs in Zone.root
    await tester.runAsync(() async {
      await tester.tap(find.widgetWithText(FilledButton, 'Delete Sample Data'));
      for (int i = 0; i < 40; i++) {
        if (dbService.getEntries().isEmpty) break;
        await Future.delayed(const Duration(milliseconds: 50));
      }
    });
    await tester.pumpAndSettle();

    // Verify sample data removed
    expect(dbService.getEntries().length, 0);
    expect(find.text('Deleted 40 sample entries and sample collections.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
