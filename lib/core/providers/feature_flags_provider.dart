import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_feature.dart';

/// Provider exposing the current feature flag state for all [AppFeature]s.
final featureFlagsProvider =
    StateNotifierProvider<FeatureFlagsNotifier, Map<AppFeature, bool>>((ref) {
  return FeatureFlagsNotifier();
});

class FeatureFlagsNotifier extends StateNotifier<Map<AppFeature, bool>> {
  FeatureFlagsNotifier()
      : super({for (final f in AppFeature.values) f: true}) {
    _loadAll();
  }

  Future<void> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final updated = <AppFeature, bool>{};
    for (final feature in AppFeature.values) {
      updated[feature] = prefs.getBool(feature.prefKey) ?? true;
    }
    state = updated;
  }

  /// Toggles [feature]. Enforces that at least one category feature remains
  /// enabled. Returns false and does nothing if the toggle would violate
  /// that invariant.
  Future<bool> toggle(AppFeature feature) async {
    final currentlyEnabled = state[feature] ?? true;

    // If disabling a category feature, ensure at least one other remains enabled.
    if (currentlyEnabled && AppFeature.categoryFeatures.contains(feature)) {
      final otherEnabledCount = AppFeature.categoryFeatures
          .where((f) => f != feature && (state[f] ?? true))
          .length;
      if (otherEnabledCount == 0) {
        // Cannot disable the last category feature.
        return false;
      }
    }

    final newValue = !currentlyEnabled;
    state = {...state, feature: newValue};

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(feature.prefKey, newValue);
    return true;
  }

  /// Returns true if [feature] is currently enabled.
  bool isEnabled(AppFeature feature) => state[feature] ?? true;

  /// Returns the list of enabled category features (excludes [AppFeature.collections]).
  List<AppFeature> get enabledCategories => AppFeature.categoryFeatures
      .where((f) => state[f] ?? true)
      .toList();
}
