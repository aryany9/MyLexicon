import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:mylexicon/l10n/lexicon_type_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';
import '../../core/models/app_feature.dart';
import '../../core/providers/feature_flags_provider.dart';
import 'widgets/duplicate_warning_card.dart';

class EntryFormScreen extends ConsumerStatefulWidget {
  final String? entryId;
  final LexiconType? initialType;

  const EntryFormScreen({super.key, this.entryId, this.initialType});

  @override
  ConsumerState<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends ConsumerState<EntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _termFieldKey = GlobalKey<FormFieldState>();
  final _definitionFieldKey = GlobalKey<FormFieldState>();

  late LexiconType _selectedType;
  bool _hideTypePicker = false;
  final _termController = TextEditingController();
  final _definitionController = TextEditingController();
  final List<TextEditingController> _exampleControllers = [];
  final _notesController = TextEditingController();
  final _tagInputController = TextEditingController();
  final _tagFocusNode = FocusNode();

  String? _selectedCollectionId;
  List<String> _tags = [];
  bool _isFavorite = false;
  DateTime? _createdAt;
  LexiconEntry? _duplicateEntry;

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.entryId != null;
    if (_isEditMode || widget.initialType != null) {
      _hideTypePicker = true;
      if (widget.initialType != null) {
        _selectedType = widget.initialType!;
      } else {
        _selectedType = LexiconType.word;
      }
    } else {
      _selectedType = LexiconType.word;
      _hideTypePicker = false;
    }

    if (_isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadEntry();
      });
    } else {
      _exampleControllers.add(TextEditingController());
    }
  }

  void _loadEntry() {
    final db = ref.read(databaseServiceProvider);
    final entry = db.getEntries().firstWhere((e) => e.id == widget.entryId);

    setState(() {
      _selectedType = entry.type;
      _hideTypePicker = true;
      _termController.text = entry.term;
      _definitionController.text = entry.definition;
      for (final c in _exampleControllers) {
        c.dispose();
      }
      _exampleControllers.clear();
      if (entry.examples.isNotEmpty) {
        for (final ex in entry.examples) {
          _exampleControllers.add(TextEditingController(text: ex));
        }
      } else {
        _exampleControllers.add(TextEditingController());
      }
      _notesController.text = entry.notes ?? '';
      _selectedCollectionId =
          entry.collectionId ??
          (entry.collectionIds.isNotEmpty ? entry.collectionIds.first : null);
      _tags = List<String>.from(entry.tags);
      _isFavorite = entry.isFavorite;
      _createdAt = entry.createdAt;
    });
  }

  @override
  void dispose() {
    _termController.dispose();
    _definitionController.dispose();
    for (final c in _exampleControllers) {
      c.dispose();
    }
    _notesController.dispose();
    _tagInputController.dispose();
    _tagFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    final clean = tag.trim().toLowerCase();
    if (clean.isNotEmpty && !_tags.contains(clean)) {
      setState(() {
        _tags.add(clean);
      });
      _tagInputController.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _addExampleField() {
    if (_exampleControllers.length < 5) {
      setState(() {
        _exampleControllers.add(TextEditingController());
      });
    }
  }

  void _removeExampleField(int index) {
    if (_exampleControllers.length > 1) {
      setState(() {
        _exampleControllers[index].dispose();
        _exampleControllers.removeAt(index);
      });
    } else {
      setState(() {
        _exampleControllers[0].clear();
      });
    }
  }

  void _save() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      // Scroll to the first field that failed validation so the error is visible
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (final key in [_termFieldKey, _definitionFieldKey]) {
          if (key.currentState?.hasError == true) {
            final ctx = key.currentContext;
            if (ctx != null) {
              Scrollable.ensureVisible(
                ctx,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                alignment: 0.15,
              );
            }
            break;
          }
        }
      });
      return;
    }

    final db = ref.read(databaseServiceProvider);
    final id = _isEditMode ? widget.entryId! : const Uuid().v4();
    final createdAt = _createdAt ?? DateTime.now();

    final effectiveCollectionIds = _selectedCollectionId == null
        ? const <String>[]
        : [_selectedCollectionId!];

    // Save-time collection-aware duplicate check
    final duplicate = db.findDuplicateEntry(
      _termController.text.trim(),
      _selectedType,
      excludeEntryId: widget.entryId,
      incomingCollectionIds: effectiveCollectionIds,
    );
    if (duplicate != null) {
      setState(() {
        _duplicateEntry = duplicate;
      });
      // Scroll to top so the warning banner is immediately visible
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      });
      return;
    }

    final entry = LexiconEntry(
      id: id,
      term: _termController.text.trim(),
      definition: _definitionController.text.trim(),
      type: _selectedType,
      examples: _exampleControllers
          .map((c) => c.text.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      tags: _tags,
      collectionId: _selectedCollectionId,
      collectionIds: effectiveCollectionIds,
      isFavorite: _isFavorite,
      createdAt: createdAt,
    );

    try {
      await db.saveEntry(entry);
      // Invalidate stats & entries
      ref.invalidate(statsProvider);
      ref.invalidate(entriesProvider);

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode
                  ? l10n.entryUpdatedSuccess
                  : l10n.entryCreatedSuccess,
            ),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        final errorMessage = e is ArgumentError && e.message.toString().contains('already exists')
            ? l10n.duplicateTermError(_selectedType.localizedSingular(l10n))
            : l10n.error(e.toString().replaceAll('ArgumentError: ', ''));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final collectionsAsync = ref.watch(collectionsProvider);
    final allTags = ref.read(databaseServiceProvider).getAllTags();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Set labels depending on type
    String termLabel = l10n.termLabel;
    String definitionLabel = l10n.definitionLabel;
    switch (_selectedType) {
      case LexiconType.word:
        termLabel = l10n.typeWord;
        definitionLabel = l10n.meaningOrDefinition;
        break;
      case LexiconType.quote:
        termLabel = l10n.quoteText;
        definitionLabel = l10n.quoteContextMeaningNotes;
        break;
      case LexiconType.phrase:
        termLabel = l10n.typePhrase;
        definitionLabel = l10n.meaningOrTranslation;
        break;
      case LexiconType.idiom:
        termLabel = l10n.typeIdiom;
        definitionLabel = l10n.meaningOrOrigin;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? l10n.editEntry : l10n.addNewEntry),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
            tooltip: l10n.saveTooltip,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Duplicate warning banner — shown at the very top when save is blocked
                if (_duplicateEntry != null) ...[
                  collectionsAsync.when(
                    data: (collections) {
                      final duplicateCollectionName = _duplicateEntry!.collectionIds.isNotEmpty
                          ? collections
                              .where((c) => _duplicateEntry!.collectionIds.contains(c.id))
                              .map((c) => c.name)
                              .firstOrNull
                          : null;
                      return DuplicateWarningCard(
                        duplicateEntry: _duplicateEntry!,
                        collectionName: duplicateCollectionName,
                        onViewEntry: () => context.push('/entry/${_duplicateEntry!.id}'),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Type Selector (SegmentedButton) - only shown when not pre-selected
                if (!_hideTypePicker) Builder(
                  builder: (context) {
                    final flags = ref.watch(featureFlagsProvider);
                    final availableSegments = <ButtonSegment<LexiconType>>[
                      if (flags[AppFeature.word] ?? true)
                        ButtonSegment(
                          value: LexiconType.word,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n.typeWord),
                          ),
                        ),
                      if (flags[AppFeature.quote] ?? true)
                        ButtonSegment(
                          value: LexiconType.quote,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n.typeQuote),
                          ),
                        ),
                      if (flags[AppFeature.phrase] ?? true)
                        ButtonSegment(
                          value: LexiconType.phrase,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n.typePhrase),
                          ),
                        ),
                      if (flags[AppFeature.idiom] ?? true)
                        ButtonSegment(
                          value: LexiconType.idiom,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n.typeIdiom),
                          ),
                        ),
                    ];

                    // If currently selected type is disabled, adjust selection to first available segment
                    if (availableSegments.isNotEmpty &&
                        !availableSegments.any((s) => s.value == _selectedType)) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _selectedType = availableSegments.first.value;
                          });
                        }
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.selectEntryType,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: SegmentedButton<LexiconType>(
                            style: const ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(Size(0, 56)),
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                              ),
                            ),
                            showSelectedIcon: true,
                            segments: availableSegments,
                            selected: {_selectedType},
                            onSelectionChanged: (Set<LexiconType> newSelection) {
                              setState(() {
                                _selectedType = newSelection.first;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),

                // Term Field
                Text(
                  termLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  key: _termFieldKey,
                  controller: _termController,
                  maxLines: _selectedType == LexiconType.quote ? 3 : 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: l10n.enterFieldHint(termLabel)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.fieldCannotBeEmpty(termLabel);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Definition Field
                Text(
                  definitionLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  key: _definitionFieldKey,
                  controller: _definitionController,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: l10n.enterFieldHint(definitionLabel),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.fieldCannotBeEmpty(definitionLabel);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Multiple Examples Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedType == LexiconType.quote
                          ? l10n.sourceContext
                          : l10n.exampleSentences,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_exampleControllers.length < 5)
                      TextButton.icon(
                        onPressed: _addExampleField,
                        icon: const Icon(Icons.add, size: 18),
                        label: Text(l10n.addExample),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                ...List.generate(_exampleControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _exampleControllers[index],
                            maxLines: 2,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: _selectedType == LexiconType.quote
                                  ? l10n.quoteSourceExample
                                  : l10n.exampleNth(index + 1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => _removeExampleField(index),
                          tooltip: l10n.removeExampleTooltip,
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),

                // Notes Field
                Text(
                  l10n.personalNotesOptional,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: l10n.personalNotesHint,
                  ),
                ),
                const SizedBox(height: 20),

                // Collection selector
                Text(
                  l10n.collectionOptional,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                collectionsAsync.when(
                  data: (collections) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          initialValue: _selectedCollectionId,
                          decoration: const InputDecoration(),
                          hint: Text(l10n.selectCollectionHint),
                          items: [
                            DropdownMenuItem<String>(
                              value: null,
                              child: Text(l10n.noneCollection),
                            ),
                            ...collections.map((c) {
                              return DropdownMenuItem<String>(
                                value: c.id,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.folder,
                                      color: Color(c.colorValue),
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(c.name),
                                  ],
                                ),
                              );
                            }),
                          ],
                          onChanged: (val) {
                            setState(() {
                              _selectedCollectionId = val;
                              // Clear duplicate warning when collection changes
                              _duplicateEntry = null;
                            });
                          },
                        ),
                      ],
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (err, stack) =>
                      Text(l10n.errorLoadingCollections(err.toString())),
                ),
                const SizedBox(height: 20),

                // Tag Input with Autocomplete
                Text(
                  l10n.tags,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return allTags.where((String option) {
                      return option.contains(
                        textEditingValue.text.toLowerCase(),
                      );
                    });
                  },
                  onSelected: (String selection) {
                    _addTag(selection);
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onFieldSubmitted) {
                        // Sync our local controller with autocomplete field controller
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: l10n.tagInputHint,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _addTag(controller.text);
                                controller.clear();
                              },
                            ),
                          ),
                          onFieldSubmitted: (val) {
                            _addTag(val);
                            controller.clear();
                          },
                        );
                      },
                ),
                const SizedBox(height: 12),

                // Tags Chips
                if (_tags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      return InputChip(
                        label: Text(tag),
                        onDeleted: () => _removeTag(tag),
                      );
                    }).toList(),
                  )
                else
                  Text(
                    l10n.noTagsAddedYet,
                    style: TextStyle(
                      color: isDark
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                const SizedBox(height: 20),

                // Favorite Switch List Tile
                SwitchListTile.adaptive(
                  title: Text(l10n.markAsFavorite),
                  subtitle: Text(l10n.markAsFavoriteSubtitle),
                  value: _isFavorite,
                  onChanged: (val) {
                    setState(() {
                      _isFavorite = val;
                    });
                  },
                ),
                const SizedBox(height: 40),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    key: const Key('saveEntryButton'),
                    onPressed: _save,
                    child: Text(_isEditMode ? l10n.updateEntry : l10n.saveEntry),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
