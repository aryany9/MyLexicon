## Context

MyLexicon is a Flutter app using Hive for local storage, Riverpod for state management, and SharedPreferences for persisted user preferences. Entry lists are displayed via `WordsCard` in `CategoryListScreen` (content-type tabs) and inline custom cards in `_CollectionDetailSubpage`. Sorting is currently hardcoded to newest-first in `DatabaseService.searchAndFilter()`. There is no density preference. CSV import silently drops collection data. Duplicate detection is global (term + type) and fires in real time.

## Goals / Non-Goals

**Goals:**
- Add per-tab sort preference for the four content-type tabs, persisted via SharedPreferences.
- Add a global list density preference (Compact / Comfortable / Detailed) persisted via SharedPreferences.
- Fix CSV import to reconstruct collection membership from collection names.
- Change duplicate detection from global to collection-scoped, with check timing moved to save time.

**Non-Goals:**
- Sorting in collection detail view or search screen.
- Per-tab or per-collection density settings.
- CSV import of collection metadata beyond name (color, description, createdAt are not in CSV format).
- Re-architecture of the Hive data layer or Riverpod provider graph.
- Any unrelated UI redesign.

## Decisions

### Decision 1: Sort state as a per-LexiconType StateNotifier

Sort preference is stored as a `Map<LexiconType, SortOrder>` (effectively one preference per tab) in a single `StateNotifier<Map<LexiconType, SortOrder>>`. SharedPreferences keys are `sort_order_word`, `sort_order_quote`, `sort_order_phrase`, `sort_order_idiom`.

**Alternative considered:** A Riverpod `family` provider keyed by `LexiconType`. Rejected because a single notifier is simpler to persist atomically and mirrors the existing `DefaultTabNotifier` pattern.

**Default:** `SortOrder.newestFirst` for all tabs — preserves current behaviour for existing users.

### Decision 2: Sort applied inside DatabaseService.searchAndFilter()

`searchAndFilter()` gains an optional `SortOrder? sortOrder` parameter. When `null`, it defaults to `newestFirst` (backward-compatible). The sort logic replaces the current hardcoded comparator.

**Alternative considered:** Sorting in the widget layer after receiving results. Rejected because `searchAndFilter()` is already the single point of sort for all callers; sorting there keeps widgets clean.

### Decision 3: Density as a global StateNotifier, applied at widget render time

A `ListDensityNotifier extends StateNotifier<ListDensity>` holds the global preference. `ListDensity.detailed` is the default. Individual widgets (`WordsCard`, `_CollectionDetailSubpage` inline cards) read the provider and decide what to render — density is a presentation hint, not a data-layer concept.

**Alternative considered:** Passing density as a constructor parameter through widget trees. Rejected as overly verbose; the provider pattern is idiomatic in this codebase.

**Compact padding:** `WordsCard` and the collection-detail inline card must genuinely reduce vertical space in Compact mode — not just hide the subtitle while keeping the same `ListTile` padding. In Compact, the `ListTile` is replaced with a simple `Padding` + `Text` row to eliminate Material's default `ListTile` vertical padding.

### Decision 4: CSV collection resolution in _buildCsvPreview()

After parsing CSV rows, extract unique non-empty collection names. For each: look up existing collections by name (case-insensitive). If found, reuse the existing `LexiconCollection`. If not found, create a new `LexiconCollection` with a generated UUID, the CSV name, no description, a default color (`0xFF607D8B`), and `createdAt = DateTime.now()`. The resulting list is passed to `ImportPreviewData.collections`. The existing `importPreview()` flow (saves collections → saves entries) then works correctly.

`_entryFromCsvRow()` is updated to receive the resolved `Map<String, LexiconCollection>` (keyed by lowercase name) rather than looking up the live DB again, ensuring consistency between preview and import.

**Alternative considered:** Resolving at import time (inside `importPreview()`) rather than preview time. Rejected because the preview screen should already show which collections will be created, so resolution belongs in `_buildCsvPreview()`.

**Overwrite safety:** The existing `importPreview()` saves collections before entries. No partial-loss risk is introduced by this fix. No transaction mechanism is added (Hive does not provide ACID transactions; the existing architecture accepts this limitation).

### Decision 5: Collection-aware duplicate detection at save time

`findDuplicateEntry()` gains a `List<String> incomingCollectionIds` parameter. The overlap rule:

- If both the existing entry and the incoming entry have no collection membership → duplicate.
- If the sets of collection IDs overlap (non-empty intersection) → duplicate.
- Otherwise → allowed.

`saveEntry()` is updated to call `findDuplicateEntry()` with the entry's `collectionIds` (resolved from `collectionId` + `collectionIds`).

The real-time debounced check in `EntryFormScreen` (`_scheduleDuplicateCheck`, `_checkForDuplicate`, `_duplicateCheckDebounce`) is removed. Instead, `_save()` calls `findDuplicateEntry()` with the selected collection context before persisting. If a duplicate is found, save is aborted and a `SnackBar` with the duplicate warning is shown (or the `DuplicateWarningCard` is surfaced inline — see UI section below).

**UI for save-time duplicate:** On save, if a duplicate is detected, the save is aborted and `_duplicateEntry` state is set. The `DuplicateWarningCard` appears below the collection picker (its current position below the term field is no longer appropriate since the check is collection-aware). The user can either change the collection or navigate to the existing entry.

**`DuplicateWarningCard`** gains an optional `String? collectionName` parameter. When provided, the warning reads: `Already exists in "<collectionName>"`. When null (both unassigned), the warning reads: `Already exists as an unassigned entry`.

**Alternative considered:** Showing a dialog on save instead of the inline card. Rejected to keep consistency with the existing card-based warning pattern.

## Risks / Trade-offs

- **CSV collection loss on very old exports**: Exports made before this fix have the same format (collection name in CSV), so the fix is backward-compatible.
- **Duplicate rule change is a breaking behaviour change**: Users who previously relied on global uniqueness will now be able to create same-term entries across collections. Considered acceptable — the old rule was overly strict and blocked legitimate use.
- **Compact mode diverges per content type**: The specific fields shown per density level are decided at the widget level, not centrally defined. This keeps widgets autonomous but means adding a new content type requires manual density-awareness. Accepted as a reasonable extension point.
- **Hive no-transaction risk on Overwrite import**: If the app crashes mid-import, the DB may be partially updated. This risk exists in the current architecture and is not introduced by this change.

## Migration Plan

No data migration needed. All changes are additive to the stored data model. Default values for new preferences (sort = newest-first, density = detailed) reproduce current behaviour for existing users.
