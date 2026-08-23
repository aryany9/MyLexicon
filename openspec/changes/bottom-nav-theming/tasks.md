## 1. Palette Theme Registry

- [ ] 1.1 Update `AppThemeRegistry._buildTheme` in `lib/core/theme/app_theme_registry.dart` to configure `navigationBarTheme` with `backgroundColor: surfaceColor`, `elevation: 0`, `indicatorColor: primaryColor.withValues(alpha: isDark ? 0.25 : 0.20)`, `iconTheme: WidgetStateProperty` resolving primary color on selected and muted tone on unselected, `height: 62`, and `labelBehavior: NavigationDestinationLabelBehavior.alwaysHide`

## 2. AppShell M3 Navigation Migration

- [ ] 2.1 Update `lib/core/shell/app_shell.dart` to replace legacy `BottomNavigationBar` and `BottomNavigationBarItem` with Material 3 `NavigationBar` and `NavigationDestination`
- [ ] 2.2 Wrap `NavigationBar` in a `Container` with a 1px top border matching the theme's card border color (`cardBorderColor`) and background matching `surfaceColor`

## 3. Settings UI Modernization

- [ ] 3.1 Update `lib/features/settings/sub_pages/navigation_settings_page.dart` to modernize the startup tab selector from the legacy `DropdownButton` to a styled Material 3 container/menu matching the appearance page design language

## 4. Verification & Testing

- [ ] 4.1 Update `test/theme_preference_provider_test.dart` to verify `navigationBarTheme` is configured on all 8 presets with `elevation == 0`, non-null `indicatorColor`, and matching surface background
- [ ] 4.2 Run `flutter test` and `flutter analyze` to verify 100% test pass rate with zero lint issues
