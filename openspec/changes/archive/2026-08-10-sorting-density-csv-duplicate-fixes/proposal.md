## Why

Three user-reported issues from community feedback reveal that MyLexicon's entry list experience lacks flexibility for power users with large vocabularies, that CSV import silently drops collection assignments (a data-loss bug), and that the duplicate-entry guard is too strict — blocking legitimate use cases where the same term should live in multiple collections with different definitions. These fixes collectively improve usability, data integrity, and correctness for real-world usage patterns.

## What Changes

- **Sorting**: Each content-type tab (Words, Quotes, Phrases, Idioms) gains a per-tab sort preference (A–Z, Z–A, Newest First, Oldest First) persisted across sessions. Sort controls appear in the AppBar of each category list. Collection detail view and search screen are not affected.
- **List density**: A new global display preference lets users choose between three density levels — Compact (term only), Comfortable (term + short definition), and Detailed (current full card, default). The setting applies wherever entries are shown in a list, including category tabs and collection detail view. Density is a presentation-level concept: the specific fields shown at each level are decided per content type (Words, Quotes, Phrases, Idioms), not defined globally.
- **CSV import fix**: CSV import now correctly reconstructs collection membership. Collection names in the CSV are resolved against existing collections (reused by name) or created as new collections if absent. The import preview's `collections` list is no longer hardcoded to empty.
- **Collection-aware duplicates**: The duplicate-detection rule changes from global (same term + type) to collection-scoped (same term + type + overlapping collection membership). The same term can now exist in different collections with different definitions. Duplicate check timing moves from real-time (while typing) to save-time (after collection is selected), and the warning identifies which collection contains the duplicate.

## Capabilities

### New Capabilities

- `entry-list-sorting`: Per-tab sort preference for content-type lists (Words, Quotes, Phrases, Idioms). Supports four sort orders. Persisted per content type.
- `list-density`: Global display preference for how much information is shown per entry in all list views. Three levels: Compact, Comfortable, Detailed (default).

### Modified Capabilities

- `export-import`: CSV import now reconstructs and preserves collection membership from collection names embedded in the CSV. Existing collections are reused by name; missing ones are created with defaults.
- `duplicate-detection`: Duplicate rule changes to collection-scoped overlap detection. Check timing moves to save-time. Warning UI updated to name the conflicting collection.
- `entry-management`: Real-time duplicate warning removed. Duplicate check now runs at save time after the collection is known.

## Impact

- **`lib/core/services/database_service.dart`**: `findDuplicateEntry()` and `saveEntry()` updated for collection-aware logic; `searchAndFilter()` gains a `sortOrder` parameter.
- **`lib/core/services/export_import_service.dart`**: `_buildCsvPreview()` fixed to resolve and populate collections.
- **`lib/core/providers/`**: Two new providers — `SortOrderProvider` (per-`LexiconType` sort state) and `ListDensityProvider` (global density state). Both persisted via `SharedPreferences`.
- **`lib/widgets/words_card.dart`**: Density-conditional rendering.
- **`lib/features/dictionary/category_list_screen.dart`**: AppBar sort menu.
- **`lib/features/dictionary/entry_form_screen.dart`**: Real-time duplicate check replaced by save-time check.
- **`lib/features/dictionary/widgets/duplicate_warning_card.dart`**: Shows collection name in warning.
- **`lib/features/collections/collections_screen.dart`**: `_CollectionDetailSubpage` entry list respects density.
- **`lib/features/settings/settings_screen.dart`**: New Display section with density picker.
- **`test/`**: New and updated tests for sorting, density, CSV import with collections, and collection-aware duplicate detection.
- **No new dependencies required.** All persistence via existing `SharedPreferences`. All state management via existing Riverpod patterns.
