import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/app_feature.dart';
import '../../../core/providers/feature_flags_provider.dart';
import '../../../core/providers/tab_order_provider.dart';
import '../../../core/providers/tab_provider.dart';

/// Maps a tab route path to a human-readable name.
String _getTabName(String path) {
  switch (path) {
    case '/collections':
      return 'Collections';
    case '/category/word':
      return 'Words';
    case '/category/idiom':
      return 'Idioms';
    case '/category/phrase':
      return 'Phrases';
    case '/category/quote':
      return 'Quotes';
    case '/':
    default:
      return 'Dashboard';
  }
}

class NavigationSettingsPage extends ConsumerWidget {
  const NavigationSettingsPage({super.key});

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featureFlags = ref.watch(featureFlagsProvider);
    final currentPath = ref.watch(defaultTabProvider);
    final tabOrder = ref.watch(tabOrderProvider);

    // Build the list of available tab paths based on enabled features.
    final List<DropdownMenuItem<String>> tabItems = [
      const DropdownMenuItem(value: '/', child: Text('Dashboard')),
      if (featureFlags[AppFeature.collections] ?? true)
        const DropdownMenuItem(
          value: '/collections',
          child: Text('Collections'),
        ),
      if (featureFlags[AppFeature.word] ?? true)
        const DropdownMenuItem(value: '/category/word', child: Text('Words')),
      if (featureFlags[AppFeature.idiom] ?? true)
        const DropdownMenuItem(value: '/category/idiom', child: Text('Idioms')),
      if (featureFlags[AppFeature.phrase] ?? true)
        const DropdownMenuItem(
          value: '/category/phrase',
          child: Text('Phrases'),
        ),
      if (featureFlags[AppFeature.quote] ?? true)
        const DropdownMenuItem(value: '/category/quote', child: Text('Quotes')),
    ];

    // Ensure the current path is still a valid option; fall back to '/' if not.
    final validPaths = tabItems.map((e) => e.value).toSet();
    final effectivePath = validPaths.contains(currentPath) ? currentPath : '/';

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation & Features')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // ── Default Launch Tab ────────────────────────────────────────────
          _buildSectionHeader(context, 'Default Launch Tab'),
          ListTile(
            title: const Text('Default Launch Tab'),
            subtitle: Text(_getTabName(effectivePath)),
            trailing: DropdownButton<String>(
              value: effectivePath,
              onChanged: (path) {
                if (path != null) {
                  ref.read(defaultTabProvider.notifier).setDefaultTab(path);
                }
              },
              items: tabItems,
            ),
          ),
          const Divider(),

          // ── Bottom Navigation Tab Order ───────────────────────────────────
          _buildSectionHeader(context, 'Navigation Tab Order'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Drag handles to reorder tabs.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tabOrder.length,
            onReorderItem: (oldIndex, newIndex) {
              ref
                  .read(tabOrderProvider.notifier)
                  .reorderItem(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              final path = tabOrder[index];
              final isEnabled = () {
                if (path == '/') return true;
                if (path == '/collections') {
                  return featureFlags[AppFeature.collections] ?? true;
                }
                final feature = AppFeature.categoryFeatures.firstWhere(
                  (f) => f.lexiconType?.name == path.split('/').last,
                  orElse: () => AppFeature.word,
                );
                return featureFlags[feature] ?? true;
              }();

              return ListTile(
                key: ValueKey(path),
                dense: true,
                leading: const Icon(Icons.drag_handle),
                title: Text(_getTabName(path)),
                subtitle: isEnabled
                    ? null
                    : Text(
                        'Disabled (Hidden)',
                        style: TextStyle(color: Colors.grey),
                      ),
              );
            },
          ),
          const Divider(),

          // ── Features ──────────────────────────────────────────────────────
          _buildSectionHeader(context, 'Features'),
          ...AppFeature.values.map((feature) {
            final isEnabled = featureFlags[feature] ?? true;
            return SwitchListTile(
              title: Text(feature.label),
              // subtitle: Text(
              //   feature == AppFeature.collections
              //       ? 'Hides Collections tab and related UI'
              //       : 'Hides from nav bar, dashboard, and entry form',
              // ),
              value: isEnabled,
              onChanged: (val) async {
                final success = await ref
                    .read(featureFlagsProvider.notifier)
                    .toggle(feature);
                if (!success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'At least one category must remain enabled',
                      ),
                    ),
                  );
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
