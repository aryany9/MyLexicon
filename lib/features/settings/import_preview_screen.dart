import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mylexicon/l10n/app_localizations.dart';

import '../../core/services/database_service.dart';
import '../../core/services/export_import_service.dart';
import '../../l10n/lexicon_type_l10n.dart';

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
    final l10n = AppLocalizations.of(context)!;
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
            content: Text(l10n.importFailed(e.toString())),
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
    final l10n = AppLocalizations.of(context)!;
    final previewData = widget.previewData;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.importPreview)),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            previewData.fileName,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _SummaryCard(
            label: l10n.entriesDetected,
            value: previewData.totalEntries.toString(),
          ),
          _SummaryCard(
            label: l10n.collectionsDetected,
            value: previewData.totalCollections.toString(),
          ),
          _SummaryCard(
            label: l10n.potentialDuplicates,
            value: previewData.duplicateCount.toString(),
          ),
          SizedBox(height: 20),
          Text(
            l10n.resolutionStrategy,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SegmentedButton<ImportConflictStrategy>(
            segments: [
              ButtonSegment(
                value: ImportConflictStrategy.skip,
                label: Text(l10n.skipDuplicates),
              ),
              ButtonSegment(
                value: ImportConflictStrategy.overwrite,
                label: Text(l10n.overwriteDuplicates),
              ),
              ButtonSegment(
                value: ImportConflictStrategy.merge,
                label: Text(l10n.mergeDuplicates),
              ),
            ],
            selected: {_strategy},
            onSelectionChanged: (selection) {
              setState(() {
                _strategy = selection.first;
              });
            },
          ),
          SizedBox(height: 20),
          if (previewData.duplicates.isNotEmpty) ...[
            Text(
              l10n.duplicateMatches,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...previewData.duplicates.map((duplicate) {
              return Card(
                child: ListTile(
                  title: Text(duplicate.incomingEntry.term),
                  subtitle: Text(
                    l10n.existingEntry(
                      duplicate.existingEntry.term,
                      duplicate.existingEntry.type.localizedSingular(l10n),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
          ],
          Text(
            l10n.previewContent,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            l10n.rawContentLength(previewData.rawContent.length),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isImporting ? null : _runImport,
              icon: _isImporting
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.file_download_outlined),
              label: Text(_isImporting ? l10n.importing : l10n.importNow),
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
