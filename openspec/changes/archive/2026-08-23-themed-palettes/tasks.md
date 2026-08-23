## 1. Palette Registry

- [x] 1.1 Create `lib/core/theme/app_theme_name.dart` with `AppThemeName` enum (8 values: `defaultLight`, `defaultDark`, `solarizedLight`, `solarizedDark`, `abyss`, `kimbieDark`, `monokai`, `oneLight`) and `brightness` getter returning `Brightness.light` or `Brightness.dark` per variant
- [x] 1.2 Create `lib/core/theme/app_theme_registry.dart` with `AppThemeRegistry` class: a static `Map<AppThemeName, ThemeData> all` built once at class load, plus `lightPalettes` and `darkPalettes` filtered getters
- [x] 1.3 Implement `ThemeData` for `defaultLight` and `defaultDark` in the registry — copy current `AppTheme.lightTheme` / `AppTheme.darkTheme` values exactly so there is zero visual regression
- [x] 1.4 Implement `ThemeData` for `solarizedLight` (cream #FDF6E3 scaffold, base-1 surfaces, blue-green #268BD2 primary; `systemOverlayStyle`: transparent status bar, dark icons, light nav bar matching scaffold)
- [x] 1.5 Implement `ThemeData` for `solarizedDark` (base-03 #002B36 scaffold, base-02 surfaces, yellow #B58900 primary; `systemOverlayStyle`: transparent status bar, light icons, nav bar matching scaffold)
- [x] 1.6 Implement `ThemeData` for `abyss` (very dark navy #000C18 scaffold, #001122 surface, cyan #00B8D4 primary; `systemOverlayStyle`: transparent status bar, light icons, nav bar #000C18)
- [x] 1.7 Implement `ThemeData` for `kimbieDark` (warm dark brown #221A0F scaffold, #362712 surface, amber #E8A838 primary; `systemOverlayStyle`: transparent status bar, light icons, nav bar matching scaffold)
- [x] 1.8 Implement `ThemeData` for `monokai` (charcoal #272822 scaffold, #3E3D32 surface, bright green #A6E22E primary; `systemOverlayStyle`: transparent status bar, light icons, nav bar #272822)
- [x] 1.9 Implement `ThemeData` for `oneLight` (warm white #FAFAFA scaffold, #F0F0F0 surface, blue-purple #4078F2 primary; `systemOverlayStyle`: transparent status bar, dark icons, light nav bar matching scaffold)
- [x] 1.10 Delete `lib/core/theme/app_theme.dart` once all palettes are implemented in the registry (no shared constants need preserving — overlay styles live inside each palette's `appBarTheme`)
- [x] 1.11 Remove hardcoded `color: isDark ? const Color(0xFF1F2937) : Colors.white` overrides from `home_screen.dart:309` (`_buildEmptyState` Card), `entry_detail_screen.dart:238` (term display Card), and `entry_detail_screen.dart:315` (example sentence Container) — delete the explicit `color:` argument so `cardTheme` drives the surface colour, which is the correct fix for non-default dark palettes (Kimbie Dark, Abyss, Monokai all have different surface colours)

## 2. Theme Preference State

- [x] 2.1 Create `lib/core/models/app_theme_preference.dart` — immutable value class with fields `mode: ThemeMode`, `lightThemeName: AppThemeName`, `darkThemeName: AppThemeName`, and a `copyWith` method
- [x] 2.2 Create `lib/core/providers/theme_preference_provider.dart` with `AppThemePreferenceNotifier extends StateNotifier<AppThemePreference>`; implement `_load()` reading three SharedPrefs keys (`app_theme_mode`, `app_light_theme`, `app_dark_theme`) with safe fallbacks; implement `setMode()`, `setLightTheme()`, `setDarkTheme()` mutators that persist on change
- [x] 2.3 Add `appThemePreferenceProvider` top-level provider in the same file

## 3. Wire Up MaterialApp

- [x] 3.1 In `lib/main.dart`, replace `ref.watch(themeModeProvider)` with `ref.watch(appThemePreferenceProvider)` and derive `themeMode`, `theme`, and `darkTheme` from the preference via `AppThemeRegistry`
- [x] 3.2 Remove `ThemeModeNotifier` class and `themeModeProvider` from `main.dart`
- [x] 3.3 Verify app builds and runs showing the same default indigo themes as before

## 4. Appearance Settings UI

- [x] 4.1 Update `lib/features/settings/sub_pages/appearance_settings_page.dart` to import `theme_preference_provider.dart` instead of `main.dart`
- [x] 4.2 Replace the existing `DropdownButton<ThemeMode>` with a segmented/radio control offering "Light", "Dark", "System" labels, bound to `appThemePreferenceProvider.notifier.setMode()`
- [x] 4.3 Build a reusable `ThemeSwatchCard` widget (inline or in `lib/widgets/`) that accepts an `AppThemeName`, renders a 56×72 rounded card with three colour bands (scaffold, surface, primary), palette name beneath, and a primary-coloured border ring when `isSelected` is true
- [x] 4.4 Add a "☀ Light Mode Theme" section header and a horizontally-scrollable `SingleChildScrollView` of `ThemeSwatchCard` items for `AppThemeRegistry.lightPalettes`, bound to `appThemePreferenceProvider.notifier.setLightTheme()`
- [x] 4.5 Add a "🌙 Dark Mode Theme" section header and a horizontally-scrollable `SingleChildScrollView` of `ThemeSwatchCard` items for `AppThemeRegistry.darkPalettes`, bound to `appThemePreferenceProvider.notifier.setDarkTheme()`
- [x] 4.6 Ensure both palette rows are always visible and interactive regardless of the active mode

## 5. Verification

- [x] 5.1 Manually test: set mode to "System", pick Solarized Light + Abyss — verify OS brightness switch auto-swaps themes
- [x] 5.2 Manually test: set mode to "Light" — verify app shows Solarized Light regardless of OS brightness
- [x] 5.3 Manually test: set mode to "Dark" — verify app shows Abyss regardless of OS brightness
- [x] 5.4 Manually test: kill and relaunch app — verify selected palettes and mode are restored from persistence
- [x] 5.5 Manually test: first launch (clear SharedPrefs) — verify default indigo light/dark themes appear with no crash
