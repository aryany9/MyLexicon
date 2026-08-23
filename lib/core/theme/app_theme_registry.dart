import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_theme_name.dart';

class PaletteColors {
  final Color scaffoldColor;
  final Color surfaceColor;
  final Color primaryColor;

  const PaletteColors({
    required this.scaffoldColor,
    required this.surfaceColor,
    required this.primaryColor,
  });
}

class AppThemeRegistry {
  AppThemeRegistry._();

  static final Map<AppThemeName, ThemeData> _themes = {
    AppThemeName.defaultLight: _buildTheme(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF6366F1),
      scaffoldColor: const Color(0xFFF9FAFB),
      surfaceColor: Colors.white,
      borderColor: Colors.grey.shade200,
      cardBorderColor: Colors.grey.shade100,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFF9FAFB),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    AppThemeName.defaultDark: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF6366F1),
      scaffoldColor: const Color(0xFF111827),
      surfaceColor: const Color(0xFF1F2937),
      borderColor: Colors.grey.shade800,
      cardBorderColor: Colors.grey.shade800,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF111827),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.solarizedLight: _buildTheme(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF268BD2),
      scaffoldColor: const Color(0xFFFDF6E3),
      surfaceColor: const Color(0xFFEEE8D5),
      borderColor: const Color(0xFFDCD2BA),
      cardBorderColor: const Color(0xFFE0D8C3),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFFDF6E3),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    AppThemeName.solarizedDark: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFB58900),
      scaffoldColor: const Color(0xFF002B36),
      surfaceColor: const Color(0xFF073642),
      borderColor: const Color(0xFF0E4C5C),
      cardBorderColor: const Color(0xFF0E4C5C),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF002B36),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.abyss: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF00B8D4),
      scaffoldColor: const Color(0xFF000C18),
      surfaceColor: const Color(0xFF00172E),
      borderColor: const Color(0xFF0A2B4C),
      cardBorderColor: const Color(0xFF0A2B4C),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF000C18),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.quietLight: _buildTheme(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF705697),
      scaffoldColor: const Color(0xFFF5F5F5),
      surfaceColor: const Color(0xFFF2F2F2),
      borderColor: const Color(0xFFD5CFE1),
      cardBorderColor: const Color(0xFFD5CFE1),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFEDEDF4),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    AppThemeName.kimbieDark: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFE8A838),
      scaffoldColor: const Color(0xFF221A0F),
      surfaceColor: const Color(0xFF362712),
      borderColor: const Color(0xFF4D381A),
      cardBorderColor: const Color(0xFF4D381A),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF221A0F),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.monokai: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFA6E22E),
      buttonForegroundColor: const Color(0xFF272822),
      scaffoldColor: const Color(0xFF272822),
      surfaceColor: const Color(0xFF3E3D32),
      borderColor: const Color(0xFF4E4D40),
      cardBorderColor: const Color(0xFF4E4D40),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF272822),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.oneLight: _buildTheme(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF4078F2),
      scaffoldColor: const Color(0xFFFAFAFA),
      surfaceColor: const Color(0xFFF0F0F0),
      borderColor: const Color(0xFFE5E5E6),
      cardBorderColor: const Color(0xFFE5E5E6),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFFAFAFA),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
  };

  static final Map<AppThemeName, PaletteColors> _paletteColors = {
    AppThemeName.defaultLight: const PaletteColors(
      scaffoldColor: Color(0xFFF9FAFB),
      surfaceColor: Colors.white,
      primaryColor: Color(0xFF6366F1),
    ),
    AppThemeName.defaultDark: const PaletteColors(
      scaffoldColor: Color(0xFF111827),
      surfaceColor: Color(0xFF1F2937),
      primaryColor: Color(0xFF6366F1),
    ),
    AppThemeName.solarizedLight: const PaletteColors(
      scaffoldColor: Color(0xFFFDF6E3),
      surfaceColor: Color(0xFFEEE8D5),
      primaryColor: Color(0xFF268BD2),
    ),
    AppThemeName.solarizedDark: const PaletteColors(
      scaffoldColor: Color(0xFF002B36),
      surfaceColor: Color(0xFF073642),
      primaryColor: Color(0xFFB58900),
    ),
    AppThemeName.abyss: const PaletteColors(
      scaffoldColor: Color(0xFF000C18),
      surfaceColor: Color(0xFF00172E),
      primaryColor: Color(0xFF00B8D4),
    ),
    AppThemeName.kimbieDark: const PaletteColors(
      scaffoldColor: Color(0xFF221A0F),
      surfaceColor: Color(0xFF362712),
      primaryColor: Color(0xFFE8A838),
    ),
    AppThemeName.monokai: const PaletteColors(
      scaffoldColor: Color(0xFF272822),
      surfaceColor: Color(0xFF3E3D32),
      primaryColor: Color(0xFFA6E22E),
    ),
    AppThemeName.oneLight: const PaletteColors(
      scaffoldColor: Color(0xFFFAFAFA),
      surfaceColor: Color(0xFFF0F0F0),
      primaryColor: Color(0xFF4078F2),
    ),
    AppThemeName.quietLight: const PaletteColors(
      scaffoldColor: Color(0xFFF5F5F5),
      surfaceColor: Color(0xFFF2F2F2),
      primaryColor: Color(0xFF705697),
    ),
  };

  static Map<AppThemeName, ThemeData> get all => _themes;

  static List<AppThemeName> get lightPalettes => AppThemeName.values
      .where((t) => t.brightness == Brightness.light)
      .toList();

  static List<AppThemeName> get darkPalettes => AppThemeName.values
      .where((t) => t.brightness == Brightness.dark)
      .toList();

  static ThemeData getTheme(AppThemeName name) {
    return _themes[name] ??
        _themes[name.brightness == Brightness.light
            ? AppThemeName.defaultLight
            : AppThemeName.defaultDark]!;
  }

  static PaletteColors getColors(AppThemeName name) {
    return _paletteColors[name] ?? _paletteColors[AppThemeName.defaultLight]!;
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primaryColor,
    Color? buttonForegroundColor,
    required Color scaffoldColor,
    required Color surfaceColor,
    required Color borderColor,
    required Color cardBorderColor,
    required SystemUiOverlayStyle systemOverlayStyle,
  }) {
    final isDark = brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111827);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        brightness: brightness,
        surface: surfaceColor,
      ),
      scaffoldBackgroundColor: scaffoldColor,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: systemOverlayStyle,
        titleTextStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: cardBorderColor, width: 1),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryColor,
          foregroundColor:
              buttonForegroundColor ??
              (isDark && primaryColor.computeLuminance() > 0.6
                  ? Colors.black
                  : Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
