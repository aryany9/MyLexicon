import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_theme_preference.dart';
import '../theme/app_theme_name.dart';

final appThemePreferenceProvider =
    StateNotifierProvider<AppThemePreferenceNotifier, AppThemePreference>((ref) {
  return AppThemePreferenceNotifier();
});

class AppThemePreferenceNotifier extends StateNotifier<AppThemePreference> {
  AppThemePreferenceNotifier() : super(const AppThemePreference()) {
    _load();
  }

  static const _modeKey = 'app_theme_mode';
  static const _lightThemeKey = 'app_light_theme';
  static const _darkThemeKey = 'app_dark_theme';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final modeStr = prefs.getString(_modeKey);
    final lightThemeStr = prefs.getString(_lightThemeKey);
    final darkThemeStr = prefs.getString(_darkThemeKey);

    ThemeMode mode = state.mode;
    if (modeStr != null) {
      mode = ThemeMode.values.firstWhere(
        (e) => e.name == modeStr,
        orElse: () => ThemeMode.system,
      );
    }

    AppThemeName lightThemeName = state.lightThemeName;
    if (lightThemeStr != null) {
      lightThemeName = AppThemeName.values.firstWhere(
        (e) => e.name == lightThemeStr && e.brightness == Brightness.light,
        orElse: () => AppThemeName.defaultLight,
      );
    }

    AppThemeName darkThemeName = state.darkThemeName;
    if (darkThemeStr != null) {
      darkThemeName = AppThemeName.values.firstWhere(
        (e) => e.name == darkThemeStr && e.brightness == Brightness.dark,
        orElse: () => AppThemeName.defaultDark,
      );
    }

    state = AppThemePreference(
      mode: mode,
      lightThemeName: lightThemeName,
      darkThemeName: darkThemeName,
    );
  }

  Future<void> setMode(ThemeMode mode) async {
    state = state.copyWith(mode: mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode.name);
  }

  Future<void> setLightTheme(AppThemeName name) async {
    if (name.brightness != Brightness.light) return;
    state = state.copyWith(lightThemeName: name);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lightThemeKey, name.name);
  }

  Future<void> setDarkTheme(AppThemeName name) async {
    if (name.brightness != Brightness.dark) return;
    state = state.copyWith(darkThemeName: name);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_darkThemeKey, name.name);
  }
}
