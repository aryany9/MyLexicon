import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/theme_preference_provider.dart';
import '../../../core/theme/app_theme_name.dart';
import '../../../core/theme/app_theme_registry.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

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
    final themePref = ref.watch(appThemePreferenceProvider);
    final themeNotifier = ref.read(appThemePreferenceProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Theme')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // ── Theme Mode ────────────────────────────────────────────────────
          _buildSectionHeader(context, 'Theme Mode'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: SegmentedButton<ThemeMode>(
              key: const ValueKey('theme_mode_segmented_button'),
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto, size: 18),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode_outlined, size: 18),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode_outlined, size: 18),
                ),
              ],
              selected: {themePref.mode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                if (newSelection.isNotEmpty) {
                  themeNotifier.setMode(newSelection.first);
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),

          // ── Light Mode Palette ───────────────────────────────────────────
          _buildSectionHeader(context, '☀ Light Mode Theme'),
          SizedBox(
            height: 110,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: AppThemeRegistry.lightPalettes.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final palette = AppThemeRegistry.lightPalettes[index];
                final isSelected = themePref.lightThemeName == palette;
                return _ThemeSwatchCard(
                  themeName: palette,
                  isSelected: isSelected,
                  onTap: () => themeNotifier.setLightTheme(palette),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ── Dark Mode Palette ────────────────────────────────────────────
          _buildSectionHeader(context, '🌙 Dark Mode Theme'),
          SizedBox(
            height: 110,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: AppThemeRegistry.darkPalettes.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final palette = AppThemeRegistry.darkPalettes[index];
                final isSelected = themePref.darkThemeName == palette;
                return _ThemeSwatchCard(
                  themeName: palette,
                  isSelected: isSelected,
                  onTap: () => themeNotifier.setDarkTheme(palette),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ThemeSwatchCard extends StatelessWidget {
  final AppThemeName themeName;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeSwatchCard({
    required this.themeName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeRegistry.getColors(themeName);
    final activeBorderColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 56,
              decoration: BoxDecoration(
                color: colors.scaffoldColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? activeBorderColor
                      : Colors.grey.withValues(alpha: 0.3),
                  width: isSelected ? 2.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: colors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: colors.primaryColor,
                        ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 18,
                    decoration: BoxDecoration(
                      color: colors.surfaceColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              themeName.displayName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? activeBorderColor : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
