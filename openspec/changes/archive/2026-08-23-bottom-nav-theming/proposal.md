## Why

While MyLexicon uses Material 3 for themes, cards, dialogs, and inputs, the persistent navigation shell in `AppShell` still uses the legacy Material 2 `BottomNavigationBar`, and navigation settings still uses the legacy `DropdownButton`. These components lack modern Material 3 pill indicators, have uncalibrated inactive contrast on custom editor palettes (Abyss, Solarized, Kimbie Dark), and introduce visual inconsistency with the rest of the application.

## What Changes

- Migrate `AppShell` from legacy `BottomNavigationBar` to Material 3 `NavigationBar` with `NavigationDestination`.
- Tune `NavigationBar` height (~62px) and hide labels (`alwaysHide`) to maintain high information density and prevent crowding when all 7 dynamic tabs are enabled.
- Configure `navigationBarTheme` and `bottomNavigationBarTheme` for all palettes in `AppThemeRegistry` with explicit `bottomNavBackgroundColor` calibrated to VS Code's Activity Bar / Status Bar palettes.
- Add `floatingActionButtonTheme` with `fabForegroundColor` (and luminance fallback) across all palettes to guarantee high contrast on bright/dark primary accents.
- Harmonize the active tab indicator pill (solid accent, ~80-85% alpha) and active icon color (`fabForegroundColor`) with the FAB contrast model.
- Synchronize Android system navigation bar color (`systemNavigationBarColor`) to `bottomNavBackgroundColor` for seamless edge-to-edge rendering.
- Modernize legacy `DropdownButton` in `navigation_settings_page.dart` to match modern Material 3 styling.
- Add a crisp 1px top border to the navigation bar matching the active palette's card border.

## Capabilities

### Modified Capabilities

- `bottom-navigation`: Migrate to Material 3 `NavigationBar` with active pill indicator and VS Code-calibrated palette harmonization.
- `theme-palettes`: Add `navigationBarTheme`, `bottomNavigationBarTheme`, and `floatingActionButtonTheme` to mandatory `ThemeData` palette components with `bottomNavBackgroundColor` and `fabForegroundColor`.

## Impact

- **`lib/core/theme/app_theme_registry.dart`**: Add `navigationBarTheme`, `floatingActionButtonTheme`, and per-palette `bottomNavBackgroundColor`/`fabForegroundColor` configuration.
- **`lib/core/shell/app_shell.dart`**: Replace `BottomNavigationBar` with `NavigationBar` + `NavigationDestination` and 1px card-matched top border.
- **`lib/features/settings/sub_pages/navigation_settings_page.dart`**: Replace legacy `DropdownButton` with M3-compatible selector.
- **`test/theme_preference_provider_test.dart`**: Verify `navigationBarTheme` and `bottomNavigationBarTheme` on all theme presets.
