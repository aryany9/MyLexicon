import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_type.dart';
import 'package:mylexicon/core/providers/display_preferences_provider.dart';

class WordsCard extends ConsumerWidget {
  const WordsCard({super.key, required this.ref, required this.entry});

  final WidgetRef ref;
  final LexiconEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final density = widgetRef.watch(listDensityProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (density) {
      case ListDensity.compact:
        return _buildCompact(context);
      case ListDensity.comfortable:
        return _buildComfortable(context, isDark);
      case ListDensity.detailed:
        return _buildDetailed(context, isDark);
    }
  }

  /// Compact: term-only, minimal padding — uses a plain Padding+Text row
  /// (no ListTile) to genuinely reduce vertical space.
  Widget _buildCompact(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/entry/${entry.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          entry.term,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Comfortable: term + one-line definition. No examples, no tags.
  Widget _buildComfortable(BuildContext context, bool isDark) {
    return ListTile(
      onTap: () => context.push('/entry/${entry.id}'),
      title: Text(
        entry.term,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
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
    );
  }

  /// Detailed: current full implementation (term + definition + examples + tags).
  Widget _buildDetailed(BuildContext context, bool isDark) {
    return ListTile(
      onTap: () => context.push('/entry/${entry.id}'),
      title: Text(
        entry.term,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
          if (entry.tags.isNotEmpty) ...[
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
      isThreeLine: entry.examples.isNotEmpty || entry.tags.isNotEmpty,
    );
  }
}
