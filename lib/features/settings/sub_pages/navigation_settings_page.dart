import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/app_feature.dart';
import '../../../core/providers/feature_flags_provider.dart';
import '../../../core/providers/tab_order_provider.dart';
import '../../../core/providers/tab_provider.dart';
import '../../../widgets/preference_picker_card.dart';

enum _NavigationSection { navigation, features }

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

/// Maps a tab route path to its associated icon.
IconData _getTabIcon(String path) {
  switch (path) {
    case '/collections':
      return Icons.collections_bookmark_outlined;
    case '/category/word':
      return Icons.wordpress_rounded;
    case '/category/idiom':
      return Icons.auto_awesome_outlined;
    case '/category/phrase':
      return Icons.text_snippet_outlined;
    case '/category/quote':
      return Icons.format_quote_outlined;
    case '/':
    default:
      return Icons.dashboard_outlined;
  }
}

/// Maps an [AppFeature] to its associated icon.
IconData _getFeatureIcon(AppFeature feature) {
  switch (feature) {
    case AppFeature.collections:
      return Icons.collections_bookmark_outlined;
    case AppFeature.word:
      return Icons.wordpress_rounded;
    case AppFeature.idiom:
      return Icons.auto_awesome_outlined;
    case AppFeature.phrase:
      return Icons.text_snippet_outlined;
    case AppFeature.quote:
      return Icons.format_quote_outlined;
  }
}

/// Maps an [AppFeature] to its descriptive subtitle.
String _getFeatureSubtitle(AppFeature feature) {
  switch (feature) {
    case AppFeature.collections:
      return 'Custom lists and entry groups';
    case AppFeature.word:
      return 'Vocabulary terms and definitions';
    case AppFeature.idiom:
      return 'Figurative expressions and meanings';
    case AppFeature.phrase:
      return 'Common phrases and expressions';
    case AppFeature.quote:
      return 'Memorable citations and notes';
  }
}

class NavigationSettingsPage extends ConsumerStatefulWidget {
  const NavigationSettingsPage({super.key});

  @override
  ConsumerState<NavigationSettingsPage> createState() =>
      _NavigationSettingsPageState();
}

class _NavigationSettingsPageState
    extends ConsumerState<NavigationSettingsPage> {
  _NavigationSection _currentSection = _NavigationSection.navigation;

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
  Widget build(BuildContext context) {
    final featureFlags = ref.watch(featureFlagsProvider);
    final currentPath = ref.watch(defaultTabProvider);
    final tabOrder = ref.watch(tabOrderProvider);

    // Build the list of available tab paths based on enabled features.
    final availableTabs = [
      '/',
      if (featureFlags[AppFeature.collections] ?? true) '/collections',
      if (featureFlags[AppFeature.word] ?? true) '/category/word',
      if (featureFlags[AppFeature.idiom] ?? true) '/category/idiom',
      if (featureFlags[AppFeature.phrase] ?? true) '/category/phrase',
      if (featureFlags[AppFeature.quote] ?? true) '/category/quote',
    ];

    // Ensure the current path is still a valid option; fall back to '/' if not.
    final effectivePath = availableTabs.contains(currentPath)
        ? currentPath
        : '/';

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation & Features')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<_NavigationSection>(
                segments: const [
                  ButtonSegment(
                    value: _NavigationSection.navigation,
                    label: Text('Navigation'),
                    icon: Icon(Icons.explore_outlined, size: 18),
                  ),
                  ButtonSegment(
                    value: _NavigationSection.features,
                    label: Text('Features'),
                    icon: Icon(Icons.tune_outlined, size: 18),
                  ),
                ],
                selected: {_currentSection},
                onSelectionChanged: (newSelection) {
                  if (newSelection.isNotEmpty) {
                    setState(() {
                      _currentSection = newSelection.first;
                    });
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _currentSection == _NavigationSection.navigation
                  ? _buildNavigationSection(
                      context,
                      effectivePath,
                      availableTabs,
                      tabOrder,
                      featureFlags,
                    )
                  : _buildFeaturesSection(context, featureFlags),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationSection(
    BuildContext context,
    String effectivePath,
    List<String> availableTabs,
    List<String> tabOrder,
    Map<AppFeature, bool> featureFlags,
  ) {
    final theme = Theme.of(context);

    return ListView(
      key: const ValueKey('navigation_section'),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      children: [
        // ── Default Launch Screen Preference Row ──────────────────────────
        _buildSectionHeader(context, 'Default launch screen'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PreferencePickerCard<String>(
            key: const ValueKey('default_launch_screen_card'),
            title: 'Default launch screen',
            subtitle: 'Screen shown when MyLexicon opens',
            icon: Icons.rocket_launch_outlined,
            currentValue: effectivePath,
            currentLabel: _getTabName(effectivePath),
            sheetTitle: 'Default launch screen',
            sheetSubtitle: 'Choose your starting screen',
            options: availableTabs.map((path) {
              return PreferencePickerOption<String>(
                value: path,
                label: _getTabName(path),
                icon: _getTabIcon(path),
              );
            }).toList(),
            onChanged: (path) {
              ref.read(defaultTabProvider.notifier).setDefaultTab(path);
            },
          ),
        ),
        const SizedBox(height: 16),

        // ── Bottom Navigation Tab Order ───────────────────────────────────
        _buildSectionHeader(context, 'Navigation Tab Order'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Drag handles to reorder tabs in the bottom navigation bar.',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.35,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: theme.brightness == Brightness.dark
                    ? Colors.white10
                    : Colors.black12,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
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
                  leading: Icon(
                    _getTabIcon(path),
                    color: isEnabled
                        ? theme.colorScheme.primary
                        : theme.disabledColor,
                  ),
                  title: Text(
                    _getTabName(path),
                    style: TextStyle(
                      color: isEnabled ? null : theme.disabledColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: isEnabled
                      ? null
                      : Text(
                          'Disabled (Hidden from bar)',
                          style: TextStyle(
                            color: theme.disabledColor,
                            fontSize: 12,
                          ),
                        ),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.drag_handle_rounded,
                        color: theme.hintColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFeaturesSection(
    BuildContext context,
    Map<AppFeature, bool> featureFlags,
  ) {
    final theme = Theme.of(context);
    final enabledCount = AppFeature.values
        .where((f) => featureFlags[f] ?? true)
        .length;
    final totalCount = AppFeature.values.length;

    return ListView(
      key: const ValueKey('features_section'),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      children: [
        _buildSectionHeader(context, 'Category & Feature Toggles'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$enabledCount of $totalCount active • Disabled categories are hidden across navigation, dashboard, and search.',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.35,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: theme.brightness == Brightness.dark
                    ? Colors.white10
                    : Colors.black12,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (int i = 0; i < AppFeature.values.length; i++) ...[
                  () {
                    final feature = AppFeature.values[i];
                    final isEnabled = featureFlags[feature] ?? true;
                    return SwitchListTile(
                      secondary: Icon(
                        _getFeatureIcon(feature),
                        color: isEnabled
                            ? theme.colorScheme.primary
                            : theme.disabledColor,
                      ),
                      title: Text(
                        feature.label,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        _getFeatureSubtitle(feature),
                        style: TextStyle(
                          fontSize: 12,
                          color: isEnabled
                              ? theme.hintColor
                              : theme.disabledColor,
                        ),
                      ),
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
                  }(),
                  if (i < AppFeature.values.length - 1)
                    Divider(
                      height: 1,
                      indent: 56,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white10
                          : Colors.black12,
                    ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
