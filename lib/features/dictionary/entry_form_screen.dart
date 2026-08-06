import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/services/database_service.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';
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

  late LexiconType _selectedType;
  bool _hideTypePicker = false;
  final _termController = TextEditingController();
  final _definitionController = TextEditingController();
  final List<TextEditingController> _exampleControllers = [];
  final _notesController = TextEditingController();
  final _tagInputController = TextEditingController();
  final _tagFocusNode = FocusNode();
  Timer? _duplicateCheckDebounce;

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
    _termController.addListener(_scheduleDuplicateCheck);

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
    _scheduleDuplicateCheck();
  }

  @override
  void dispose() {
    _duplicateCheckDebounce?.cancel();
    _termController.removeListener(_scheduleDuplicateCheck);
    _termController.dispose();
    _definitionController.dispose();
    for (final c in _exampleControllers) {
      c.dispose();
    }
    _notesController.dispose();
    _tagInputController.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }

  void _scheduleDuplicateCheck() {
    _duplicateCheckDebounce?.cancel();
    _duplicateCheckDebounce = Timer(
      const Duration(milliseconds: 300),
      _checkForDuplicate,
    );
  }

  void _checkForDuplicate() {
    if (!mounted) {
      return;
    }

    final term = _termController.text.trim();
    if (term.isEmpty) {
      setState(() {
        _duplicateEntry = null;
      });
      return;
    }

    final db = ref.read(databaseServiceProvider);
    final duplicate = db.findDuplicateEntry(
      term,
      _selectedType,
      excludeEntryId: widget.entryId,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _duplicateEntry = duplicate;
    });
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
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseServiceProvider);
    final id = _isEditMode ? widget.entryId! : const Uuid().v4();
    final createdAt = _createdAt ?? DateTime.now();

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
      collectionIds: _selectedCollectionId == null
          ? const []
          : [_selectedCollectionId!],
      isFavorite: _isFavorite,
      createdAt: createdAt,
    );

    try {
      await db.saveEntry(entry);
      // Invalidate stats & entries
      ref.invalidate(statsProvider);
      ref.invalidate(entriesProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode
                  ? 'Entry updated successfully'
                  : 'Entry created successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('ArgumentError: ', '')),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionsAsync = ref.watch(collectionsProvider);
    final allTags = ref.read(databaseServiceProvider).getAllTags();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Set labels depending on type
    String termLabel = 'Term';
    String definitionLabel = 'Meaning / Definition';
    switch (_selectedType) {
      case LexiconType.word:
        termLabel = 'Word';
        definitionLabel = 'Meaning / Definition';
        break;
      case LexiconType.quote:
        termLabel = 'Quote Text';
        definitionLabel = 'Context / Meaning / Author Notes';
        break;
      case LexiconType.phrase:
        termLabel = 'Phrase';
        definitionLabel = 'Meaning / Translation';
        break;
      case LexiconType.idiom:
        termLabel = 'Idiom';
        definitionLabel = 'Meaning / Origin';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Entry' : 'Add New Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
            tooltip: 'Save',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type Selector (SegmentedButton) - only shown when not pre-selected
                if (!_hideTypePicker) ...[
                  Text(
                    'Select Entry Type',
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
                      segments: const [
                        ButtonSegment(
                          value: LexiconType.word,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Word'),
                          ),
                        ),
                        ButtonSegment(
                          value: LexiconType.quote,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Quote'),
                          ),
                        ),
                        ButtonSegment(
                          value: LexiconType.phrase,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Phrase'),
                          ),
                        ),
                        ButtonSegment(
                          value: LexiconType.idiom,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Idiom'),
                          ),
                        ),
                      ],
                      selected: {_selectedType},
                      onSelectionChanged: (Set<LexiconType> newSelection) {
                        setState(() {
                          _selectedType = newSelection.first;
                        });
                        _scheduleDuplicateCheck();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Term Field
                Text(
                  termLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _termController,
                  maxLines: _selectedType == LexiconType.quote ? 3 : 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: 'Enter $termLabel...'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '$termLabel cannot be empty';
                    }
                    return null;
                  },
                ),
                if (_duplicateEntry != null) ...[
                  const SizedBox(height: 12),
                  DuplicateWarningCard(
                    duplicateEntry: _duplicateEntry!,
                    onViewEntry: () =>
                        context.push('/entry/${_duplicateEntry!.id}'),
                  ),
                ],
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
                  controller: _definitionController,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Enter $definitionLabel...',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '$definitionLabel cannot be empty';
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
                          ? 'Source Context'
                          : 'Example Sentences',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_exampleControllers.length < 5)
                      TextButton.icon(
                        onPressed: _addExampleField,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add Example'),
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
                                  ? 'e.g. Shakespeare - Hamlet, Act III'
                                  : 'Example ${index + 1}...',
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
                          tooltip: 'Remove example',
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),

                // Notes Field
                Text(
                  'Personal Notes (Optional)',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText:
                        'Add personal notes, memory triggers, or references...',
                  ),
                ),
                const SizedBox(height: 20),

                // Collection selector
                Text(
                  'Collection (Optional)',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                collectionsAsync.when(
                  data: (collections) {
                    return DropdownButtonFormField<String>(
                      value: _selectedCollectionId,
                      decoration: const InputDecoration(),
                      hint: const Text('Select a collection...'),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('None'),
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
                        });
                      },
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (err, stack) =>
                      Text('Error loading collections: $err'),
                ),
                const SizedBox(height: 20),

                // Tag Input with Autocomplete
                Text(
                  'Tags',
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
                            hintText: 'Type a tag and press enter...',
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
                    'No tags added yet',
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
                  title: const Text('Mark as Favorite'),
                  subtitle: const Text(
                    'Easily access this entry from favorites quick actions',
                  ),
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
                    child: Text(_isEditMode ? 'Update Entry' : 'Save Entry'),
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
