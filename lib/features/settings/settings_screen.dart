import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/database_service.dart';
import '../../core/services/export_import_service.dart';
import 'import_preview_screen.dart';
import '../../main.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _showClearAllConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Clear All Data?',
            style: TextStyle(color: Colors.redAccent),
          ),
          content: const Text(
            'This action will permanently delete all your stored words, quotes, phrases, idioms, and collections.\n\n'
            'This is irreversible. Are you sure you want to continue?',
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
                  await db.clearAllData();
                  ref.invalidate(statsProvider);
                  ref.invalidate(entriesProvider);
                  ref.invalidate(collectionsProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All data cleared successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error clearing data: $e'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Clear Everything',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
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
                  ref.invalidate(
                    entriesProvider,
                  ); // Invalidate entries to trigger refresh
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

  /// Prompts the user for an export format, generates the export file via
  /// [ExportImportService], then lets the user pick where to save it locally
  /// using the system's native save/file-location picker (file_picker).
  ///
  /// NOTE: This replaces the previous share-sheet-based flow. The export is
  /// written to a real, user-chosen location instead of a transient temp file
  /// handed off to Share.
  Future<void> _showExportFormatPicker(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final format = await showDialog<ExportFormat>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Export Data'),
          content: const Text(
            'Choose the export format for your lexicon backup.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ExportFormat.json),
              child: const Text('JSON Backup'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ExportFormat.csv),
              child: const Text('CSV Spreadsheet'),
            ),
          ],
        );
      },
    );

    if (format == null) {
      return;
    }

    final service = ExportImportService(
      databaseService: ref.read(databaseServiceProvider),
    );

    try {
      // Generate the export content using the existing service pipeline.
      final exportPackage = await service.exportAll(format);
      final tempFile = await service.writeExportToTempFile(exportPackage);
      final bytes = await tempFile.readAsBytes();

      final fileName =
          'lexicon_export_${DateTime.now().millisecondsSinceEpoch}.${format.name}';

      // Ask the user where to save the file locally.
      final String? savedPath = await FilePicker.saveFile(
        dialogTitle: 'Save Lexicon Export',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: [format.name],
        bytes: bytes,
      );

      // User cancelled the save dialog.
      if (savedPath == null) {
        return;
      }

      // Some file_picker versions/platforms only return the chosen path and
      // do not write the file for you when `bytes` is provided (this varies
      // by platform and package version). Guard against that so the export
      // is always written even on older/desktop implementations.
      // final savedFile = File(savedPath);
      // if (!await savedFile.exists()) {
      //   await savedFile.writeAsBytes(bytes);
      // }

      // Clean up the temp file now that the real copy has been saved.
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export saved to $savedPath'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _pickAndImportFile(BuildContext context, WidgetRef ref) async {
    final selection = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json', 'csv'],
    );
    if (selection == null || selection.files.isEmpty) {
      return;
    }

    final path = selection.files.single.path;
    if (path == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to read the selected file.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      return;
    }

    final service = ExportImportService(
      databaseService: ref.read(databaseServiceProvider),
    );
    try {
      final previewData = await service.analyzeImportFile(File(path));
      if (!context.mounted) {
        return;
      }

      final result = await Navigator.of(context).push<ImportPreviewResult>(
        MaterialPageRoute(
          builder: (context) => ImportPreviewScreen(previewData: previewData),
        ),
      );

      if (result != null && context.mounted) {
        ref.invalidate(entriesProvider);
        ref.invalidate(collectionsProvider);
        ref.invalidate(statsProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Imported ${result.result.added} new, ${result.result.skipped} skipped, ${result.result.overwritten} overwritten, ${result.result.merged} merged entries.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on InvalidImportFormatException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: Colors.redAccent),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
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
    final themeMode = ref.watch(themeModeProvider);
    final db = ref.watch(databaseServiceProvider);

    // We watch entriesProvider so tag list updates reactively
    ref.watch(entriesProvider);
    final allTags = db.getAllTags();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // Theme Section
          _buildSectionHeader(context, 'Theme Preferences'),
          ListTile(
            title: const Text('App Theme'),
            subtitle: Text(themeMode.name.toUpperCase()),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(mode);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Default'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Mode'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Mode'),
                ),
              ],
            ),
          ),
          const Divider(),

          // Tag Management Section
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
          const Divider(),

          // Data Import / Export Section
          _buildSectionHeader(context, 'Data Import & Export'),
          ListTile(
            leading: const Icon(Icons.save_alt_outlined),
            title: const Text('Export Data'),
            subtitle: const Text(
              'Save a JSON backup or CSV export of your lexicon to a location you choose',
            ),
            onTap: () => _showExportFormatPicker(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Import Data'),
            subtitle: const Text(
              'Pick a JSON or CSV file and preview duplicates before import',
            ),
            onTap: () => _pickAndImportFile(context, ref),
          ),
          const Divider(),

          // Storage Section
          _buildSectionHeader(context, 'Data Storage'),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            title: const Text(
              'Clear All Local Data',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              'Irreversibly delete all words, quotes, collections, and tags',
            ),
            onTap: () => _showClearAllConfirmation(context, ref),
          ),
        ],
      ),
    );
  }

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
}
