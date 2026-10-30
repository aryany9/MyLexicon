import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:mylexicon/l10n/lexicon_type_l10n.dart';
import 'package:flutter/material.dart';

import '../../../models/lexicon_entry.dart';

class DuplicateWarningCard extends StatelessWidget {
  final LexiconEntry duplicateEntry;
  final VoidCallback onViewEntry;
  /// When provided, shows "Already exists in `<collectionName>`".
  /// When null, shows "Already exists as an unassigned entry".
  final String? collectionName;

  const DuplicateWarningCard({
    super.key,
    required this.duplicateEntry,
    required this.onViewEntry,
    this.collectionName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final existsLine = collectionName != null
        ? 'Already exists in "$collectionName"'
        : 'Already exists as an unassigned entry';

    final hintLine = collectionName != null
        ? 'If this entry belongs to a different collection, change the Collection field below and tap Save again.'
        : 'If this is a different usage, assign it to a specific collection using the Collection field below and tap Save again.';

    return Card(
      color: Colors.amber.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.orange.withValues(alpha: 0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_outlined, color: Colors.orange),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.duplicateEntryDetected,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${duplicateEntry.term} • ${duplicateEntry.type.localizedSingular(AppLocalizations.of(context)!)}',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  Text(
                    existsLine,
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 8),
                  Text(
                    hintLine,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      onPressed: onViewEntry,
                      child: Text(l10n.viewExistingEntry),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
