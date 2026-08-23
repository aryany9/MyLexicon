## Why

While MyLexicon uses Material 3 for themes, cards, dialogs, and inputs, the persistent navigation shell in `AppShell` still uses the legacy Material 2 `BottomNavigationBar`, and navigation settings still uses the legacy `DropdownButton`. These components lack modern Material 3 pill indicators, have uncalibrated inactive contrast on custom editor palettes (Abyss, Solarized, Kimbie Dark), and introduce visual inconsistency with the rest of the application.

## What Changes

- Migrate `AppShell` from legacy `BottomNavigationBar` to Material 3 `NavigationBar` with `NavigationDestination`.
- Tune `NavigationBar` height (~62px) and hide labels (`alwaysHide`) to maintain high information density and prevent crowding when all 7 dynamic tabs are enabled.
- Configure `navigationBarTheme` for all 8 palettes in `AppThemeRegistry` (`backgroundColor: surfaceColor`, `elevation: 0`, `indicatorColor: primary.withValues(alpha: 0.20)`, primary active icon, muted inactive icon).
- Modernize legacy `DropdownButton` in `navigation_settings_page.dart` to match modern Material 3 styling.
- Add a crisp 1px top border to the navigation bar matching the active palette's card border.

## Capabilities

### Modified Capabilities

- `bottom-navigation`: Migrate to Material 3 `NavigationBar` with active pill indicator and palette harmonization.
- `theme-palettes`: Add `navigationBarTheme` to mandatory `ThemeData` palette components.

## Impact

- **`lib/core/theme/app_theme_registry.dart`**: Add `navigationBarTheme` configuration to `_buildTheme`.
- **`lib/core/shell/app_shell.dart`**: Replace `BottomNavigationBar` with `NavigationBar` + `NavigationDestination`.
- **`lib/features/settings/sub_pages/navigation_settings_page.dart`**: Replace legacy `DropdownButton` with M3-compatible selector.
- **`test/theme_preference_provider_test.dart`**: Verify `navigationBarTheme` on all 8 theme presets.
