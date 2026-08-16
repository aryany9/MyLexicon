## 1. Foundations — New Providers

- [x] 1.1 Create `lib/core/providers/sort_order_provider.dart`: define `SortOrder` enum (`newestFirst`, `oldestFirst`, `aToZ`, `zToA`) and `SortOrderNotifier extends StateNotifier<Map<LexiconType, SortOrder>>` persisting per-type to SharedPreferences keys `sort_order_<type.name>`
- [x] 1.2 Create `lib/core/providers/display_preferences_provider.dart`

## 2. Database Service — Sort and Duplicate Logic

- [x] 2.1 Add optional `SortOrder? sortOrder` parameter to `DatabaseService.searchAndFilter()`
- [x] 2.2 Update `DatabaseService.findDuplicateEntry()` with collection-overlap rule
- [x] 2.3 Update `DatabaseService.saveEntry()` inline duplicate guard

## 3. CSV Import Fix — Collection Reconstruction

- [x] 3.1 Add `_resolveOrCreateCollections()` helper in `ExportImportService`
- [x] 3.2 Update `_buildCsvPreview()` to call `_resolveOrCreateCollections()`
- [x] 3.3 Update `_entryFromCsvRow()` to accept resolved collections map

## 4. Entry Form — Save-Time Duplicate Check

- [x] 4.1 Remove real-time duplicate check from `EntryFormScreen`
- [x] 4.2 In `EntryFormScreen._save()`, call `db.findDuplicateEntry()` with collection context
- [x] 4.3 Render `DuplicateWarningCard` below Collection picker when duplicate found

## 5. Duplicate Warning Card — Collection Name

- [x] 5.1 Add optional `String? collectionName` parameter to `DuplicateWarningCard`
- [x] 5.2 In `EntryFormScreen`, resolve duplicate collection name and pass to `DuplicateWarningCard`

## 6. Category List Screen — Sort UI

- [x] 6.1 Update `CategoryListScreen` to watch `sortOrderProvider` and pass sort order
- [x] 6.2 Add `PopupMenuButton` sort icon to `CategoryListScreen`'s AppBar

## 7. List Density — WordsCard

- [x] 7.1 Update `WordsCard` with density-conditional rendering (Compact/Comfortable/Detailed)

## 8. List Density — Collection Detail View

- [x] 8.1 Update `_CollectionDetailSubpage` inline entry cards to respect `listDensityProvider`

## 9. Settings — Display Section and Density Picker

- [x] 9.1 Add a "Display" section header to `SettingsScreen` above the existing "Launch Preferences" section
- [x] 9.2 Add a `RadioListTile`-based density picker (three options: Compact, Comfortable, Detailed) with a short description under each, reading from and writing to `listDensityProvider`

## 10. Tests

- [x] 10.1 Add sort order tests to `test/database_service_test.dart`: verify A–Z, Z–A, oldestFirst, and newestFirst ordering
- [x] 10.2 Add collection-aware duplicate tests to `test/database_service_test.dart`: same term + type + same collection → rejected; same term + type + different collections → allowed; overlapping collections → rejected; both unassigned → rejected; one assigned one not → allowed; different types → allowed
- [x] 10.3 Add CSV import collection preservation test to `test/export_import_service_test.dart`: CSV export + import into clean DB preserves collection membership; existing collection is reused by name; missing collection is created
- [x] 10.4 Update the existing CSV import strategy test in `test/export_import_service_test.dart` to account for the new collection-resolution behaviour (the `GRE Words` collection in the CSV should be resolved correctly even in a fresh target DB)
- [x] 10.5 Add `ListDensityNotifier` provider tests (unit, no Flutter widgets needed): default density is `ListDensity.detailed`; each of `compact`, `comfortable`, `detailed` can be set; setting density persists the correct string to SharedPreferences; recreating the notifier with a pre-populated SharedPreferences restores the saved density
- [x] 10.6 Add/update widget tests for density rendering in `test/words_card_test.dart`: Compact renders only the term text and no definition or tags; Comfortable renders the term and a truncated definition but not examples or tags; Detailed renders the full card matching the current implementation; Compact mode produces a measurably smaller rendered height than Detailed for the same entry; Collection detail entries rendered under Compact show only the term
