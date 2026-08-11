import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mylexicon/core/providers/display_preferences_provider.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';
import 'package:mylexicon/widgets/words_card.dart';

int _boxCounter = 100;

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
    tempDir = await Directory.systemTemp.createTemp('words_card_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('wc_entries_$_boxCounter');
    collectionsBox = await Hive.openBox<LexiconCollection>('wc_cols_$_boxCounter');
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

  Widget buildCardWidget(LexiconEntry entry, ListDensity density) {
    return ProviderScope(
      key: ValueKey(density),
      overrides: [
        databaseServiceProvider.overrideWithValue(dbService),
        listDensityProvider.overrideWith((ref) {
          final notifier = ListDensityNotifier();
          notifier.state = density;
          return notifier;
        }),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return WordsCard(ref: ref, entry: entry);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final testEntry = LexiconEntry(
    id: 'e1',
    term: 'Serendipity',
    definition: 'Occurrence of events by chance in a happy way',
    type: LexiconType.word,
    examples: ['Pure serendipity!'],
    tags: ['happy', 'vocab'],
    isFavorite: false,
    createdAt: DateTime.now(),
  );

  testWidgets('Compact renders only the term text and no definition or tags', (tester) async {
    await tester.pumpWidget(buildCardWidget(testEntry, ListDensity.compact));

    expect(find.text('Serendipity'), findsOneWidget);
    expect(find.text('Occurrence of events by chance in a happy way'), findsNothing);
    expect(find.text('"Pure serendipity!"'), findsNothing);
    expect(find.text('#happy'), findsNothing);
  });

  testWidgets('Comfortable renders term and definition but not examples or tags', (tester) async {
    await tester.pumpWidget(buildCardWidget(testEntry, ListDensity.comfortable));

    expect(find.text('Serendipity'), findsOneWidget);
    expect(find.text('Occurrence of events by chance in a happy way'), findsOneWidget);
    expect(find.text('"Pure serendipity!"'), findsNothing);
    expect(find.text('#happy'), findsNothing);
  });

  testWidgets('Detailed renders full card including definition, examples, and tags', (tester) async {
    await tester.pumpWidget(buildCardWidget(testEntry, ListDensity.detailed));

    expect(find.text('Serendipity'), findsOneWidget);
    expect(find.text('Occurrence of events by chance in a happy way'), findsOneWidget);
    expect(find.text('"Pure serendipity!"'), findsOneWidget);
    expect(find.text('#happy'), findsOneWidget);
  });

  testWidgets('Compact mode produces a measurably smaller rendered height than Detailed', (tester) async {
    await tester.pumpWidget(buildCardWidget(testEntry, ListDensity.compact));
    await tester.pumpAndSettle();
    final compactSize = tester.getSize(find.byType(WordsCard));

    await tester.pumpWidget(buildCardWidget(testEntry, ListDensity.detailed));
    await tester.pumpAndSettle();
    final detailedSize = tester.getSize(find.byType(WordsCard));

    expect(compactSize.height, lessThan(detailedSize.height));
  });
}
