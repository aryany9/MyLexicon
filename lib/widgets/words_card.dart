import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';
import 'package:mylexicon/core/providers/display_preferences_provider.dart';

class WordsCard extends ConsumerWidget {
  const WordsCard({
    super.key,
    required this.ref,
    required this.entry,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onSelect,
    this.onLongPress,
  });

  final WidgetRef ref;
  final LexiconEntry entry;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onSelect;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final density = widgetRef.watch(listDensityProvider);
    final showTags = widgetRef.watch(showCardTagsProvider);
    final showTypeBadges = widgetRef.watch(showTypeBadgesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (density) {
      case ListDensity.compact:
        return _buildCompact(context, isDark, showTypeBadges);
      case ListDensity.comfortable:
        return _buildComfortable(context, isDark, showTypeBadges);
      case ListDensity.detailed:
        return _buildDetailed(context, isDark, showTags, showTypeBadges);
    }
  }

  Widget _buildTypeBadge(BuildContext context, LexiconType type, bool isDark) {
    Color typeColor = Colors.blue;
    switch (type) {
      case LexiconType.word:
        typeColor = Colors.blue;
        break;
      case LexiconType.quote:
        typeColor = Colors.purple;
        break;
      case LexiconType.phrase:
        typeColor = Colors.teal;
        break;
      case LexiconType.idiom:
        typeColor = Colors.orange;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: typeColor.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type.name.toUpperCase(),
        style: TextStyle(
          color: typeColor,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Compact: term-only, minimal padding.
  Widget _buildCompact(BuildContext context, bool isDark, bool showTypeBadges) {
    return InkWell(
      onTap: isSelectionMode
          ? onSelect
          : () => context.push('/entry/${entry.id}'),
      onLongPress: onLongPress,
      child: Container(
        color: isSelected
            ? Theme.of(context)
                .colorScheme
                .primaryContainer
                .withValues(alpha: 0.25)
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            if (isSelectionMode) ...[
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onSelect?.call(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                entry.term,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            if (showTypeBadges) ...[
              const SizedBox(width: 8),
              _buildTypeBadge(context, entry.type, isDark),
            ],
          ],
        ),
      ),
    );
  }

  /// Comfortable: term + one-line definition. No examples, no tags.
  Widget _buildComfortable(BuildContext context, bool isDark, bool showTypeBadges) {
    return Material(
      color: isSelected
          ? Theme.of(context)
              .colorScheme
              .primaryContainer
              .withValues(alpha: 0.25)
          : Colors.transparent,
      child: ListTile(
        leading: isSelectionMode
            ? SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onSelect?.call(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                ),
              )
            : null,
        minLeadingWidth: 24,
        onTap: isSelectionMode
            ? onSelect
            : () => context.push('/entry/${entry.id}'),
        onLongPress: onLongPress,
        title: Row(
          children: [
            Expanded(
              child: Text(
                entry.term,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            if (showTypeBadges) ...[
              const SizedBox(width: 8),
              _buildTypeBadge(context, entry.type, isDark),
            ],
          ],
        ),
        subtitle: Text(
          entry.definition,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// Detailed: full card implementation (term + definition + examples + tags).
  Widget _buildDetailed(
    BuildContext context,
    bool isDark,
    bool showTags,
    bool showTypeBadges,
  ) {
    final hasTags = showTags && entry.tags.isNotEmpty;

    return Material(
      color: isSelected
          ? Theme.of(context)
              .colorScheme
              .primaryContainer
              .withValues(alpha: 0.25)
          : Colors.transparent,
      child: ListTile(
        leading: isSelectionMode
            ? SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onSelect?.call(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                ),
              )
            : null,
        minLeadingWidth: 24,
        onTap: isSelectionMode
            ? onSelect
            : () => context.push('/entry/${entry.id}'),
        onLongPress: onLongPress,
      title: Row(
        children: [
          Expanded(
            child: Text(
              entry.term,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (showTypeBadges) ...[
            const SizedBox(width: 8),
            _buildTypeBadge(context, entry.type, isDark),
          ],
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            entry.definition,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          if (entry.examples.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              entry.type == LexiconType.quote
                  ? entry.examples.first
                  : '"${entry.examples.first}"',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                fontSize: 13,
                fontStyle: entry.type == LexiconType.quote
                    ? FontStyle.normal
                    : FontStyle.italic,
              ),
            ),
          ],
          if (hasTags) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: entry.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '#$tag',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
      isThreeLine: entry.examples.isNotEmpty || hasTags,
      ),
    );
  }
}
