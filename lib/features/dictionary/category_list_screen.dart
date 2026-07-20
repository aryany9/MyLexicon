import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';

class CategoryListScreen extends ConsumerWidget {
  final LexiconType type;

  const CategoryListScreen({super.key, required this.type});

  String _getCategoryTitle() {
    switch (type) {
      case LexiconType.word:
        return 'Words';
      case LexiconType.quote:
        return 'Quotes';
      case LexiconType.phrase:
        return 'Phrases';
      case LexiconType.idiom:
        return 'Idioms';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseServiceProvider);
    final entriesAsync = ref.watch(entriesProvider);
    final title = _getCategoryTitle();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: entriesAsync.when(
        data: (allEntries) {
          // Use searchAndFilter from DatabaseService which does the filtering and sorting (most recent first)
          final entries = db.searchAndFilter(type: type);

          if (entries.isEmpty) {
            return _buildEmptyState(context, title);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildEntryCard(context, ref, entries[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading entries: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/entry-form'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String categoryTitle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open_outlined,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No $categoryTitle yet',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'You haven\'t added any ${categoryTitle.toLowerCase()} to your lexicon yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.push('/entry-form'),
              icon: const Icon(Icons.add),
              label: Text('Add First $categoryTitle'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntryCard(
    BuildContext context,
    WidgetRef ref,
    LexiconEntry entry,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: InkWell(
        onTap: () => context.push('/entry/${entry.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.term,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      entry.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: entry.isFavorite
                          ? Colors.redAccent
                          : Colors.grey.shade400,
                      size: 20,
                    ),
                    onPressed: () async {
                      final db = ref.read(databaseServiceProvider);
                      entry.isFavorite = !entry.isFavorite;
                      await db.saveEntry(entry);
                      ref.invalidate(statsProvider);
                      ref.invalidate(entriesProvider);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade100,
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
        ),
      ),
    );
  }
}
