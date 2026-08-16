import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/app_feature.dart';
import '../providers/feature_flags_provider.dart';
import '../providers/tab_order_provider.dart';

class _TabDescriptor {
  final AppFeature? feature;
  final String path;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _TabDescriptor({
    required this.feature,
    required this.path,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

const _allTabs = <_TabDescriptor>[
  _TabDescriptor(
    feature: null,
    path: '/',
    icon: Icons.dashboard_outlined,
    activeIcon: Icons.dashboard,
    label: 'Dashboard',
  ),
  _TabDescriptor(
    feature: AppFeature.word,
    path: '/category/word',
    icon: Icons.wordpress_rounded,
    activeIcon: Icons.wordpress_outlined,
    label: 'Words',
  ),
  _TabDescriptor(
    feature: AppFeature.phrase,
    path: '/category/phrase',
    icon: Icons.text_snippet_outlined,
    activeIcon: Icons.text_snippet,
    label: 'Phrases',
  ),
  _TabDescriptor(
    feature: AppFeature.idiom,
    path: '/category/idiom',
    icon: Icons.auto_awesome_outlined,
    activeIcon: Icons.auto_awesome,
    label: 'Idioms',
  ),
  _TabDescriptor(
    feature: AppFeature.quote,
    path: '/category/quote',
    icon: Icons.format_quote_outlined,
    activeIcon: Icons.format_quote,
    label: 'Quotes',
  ),
  _TabDescriptor(
    feature: AppFeature.collections,
    path: '/collections',
    icon: Icons.collections_bookmark_outlined,
    activeIcon: Icons.collections_bookmark,
    label: 'Collections',
  ),
  _TabDescriptor(
    feature: null,
    path: '/settings',
    icon: Icons.settings_outlined,
    activeIcon: Icons.settings,
    label: 'Settings',
  ),
];

class AppShell extends ConsumerWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flags = ref.watch(featureFlagsProvider);
    final customOrder = ref.watch(tabOrderProvider);

    final tabMap = {for (final t in _allTabs) t.path: t};

    // Ordered list of paths: customOrder for moveable tabs, with '/settings' pinned at the end.
    final orderedPaths = [...customOrder, '/settings'];

    final visibleTabs = <_TabDescriptor>[];
    for (final path in orderedPaths) {
      final descriptor = tabMap[path];
      if (descriptor != null) {
        if (descriptor.feature == null || flags[descriptor.feature] == true) {
          visibleTabs.add(descriptor);
        }
      }
    }

    final location = GoRouterState.of(context).uri.path;

    final currentIndex = () {
      final idx = visibleTabs.indexWhere(
        (tab) => location.startsWith(tab.path) && tab.path != '/',
      );
      if (idx != -1) return idx;
      final homeIdx = visibleTabs.indexWhere((tab) => tab.path == '/');
      return homeIdx != -1 ? homeIdx : 0;
    }();

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          final targetPath = visibleTabs[index].path;
          if (location != targetPath) {
            context.go(targetPath);
          }
        },
        items: visibleTabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                activeIcon: Icon(tab.activeIcon),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
