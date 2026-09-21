import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── List Density ────────────────────────────────────────────────────────────

enum ListDensity { compact, comfortable, detailed }

const _kListDensityKey = 'list_density';

final listDensityProvider =
    StateNotifierProvider<ListDensityNotifier, ListDensity>((ref) {
  return ListDensityNotifier();
});

class ListDensityNotifier extends StateNotifier<ListDensity> {
  ListDensityNotifier() : super(ListDensity.detailed) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_kListDensityKey);
    if (stored != null) {
      for (final density in ListDensity.values) {
        if (density.name == stored) {
          state = density;
          return;
        }
      }
    }
  }

  Future<void> setDensity(ListDensity density) async {
    state = density;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kListDensityKey, density.name);
  }
}

// ── Card Content Toggles ────────────────────────────────────────────────────

const _kShowCardTagsKey = 'show_card_tags';
const _kShowTypeBadgesKey = 'show_type_badges';

final showCardTagsProvider =
    StateNotifierProvider<ShowCardTagsNotifier, bool>((ref) {
  return ShowCardTagsNotifier();
});

class ShowCardTagsNotifier extends StateNotifier<bool> {
  ShowCardTagsNotifier() : super(true) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_kShowCardTagsKey) ?? true;
  }

  Future<void> set(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kShowCardTagsKey, value);
  }

  Future<void> toggle() => set(!state);
}

final showTypeBadgesProvider =
    StateNotifierProvider<ShowTypeBadgesNotifier, bool>((ref) {
  return ShowTypeBadgesNotifier();
});

class ShowTypeBadgesNotifier extends StateNotifier<bool> {
  ShowTypeBadgesNotifier() : super(true) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_kShowTypeBadgesKey) ?? true;
  }

  Future<void> set(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kShowTypeBadgesKey, value);
  }

  Future<void> toggle() => set(!state);
}

// ── Typography: Font Family ─────────────────────────────────────────────────

enum AppFontFamily {
  system('System (Default)', null),
  serif('Serif (Literary)', 'serif'),
  monospace('Monospace', 'monospace');

  final String label;
  final String? fontFamily;

  const AppFontFamily(this.label, this.fontFamily);
}

const _kFontFamilyKey = 'app_font_family';

final fontFamilyPreferenceProvider =
    StateNotifierProvider<FontFamilyNotifier, AppFontFamily>((ref) {
  return FontFamilyNotifier();
});

class FontFamilyNotifier extends StateNotifier<AppFontFamily> {
  FontFamilyNotifier() : super(AppFontFamily.system) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_kFontFamilyKey);
    if (stored != null) {
      for (final font in AppFontFamily.values) {
        if (font.name == stored) {
          state = font;
          return;
        }
      }
    }
  }

  Future<void> setFont(AppFontFamily font) async {
    state = font;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kFontFamilyKey, font.name);
  }
}

// ── Typography: Text Scale ──────────────────────────────────────────────────

enum AppTextScale {
  small('Small (85%)', 0.85),
  normal('Default (100%)', 1.0),
  large('Large (115%)', 1.15),
  extraLarge('Extra Large (130%)', 1.30);

  final String label;
  final double scaleFactor;

  const AppTextScale(this.label, this.scaleFactor);
}

const _kTextScaleKey = 'app_text_scale';

final textScalePreferenceProvider =
    StateNotifierProvider<TextScaleNotifier, AppTextScale>((ref) {
  return TextScaleNotifier();
});

class TextScaleNotifier extends StateNotifier<AppTextScale> {
  TextScaleNotifier() : super(AppTextScale.normal) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_kTextScaleKey);
    if (stored != null) {
      for (final scale in AppTextScale.values) {
        if (scale.name == stored) {
          state = scale;
          return;
        }
      }
    }
  }

  Future<void> setScale(AppTextScale scale) async {
    state = scale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kTextScaleKey, scale.name);
  }
}
