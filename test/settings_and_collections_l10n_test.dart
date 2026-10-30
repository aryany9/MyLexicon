import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/features/collections/collections_screen.dart';
import 'package:mylexicon/features/settings/settings_screen.dart';
import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';

void main() {
  testWidgets('SettingsScreen displays localized subtitles in Ukrainian',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('uk'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Ukrainian navigation and data subtitles
    expect(find.text('Початковий екран, вкладки, функції'), findsOneWidget);
    expect(find.text('Експорт, імпорт та очищення'), findsOneWidget);
  });

  testWidgets('SettingsScreen displays localized subtitles in Russian',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('ru'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Russian navigation and data subtitles
    expect(find.text('Начальный экран, вкладки, функции'), findsOneWidget);
    expect(find.text('Экспорт, импорт и очистка'), findsOneWidget);
  });

  testWidgets(
      'CollectionsScreen displays localized entry count on 3rd line of collection card',
      (tester) async {
    final testCollection = LexiconCollection(
      id: 'col-1',
      name: 'Test Collection',
      description: 'A test description',
      colorValue: 0xFF2196F3,
      createdAt: DateTime.now(),
    );

    final testEntry = LexiconEntry(
      id: 'e-1',
      term: 'Test Term',
      definition: 'Test Definition',
      type: LexiconType.word,
      tags: [],
      isFavorite: false,
      collectionId: 'col-1',
      createdAt: DateTime.now(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          collectionsProvider.overrideWith((ref) => Stream.value([testCollection])),
          entriesProvider.overrideWith((ref) => Stream.value([testEntry])),
        ],
        child: const MaterialApp(
          locale: Locale('uk'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: CollectionsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1 item in collection in Ukrainian -> "1 запис" (not "1 entry" or "1 entries")
    expect(find.text('1 запис'), findsOneWidget);
  });
}
