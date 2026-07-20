import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_lexicon/core/services/database_service.dart';
import 'package:my_lexicon/models/lexicon_entry.dart';
import 'package:my_lexicon/models/lexicon_type.dart';

class WordsCard extends StatelessWidget {
  const WordsCard({super.key, required this.ref, required this.entry});

  final WidgetRef ref;
  final LexiconEntry entry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color typeColor = Colors.grey;

    switch (entry.type) {
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

    return ListTile(
      onTap: () => context.push('/entry/${entry.id}'),
      // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // leading: Container(
      //   // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //   decoration: BoxDecoration(
      //     color: typeColor.withOpacity(isDark ? 0.2 : 0.1),
      //     borderRadius: BorderRadius.circular(6),
      //   ),
      //   child: Text(
      //     entry.type.name.toUpperCase(),
      //     style: TextStyle(
      //       color: typeColor,
      //       fontSize: 10,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
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
          if (entry.example != null) ...[
            const SizedBox(height: 10),
            Text(
              entry.type == LexiconType.quote
                  ? entry.example!
                  : '"${entry.example!}"',
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
      // trailing: IconButton(
      //   constraints: const BoxConstraints(),
      //   padding: EdgeInsets.zero,
      //   icon: Icon(
      //     entry.isFavorite ? Icons.favorite : Icons.favorite_border,
      //     color: entry.isFavorite ? Colors.redAccent : Colors.grey.shade400,
      //     size: 20,
      //   ),
      //   onPressed: () async {
      //     final db = ref.read(databaseServiceProvider);
      //     entry.isFavorite = !entry.isFavorite;
      //     await db.saveEntry(entry);
      //     ref.invalidate(statsProvider);
      //     ref.invalidate(entriesProvider);
      //   },
      // ),
      isThreeLine: entry.example != null || entry.tags.isNotEmpty,
    );
  }
}
