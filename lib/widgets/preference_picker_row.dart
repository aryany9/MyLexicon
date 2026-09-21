import 'package:flutter/material.dart';
import 'preference_picker_card.dart';

export 'preference_picker_card.dart' show PreferencePickerOption;

/// A Reddit-style preference row that displays an icon, title, and current value
/// with a chevron on the right.
///
/// Tapping the row opens a Reddit-style modal bottom sheet featuring:
/// - A bold title on the left and a circular (×) close button on the right
/// - Clean option rows with a checkmark (✓) on the right for the selected item
class PreferencePickerRow<T> extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final T currentValue;
  final String currentLabel;
  final String? sheetTitle;
  final List<PreferencePickerOption<T>> options;
  final ValueChanged<T> onChanged;

  const PreferencePickerRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.currentValue,
    required this.currentLabel,
    this.sheetTitle,
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Title on left, circular (×) close button on right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sheetTitle ?? title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      key: const ValueKey('preference_picker_close_button'),
                      onTap: () => Navigator.of(bottomSheetContext).pop(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Options list (Reddit style: label on left, ✓ on right)
                ...options.map((option) {
                  final isSelected = option.value == currentValue;

                  return InkWell(
                    key: ValueKey('preference_option_${option.value}'),
                    onTap: () {
                      onChanged(option.value);
                      Navigator.of(bottomSheetContext).pop();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14.0,
                        horizontal: 4.0,
                      ),
                      child: Row(
                        children: [
                          if (option.icon != null) ...[
                            Icon(
                              option.icon,
                              size: 20,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option.label,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
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
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check,
                              size: 22,
                              color: theme.colorScheme.primary,
                            ),
                        ],
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

    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 160),
            child: Text(
              currentLabel,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.chevron_right,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
      onTap: () => _showPicker(context),
    );
  }
}
