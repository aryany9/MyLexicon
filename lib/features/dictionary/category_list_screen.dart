import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_lexicon/core/constants/size_constants.dart';
import '../../core/services/database_service.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseServiceProvider);
    final entriesAsync = ref.watch(entriesProvider);
    final title = _getCategoryTitle();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: entriesAsync.when(
        data: (_) {
          // Use searchAndFilter from DatabaseService which does the filtering and sorting (most recent first)
          final entries = db.searchAndFilter(type: type);

          if (entries.isEmpty) {
            return _buildEmptyState(context, title);
          }

          return ListView.separated(
            // padding: const EdgeInsets.all(16.0),
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
}
