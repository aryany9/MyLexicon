## 1. Localization Toolchain & Infrastructure

- [x] 1.1 Add `flutter_localizations` from Flutter SDK to `pubspec.yaml` and add `generate: true` as a top-level key directly under `flutter:` (not under the icon generator sub-keys `web`, `windows`, or `macos` which already have their own `generate: false` flags for `flutter_launcher_icons`)
- [x] 1.2 Create `l10n.yaml` in project root configuring `arb-dir: lib/l10n`, `template-arb-file: app_en.arb`, `output-localization-file: app_localizations.dart`, and `untranslated-messages-file: l10n_untranslated.txt` to catch missing keys
- [x] 1.3 Create `lib/core/providers/locale_preference_provider.dart` to manage and persist user locale preference (`'system'`, `'en'`, `'uk'`, `'ru'`, `'fa'`, `'hi'`) in `SharedPreferences`
- [x] 1.4 Update `lib/main.dart` (`MyLexiconApp`) to listen to `localePreferenceProvider` and configure `localizationsDelegates`, `supportedLocales`, and `locale` on `MaterialApp.router`

## 2. String Extraction & UI Refactoring

- [x] 2.1 Create `lib/l10n/app_en.arb` extracting all user-facing UI strings: navigation labels, dashboard sections, entry form fields, singular and plural category names, dialog titles/buttons, filter chips, tooltips, input hint/label text, SnackBar messages, and settings screen strings
- [x] 2.2 Create localized helper extensions on `LexiconType` and `AppFeature` providing both singular (`word`, `quote`, etc.) and plural (`words`, `quotes`, etc.) localized labels from `AppLocalizations`
- [x] 2.3 Fix all type badges, filter chips, and duplicate indicators across the app (`lib/widgets/words_card.dart`, `lib/features/home/home_screen.dart`, `lib/features/search/search_screen.dart`, `lib/features/dictionary/entry_detail_screen.dart`, and `lib/features/dictionary/widgets/duplicate_warning_card.dart`): replace all direct `type.name` and `entry.type.name.toUpperCase()` calls with the localized helper extension from task 2.2
- [x] 2.4 Fix `ImportPreviewScreen` (`lib/features/settings/import_preview_screen.dart`): replace `duplicate.existingEntry.type.name` (raw enum) with the localized type label, and extract all interpolated strings (`'Entries detected'`, `'Import failed: ...'`, `'Skip'`, `'Overwrite'`, `'Merge'`, `'Preview Content'`, `'Resolution Strategy'`, etc.) into ARB keys
- [x] 2.5 Refactor `lib/core/shell/app_shell.dart` to render localized tab labels dynamically from `AppLocalizations`
- [x] 2.6 Refactor `HomeScreen`, `CategoryListScreen`, `SearchScreen`, and `CollectionsScreen` to replace hardcoded strings (including all `TextConstants.*` references, sort order labels, and batch deletion dialogs with plural ARB parameters) with `AppLocalizations`
- [x] 2.7 Refactor `EntryFormScreen`, `EntryDetailScreen`, and custom widgets (`StatCard`): replace hardcoded strings with `AppLocalizations`, and ensure duplicate term error in `EntryFormScreen` displays a localized message instead of the raw English `ArgumentError` from `DatabaseService`
- [x] 2.8 Refactor `SettingsScreen` and sub-pages (`AppearanceSettingsPage`, `TagsSettingsPage`, `DataSettingsPage`, `AboutSettingsPage`) — covering all inline `const Text(...)` strings, dialog buttons, and all SnackBar message strings in each file (~30 SnackBar calls total across these files)
- [x] 2.9 Refactor `NavigationSettingsPage`: migrate the standalone top-level functions `_getTabName()` and `_getFeatureSubtitle()` — which hardcode English tab and feature description strings — to accept `AppLocalizations l10n` and return the localized equivalent, threading `context` into `_buildNavigationSection` and `_buildFeaturesSection` call sites; also extract the SnackBar `'At least one category must remain enabled'` string
- [x] 2.10 Make `DateFormat` locale-aware in `EntryDetailScreen` (`lib/features/dictionary/entry_detail_screen.dart`): change `DateFormat('MMMM d, yyyy • hh:mm a')` to `DateFormat('MMMM d, yyyy • hh:mm a', Localizations.localeOf(context).languageCode)` so month names render in the active locale
- [x] 2.11 Deprecate and delete `lib/core/constants/text_constants.dart` (`TextConstants`, `TitleConstants`) after all usages are replaced with `AppLocalizations` keys — ensuring no stale English-only fallback constants remain as a parallel source of truth for UI strings

## 3. Translation Files for Initial Batch (uk, ru, fa, hi)

- [x] 3.1 Create `lib/l10n/app_uk.arb` containing complete Ukrainian translations for all keys defined in `app_en.arb`
- [x] 3.2 Create `lib/l10n/app_ru.arb` containing complete Russian translations for all keys defined in `app_en.arb`
- [x] 3.3 Create `lib/l10n/app_fa.arb` containing complete Persian translations for all keys defined in `app_en.arb`
- [x] 3.4 Create `lib/l10n/app_hi.arb` containing complete Hindi translations for all keys defined in `app_en.arb`
- [x] 3.5 Run `flutter gen-l10n` to compile ARB files; verify `l10n_untranslated.txt` is empty (zero missing keys across all locales)

## 4. Language Settings Screen

- [x] 4.1 Create `lib/features/settings/sub_pages/language_settings_page.dart` with a radio list showing each language by its native endonym: `"English"`, `"Українська (Ukrainian)"`, `"Русский (Russian)"`, `"فارسی (Persian)"`, `"हिन्दी (Hindi)"`; selecting an option writes to `localePreferenceProvider` and updates the app locale immediately without requiring an app restart
- [x] 4.2 Add `"Language"` list tile with `Icons.translate` to `lib/features/settings/settings_screen.dart`, pushing `LanguageSettingsPage` via `Navigator.of(context).push(MaterialPageRoute(...))`
- [x] 4.3 Wrap `LanguageSettingsPage` in `PopScope(canPop: false)` checking `Navigator.of(context).canPop()` before falling back to `context.go('/')`, per repository back-navigation rules

## 5. Right-to-Left (RTL) Layout Polish

- [x] 5.1 Refactor `FanOutFab` (`lib/widgets/fan_out_fab.dart`): change `CompositedTransformFollower` anchors from `Alignment.bottomRight` to `AlignmentDirectional.bottomEnd`, and update `CrossAxisAlignment.end` inside the fan-out `Column` to remain directionally correct, so the FAB overlay expands from the correct corner in RTL
- [x] 5.2 Convert hardcoded `EdgeInsets.only(right: 8)` to `EdgeInsetsDirectional.only(end: 8)` in `home_screen.dart` (tag chip row padding) and `search_screen.dart` (filter chip row padding)
- [x] 5.3 Audit all `Icons.chevron_right` / `Icons.chevron_right_rounded` usages in `SettingsScreen`, `AppearanceSettingsPage`, `AboutSettingsPage`, `PreferencePickerRow`, and `PreferencePickerCard`; wrap with `Directionality.of(context) == TextDirection.rtl` check or use `Icons.chevron_left` for RTL, so navigation arrows always point toward content

## 6. Verification & Versioning

- [x] 6.1 Update existing widget test helpers (`test/words_card_test.dart`, `test/navigation_settings_page_test.dart`, `test/fan_out_fab_test.dart`, `test/home_card_badge_test.dart`) to provide `AppLocalizations.localizationsDelegates` and `AppLocalizations.supportedLocales` in their `MaterialApp` wrappers so tests continue to pass with localization active
- [x] 6.2 Run `flutter analyze` and `flutter test` to confirm zero errors and all tests passing
- [x] 6.3 Smoke-test each locale: run the app with device/emulator language set to Ukrainian, Russian, Persian, and Hindi; verify all screens, dialogs, SnackBars, and type badges render in the target language with no English fallback strings visible
- [x] 6.4 Verify RTL layout smoke-test: set device to Persian and confirm `FanOutFab` expands from bottom-start, chevrons face the correct direction, and tag chip padding does not appear mirrored
- [x] 6.5 Bump version in `pubspec.yaml` (minor version bump per AGENTS.md policy)
- [x] 6.6 Update `CHANGELOG.md` with release notes for the version bump
- [x] 6.7 Create matching Fastlane changelogs (`51.txt`, `52.txt`, `53.txt`) per AGENTS.md rules
