import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/app_theme_preference.dart';
import '../../../core/providers/display_preferences_provider.dart';
import '../../../core/providers/theme_preference_provider.dart';
import '../../../widgets/preference_picker_row.dart';
import 'theme_settings_page.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  String _getThemeSummary(AppThemePreference pref) {
    switch (pref.mode) {
      case ThemeMode.system:
        return 'System (${pref.lightThemeName.displayName})';
      case ThemeMode.light:
        return pref.lightThemeName.displayName;
      case ThemeMode.dark:
        return pref.darkThemeName.displayName;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themePref = ref.watch(appThemePreferenceProvider);
    final listDensity = ref.watch(listDensityProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Appearance')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // ── Theme Section ─────────────────────────────────────────────────
          _buildSectionHeader(context, 'Theme'),
          ListTile(
            key: const ValueKey('theme_settings_tile'),
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 160),
                  child: Text(
                    _getThemeSummary(themePref),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingsPage(),
                ),
              );
            },
          ),
          // const SizedBox(height: 8),
          // const Divider(),

          // ── Display Section ───────────────────────────────────────────────
          _buildSectionHeader(context, 'Display'),
          PreferencePickerRow<ListDensity>(
            key: const ValueKey('display_density_card'),
            title: 'Display density',
            icon: Icons.table_rows_outlined,
            currentValue: listDensity,
            currentLabel: _getDensityLabel(listDensity),
            sheetTitle: 'Display density',
            options: const [
              PreferencePickerOption(
                value: ListDensity.compact,
                label: 'Compact',
                description: 'Show term only with minimal vertical padding',
              ),
              PreferencePickerOption(
                value: ListDensity.comfortable,
                label: 'Comfortable',
                description: 'Show term and a short one-line definition',
              ),
              PreferencePickerOption(
                value: ListDensity.detailed,
                label: 'Detailed',
                description: 'Show full details including examples and tags',
              ),
            ],
            onChanged: (val) {
              ref.read(listDensityProvider.notifier).setDensity(val);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

String _getDensityLabel(ListDensity density) {
  switch (density) {
    case ListDensity.compact:
      return 'Compact';
    case ListDensity.comfortable:
      return 'Comfortable';
    case ListDensity.detailed:
      return 'Detailed';
  }
}
