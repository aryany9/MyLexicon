import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/database_service.dart';
import '../../core/services/export_import_service.dart';

class ImportPreviewScreen extends ConsumerStatefulWidget {
  final ImportPreviewData previewData;

  const ImportPreviewScreen({super.key, required this.previewData});

  @override
  ConsumerState<ImportPreviewScreen> createState() =>
      _ImportPreviewScreenState();
}

class _ImportPreviewScreenState extends ConsumerState<ImportPreviewScreen> {
  ImportConflictStrategy _strategy = ImportConflictStrategy.skip;
  bool _isImporting = false;

  Future<void> _runImport() async {
    setState(() {
      _isImporting = true;
    });

    try {
      final service = ExportImportService(
        databaseService: ref.read(databaseServiceProvider),
      );
      final result = await service.importPreview(widget.previewData, _strategy);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(result);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isImporting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final previewData = widget.previewData;

    return Scaffold(
      appBar: AppBar(title: const Text('Import Preview')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            previewData.fileName,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _SummaryCard(
            label: 'Entries detected',
            value: previewData.totalEntries.toString(),
          ),
          _SummaryCard(
            label: 'Collections detected',
            value: previewData.totalCollections.toString(),
          ),
          _SummaryCard(
            label: 'Potential duplicates',
            value: previewData.duplicateCount.toString(),
          ),
          const SizedBox(height: 20),
          Text(
            'Resolution Strategy',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SegmentedButton<ImportConflictStrategy>(
            segments: const [
              ButtonSegment(
                value: ImportConflictStrategy.skip,
                label: Text('Skip'),
              ),
              ButtonSegment(
                value: ImportConflictStrategy.overwrite,
                label: Text('Overwrite'),
              ),
              ButtonSegment(
                value: ImportConflictStrategy.merge,
                label: Text('Merge'),
              ),
            ],
            selected: {_strategy},
            onSelectionChanged: (selection) {
              setState(() {
                _strategy = selection.first;
              });
            },
          ),
          const SizedBox(height: 20),
          if (previewData.duplicates.isNotEmpty) ...[
            Text(
              'Duplicate Matches',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...previewData.duplicates.map((duplicate) {
              return Card(
                child: ListTile(
                  title: Text(duplicate.incomingEntry.term),
                  subtitle: Text(
                    'Existing: ${duplicate.existingEntry.term} • ${duplicate.existingEntry.type.name}',
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
          Text(
            'Preview Content',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Raw content length: ${previewData.rawContent.length} characters',
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isImporting ? null : _runImport,
              icon: _isImporting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.file_download_outlined),
              label: Text(_isImporting ? 'Importing...' : 'Import Now'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
