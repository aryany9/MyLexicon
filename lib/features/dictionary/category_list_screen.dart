import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mylexicon/core/constants/size_constants.dart';
import '../../core/services/database_service.dart';
import '../../core/providers/sort_order_provider.dart';
import '../../models/lexicon_type.dart';
import '../../widgets/words_card.dart';

class CategoryListScreen extends ConsumerStatefulWidget {
  final LexiconType type;

  const CategoryListScreen({super.key, required this.type});

  @override
  ConsumerState<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends ConsumerState<CategoryListScreen> {
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = {};

  String _getCategoryTitle() {
    switch (widget.type) {
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
    switch (widget.type) {
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

  void _enterSelectionMode(String? initialId) {
    setState(() {
      _isSelectionMode = true;
      if (initialId != null) {
        _selectedIds.add(initialId);
      }
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  Future<void> _confirmDeleteSelected(int count) async {
    await showDialog<void>(
      context: context,
      useRootNavigator: false,
      builder: (dialogContext) {
        final itemLabel = count == 1
            ? _getSingleTypeName().toLowerCase()
            : _getCategoryTitle().toLowerCase();
        return AlertDialog(
          title: Text('Delete $count $itemLabel?'),
          content: Text(
            'Are you sure you want to permanently delete $count selected $itemLabel? '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                final db = ref.read(databaseServiceProvider);
                final toDelete = _selectedIds.toList();
                for (final id in toDelete) {
                  await db.deleteEntry(id);
                }
                ref.invalidate(statsProvider);
                ref.invalidate(entriesProvider);
                _exitSelectionMode();
                if (mounted) {
                  final itemLabel = count == 1
                      ? _getSingleTypeName().toLowerCase()
                      : _getCategoryTitle().toLowerCase();
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Deleted $count $itemLabel.'),
                    ),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (_isSelectionMode) {
      // Re-enable system back handling so Android does not close the app
      // after the dialog popped off the root navigator.
      SystemNavigator.setFrameworkHandlesBack(true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isSelectionMode) {
          const NavigationNotification(canHandlePop: true).dispatch(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseServiceProvider);
    final entriesAsync = ref.watch(entriesProvider);
    final sortOrderMap = ref.watch(sortOrderProvider);
    final currentSortOrder = sortOrderMap[widget.type] ?? SortOrder.newestFirst;
    final title = _getCategoryTitle();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (_isSelectionMode) {
            _exitSelectionMode();
          } else {
            context.go('/');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _isSelectionMode
              ? IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Cancel',
                  onPressed: _exitSelectionMode,
                )
              : null,
          title: Text(
            _isSelectionMode ? '${_selectedIds.length} selected' : title,
          ),
          centerTitle: false,
          actions: _isSelectionMode
              ? [
                  IconButton(
                    icon: const Icon(Icons.select_all_rounded),
                    tooltip: 'Toggle select all',
                    onPressed: () {
                      final entries = db.searchAndFilter(
                        type: widget.type,
                        sortOrder: currentSortOrder,
                      );
                      setState(() {
                        if (_selectedIds.length == entries.length) {
                          _selectedIds.clear();
                        } else {
                          _selectedIds.addAll(entries.map((e) => e.id));
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                    tooltip: 'Delete selected',
                    onPressed: _selectedIds.isEmpty
                        ? null
                        : () => _confirmDeleteSelected(_selectedIds.length),
                  ),
                ]
              : [
                  IconButton(
                    icon: const Icon(Icons.checklist_rounded),
                    tooltip: 'Select items',
                    onPressed: () {
                      final entries = db.searchAndFilter(
                        type: widget.type,
                        sortOrder: currentSortOrder,
                      );
                      if (entries.isNotEmpty) {
                        _enterSelectionMode(null);
                      }
                    },
                  ),
                  PopupMenuButton<SortOrder>(
                    icon: const Icon(Icons.swap_vert),
                    tooltip: 'Sort order',
                    onSelected: (order) {
                      ref
                          .read(sortOrderProvider.notifier)
                          .setSortOrder(widget.type, order);
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
            final entries = db.searchAndFilter(
              type: widget.type,
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
                final entry = entries[index];
                return WordsCard(
                  ref: ref,
                  entry: entry,
                  isSelectionMode: _isSelectionMode,
                  isSelected: _selectedIds.contains(entry.id),
                  onSelect: () => _toggleSelection(entry.id),
                  onLongPress: () {
                    if (!_isSelectionMode) {
                      _enterSelectionMode(entry.id);
                    }
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Center(child: Text('Error loading entries: $err')),
        ),
        floatingActionButton: _isSelectionMode
            ? null
            : FloatingActionButton.extended(
                onPressed: () =>
                    context.push('/entry-form?type=${widget.type.name}'),
                icon: const Icon(Icons.add),
                label: Text('Add ${_getSingleTypeName()}'),
              ),
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
              onPressed: () =>
                  context.push('/entry-form?type=${widget.type.name}'),
              icon: const Icon(Icons.add),
              label: Text('Add First $categoryTitle'),
            ),
          ],
        ),
      ),
    );
  }
}
