import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/database_service.dart';

class TagsSettingsPage extends ConsumerWidget {
  const TagsSettingsPage({super.key});

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  void _showRenameTagDialog(
    BuildContext context,
    WidgetRef ref,
    String oldTag,
  ) {
    final controller = TextEditingController(text: oldTag);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename Tag #$oldTag'),
          content: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(labelText: 'New Tag Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newTag = controller.text.trim().toLowerCase();
                if (newTag.isEmpty) return;

                final db = ref.read(databaseServiceProvider);
                try {
                  await db.renameTag(oldTag, newTag);
                  ref.invalidate(entriesProvider);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tag #$oldTag renamed to #$newTag'),
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
              child: const Text('Rename'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteTag(BuildContext context, WidgetRef ref, String tag) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Tag #$tag?'),
          content: Text(
            'Are you sure you want to remove the tag #$tag from all entries? The entries themselves will NOT be deleted.',
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
                  await db.deleteTag(tag);
                  ref.invalidate(entriesProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tag #$tag deleted from all entries'),
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
    final db = ref.watch(databaseServiceProvider);

    // Watch entriesProvider so the tag list updates reactively.
    ref.watch(entriesProvider);
    final allTags = db.getAllTags();

    return Scaffold(
      appBar: AppBar(title: const Text('Tags')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          _buildSectionHeader(context, 'Manage Tags (${allTags.length})'),
          if (allTags.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No tags found in the database. Tags can be added when creating or editing lexicon entries.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allTags.length,
              itemBuilder: (context, index) {
                final tag = allTags[index];
                return ListTile(
                  title: Text('#$tag'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        onPressed: () =>
                            _showRenameTagDialog(context, ref, tag),
                        tooltip: 'Rename Tag',
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                        onPressed: () => _confirmDeleteTag(context, ref, tag),
                        tooltip: 'Delete Tag',
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
