## Why

MyLexicon currently offers only a binary light/dark theme toggle, both hardcoded to an indigo seed palette. Users — particularly those accustomed to expressive editor themes like Abyss, Solarized, or Kimbie Dark — have no way to personalise the app's visual identity beyond brightness. Adding named palette themes makes the app feel crafted and personal.

## What Changes

- Introduce a curated set of named theme palettes (light and dark variants where applicable)
- Replace the single `ThemeMode` provider with a richer `AppThemePreference` state that stores mode + chosen light theme + chosen dark theme
- Update `MaterialApp.router` to dynamically resolve the correct `ThemeData` from user preferences
- Redesign the Appearance settings page to show a two-slot theme picker (☀ Light / 🌙 Dark) alongside the existing mode toggle (Light / Dark / System)
- Persist theme preferences via `SharedPreferences`

## Capabilities

### New Capabilities

- `theme-palettes`: A catalogue of named theme palettes (Default Light, Default Dark, Solarized Light, Solarized Dark, Abyss, Kimbie Dark, Monokai, One Light) each defined as a complete `ThemeData`. Palettes are tagged as light-compatible or dark-compatible.
- `theme-preference`: User preference state that stores the active mode (light / dark / system) plus the chosen light-slot theme and dark-slot theme. Persisted across launches and resolved at runtime to produce the active `ThemeData`.

### Modified Capabilities

- `list-density`: No requirement changes — appearance settings UI restructuring may affect layout but not the density behaviour itself.

## Impact

- **`lib/main.dart`** — `themeModeProvider` / `ThemeModeNotifier` replaced by the new `AppThemePreferenceNotifier`
- **`lib/core/theme/app_theme.dart`** — extended from two static getters to a palette registry
- **`lib/features/settings/sub_pages/appearance_settings_page.dart`** — UI overhauled to render theme swatches and dual-slot picker
- **No new packages required** — implementation uses Flutter's built-in `ThemeData` / `ColorScheme` APIs and existing `shared_preferences` dependency
