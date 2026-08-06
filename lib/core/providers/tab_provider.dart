import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kDefaultTabKey = 'default_tab_index';

final defaultTabProvider = StateNotifierProvider<DefaultTabNotifier, int>((ref) {
  return DefaultTabNotifier();
});

class DefaultTabNotifier extends StateNotifier<int> {
  DefaultTabNotifier() : super(0) {
    _loadDefaultTab();
  }

  Future<void> _loadDefaultTab() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt(kDefaultTabKey) ?? 0;
  }

  Future<void> setDefaultTab(int index) async {
    if (index < 0 || index > 4) return;
    state = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kDefaultTabKey, index);
  }
}

String tabIndexToPath(int index) {
  switch (index) {
    case 1:
      return '/category/word';
    case 2:
      return '/category/phrase';
    case 3:
      return '/category/idiom';
    case 4:
      return '/category/quote';
    case 5:
      return '/settings';
    case 0:
    default:
      return '/';
  }
}

int pathToTabIndex(String path) {
  if (path == '/') return 0;
  if (path.startsWith('/category/word')) return 1;
  if (path.startsWith('/category/phrase')) return 2;
  if (path.startsWith('/category/idiom')) return 3;
  if (path.startsWith('/category/quote')) return 4;
  if (path.startsWith('/settings')) return 5;
  return 0;
}
