import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:mylexicon/l10n/lexicon_type_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';
import '../../core/models/app_feature.dart';
import '../../core/providers/feature_flags_provider.dart';

class EntryDetailScreen extends ConsumerWidget {
  final String entryId;

  const EntryDetailScreen({super.key, required this.entryId});

  void _toggleFavorite(
    BuildContext context,
    WidgetRef ref,
    LexiconEntry entry,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final db = ref.read(databaseServiceProvider);
    entry.isFavorite = !entry.isFavorite;
    try {
      await db.saveEntry(entry);
      ref.invalidate(statsProvider);
      ref.invalidate(entriesProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.failedToUpdateFavorite(e.toString())),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, LexiconEntry entry) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.deleteEntryTitle),
          content: Text(l10n.deleteEntryContent(entry.term)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss dialog
                final db = ref.read(databaseServiceProvider);
                try {
                  await db.deleteEntry(entry.id);
                  ref.invalidate(statsProvider);
                  ref.invalidate(entriesProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.deleteSuccess),
                        backgroundColor: Colors.green,
                      ),
                    );
                    context.pop(); // Pop detail screen
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.deleteError(e.toString())),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
              child: Text(
                l10n.delete,
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
    final l10n = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(entriesProvider);
    final collectionsAsync = ref.watch(collectionsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return entriesAsync.when(
      data: (entries) {
        final entryIndex = entries.indexWhere((e) => e.id == entryId);
        if (entryIndex == -1) {
          // Entry not found (deleted)
          return Scaffold(body: Center(child: Text(l10n.entryNotFound)));
        }

        final entry = entries[entryIndex];
        final formattedDate = DateFormat(
          'MMMM d, yyyy • hh:mm a',
          Localizations.localeOf(context).languageCode,
        ).format(entry.createdAt);

        // Fetch collection details
        final collection = collectionsAsync.maybeWhen(
          data: (cols) => cols.firstWhere(
            (c) =>
                c.id == entry.collectionId ||
                entry.collectionIds.contains(c.id),
            orElse: () => LexiconCollection(
              id: '',
              name: l10n.uncategorized,
              colorValue: Colors.grey.toARGB32(),
              createdAt: DateTime.now(),
            ),
          ),
          orElse: () => null,
        );

        Color typeColor = Colors.grey;
        switch (entry.type) {
          case LexiconType.word:
            typeColor = Colors.blue;
            break;
          case LexiconType.quote:
            typeColor = Colors.purple;
            break;
          case LexiconType.phrase:
            typeColor = Colors.teal;
            break;
          case LexiconType.idiom:
            typeColor = Colors.orange;
            break;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.entryDetails),
            actions: [
              IconButton(
                icon: Icon(
                  entry.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: entry.isFavorite ? Colors.redAccent : null,
                ),
                onPressed: () => _toggleFavorite(context, ref, entry),
                tooltip: entry.isFavorite ? l10n.unfavoriteTooltip : l10n.favoriteTooltip,
              ),
              IconButton(
                icon: Icon(Icons.edit_outlined),
                onPressed: () => context.push('/entry-form?id=${entry.id}'),
                tooltip: l10n.editTooltip,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => _confirmDelete(context, ref, entry),
                tooltip: l10n.deleteTooltip,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type & Collection Header Row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          entry.type.localizedBadge(AppLocalizations.of(context)!),
                          style: TextStyle(
                            color: typeColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (collection != null &&
                          (ref.watch(featureFlagsProvider)[AppFeature.collections] ??
                              true)) ...[
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color(
                              collection.colorValue,
                            ).withValues(alpha: isDark ? 0.2 : 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.folder,
                                color: Color(collection.colorValue),
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                collection.name,
                                style: TextStyle(
                                  color: Color(collection.colorValue),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 20),

                  // The Term/Text Display Card
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade100,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: SelectionArea(
                          child: Text(
                            entry.term,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                  fontSize: entry.type == LexiconType.quote
                                      ? 22
                                      : 28,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Definition / Meaning Section
                  Text(
                    entry.type == LexiconType.quote
                        ? l10n.contextAndMeaning
                        : entry.type == LexiconType.idiom
                        ? l10n.meaningAndInterpretation
                        : l10n.definitionLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: SelectionArea(
                      child: Text(
                        entry.definition,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Example Sentences Section
                  if (entry.examples.isNotEmpty) ...[
                    Text(
                      entry.type == LexiconType.quote
                          ? l10n.sourceContext
                          : entry.examples.length > 1
                          ? l10n.examples
                          : l10n.exampleUsage,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...List.generate(entry.examples.length, (index) {
                      final ex = entry.examples[index];
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade100,
                          ),
                        ),
                        child: SelectionArea(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (entry.examples.length > 1)
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '${index + 1}.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  entry.type == LexiconType.quote
                                      ? ex
                                      : '"$ex"',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontStyle: entry.type == LexiconType.quote
                                        ? FontStyle.normal
                                        : FontStyle.italic,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 16),
                  ],

                  // Notes Section
                  if (entry.notes != null) ...[
                    Text(
                      l10n.personalNotes,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: isDark ? 0.05 : 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.2),
                        ),
                      ),
                      child: SelectionArea(
                        child: Text(
                          entry.notes!,
                          style: TextStyle(fontSize: 15, height: 1.4),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],

                  // Tags Section
                  if (entry.tags.isNotEmpty) ...[
                    Text(
                      l10n.tags,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: entry.tags.map((tag) {
                        return ActionChip(
                          label: Text('#$tag'),
                          onPressed: () {
                            context.push('/search?tag=$tag');
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 24),
                  ],

                  Divider(),
                  SizedBox(height: 8),

                  // Metadata section
                  Text(
                    l10n.storedOn(formattedDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
      loading: () =>
          Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text(l10n.error(err.toString())))),
    );
  }
}
