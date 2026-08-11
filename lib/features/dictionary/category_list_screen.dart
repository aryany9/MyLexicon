import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mylexicon/core/constants/size_constants.dart';
import '../../core/services/database_service.dart';
import '../../core/providers/sort_order_provider.dart';
import '../../models/lexicon_type.dart';
import '../../widgets/words_card.dart';

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

  String _getSingleTypeName() {
    switch (type) {
      case LexiconType.word:
        return 'Word';
      case LexiconType.quote:
        return 'Quote';
      case LexiconType.phrase:
        return 'Phrase';
      case LexiconType.idiom:
        return 'Idiom';
    }
  }

  String _sortOrderLabel(SortOrder order) {
    switch (order) {
      case SortOrder.newestFirst:
        return 'Newest First';
      case SortOrder.oldestFirst:
        return 'Oldest First';
      case SortOrder.aToZ:
        return 'A → Z';
      case SortOrder.zToA:
        return 'Z → A';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseServiceProvider);
    final entriesAsync = ref.watch(entriesProvider);
    final sortOrderMap = ref.watch(sortOrderProvider);
    final currentSortOrder = sortOrderMap[type] ?? SortOrder.newestFirst;
    final title = _getCategoryTitle();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        actions: [
          PopupMenuButton<SortOrder>(
            icon: const Icon(Icons.swap_vert),
            tooltip: 'Sort order',
            onSelected: (order) {
              ref.read(sortOrderProvider.notifier).setSortOrder(type, order);
            },
            itemBuilder: (context) => SortOrder.values.map((order) {
              return PopupMenuItem<SortOrder>(
                value: order,
                child: Row(
                  children: [
                    if (order == currentSortOrder)
                      const Icon(Icons.check, size: 18)
                    else
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    Text(_sortOrderLabel(order)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: entriesAsync.when(
        data: (_) {
          // Pass current sort order to searchAndFilter
          final entries = db.searchAndFilter(
            type: type,
            sortOrder: currentSortOrder,
          );

          if (entries.isEmpty) {
            return _buildEmptyState(context, title);
          }

          return ListView.separated(
            itemCount: entries.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: SizeConstants.space10),
            itemBuilder: (context, index) {
              return WordsCard(ref: ref, entry: entries[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading entries: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/entry-form?type=${type.name}'),
        icon: const Icon(Icons.add),
        label: Text('Add ${_getSingleTypeName()}'),
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
              onPressed: () => context.push('/entry-form?type=${type.name}'),
              icon: const Icon(Icons.add),
              label: Text('Add First $categoryTitle'),
            ),
          ],
        ),
      ),
    );
  }
}
