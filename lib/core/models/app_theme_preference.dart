import 'package:flutter/material.dart';
import '../theme/app_theme_name.dart';

class AppThemePreference {
  final ThemeMode mode;
  final AppThemeName lightThemeName;
  final AppThemeName darkThemeName;

  const AppThemePreference({
    this.mode = ThemeMode.system,
    this.lightThemeName = AppThemeName.defaultLight,
    this.darkThemeName = AppThemeName.defaultDark,
  });

  AppThemePreference copyWith({
    ThemeMode? mode,
    AppThemeName? lightThemeName,
    AppThemeName? darkThemeName,
  }) {
    return AppThemePreference(
      mode: mode ?? this.mode,
      lightThemeName: lightThemeName ?? this.lightThemeName,
      darkThemeName: darkThemeName ?? this.darkThemeName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppThemePreference &&
        other.mode == mode &&
        other.lightThemeName == lightThemeName &&
        other.darkThemeName == darkThemeName;
  }

  @override
  int get hashCode => Object.hash(mode, lightThemeName, darkThemeName);
}
