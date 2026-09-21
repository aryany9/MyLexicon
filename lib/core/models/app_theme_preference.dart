import 'package:flutter/material.dart';
import '../theme/app_theme_name.dart';

class AppThemePreference {
  final ThemeMode mode;
  final AppThemeName lightThemeName;
  final AppThemeName darkThemeName;
  final bool isAmoled;

  const AppThemePreference({
    this.mode = ThemeMode.system,
    this.lightThemeName = AppThemeName.defaultLight,
    this.darkThemeName = AppThemeName.defaultDark,
    this.isAmoled = false,
  });

  AppThemePreference copyWith({
    ThemeMode? mode,
    AppThemeName? lightThemeName,
    AppThemeName? darkThemeName,
    bool? isAmoled,
  }) {
    return AppThemePreference(
      mode: mode ?? this.mode,
      lightThemeName: lightThemeName ?? this.lightThemeName,
      darkThemeName: darkThemeName ?? this.darkThemeName,
      isAmoled: isAmoled ?? this.isAmoled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppThemePreference &&
        other.mode == mode &&
        other.lightThemeName == lightThemeName &&
        other.darkThemeName == darkThemeName &&
        other.isAmoled == isAmoled;
  }

  @override
  int get hashCode =>
      Object.hash(mode, lightThemeName, darkThemeName, isAmoled);
}
