## Context

My Lexicon is a 100% offline, privacy-first personal dictionary and knowledge companion app published on F-Droid and Android. All user-facing strings are currently hardcoded in English, with scattered constants in `TitleConstants` / `TextConstants` and raw string literals in UI widgets.

To expand accessibility to international audiences, we are introducing localized strings and layout support starting with an initial batch of **Ukrainian (`uk`)**, **Russian (`ru`)**, **Persian / Farsi (`fa`)**, and **Hindi (`hi`)**, while architecting the localization pipeline to smoothly accommodate future Indian regional languages (**Marathi, Gujarati, Punjabi, Tamil, Telugu, Malayalam, Kannada, Bengali**).

## Goals / Non-Goals

**Goals:**
- Implement official Flutter localization (`flutter_localizations` + `intl` + `.arb` code generation).
- Extract all user-facing strings across all tabs, dialogs, forms, cards, and settings into `lib/l10n/app_en.arb`.
- Provide complete translation ARB files for `uk`, `ru`, `fa`, and `hi`.
- Create a dedicated `LanguageSettingsPage` in Settings allowing users to choose "System Default" or any supported language, with persistent state stored in `SharedPreferences`.
- Fully support Right-to-Left (RTL) for Persian (`fa`), including directional layout fixes for `FanOutFab`, padding, and navigation chevrons.
- Ensure 100% offline operation with zero internet permission and zero added font asset payload by leveraging the Android system font stack (Noto Sans Arabic, Noto Sans Devanagari, etc.).

**Non-Goals:**
- Translating user-generated entry content or database tags.
- Translating internal database enum keys stored in Hive (`word`, `quote`, etc.).
- Bundling heavy custom font files (`.ttf`) in APK assets.
- Enabling Android `INTERNET` permission.

## Decisions

### 1. Localization Engine: Flutter `gen-l10n` + ARB
- **Decision**: Use `flutter_localizations` from the Flutter SDK, `intl: ^0.20.3`, and `l10n.yaml` with `generate: true`.
- **Rationale**: Built into Flutter, officially supported, offline-friendly (compile-time code generation), zero third-party package dependencies, and standard `.arb` files can easily be shared with translators.
- **Alternatives Considered**:
  - `easy_localization`: Requires runtime asset loading and extra third-party dependencies.
  - `slang`: Powerful, but adds third-party dependencies when official Flutter tooling is completely adequate.

### 2. Language Preference & Persistence
- **Decision**: Implement `appLocalePreferenceProvider` with `SharedPreferences` storing locale code (`'system'`, `'en'`, `'uk'`, `'ru'`, `'fa'`, `'hi'`).
- **Rationale**: When `'system'` is selected, `MaterialApp.router` omits explicit `locale` or sets `null` so Flutter automatically matches the device's system locale. When a specific language is picked, it overrides the system locale immediately.

### 3. Settings Navigation
- **Decision**: Add a dedicated "Language" tile on `SettingsScreen` leading to `LanguageSettingsPage`.
- **Rationale**: Language affects the entire UI presentation, typography, and directionality. Grouping it under its own top-level settings tile matches user expectations and aligns with the app's modular sub-page architecture. Uses `Navigator.of(context).push(MaterialPageRoute(...))` per repository convention.

### 4. Native Endonym Display in Picker
- **Decision**: Display each language option in its native script alongside its English name (e.g. `Українська (Ukrainian)`, `Русский (Russian)`, `فارسی (Persian)`, `हिन्दी (Hindi)`).
- **Rationale**: Ensures speakers of that language can immediately find and select their native language even if the app initially boots in English.

### 5. Font Strategy & Offline Guarantee
- **Decision**: Do not bundle custom `.ttf` files; rely on Android's pre-installed system font stack (`Noto Sans Devanagari`, `Noto Sans Arabic`, etc.) via Android's font fallback mechanism.
- **Rationale**: Keeps APK size minimal, requires no network requests or internet permission, and renders native ligatures/matras correctly via HarfBuzz in Flutter.

### 6. Persian RTL & Layout Handling
- **Decision**:
  - Update `FanOutFab` to use `AlignmentDirectional.bottomEnd` and directional horizontal flow.
  - Convert hardcoded `EdgeInsets.only(left/right)` to `EdgeInsetsDirectional.only(start/end)` in list headers, cards, and chips.
  - Keep Western digits (`1, 2, 3`) for stats, badge counts, and search filtering to prevent confusion when browsing multilingual vocabulary.

### 7. Language Expansion Roadmap
- **Decision**: Architect the ARB structure so subsequent Indian languages (`mr`, `gu`, `pa`, `ta`, `te`, `ml`, `kn`, `bn`) can be added simply by creating `app_<locale>.arb` and registering the locale in the supported locales list without touching widget code.

### 8. Locale-Aware Date Formatting
- **Decision**: Pass the active locale's language code into every `DateFormat` call: `DateFormat('MMMM d, yyyy • hh:mm a', Localizations.localeOf(context).languageCode)`.
- **Rationale**: Without an explicit locale, `DateFormat` always produces English month names regardless of the active UI language. This is the only `DateFormat` call site in the codebase (`EntryDetailScreen`), so the fix is contained to a single line.
- **Note**: Western digits are retained for dates — only month and day-of-week names are localized.

### 9. Deprecation of `TextConstants` / `TitleConstants`
- **Decision**: After all usages are migrated to `AppLocalizations`, delete `lib/core/constants/text_constants.dart` entirely.
- **Rationale**: Keeping the constants file alongside `AppLocalizations` creates two competing sources of truth for UI strings, risks developers using the English-only constants in new code, and breaks the contract that all user-facing text flows through the l10n system.
- **Migration**: Each `TextConstants.*` and `TitleConstants.*` reference is replaced with the semantically equivalent `AppLocalizations.of(context)!.*` key during the string extraction pass.

## Risks / Trade-offs

- **[Risk] Text Expansion in Indic Scripts**: Indian language translations can be 20–40% longer in width, potentially causing button/chip overflow.
  - **Mitigation**: Choose concise terminology; verify `ButtonSegment` and tab labels on narrow screen widths.
- **[Risk] Directionality Collision in FanOutFab**: Anchored overlay follower might jump to bottom-left in RTL while backdrop links to right.
  - **Mitigation**: Explicitly refactor `CompositedTransformFollower` to use `AlignmentDirectional`.
- **[Risk] Build Errors if ARB keys mismatch**: If a key is missing in a secondary ARB, build might warn or fail.
  - **Mitigation**: Use `untranslated-messages-file` in `l10n.yaml` to detect missing keys and fallback to English.

## Migration Plan

No database migration is required. Hive stores entry data independently of UI localization. SharedPreferences key `app_locale` defaults to `'system'` for all existing users, preserving existing user experience seamlessly.
