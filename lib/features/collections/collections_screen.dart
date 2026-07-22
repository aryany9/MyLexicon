import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_collection.dart';

final List<int> _collectionColors = [
  0xFF6366F1, // Indigo
  0xFFEC4899, // Pink
  0xFF10B981, // Green
  0xFFF59E0B, // Amber
  0xFF3B82F6, // Blue
  0xFF8B5CF6, // Purple
  0xFFEF4444, // Red
  0xFF14B8A6, // Teal
];

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  void _showCollectionForm(
    BuildContext context,
    WidgetRef ref, [
    LexiconCollection? collection,
  ]) {
    final isEdit = collection != null;
    final nameController = TextEditingController(text: collection?.name ?? '');
    final descController = TextEditingController(
      text: collection?.description ?? '',
    );
    int selectedColor = collection?.colorValue ?? _collectionColors.first;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEdit ? 'Edit Collection' : 'Create Collection'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Collection Name',
                        hintText: 'e.g. GRE Words, German Phrases',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Description (Optional)',
                        hintText: 'Describe this collection...',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Choose Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _collectionColors.map((colorVal) {
                        final isSelected = selectedColor == colorVal;
                        return GestureDetector(
                          onTap: () {
                            setDialogState(() {
                              selectedColor = colorVal;
                            });
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Color(colorVal),
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: Colors.white, width: 3)
                                  : null,
                              boxShadow: isSelected
                                  ? [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Collection name cannot be empty'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    final db = ref.read(databaseServiceProvider);
                    final col = LexiconCollection(
                      id: collection?.id ?? const Uuid().v4(),
                      name: name,
                      description: descController.text.trim().isEmpty
                          ? null
                          : descController.text.trim(),
                      colorValue: selectedColor,
                      createdAt: collection?.createdAt ?? DateTime.now(),
                    );

                    try {
                      await db.saveCollection(col);
                      ref.invalidate(collectionsProvider);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEdit
                                  ? 'Collection updated'
                                  : 'Collection created',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    }
                  },
                  child: Text(isEdit ? 'Save' : 'Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    LexiconCollection collection,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Collection?'),
          content: Text(
            'Are you sure you want to delete "${collection.name}"?\n\n'
            'Important: The entries stored inside this collection will NOT be deleted. '
            'They will simply become unassigned (orphaned) so you don\'t lose your words.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final db = ref.read(databaseServiceProvider);
                try {
                  await db.deleteCollection(collection.id);
                  ref.invalidate(collectionsProvider);
                  ref.invalidate(entriesProvider);
                  ref.invalidate(statsProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Collection deleted successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to delete collection: $e'),
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
    final collectionsAsync = ref.watch(collectionsProvider);
    final entriesAsync = ref.watch(entriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Collections')),
      body: collectionsAsync.when(
        data: (collections) {
          if (collections.isEmpty) {
            return _buildEmptyState(context, ref);
          }

          return entriesAsync.when(
            data: (entries) {
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: collections.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final col = collections[index];
                  // Calculate count of entries in this collection
                  final count = entries
                      .where(
                        (e) =>
                            e.collectionId == col.id ||
                            e.collectionIds.contains(col.id),
                      )
                      .length;

                  return _buildCollectionCard(context, ref, col, count);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) =>
                Center(child: Text('Error loading entries: $err')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading collections: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCollectionForm(context, ref),
        child: const Icon(Icons.create_new_folder_outlined),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
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
              'No collections created',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Create custom folders/collections to group your lexicon entries for organized revision.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showCollectionForm(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Create First Collection'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionCard(
    BuildContext context,
    WidgetRef ref,
    LexiconCollection collection,
    int count,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(collection.colorValue);

    return Card(
      child: InkWell(
        onTap: () {
          // Drill down to the collection entries list
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  _CollectionDetailSubpage(collection: collection),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Row(
            children: [
              // Folder Icon with customizable color
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(isDark ? 0.2 : 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.folder, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              // Name and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      collection.description ?? 'No description provided',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$count ${count == 1 ? 'entry' : 'entries'}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              // Action Buttons
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () => _showCollectionForm(context, ref, collection),
                tooltip: 'Edit Collection',
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
                onPressed: () => _confirmDelete(context, ref, collection),
                tooltip: 'Delete Collection',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Inner detailed subpage to list items in a single collection
class _CollectionDetailSubpage extends ConsumerWidget {
  final LexiconCollection collection;

  const _CollectionDetailSubpage({required this.collection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(entriesProvider);
    final db = ref.watch(databaseServiceProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(collection.colorValue);

    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Row(
                    children: [
                      Icon(Icons.folder, color: color),
                      const SizedBox(width: 8),
                      Text(collection.name),
                    ],
                  ),
                  content: Text(
                    collection.description ??
                        'No description provided for this collection.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: entriesAsync.when(
        data: (_) {
          final entries = db.searchAndFilter(collectionId: collection.id);

          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Collection is empty',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'No entries are assigned to this collection yet. You can assign them when creating or editing an entry.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final entry = entries[index];
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
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            if (entry.isFavorite)
                              const Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                                size: 18,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.definition,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
