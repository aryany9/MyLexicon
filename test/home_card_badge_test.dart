import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mylexicon/core/providers/display_preferences_provider.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/features/home/home_screen.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';

int _homeBoxCounter = 0;

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
    _homeBoxCounter++;
    tempDir = await Directory.systemTemp.createTemp('home_badge_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('home_entries_$_homeBoxCounter');
    collectionsBox =
        await Hive.openBox<LexiconCollection>('home_cols_$_homeBoxCounter');
    dbService = DatabaseService(
      entriesBox: entriesBox,
      collectionsBox: collectionsBox,
    );

    // Seed one entry
    await dbService.saveEntry(
      LexiconEntry(
        id: 'test_entry_1',
        term: 'Serendipity',
        definition: 'Occurrence of events by chance in a happy way.',
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
      'HomeScreen entry card starts with word, shows badge below word when enabled, and heart on right',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
          showTypeBadgesProvider.overrideWith((ref) {
            final notifier = ShowTypeBadgesNotifier();
            notifier.state = true;
            return notifier;
          }),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    // Verify word and badge are both present
    final wordFinder = find.text('Serendipity');
    final badgeFinder = find.text('WORD');
    final heartFinder = find.byIcon(Icons.favorite_border);

    expect(wordFinder, findsOneWidget);
    expect(badgeFinder, findsOneWidget);
    expect(heartFinder, findsOneWidget);

    // Badge should be BELOW the word vertically (badge top > word top)
    final wordTop = tester.getTopLeft(wordFinder).dy;
    final badgeTop = tester.getTopLeft(badgeFinder).dy;
    expect(badgeTop, greaterThan(wordTop));

    // Heart should be to the RIGHT of the word (heart left > word right)
    final wordRight = tester.getTopRight(wordFinder).dx;
    final heartLeft = tester.getTopLeft(heartFinder).dx;
    expect(heartLeft, greaterThan(wordRight));
  });

  testWidgets(
      'HomeScreen entry card starts with word and hides badge when badges are disabled',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
          showTypeBadgesProvider.overrideWith((ref) {
            final notifier = ShowTypeBadgesNotifier();
            notifier.state = false;
            return notifier;
          }),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    // Verify word is present, badge is hidden, heart is present
    final wordFinder = find.text('Serendipity');
    final badgeFinder = find.text('WORD');
    final heartFinder = find.byIcon(Icons.favorite_border);

    expect(wordFinder, findsOneWidget);
    expect(badgeFinder, findsNothing);
    expect(heartFinder, findsOneWidget);

    // Word should start right at the top of the header row alongside the heart
    final wordTop = tester.getTopLeft(wordFinder).dy;
    final heartTop = tester.getTopLeft(heartFinder).dy;
    // Word and heart should be roughly aligned at the top of the card
    expect((wordTop - heartTop).abs(), lessThan(20.0));
  });
}
