import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:mylexicon/l10n/lexicon_type_l10n.dart';
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

  String _sortOrderLabel(SortOrder order, AppLocalizations l10n) {
    switch (order) {
      case SortOrder.newestFirst:
        return l10n.sortNewestFirst;
      case SortOrder.oldestFirst:
        return l10n.sortOldestFirst;
      case SortOrder.aToZ:
        return l10n.sortAtoZ;
      case SortOrder.zToA:
        return l10n.sortZtoA;
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

  Future<void> _confirmDeleteSelected(int count, AppLocalizations l10n) async {
    await showDialog<void>(
      context: context,
      useRootNavigator: false,
      builder: (dialogContext) {
        final itemLabel = count == 1 ? widget.type.localizedSingular(l10n).toLowerCase() : widget.type.localizedPlural(l10n).toLowerCase();
        return AlertDialog(
          title: Text(l10n.deleteItemsTitle(count, itemLabel)),
          content: Text(l10n.deleteItemsContent(count, itemLabel)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancel),
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
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.deletedSuccess(count)),
                    ),
                  );
                }
              },
              child: Text(l10n.delete),
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
    final l10n = AppLocalizations.of(context)!;
    final db = ref.watch(databaseServiceProvider);
    final entriesAsync = ref.watch(entriesProvider);
    final sortOrderMap = ref.watch(sortOrderProvider);
    final currentSortOrder = sortOrderMap[widget.type] ?? SortOrder.newestFirst;
    final title = widget.type.localizedPlural(l10n);

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
                  tooltip: l10n.cancelTooltip,
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
                    tooltip: l10n.toggleSelectAllTooltip,
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
                    tooltip: l10n.deleteSelectedTooltip,
                    onPressed: _selectedIds.isEmpty
                        ? null
                        : () => _confirmDeleteSelected(_selectedIds.length, l10n),
                  ),
                ]
              : [
                  IconButton(
                    icon: const Icon(Icons.checklist_rounded),
                    tooltip: l10n.selectItemsTooltip,
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
                    tooltip: l10n.sortOrderTooltip,
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
                            Text(_sortOrderLabel(order, l10n)),
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
              return _buildEmptyState(context, title, l10n);
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
              Center(child: Text(l10n.errorLoadingEntries(err.toString()))),
        ),
        floatingActionButton: _isSelectionMode
            ? null
            : FloatingActionButton.extended(
                onPressed: () =>
                    context.push('/entry-form?type=${widget.type.name}'),
                icon: const Icon(Icons.add),
                label: Text('${l10n.addEntry} - ${widget.type.localizedSingular(l10n)}'),
              ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String categoryTitle, AppLocalizations l10n) {
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
              l10n.yourLexiconIsEmpty,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.emptyStateDescription,
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
              label: Text(l10n.addFirstEntry),
            ),
          ],
        ),
      ),
    );
  }
}
