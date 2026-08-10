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
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.warning_amber_outlined, color: Colors.orange),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Duplicate entry detected',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${duplicateEntry.term} • ${duplicateEntry.type.name}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    existsLine,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hintLine,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      onPressed: onViewEntry,
                      child: const Text('View Existing Entry'),
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
