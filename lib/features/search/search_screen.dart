import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  String _query = '';
  LexiconType? _selectedType;
  String? _selectedTag;
  bool _isFavoriteOnly = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    // Read route query parameters after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = GoRouterState.of(context).uri;
      final favoriteParam = uri.queryParameters['favorite'];
      final tagParam = uri.queryParameters['tag'];
      final focusTagsParam = uri.queryParameters['focusTags'];

      setState(() {
        if (favoriteParam == 'true') {
          _isFavoriteOnly = true;
        }
        if (tagParam != null && tagParam.isNotEmpty) {
          _selectedTag = tagParam;
        }
        if (focusTagsParam == 'true') {
          // Open tag picker directly
          _showTagPicker();
        } else {
          _searchFocusNode.requestFocus();
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _query = _searchController.text;
    });
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _query = '';
      _selectedType = null;
      _selectedTag = null;
      _isFavoriteOnly = false;
    });
  }

  void _showTagPicker() {
    final db = ref.read(databaseServiceProvider);
    final allTags = db.getAllTags();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a Tag',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                if (allTags.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Text(
                        'No tags found in database',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: allTags.map((tag) {
                            final isSelected = _selectedTag == tag;
                            return ChoiceChip(
                              label: Text('#$tag'),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedTag = selected ? tag : null;
                                });
                                Navigator.of(context).pop();
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseServiceProvider);
    final entriesAsync = ref.watch(entriesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine if any filters are active
    final hasActiveFilters =
        _query.isNotEmpty ||
        _selectedType != null ||
        _selectedTag != null ||
        _isFavoriteOnly;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
        actions: [
          if (hasActiveFilters)
            TextButton(onPressed: _clearFilters, child: const Text('Reset')),
        ],
      ),
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search term or definition...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
              ),
            ),
          ),

          // Filters Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: Row(
              children: [
                // Favorites Chip
                FilterChip(
                  label: const Text('Favorites'),
                  selected: _isFavoriteOnly,
                  onSelected: (selected) {
                    setState(() {
                      _isFavoriteOnly = selected;
                    });
                  },
                  selectedColor: Colors.redAccent.withOpacity(0.2),
                  checkmarkColor: Colors.redAccent,
                ),
                const SizedBox(width: 8),

                // Tags Chip
                ActionChip(
                  label: Text(
                    _selectedTag != null ? '#$_selectedTag' : 'Select Tag',
                  ),
                  onPressed: _showTagPicker,
                  avatar: const Icon(Icons.sell_outlined, size: 16),
                  backgroundColor: _selectedTag != null
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : null,
                ),
                const SizedBox(width: 8),

                // Type Chips
                ...LexiconType.values.map((type) {
                  final isSelected = _selectedType == type;
                  Color chipColor = Colors.grey;
                  switch (type) {
                    case LexiconType.word:
                      chipColor = Colors.blue;
                      break;
                    case LexiconType.quote:
                      chipColor = Colors.purple;
                      break;
                    case LexiconType.phrase:
                      chipColor = Colors.teal;
                      break;
                    case LexiconType.idiom:
                      chipColor = Colors.orange;
                      break;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(type.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = selected ? type : null;
                        });
                      },
                      selectedColor: chipColor.withOpacity(0.2),
                      checkmarkColor: chipColor,
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(),

          // Search Results
          Expanded(
            child: entriesAsync.when(
              data: (_) {
                // Apply current active filters reactively
                final results = db.searchAndFilter(
                  query: _query,
                  type: _selectedType,
                  tag: _selectedTag,
                  isFavorite: _isFavoriteOnly ? true : null,
                );

                if (results.isEmpty) {
                  return _buildEmptyState(context, hasActiveFilters);
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: results.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildEntryCard(context, ref, results[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool hasActiveFilters) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasActiveFilters ? Icons.search_off : Icons.find_in_page_outlined,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              hasActiveFilters ? 'No results found' : 'Your lexicon is empty',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              hasActiveFilters
                  ? 'Try adjusting your search terms or filter constraints.'
                  : 'Start adding new entries using the add button.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            if (hasActiveFilters) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: _clearFilters,
                icon: const Icon(Icons.refresh),
                label: const Text('Clear Filters'),
              ),
            ],
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
              const SizedBox(height: 8),
              Text(
                entry.term,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
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
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: entry.tags.map((tag) {
                    final isCurrentTag = _selectedTag == tag;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isCurrentTag
                            ? Theme.of(context).colorScheme.primary.withOpacity(
                                isDark ? 0.3 : 0.1,
                              )
                            : (isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(100),
                        border: isCurrentTag
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0.5,
                              )
                            : null,
                      ),
                      child: Text(
                        '#$tag',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isCurrentTag
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isCurrentTag
                              ? Theme.of(context).colorScheme.primary
                              : (isDark
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade700),
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
