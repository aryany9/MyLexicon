import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kTabOrderKey = 'navigation_tab_order';

/// Default moveable tab order (excludes Settings, which is pinned at the end).
const List<String> kDefaultTabOrder = [
  '/',
  '/category/word',
  '/category/phrase',
  '/category/idiom',
  '/category/quote',
  '/collections',
];

final tabOrderProvider =
    StateNotifierProvider<TabOrderNotifier, List<String>>((ref) {
  return TabOrderNotifier();
});

class TabOrderNotifier extends StateNotifier<List<String>> {
  TabOrderNotifier() : super(kDefaultTabOrder) {
    _loadTabOrder();
  }

  Future<void> _loadTabOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(kTabOrderKey);
    if (saved != null && saved.isNotEmpty) {
      // Ensure all known moveable paths exist in the loaded list
      final valid = saved.where((p) => kDefaultTabOrder.contains(p)).toList();
      for (final p in kDefaultTabOrder) {
        if (!valid.contains(p)) {
          valid.add(p);
        }
      }
      state = valid;
    } else {
      state = kDefaultTabOrder;
    }
  }

  /// Reorders moveable tabs by moving an item from [oldIndex] to [newIndex].
  Future<void> reorder(int oldIndex, int newIndex) async {
    final updated = List<String>.from(state);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = updated.removeAt(oldIndex);
    updated.insert(newIndex, item);

    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(kTabOrderKey, updated);
  }

  /// Reorders moveable tabs where newIndex is already adjusted (onReorderItem).
  Future<void> reorderItem(int oldIndex, int newIndex) async {
    final updated = List<String>.from(state);
    final item = updated.removeAt(oldIndex);
    updated.insert(newIndex, item);

    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(kTabOrderKey, updated);
  }

  /// Resets tab order back to default.
  Future<void> resetToDefault() async {
    state = kDefaultTabOrder;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kTabOrderKey);
  }
}
