import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/app_theme_preference.dart';
import '../../../core/providers/display_preferences_provider.dart';
import '../../../core/providers/locale_preference_provider.dart';
import '../../../core/providers/theme_preference_provider.dart';
import '../../../widgets/preference_picker_row.dart';
import 'theme_settings_page.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
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

  String _getLanguageLabel(String locale, AppLocalizations l10n) {
    switch (locale) {
      case 'en':
        return 'English';
      case 'uk':
        return 'Українська';
      case 'ru':
        return 'Русский';
      case 'fa':
        return 'فارسی';
      case 'hi':
        return 'हिन्दी';
      case 'ta':
        return 'தமிழ்';
      case 'te':
        return 'తెలుగు';
      case 'system':
      default:
        return l10n.systemDefault;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themePref = ref.watch(appThemePreferenceProvider);
    final listDensity = ref.watch(listDensityProvider);
    final showTags = ref.watch(showCardTagsProvider);
    final showTypeBadges = ref.watch(showTypeBadgesProvider);
    final fontFamilyPref = ref.watch(fontFamilyPreferenceProvider);
    final textScalePref = ref.watch(textScalePreferenceProvider);
    final currentLocale = ref.watch(localePreferenceProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appearance)),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // ── THEME ─────────────────────────────────────────────────────────
          _buildSectionHeader(context, l10n.theme),
          ListTile(
            key: const ValueKey('theme_settings_tile'),
            leading: const Icon(Icons.palette_outlined),
            title: Text(l10n.theme),
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
            title: Text(l10n.pureBlack),
            subtitle: Text(l10n.pureBlackSubtitle),
            value: themePref.isAmoled,
            onChanged: (val) {
              ref.read(appThemePreferenceProvider.notifier).setAmoled(val);
            },
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ── VIEW OPTIONS ──────────────────────────────────────────────────
          _buildSectionHeader(context, l10n.viewOptions),
          PreferencePickerRow<ListDensity>(
            key: const ValueKey('display_density_card'),
            title: l10n.displayDensity,
            icon: Icons.table_rows_outlined,
            currentValue: listDensity,
            currentLabel: _getDensityLabel(listDensity, l10n),
            sheetTitle: l10n.displayDensity,
            options: [
              PreferencePickerOption(
                value: ListDensity.compact,
                label: l10n.compact,
                description: l10n.compactDescription,
              ),
              PreferencePickerOption(
                value: ListDensity.comfortable,
                label: l10n.comfortable,
                description: l10n.comfortableDescription,
              ),
              PreferencePickerOption(
                value: ListDensity.detailed,
                label: l10n.detailed,
                description: l10n.detailedDescription,
              ),
            ],
            onChanged: (val) {
              ref.read(listDensityProvider.notifier).setDensity(val);
            },
          ),
          SwitchListTile(
            key: const ValueKey('show_tags_switch'),
            secondary: const Icon(Icons.sell_outlined),
            title: Text(l10n.showTagsOnCards),
            subtitle: Text(l10n.showTagsSubtitle),
            value: showTags,
            onChanged: (val) {
              ref.read(showCardTagsProvider.notifier).set(val);
            },
          ),
          SwitchListTile(
            key: const ValueKey('show_type_badges_switch'),
            secondary: const Icon(Icons.label_outline_rounded),
            title: Text(l10n.showTypeBadges),
            subtitle: Text(l10n.showTypeBadgesSubtitle),
            value: showTypeBadges,
            onChanged: (val) {
              ref.read(showTypeBadgesProvider.notifier).set(val);
            },
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ── TYPOGRAPHY ────────────────────────────────────────────────────
          _buildSectionHeader(context, l10n.typography),
          PreferencePickerRow<AppFontFamily>(
            key: const ValueKey('font_family_picker_row'),
            title: l10n.fontStyle,
            icon: Icons.font_download_outlined,
            currentValue: fontFamilyPref,
            currentLabel: fontFamilyPref.label,
            sheetTitle: l10n.fontStyle,
            options: [
              PreferencePickerOption(
                value: AppFontFamily.system,
                label: l10n.system,
                description: l10n.systemFontDescription,
              ),
              PreferencePickerOption(
                value: AppFontFamily.serif,
                label: l10n.serif,
                description: l10n.serifDescription,
              ),
              PreferencePickerOption(
                value: AppFontFamily.monospace,
                label: l10n.monospace,
                description: l10n.monospaceDescription,
              ),
            ],
            onChanged: (val) {
              ref.read(fontFamilyPreferenceProvider.notifier).setFont(val);
            },
          ),
          PreferencePickerRow<AppTextScale>(
            key: const ValueKey('text_scale_picker_row'),
            title: l10n.textSize,
            icon: Icons.format_size_rounded,
            currentValue: textScalePref,
            currentLabel: textScalePref.label,
            sheetTitle: l10n.textSize,
            options: [
              PreferencePickerOption(
                value: AppTextScale.small,
                label: l10n.small,
                description: l10n.smallDescription,
              ),
              PreferencePickerOption(
                value: AppTextScale.normal,
                label: l10n.defaultSize,
                description: l10n.defaultSizeDescription,
              ),
              PreferencePickerOption(
                value: AppTextScale.large,
                label: l10n.large,
                description: l10n.largeDescription,
              ),
              PreferencePickerOption(
                value: AppTextScale.extraLarge,
                label: l10n.extraLarge,
                description: l10n.extraLargeDescription,
              ),
            ],
            onChanged: (val) {
              ref.read(textScalePreferenceProvider.notifier).setScale(val);
            },
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ── LANGUAGE ──────────────────────────────────────────────────────
          _buildSectionHeader(context, l10n.language),
          PreferencePickerRow<String>(
            key: ValueKey('language_picker_row'),
            title: l10n.language,
            icon: Icons.translate,
            currentValue: currentLocale,
            currentLabel: _getLanguageLabel(currentLocale, l10n),
            sheetTitle: l10n.selectLanguage,
            options: [
              PreferencePickerOption(
                value: 'system',
                label: l10n.systemDefault,
              ),
              PreferencePickerOption(
                value: 'en',
                label: 'English',
              ),
              PreferencePickerOption(
                value: 'uk',
                label: 'Українська',
                description: 'Ukrainian',
              ),
              PreferencePickerOption(
                value: 'ru',
                label: 'Русский',
                description: 'Russian',
              ),
              PreferencePickerOption(
                value: 'fa',
                label: 'فارسی',
                description: 'Persian',
              ),
              PreferencePickerOption(
                value: 'hi',
                label: 'हिन्दी',
                description: 'Hindi',
              ),
              PreferencePickerOption(
                value: 'ta',
                label: 'தமிழ்',
                description: 'Tamil',
              ),
              PreferencePickerOption(
                value: 'te',
                label: 'తెలుగు',
                description: 'Telugu',
              ),
            ],
            onChanged: (val) {
              ref.read(localePreferenceProvider.notifier).setLocale(val);
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

String _getDensityLabel(ListDensity density, AppLocalizations l10n) {
  switch (density) {
    case ListDensity.compact:
      return l10n.compact;
    case ListDensity.comfortable:
      return l10n.comfortable;
    case ListDensity.detailed:
      return l10n.detailed;
  }
}
