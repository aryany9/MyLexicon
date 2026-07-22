import 'package:flutter/material.dart';

import '../../../models/lexicon_entry.dart';

class DuplicateWarningCard extends StatelessWidget {
  final LexiconEntry duplicateEntry;
  final VoidCallback onViewEntry;

  const DuplicateWarningCard({
    super.key,
    required this.duplicateEntry,
    required this.onViewEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.withOpacity(0.12),
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
