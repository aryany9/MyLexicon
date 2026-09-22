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
    final showTags = ref.watch(showCardTagsProvider);
    final showTypeBadges = ref.watch(showTypeBadgesProvider);
    final fontFamilyPref = ref.watch(fontFamilyPreferenceProvider);
    final textScalePref = ref.watch(textScalePreferenceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Appearance')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // ── THEME ─────────────────────────────────────────────────────────
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
          SwitchListTile(
            key: const ValueKey('pure_black_switch'),
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Pure black (AMOLED)'),
            subtitle: const Text('Use pitch black for dark mode backgrounds'),
            value: themePref.isAmoled,
            onChanged: (val) {
              ref.read(appThemePreferenceProvider.notifier).setAmoled(val);
            },
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ── VIEW OPTIONS ──────────────────────────────────────────────────
          _buildSectionHeader(context, 'View options'),
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
          SwitchListTile(
            key: const ValueKey('show_tags_switch'),
            secondary: const Icon(Icons.sell_outlined),
            title: const Text('Show tags on cards'),
            subtitle: const Text('Display tag chips on word cards'),
            value: showTags,
            onChanged: (val) {
              ref.read(showCardTagsProvider.notifier).set(val);
            },
          ),
          SwitchListTile(
            key: const ValueKey('show_type_badges_switch'),
            secondary: const Icon(Icons.label_outline_rounded),
            title: const Text('Show type badges'),
            subtitle: const Text(
              'Display Word, Phrase, Idiom, or Quote badges',
            ),
            value: showTypeBadges,
            onChanged: (val) {
              ref.read(showTypeBadgesProvider.notifier).set(val);
            },
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ── TYPOGRAPHY ────────────────────────────────────────────────────
          _buildSectionHeader(context, 'Typography'),
          PreferencePickerRow<AppFontFamily>(
            key: const ValueKey('font_family_picker_row'),
            title: 'Font style',
            icon: Icons.font_download_outlined,
            currentValue: fontFamilyPref,
            currentLabel: fontFamilyPref.label,
            sheetTitle: 'Font style',
            options: const [
              PreferencePickerOption(
                value: AppFontFamily.system,
                label: 'System (Default)',
                description: 'Clean, modern sans-serif typeface',
              ),
              PreferencePickerOption(
                value: AppFontFamily.serif,
                label: 'Serif (Literary)',
                description: 'Classic editorial serif, great for reading',
              ),
              PreferencePickerOption(
                value: AppFontFamily.monospace,
                label: 'Monospace',
                description: 'Fixed-width technical font',
              ),
            ],
            onChanged: (val) {
              ref.read(fontFamilyPreferenceProvider.notifier).setFont(val);
            },
          ),
          PreferencePickerRow<AppTextScale>(
            key: const ValueKey('text_scale_picker_row'),
            title: 'Text size',
            icon: Icons.format_size_rounded,
            currentValue: textScalePref,
            currentLabel: textScalePref.label,
            sheetTitle: 'Text size',
            options: const [
              PreferencePickerOption(
                value: AppTextScale.small,
                label: 'Small (85%)',
                description: 'Fit more text on screen',
              ),
              PreferencePickerOption(
                value: AppTextScale.normal,
                label: 'Default (100%)',
                description: 'Standard balanced readability',
              ),
              PreferencePickerOption(
                value: AppTextScale.large,
                label: 'Large (115%)',
                description: 'Larger text for comfortable reading',
              ),
              PreferencePickerOption(
                value: AppTextScale.extraLarge,
                label: 'Extra Large (130%)',
                description: 'Maximum legibility',
              ),
            ],
            onChanged: (val) {
              ref.read(textScalePreferenceProvider.notifier).setScale(val);
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
