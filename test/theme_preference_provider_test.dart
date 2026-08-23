import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mylexicon/core/providers/theme_preference_provider.dart';
import 'package:mylexicon/core/theme/app_theme_name.dart';
import 'package:mylexicon/core/theme/app_theme_registry.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AppThemeRegistry Tests', () {
    test('Registry contains all theme palettes', () {
      expect(AppThemeRegistry.all.length, AppThemeName.values.length);
      for (final name in AppThemeName.values) {
        final theme = AppThemeRegistry.getTheme(name);
        expect(theme, isNotNull);
        expect(theme.brightness, name.brightness);
      }
    });

    test('Filtered light and dark palettes return correct subsets', () {
      final lightPalettes = AppThemeRegistry.lightPalettes;
      final darkPalettes = AppThemeRegistry.darkPalettes;

      expect(lightPalettes.length, 4);
      expect(darkPalettes.length, 5);

      for (final p in lightPalettes) {
        expect(p.brightness, Brightness.light);
      }
      for (final p in darkPalettes) {
        expect(p.brightness, Brightness.dark);
      }
    });

    test('Each palette has defined palette colors', () {
      for (final name in AppThemeName.values) {
        final colors = AppThemeRegistry.getColors(name);
        expect(colors.scaffoldColor, isNotNull);
        expect(colors.surfaceColor, isNotNull);
        expect(colors.primaryColor, isNotNull);
      }
    });

    test('Each palette configures navigationBarTheme and floatingActionButtonTheme', () {
      for (final name in AppThemeName.values) {
        final theme = AppThemeRegistry.getTheme(name);
        final navBarTheme = theme.navigationBarTheme;
        expect(navBarTheme, isNotNull);
        expect(navBarTheme.elevation, 0);
        expect(navBarTheme.indicatorColor, isNotNull);
        expect(navBarTheme.backgroundColor, isNotNull);
        expect(navBarTheme.height, 62);

        final bottomNavTheme = theme.bottomNavigationBarTheme;
        expect(bottomNavTheme, isNotNull);
        expect(bottomNavTheme.elevation, 0);
        expect(bottomNavTheme.backgroundColor, isNotNull);

        final fabTheme = theme.floatingActionButtonTheme;
        expect(fabTheme, isNotNull);
        expect(fabTheme.backgroundColor, isNotNull);
        expect(fabTheme.foregroundColor, isNotNull);
      }
    });
  });

  group('AppThemePreferenceNotifier Tests', () {
    test('Default preference is system with defaultLight and defaultDark', () {
      final notifier = AppThemePreferenceNotifier();
      expect(notifier.state.mode, ThemeMode.system);
      expect(notifier.state.lightThemeName, AppThemeName.defaultLight);
      expect(notifier.state.darkThemeName, AppThemeName.defaultDark);
    });

    test(
      'Setting mode updates state and persists to SharedPreferences',
      () async {
        final notifier = AppThemePreferenceNotifier();

        await notifier.setMode(ThemeMode.dark);
        expect(notifier.state.mode, ThemeMode.dark);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('app_theme_mode'), 'dark');
      },
    );

    test('Setting light theme updates state and persists', () async {
      final notifier = AppThemePreferenceNotifier();

      await notifier.setLightTheme(AppThemeName.solarizedLight);
      expect(notifier.state.lightThemeName, AppThemeName.solarizedLight);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('app_light_theme'), 'solarizedLight');
    });

    test('Setting dark theme updates state and persists', () async {
      final notifier = AppThemePreferenceNotifier();

      await notifier.setDarkTheme(AppThemeName.abyss);
      expect(notifier.state.darkThemeName, AppThemeName.abyss);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('app_dark_theme'), 'abyss');
    });

    test('Recreating notifier with saved values restores preference', () async {
      SharedPreferences.setMockInitialValues({
        'app_theme_mode': 'light',
        'app_light_theme': 'solarizedLight',
        'app_dark_theme': 'kimbieDark',
      });

      final notifier = AppThemePreferenceNotifier();
      await Future<void>.delayed(Duration.zero);

      expect(notifier.state.mode, ThemeMode.light);
      expect(notifier.state.lightThemeName, AppThemeName.solarizedLight);
      expect(notifier.state.darkThemeName, AppThemeName.kimbieDark);
    });

    test(
      'Corrupted or invalid theme strings safely fall back to defaults',
      () async {
        SharedPreferences.setMockInitialValues({
          'app_theme_mode': 'invalid_mode',
          'app_light_theme':
              'abyss', // dark theme assigned to light slot -> invalid
          'app_dark_theme': 'non_existent',
        });

        final notifier = AppThemePreferenceNotifier();
        await Future<void>.delayed(Duration.zero);

        expect(notifier.state.mode, ThemeMode.system);
        expect(notifier.state.lightThemeName, AppThemeName.defaultLight);
        expect(notifier.state.darkThemeName, AppThemeName.defaultDark);
      },
    );
  });
}
