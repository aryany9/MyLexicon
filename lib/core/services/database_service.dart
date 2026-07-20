import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_collection.dart';
import '../../models/lexicon_type.dart';

class DatabaseService {
  final Box<LexiconEntry> _entriesBox;
  final Box<LexiconCollection> _collectionsBox;

  DatabaseService({
    required Box<LexiconEntry> entriesBox,
    required Box<LexiconCollection> collectionsBox,
  })  : _entriesBox = entriesBox,
        _collectionsBox = collectionsBox;

  // Expose boxes for stream notifications
  Box<LexiconEntry> get entriesBox => _entriesBox;
  Box<LexiconCollection> get collectionsBox => _collectionsBox;

  // --- Lexicon Collections CRUD ---
  
  List<LexiconCollection> getCollections() {
    return _collectionsBox.values.toList();
  }

  Future<void> saveCollection(LexiconCollection collection) async {
    if (collection.name.trim().isEmpty) {
      throw ArgumentError('Collection name cannot be empty');
    }
    await _collectionsBox.put(collection.id, collection);
  }

  Future<void> deleteCollection(String collectionId) async {
    // Collection-deletion policy: orphan entries by setting collectionId = null
    final entriesToOrphan = _entriesBox.values.where((entry) => entry.collectionId == collectionId).toList();
    for (final entry in entriesToOrphan) {
      entry.collectionId = null;
      await entry.save();
    }
    await _collectionsBox.delete(collectionId);
  }

  // --- Lexicon Entries CRUD ---

  List<LexiconEntry> getEntries() {
    return _entriesBox.values.toList();
  }

  Future<void> saveEntry(LexiconEntry entry) async {
    if (entry.term.trim().isEmpty) {
      throw ArgumentError('Term cannot be empty');
    }
    if (entry.definition.trim().isEmpty) {
      throw ArgumentError('Definition cannot be empty');
    }
    
    // Check duplicate term for the same type (case-insensitive)
    final isDuplicate = _entriesBox.values.any((e) => 
      e.id != entry.id &&
      e.type == entry.type &&
      e.term.trim().toLowerCase() == entry.term.trim().toLowerCase()
    );
    if (isDuplicate) {
      throw ArgumentError('A ${entry.type.name} with this term already exists.');
    }

    await _entriesBox.put(entry.id, entry);
  }

  Future<void> deleteEntry(String entryId) async {
    await _entriesBox.delete(entryId);
  }

  // --- Search and Filters ---
  
  List<LexiconEntry> searchAndFilter({
    String? query,
    LexiconType? type,
    String? tag,
    String? collectionId,
    bool? isFavorite,
  }) {
    Iterable<LexiconEntry> results = _entriesBox.values;

    if (query != null && query.trim().isNotEmpty) {
      final cleanQuery = query.trim().toLowerCase();
      results = results.where((e) =>
        e.term.toLowerCase().contains(cleanQuery) ||
        e.definition.toLowerCase().contains(cleanQuery)
      );
    }

    if (type != null) {
      results = results.where((e) => e.type == type);
    }

    if (tag != null && tag.trim().isNotEmpty) {
      results = results.where((e) => e.tags.contains(tag.trim()));
    }

    if (collectionId != null) {
      results = results.where((e) => e.collectionId == collectionId);
    }

    if (isFavorite != null) {
      results = results.where((e) => e.isFavorite == isFavorite);
    }

    // Default sort: most recently added first
    return results.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // --- Stats ---
  
  Map<String, int> getStats() {
    final entries = _entriesBox.values;
    final total = entries.length;
    final words = entries.where((e) => e.type == LexiconType.word).length;
    final quotes = entries.where((e) => e.type == LexiconType.quote).length;
    final phrases = entries.where((e) => e.type == LexiconType.phrase).length;
    final idioms = entries.where((e) => e.type == LexiconType.idiom).length;
    final favorites = entries.where((e) => e.isFavorite).length;
    final collectionsCount = _collectionsBox.length;

    return {
      'total': total,
      'words': words,
      'quotes': quotes,
      'phrases': phrases,
      'idioms': idioms,
      'favorites': favorites,
      'collections': collectionsCount,
    };
  }

  // --- Tags Management ---
  
  List<String> getAllTags() {
    final tagsSet = <String>{};
    for (final entry in _entriesBox.values) {
      for (final t in entry.tags) {
        final clean = t.trim();
        if (clean.isNotEmpty) {
          tagsSet.add(clean);
        }
      }
    }
    return tagsSet.toList()..sort();
  }

  Future<void> renameTag(String oldTag, String newTag) async {
    final trimmedNew = newTag.trim();
    if (trimmedNew.isEmpty) {
      throw ArgumentError('Tag name cannot be empty');
    }
    for (final entry in _entriesBox.values) {
      if (entry.tags.contains(oldTag)) {
        final updatedTags = List<String>.from(entry.tags);
        updatedTags.remove(oldTag);
        if (!updatedTags.contains(trimmedNew)) {
          updatedTags.add(trimmedNew);
        }
        entry.tags = updatedTags;
        await entry.save();
      }
    }
  }

  Future<void> deleteTag(String tag) async {
    for (final entry in _entriesBox.values) {
      if (entry.tags.contains(tag)) {
        final updatedTags = List<String>.from(entry.tags)..remove(tag);
        entry.tags = updatedTags;
        await entry.save();
      }
    }
  }

  Future<void> clearAllData() async {
    await _entriesBox.clear();
    await _collectionsBox.clear();
  }
}

// --- Riverpod Providers ---

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('databaseServiceProvider is not initialized');
});

// Reactively stream list of all lexicon entries
final entriesProvider = StreamProvider<List<LexiconEntry>>((ref) async* {
  final db = ref.watch(databaseServiceProvider);
  yield db.getEntries();
  await for (final _ in db.entriesBox.watch()) {
    yield db.getEntries();
  }
});

// Reactively stream list of all collections
final collectionsProvider = StreamProvider<List<LexiconCollection>>((ref) async* {
  final db = ref.watch(databaseServiceProvider);
  yield db.getCollections();
  await for (final _ in db.collectionsBox.watch()) {
    yield db.getCollections();
  }
});

// Reactively stream stats
final statsProvider = StreamProvider<Map<String, int>>((ref) async* {
  final db = ref.watch(databaseServiceProvider);
  yield db.getStats();
  // Listen to both boxes changing to update stats
  await for (final _ in db.entriesBox.watch()) {
    yield db.getStats();
  }
});
