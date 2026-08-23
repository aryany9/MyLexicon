import 'package:flutter/material.dart';

enum AppThemeName {
  defaultLight,
  defaultDark,
  solarizedLight,
  solarizedDark,
  abyss,
  kimbieDark,
  monokai,
  oneLight,
  quietLight;

  Brightness get brightness {
    switch (this) {
      case AppThemeName.defaultLight:
      case AppThemeName.solarizedLight:
      case AppThemeName.oneLight:
      case AppThemeName.quietLight:
        return Brightness.light;
      case AppThemeName.defaultDark:
      case AppThemeName.solarizedDark:
      case AppThemeName.abyss:
      case AppThemeName.kimbieDark:
      case AppThemeName.monokai:
        return Brightness.dark;
    }
  }

  String get displayName {
    switch (this) {
      case AppThemeName.defaultLight:
        return 'Default Light';
      case AppThemeName.defaultDark:
        return 'Default Dark';
      case AppThemeName.solarizedLight:
        return 'Solarized Light';
      case AppThemeName.solarizedDark:
        return 'Solarized Dark';
      case AppThemeName.abyss:
        return 'Abyss';
      case AppThemeName.kimbieDark:
        return 'Kimbie Dark';
      case AppThemeName.monokai:
        return 'Monokai';
      case AppThemeName.oneLight:
        return 'One Light';
      case AppThemeName.quietLight:
        return 'Quiet Light';
    }
  }
}
