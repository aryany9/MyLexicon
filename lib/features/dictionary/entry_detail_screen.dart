import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_lexicon/models/lexicon_collection.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';

class EntryDetailScreen extends ConsumerWidget {
  final String entryId;

  const EntryDetailScreen({super.key, required this.entryId});

  void _toggleFavorite(
    BuildContext context,
    WidgetRef ref,
    LexiconEntry entry,
  ) async {
    final db = ref.read(databaseServiceProvider);
    entry.isFavorite = !entry.isFavorite;
    try {
      await db.saveEntry(entry);
      ref.invalidate(statsProvider);
      ref.invalidate(entriesProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update favorite status: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, LexiconEntry entry) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Entry?'),
          content: Text(
            'Are you sure you want to permanently delete "${entry.term}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss dialog
                final db = ref.read(databaseServiceProvider);
                try {
                  await db.deleteEntry(entry.id);
                  ref.invalidate(statsProvider);
                  ref.invalidate(entriesProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Entry deleted successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    context.pop(); // Pop detail screen
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to delete entry: $e'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(entriesProvider);
    final collectionsAsync = ref.watch(collectionsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return entriesAsync.when(
      data: (entries) {
        final entryIndex = entries.indexWhere((e) => e.id == entryId);
        if (entryIndex == -1) {
          // Entry not found (deleted)
          return const Scaffold(body: Center(child: Text('Entry not found')));
        }

        final entry = entries[entryIndex];
        final formattedDate = DateFormat(
          'MMMM d, yyyy • hh:mm a',
        ).format(entry.createdAt);

        // Fetch collection details
        final collection = collectionsAsync.maybeWhen(
          data: (cols) => cols.firstWhere(
            (c) => c.id == entry.collectionId,
            orElse: () => LexiconCollection(
              id: '',
              name: 'Uncategorized',
              colorValue: Colors.grey.value,
              createdAt: DateTime.now(),
            ),
          ),
          orElse: () => null,
        );

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

        return Scaffold(
          appBar: AppBar(
            title: const Text('Entry Details'),
            actions: [
              IconButton(
                icon: Icon(
                  entry.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: entry.isFavorite ? Colors.redAccent : null,
                ),
                onPressed: () => _toggleFavorite(context, ref, entry),
                tooltip: entry.isFavorite ? 'Unfavorite' : 'Favorite',
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push('/entry-form?id=${entry.id}'),
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => _confirmDelete(context, ref, entry),
                tooltip: 'Delete',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type & Collection Header Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: typeColor.withOpacity(isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          entry.type.name.toUpperCase(),
                          style: TextStyle(
                            color: typeColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (collection != null) ...[
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color(
                              collection.colorValue,
                            ).withOpacity(isDark ? 0.2 : 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.folder,
                                color: Color(collection.colorValue),
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                collection.name,
                                style: TextStyle(
                                  color: Color(collection.colorValue),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),

                  // The Term/Text Display Card
                  Card(
                    elevation: 0,
                    color: isDark ? const Color(0xFF1F2937) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade100,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: SelectionArea(
                          child: Text(
                            entry.term,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                  fontSize: entry.type == LexiconType.quote
                                      ? 22
                                      : 28,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Definition / Meaning Section
                  Text(
                    entry.type == LexiconType.quote
                        ? 'Context & Meaning'
                        : entry.type == LexiconType.idiom
                        ? 'Meaning & Interpretation'
                        : 'Definition',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SelectionArea(
                      child: Text(
                        entry.definition,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Example Sentence Section
                  if (entry.example != null) ...[
                    Text(
                      entry.type == LexiconType.quote
                          ? 'Source Context'
                          : 'Example Usage',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1F2937)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade100,
                        ),
                      ),
                      child: SelectionArea(
                        child: Text(
                          entry.type == LexiconType.quote
                              ? entry.example!
                              : '"${entry.example!}"',
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: entry.type == LexiconType.quote
                                ? FontStyle.normal
                                : FontStyle.italic,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Notes Section
                  if (entry.notes != null) ...[
                    Text(
                      'Personal Notes',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(isDark ? 0.05 : 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.2),
                        ),
                      ),
                      child: SelectionArea(
                        child: Text(
                          entry.notes!,
                          style: const TextStyle(fontSize: 15, height: 1.4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Tags Section
                  if (entry.tags.isNotEmpty) ...[
                    Text(
                      'Tags',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: entry.tags.map((tag) {
                        return ActionChip(
                          label: Text('#$tag'),
                          onPressed: () {
                            context.push('/search?tag=$tag');
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  const Divider(),
                  const SizedBox(height: 8),

                  // Metadata section
                  Text(
                    'Stored on $formattedDate',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }
}
