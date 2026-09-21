import 'package:flutter/material.dart';

/// A selectable option item displayed in [PreferencePickerCard]'s bottom sheet.
class PreferencePickerOption<T> {
  final T value;
  final String label;
  final String? description;
  final IconData? icon;

  const PreferencePickerOption({
    required this.value,
    required this.label,
    this.description,
    this.icon,
  });
}

/// A reusable Material 3 preference card that displays a title, subtitle,
/// an icon, and the currently selected value aligned at the bottom-right.
///
/// Tapping anywhere on the card opens a radio-less bottom sheet
/// with active accent highlights and instant selection.
class PreferencePickerCard<T> extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final T currentValue;
  final String currentLabel;
  final String? sheetTitle;
  final String? sheetSubtitle;
  final List<PreferencePickerOption<T>> options;
  final ValueChanged<T> onChanged;

  const PreferencePickerCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.currentValue,
    required this.currentLabel,
    this.sheetTitle,
    this.sheetSubtitle,
    required this.options,
    required this.onChanged,
  });

  void _showPicker(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                // Title and subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sheetTitle ?? title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (sheetSubtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          sheetSubtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // List of selectable options
                ...options.map((option) {
                  final isSelected = option.value == currentValue;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Material(
                      color: isSelected
                          ? theme.colorScheme.primary.withValues(alpha: 0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          onChanged(option.value);
                          Navigator.of(bottomSheetContext).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 14.0,
                          ),
                          child: Row(
                            children: [
                              // Checkmark space for alignment
                              SizedBox(
                                width: 24,
                                child: isSelected
                                    ? Icon(
                                        Icons.check_rounded,
                                        size: 20,
                                        color: theme.colorScheme.primary,
                                      )
                                    : null,
                              ),
                              if (option.icon != null) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  option.icon,
                                  size: 22,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurface
                                          .withValues(alpha: 0.7),
                                ),
                              ],
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option.label,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    if (option.description != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        option.description!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isSelected
                                              ? theme.colorScheme.primary
                                                  .withValues(alpha: 0.8)
                                              : theme.hintColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.brightness == Brightness.dark
              ? Colors.white10
              : Colors.black12,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showPicker(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentLabel,
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: theme.hintColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
