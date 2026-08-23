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
      fabForegroundColor: Colors.white,
      // VS Code Default Light title: near-black
      titleTextColor: const Color(0xFF1F1F1F),
      scaffoldColor: const Color(0xFFF9FAFB),
      surfaceColor: Colors.white,
      borderColor: Colors.grey.shade200,
      bottomNavBackgroundColor: Colors.white,
      cardBorderColor: Colors.grey.shade100,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    AppThemeName.defaultDark: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF6366F1),
      fabForegroundColor: Colors.white,
      // VS Code Default Dark title: #cccccc (soft grey, not harsh white)
      titleTextColor: const Color(0xFFCCCCCC),
      scaffoldColor: const Color(0xFF111827),
      surfaceColor: const Color(0xFF1F2937),
      borderColor: Colors.grey.shade800,
      bottomNavBackgroundColor: const Color(0xFF1F2937),
      cardBorderColor: Colors.grey.shade800,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF1F2937),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.solarizedLight: _buildTheme(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF268BD2),
      fabForegroundColor: Colors.white,
      // VS Code Solarized Light title: base01 #586E75 (blue-grey)
      titleTextColor: const Color(0xFF586E75),
      scaffoldColor: const Color(0xFFFDF6E3),
      surfaceColor: const Color(0xFFEEE8D5),
      borderColor: const Color(0xFFDCD2BA),
      bottomNavBackgroundColor: const Color(0xFFEEE8D5),
      cardBorderColor: const Color(0xFFE0D8C3),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFEEE8D5),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    AppThemeName.solarizedDark: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFB58900),
      fabForegroundColor: const Color(0xFF002B36),
      // VS Code Solarized Dark title: base0 #839496 (muted teal-grey)
      titleTextColor: const Color(0xFF839496),
      scaffoldColor: const Color(0xFF002B36),
      surfaceColor: const Color(0xFF073642),
      borderColor: const Color(0xFF0E4C5C),
      bottomNavBackgroundColor: const Color(0xFF073642),
      cardBorderColor: const Color(0xFF0E4C5C),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF073642),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.abyss: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF00B8D4),
      fabForegroundColor: const Color(0xFF000C18),
      // VS Code Abyss title: #6688cc (cool periwinkle-blue)
      titleTextColor: const Color(0xFF6688CC),
      scaffoldColor: const Color(0xFF000C18),
      surfaceColor: const Color(0xFF00172E),
      borderColor: const Color(0xFF0A2B4C),
      cardBorderColor: const Color(0xFF0A2B4C),
      bottomNavBackgroundColor: const Color(0xFF00172E),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF00172E),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.quietLight: _buildTheme(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF705697),
      fabForegroundColor: Colors.white,
      // VS Code Quiet Light title: #333333 (deep charcoal)
      titleTextColor: const Color(0xFF333333),
      scaffoldColor: const Color(0xFFF5F5F5),
      surfaceColor: const Color(0xFFF2F2F2),
      bottomNavBackgroundColor: const Color(0xFFEDEDF4),
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
      fabForegroundColor: const Color(0xFF221A0F),
      // VS Code Kimbie Dark title: #d3af86 (warm beige)
      titleTextColor: const Color(0xFFD3AF86),
      scaffoldColor: const Color(0xFF221A0F),
      surfaceColor: const Color(0xFF362712),
      borderColor: const Color(0xFF4D381A),
      cardBorderColor: const Color(0xFF4D381A),
      bottomNavBackgroundColor: const Color(0xFF362712),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF362712),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.monokai: _buildTheme(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFA6E22E),
      buttonForegroundColor: const Color(0xFF272822),
      fabForegroundColor: const Color(0xFF272822),
      // VS Code Monokai title: #f8f8f2 (warm off-white)
      titleTextColor: const Color(0xFFF8F8F2),
      scaffoldColor: const Color(0xFF272822),
      surfaceColor: const Color(0xFF3E3D32),
      borderColor: const Color(0xFF4E4D40),
      cardBorderColor: const Color(0xFF4E4D40),
      bottomNavBackgroundColor: const Color(0xFF1E1F1C),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF1E1F1C),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    AppThemeName.oneLight: _buildTheme(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF4078F2),
      fabForegroundColor: Colors.white,
      // VS Code One Light title: #383a42 (deep slate)
      titleTextColor: const Color(0xFF383A42),
      scaffoldColor: const Color(0xFFFAFAFA),
      surfaceColor: const Color(0xFFF0F0F0),
      borderColor: const Color(0xFFE5E5E6),
      cardBorderColor: const Color(0xFFE5E5E6),
      bottomNavBackgroundColor: const Color(0xFFF0F0F0),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFF0F0F0),
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
    Color? fabForegroundColor,
    Color? titleTextColor,
    required Color scaffoldColor,
    required Color surfaceColor,
    required Color bottomNavBackgroundColor,
    required Color borderColor,
    required Color cardBorderColor,
    required SystemUiOverlayStyle systemOverlayStyle,
  }) {
    final isDark = brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    // AppBar title & icon use palette-specific tone if provided, else fall back to textColor.
    final resolvedTitleColor = titleTextColor ?? textColor;

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
          color: resolvedTitleColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: resolvedTitleColor),
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
        backgroundColor: primaryColor.withValues(alpha: isDark ? 0.18 : 0.12),
        labelStyle: TextStyle(
          color: primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide(color: primaryColor.withValues(alpha: isDark ? 0.35 : 0.25)),
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
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: fabForegroundColor ??
            (primaryColor.computeLuminance() > 0.35
                ? const Color(0xFF111827)
                : Colors.white),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: bottomNavBackgroundColor,
        elevation: 0,
        height: 62,
        indicatorColor: primaryColor.withValues(alpha: isDark ? 0.85 : 0.80),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            // Icon sits on the primaryColor indicator — same contrast logic as FAB.
            final selectedColor = fabForegroundColor ??
                (primaryColor.computeLuminance() > 0.35
                    ? const Color(0xFF111827)
                    : Colors.white);
            return IconThemeData(color: selectedColor, size: 24);
          }
          return IconThemeData(
            color: isDark
                ? Colors.white.withValues(alpha: 0.45)
                : Colors.black.withValues(alpha: 0.40),
            size: 24,
          );
        }),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bottomNavBackgroundColor,
        elevation: 0,
        selectedItemColor: fabForegroundColor ??
            (primaryColor.computeLuminance() > 0.35
                ? const Color(0xFF111827)
                : Colors.white),
        unselectedItemColor: isDark
            ? Colors.white.withValues(alpha: 0.45)
            : Colors.black.withValues(alpha: 0.40),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
