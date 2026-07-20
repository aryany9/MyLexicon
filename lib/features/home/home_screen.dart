import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/size_constants.dart';
import '../../core/constants/path_constants.dart';
import '../../core/constants/text_constants.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';
import '../../widgets/gap.dart';
import '../../widgets/stat_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);
    final entriesAsync = ref.watch(entriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.appTitle),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push(PathConstants.search),
            tooltip: TextConstants.search,
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(PathConstants.settings),
            tooltip: TextConstants.settings,
          ),
        ],
      ),
      body: statsAsync.when(
        data: (stats) {
          final total = stats['total'] ?? 0;
          return RefreshIndicator(
            onRefresh: () async {
              // Hive is local, so this just triggers a redraw
              ref.invalidate(statsProvider);
              ref.invalidate(entriesProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(SizeConstants.pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome & Search Box shortcut
                    // _buildSearchBar(context),
                    // const SizedBox(height: 24),

                    // Stats Grid Section
                    Text(
                      TextConstants.yourLexiconStats,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap.vertical(SizeConstants.lg),
                    _buildStatsGrid(context, stats),
                    const Gap.vertical(SizeConstants.lg),

                    // Quick Actions
                    Text(
                      TextConstants.quickActions,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap.vertical(SizeConstants.lg),
                    _buildQuickActions(context),
                    const Gap.vertical(SizeConstants.lg),

                    // Tags Index
                    _buildTagsSection(context, ref),
                    const Gap.vertical(SizeConstants.lg),

                    // Recent Items Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TextConstants.recentEntries,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (total > 0)
                          TextButton(
                            onPressed: () => context.push(PathConstants.search),
                            child: const Text(TextConstants.viewAll),
                          ),
                      ],
                    ),
                    const Gap.vertical(SizeConstants.sm),

                    entriesAsync.when(
                      data: (entries) {
                        if (entries.isEmpty) {
                          return _buildEmptyState(context);
                        }
                        // Limit to top 5 recent entries
                        final recent = entries.take(5).toList();
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recent.length,
                          separatorBuilder: (context, index) =>
                              const Gap.vertical(SizeConstants.space10),
                          itemBuilder: (context, index) {
                            return _buildEntryCard(context, ref, recent[index]);
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) =>
                          Text('${TextConstants.errorLoadingEntries} $err'),
                    ),
                    const Gap.vertical(
                      SizeConstants.fabSpacer,
                    ), // Space for FAB
                  ],
                ),
              ),
            ),
          );
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, stack) =>
            Scaffold(body: Center(child: Text('${TextConstants.error} $err'))),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(PathConstants.entryForm),
        icon: const Icon(Icons.add),
        label: const Text(TextConstants.addEntry),
      ),
    );
  }

  Widget _buildTagsSection(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseServiceProvider);
    final tags = db.getAllTags();

    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextConstants.yourTags,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap.vertical(SizeConstants.space10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.take(8).map((tag) {
            return ActionChip(
              label: Text('#$tag'),
              onPressed: () => context.push(PathConstants.searchByTag(tag)),
              visualDensity: VisualDensity.compact,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context, Map<String, int> stats) {
    final wordCount = stats['words'] ?? 0;
    final quoteCount = stats['quotes'] ?? 0;
    final phraseCount = stats['phrases'] ?? 0;
    final idiomCount = stats['idioms'] ?? 0;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.6,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        StatCard(
          title: TextConstants.words,
          count: wordCount,
          icon: Icons.abc,
          color: Colors.blue,
          onTap: () => context.push(PathConstants.categoryByType('word')),
        ),
        StatCard(
          title: TextConstants.quotes,
          count: quoteCount,
          icon: Icons.format_quote,
          color: Colors.purple,
          onTap: () => context.push(PathConstants.categoryByType('quote')),
        ),
        StatCard(
          title: TextConstants.phrases,
          count: phraseCount,
          icon: Icons.chat_bubble_outline,
          color: Colors.teal,
          onTap: () => context.push(PathConstants.categoryByType('phrase')),
        ),
        StatCard(
          title: TextConstants.idioms,
          count: idiomCount,
          icon: Icons.auto_awesome,
          color: Colors.orange,
          onTap: () => context.push(PathConstants.categoryByType('idiom')),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildActionButton(
            context,
            label: TextConstants.favorites,
            icon: Icons.favorite,
            color: Colors.redAccent,
            onTap: () => context.push(PathConstants.searchFavorites()),
          ),
          const Gap.horizontal(SizeConstants.md),
          _buildActionButton(
            context,
            label: TextConstants.collections,
            icon: Icons.folder_special,
            color: Colors.indigo,
            onTap: () => context.push(PathConstants.collections),
          ),
          const Gap.horizontal(SizeConstants.md),
          _buildActionButton(
            context,
            label: TextConstants.searchTags,
            icon: Icons.sell,
            color: Colors.green,
            onTap: () => context.push(PathConstants.searchFocusTags()),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 0,
      color: isDark ? const Color(0xFF1F2937) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(
          children: [
            Icon(
              Icons.auto_stories_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const Gap.vertical(SizeConstants.lg),
            Text(
              TextConstants.yourLexiconIsEmpty,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap.vertical(SizeConstants.sm),
            Text(
              TextConstants.emptyStateDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const Gap.vertical(SizeConstants.xl),
            ElevatedButton.icon(
              onPressed: () => context.push(PathConstants.entryForm),
              icon: const Icon(Icons.add),
              label: const Text(TextConstants.addFirstEntry),
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

    return Card(
      child: InkWell(
        onTap: () => context.push(PathConstants.entryDetail(entry.id)),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      entry.type.name.toUpperCase(),
                      style: TextStyle(
                        color: typeColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
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
              const Gap.vertical(SizeConstants.sm),
              Text(
                entry.term,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap.vertical(SizeConstants.xs),
              Text(
                entry.definition,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              if (entry.tags.isNotEmpty) ...[
                const Gap.vertical(SizeConstants.md),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: entry.tags.take(3).map((tag) {
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
