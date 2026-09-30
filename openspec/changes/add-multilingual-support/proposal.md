## Why

My Lexicon currently hardcodes all UI labels and messages in English, limiting accessibility for non-English speakers and polyglots. Adding multilingual support allows users worldwide to navigate the app in their native language while continuing to use it as an offline personal knowledge companion.

## What Changes

- **Localization Infrastructure**: Integrate Flutter's official `flutter_localizations` and `intl` with code generation (`gen-l10n`) and `.arb` files.
- **Language Preference Management**: Provide an in-app language picker allowing users to follow the system default or explicitly select an app language.
- **Language Settings Screen**: Add a dedicated "Language" sub-page to the Settings menu following the app's established inner-navigator and `PopScope` patterns.
- **Initial Language Batch**:
  - English (`en`) - baseline
  - Ukrainian (`uk`) - Cyrillic LTR
  - Russian (`ru`) - Cyrillic LTR
  - Persian / Farsi (`fa`) - Perso-Arabic RTL
  - Hindi (`hi`) - Devanagari Indic LTR
- **Planned Upcoming Languages (Roadmap)**:
  - Marathi (`mr`), Gujarati (`gu`), Punjabi (`pa`), Tamil (`ta`), Telugu (`te`), Malayalam (`ml`), Kannada (`kn`), Bengali (`bn`).
- **RTL & Directionality Polish**: Ensure `FanOutFab`, horizontal padding, and navigation icons adapt seamlessly when Right-to-Left (Persian) is active.
- **Zero Network / 100% Offline Guarantee**: Rely strictly on bundled assets and Android's offline system font stack (Noto Sans Devanagari, Noto Sans Arabic, etc.) with no Internet permission.

## Capabilities

### New Capabilities
- `localization`: System and manual locale management, `.arb`-driven localization delegates, language settings page, and localized strings for initial batch (`en`, `uk`, `ru`, `fa`, `hi`) with planned Indic expansion (`mr`, `gu`, `pa`, `ta`, `te`, `ml`, `kn`, `bn`).

### Modified Capabilities
<!-- No requirement changes to existing capability behaviors. Hive data models and storage formats remain intact. -->

## Impact

- **Dependencies**: Add `flutter_localizations` (from Flutter SDK) in `pubspec.yaml`, enable `generate: true`.
- **Files Modified**: `lib/main.dart`, `lib/core/shell/app_shell.dart`, `lib/features/settings/settings_screen.dart`, all UI screens and custom cards to use `AppLocalizations`.
- **New Files**: `l10n.yaml`, `lib/l10n/app_en.arb`, `lib/l10n/app_uk.arb`, `lib/l10n/app_ru.arb`, `lib/l10n/app_fa.arb`, `lib/l10n/app_hi.arb`, `lib/features/settings/sub_pages/language_settings_page.dart`, `lib/core/providers/locale_preference_provider.dart`.
- **Database & Storage**: No schema migrations or breaking changes; enum values in Hive remain unchanged.
