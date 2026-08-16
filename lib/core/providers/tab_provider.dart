import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kDefaultTabPathKey = 'default_tab_path';

/// The set of valid tab paths used for validation in [DefaultTabNotifier.setDefaultTab].
const _knownTabPaths = <String>{
  '/',
  '/category/word',
  '/category/phrase',
  '/category/idiom',
  '/category/quote',
  '/collections',
  '/settings',
};

final defaultTabProvider = StateNotifierProvider<DefaultTabNotifier, String>(
  (ref) {
    return DefaultTabNotifier();
  },
);

class DefaultTabNotifier extends StateNotifier<String> {
  DefaultTabNotifier() : super('/') {
    _loadDefaultTab();
  }

  Future<void> _loadDefaultTab() async {
    final prefs = await SharedPreferences.getInstance();

    // Try reading the new string key first.
    final saved = prefs.getString(kDefaultTabPathKey);
    if (saved != null) {
      state = saved;
      return;
    }

    // Migration: read the old int key and convert to a path.
    final oldIndex = prefs.getInt('default_tab_index');
    if (oldIndex != null) {
      final path = _intIndexToPath(oldIndex);
      await prefs.setString(kDefaultTabPathKey, path);
      await prefs.remove('default_tab_index');
      state = path;
      return;
    }

    state = '/';
  }

  /// Persists [path] as the default tab. No-op if [path] is not a known tab path.
  Future<void> setDefaultTab(String path) async {
    if (!_knownTabPaths.contains(path)) return;
    state = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kDefaultTabPathKey, path);
  }
}

String _intIndexToPath(int index) {
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

// ---------------------------------------------------------------------------
// Legacy helpers — kept for backward compatibility.
// ---------------------------------------------------------------------------

@Deprecated('Use featureFlagsProvider and dynamic tab list in AppShell instead')
String tabIndexToPath(int index) {
  switch (index) {
    case 1:
      return '/collections';
    case 2:
      return '/category/word';
    case 3:
      return '/category/idiom';
    case 4:
      return '/category/phrase';
    case 5:
      return '/category/quote';
    case 6:
      return '/settings';
    case 0:
    default:
      return '/';
  }
}

@Deprecated('Use featureFlagsProvider and dynamic tab list in AppShell instead')
int pathToTabIndex(String path) {
  if (path == '/') return 0;
  if (path.startsWith('/collections')) return 1;
  if (path.startsWith('/category/word')) return 2;
  if (path.startsWith('/category/idiom')) return 3;
  if (path.startsWith('/category/phrase')) return 4;
  if (path.startsWith('/category/quote')) return 5;
  if (path.startsWith('/settings')) return 6;
  return 0;
}
