import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/display_preferences_provider.dart';
import '../../../main.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

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
    final themeMode = ref.watch(themeModeProvider);
    final listDensity = ref.watch(listDensityProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Appearance')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // ── Theme Preferences ─────────────────────────────────────────────
          _buildSectionHeader(context, 'Theme Preferences'),
          ListTile(
            title: const Text('App Theme'),
            subtitle: Text(themeMode.name.toUpperCase()),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(mode);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Default'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Mode'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Mode'),
                ),
              ],
            ),
          ),
          const Divider(),

          // ── Display ───────────────────────────────────────────────────────
          _buildSectionHeader(context, 'Display'),
          RadioGroup<ListDensity>(
            groupValue: listDensity,
            onChanged: (val) {
              if (val != null) {
                ref.read(listDensityProvider.notifier).setDensity(val);
              }
            },
            child: Column(
              children: const [
                RadioListTile<ListDensity>(
                  title: Text('Compact'),
                  subtitle: Text('Show term only with minimal vertical padding'),
                  value: ListDensity.compact,
                ),
                RadioListTile<ListDensity>(
                  title: Text('Comfortable'),
                  subtitle: Text('Show term and a short one-line definition'),
                  value: ListDensity.comfortable,
                ),
                RadioListTile<ListDensity>(
                  title: Text('Detailed'),
                  subtitle: Text('Show full details including examples and tags'),
                  value: ListDensity.detailed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
