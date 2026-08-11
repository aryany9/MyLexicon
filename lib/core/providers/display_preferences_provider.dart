import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
