import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localePreferenceProvider = StateNotifierProvider<LocalePreferenceNotifier, String>((ref) {
  return LocalePreferenceNotifier();
});

class LocalePreferenceNotifier extends StateNotifier<String> {
  static const _key = 'app_locale';
  SharedPreferences? _prefs;

  LocalePreferenceNotifier() : super('system') {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    state = _prefs?.getString(_key) ?? 'system';
  }

  Future<void> setLocale(String code) async {
    state = code;
    await _prefs?.setString(_key, code);
  }
}
