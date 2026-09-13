## 1. Palette Theme Registry
 
- [x] 1.1 Update `AppThemeRegistry._buildTheme` in `lib/core/theme/app_theme_registry.dart` to configure `navigationBarTheme` with `backgroundColor: bottomNavBackgroundColor`, `elevation: 0`, `indicatorColor: primaryColor.withValues(alpha: isDark ? 0.85 : 0.80)`, `iconTheme: WidgetStateProperty` resolving `fabForegroundColor` on selected and muted tone on unselected, `height: 62`, and `labelBehavior: NavigationDestinationLabelBehavior.alwaysHide`
- [x] 1.2 Configure `floatingActionButtonTheme` with `backgroundColor: primaryColor` and per-palette `fabForegroundColor` (with luminance fallback), calibrating `bottomNavBackgroundColor` across all 9 presets to VS Code Activity Bar specs
 
## 2. AppShell M3 Navigation Migration
 
- [x] 2.1 Update `lib/core/shell/app_shell.dart` to replace legacy `BottomNavigationBar` and `BottomNavigationBarItem` with Material 3 `NavigationBar` and `NavigationDestination`
- [x] 2.2 Wrap `NavigationBar` in a `Container` with a 1px top border matching the theme's card border color (`cardBorderColor`) and background matching `surfaceColor`
 
## 3. Settings UI Modernization
 
- [x] 3.1 Update `lib/features/settings/sub_pages/navigation_settings_page.dart` to modernize the startup tab selector from the legacy `DropdownButton` to a styled Material 3 container/menu matching the appearance page design language
 
## 4. Verification & Testing
 
- [x] 4.1 Update `test/theme_preference_provider_test.dart` to verify `navigationBarTheme`, `bottomNavigationBarTheme`, and `floatingActionButtonTheme` are configured on all presets with `elevation == 0`, non-null `indicatorColor`, and non-null `foregroundColor`
- [x] 4.2 Run `flutter test` and `flutter analyze` to verify 100% test pass rate with zero lint issues
