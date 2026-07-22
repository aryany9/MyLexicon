## 1. Dependencies & Services Core

- [x] 1.1 Add necessary file handling dependencies (`file_picker`, `share_plus`, `path_provider`) to `pubspec.yaml`.
- [x] 1.2 Implement `ExportImportService` in `lib/core/services/export_import_service.dart` with JSON & CSV encoders/decoders and file IO helpers.
- [x] 1.2a Ensure CSV encoder includes `id` and `collectionName`(s) columns per finalized column spec, and decoder correctly parses multi-collection values.
- [x] 1.2b Run JSON/CSV parsing and encoding via Flutter `compute` (isolate) for files above a defined size threshold, to prevent UI freeze on large imports/exports.
- [x] 1.3 Enhance `DatabaseService` in `lib/core/services/database_service.dart` to support batch imports and conflict resolution strategies (`Skip`, `Overwrite`, `Merge`).
- [x] 1.3a Implement field-by-field behavior for `Merge`: retain existing ID, definition, `createdAt`; union tags; append unique examples; merge `collections` (union); preserve existing `isFavorite` unless finalized spec says otherwise.
- [x] 1.3b Implement field-by-field behavior for `Overwrite`: confirm existing entry ID is preserved (not replaced) while all other fields (including `collections`, `isFavorite`, `personalNotes`) take incoming values.
- [x] 1.4 Implement pre-parse file/schema validation (header check, required fields, structural integrity) that runs before handing data to the Import Preview Screen; surface clear, user-facing error states for invalid/corrupted files.

## 2. Import Preview & Settings Integration

- [x] 2.1 Create `ImportPreviewScreen` in `lib/features/settings/import_preview_screen.dart` featuring file analysis stats, detected duplicates summary, resolution strategy selector, and execution trigger.
- [x] 2.2 Wire up Export and Import triggers inside `SettingsScreen` (`lib/features/settings/settings_screen.dart`).
- [x] 2.3 Implement post-import result feedback UI (e.g. summary dialog/snackbar showing counts of entries added, skipped, and merged, plus any partial-failure messaging).
- [x] 2.4 Wire invalid/corrupted file error (from 1.4) into Settings screen UX, per the "Invalid file format selected" scenario.


## 3. Single-Entry Creation Real-Time Duplicate Warning

- [x] 3.1 Create `DuplicateWarningCard` component displaying matched entry info and a button to view/edit existing entry.
- [x] 3.2 Update `EntryFormScreen` (`lib/features/dictionary/entry_form_screen.dart`) with a 300ms debounced term listener that triggers the `DuplicateWarningCard`.
- [x] 3.3 Confirm/implement duplicate detection behavior in edit mode: listener excludes the current entry's own ID from matches, so editing an entry doesn't falsely warn against itself, while still catching collisions with other entries.

## 4. Verification

- [ ] 4.1 Test full JSON export & import round-trip.
- [ ] 4.2 Test CSV export & import with conflict resolution strategies (`Skip`, `Overwrite`, `Merge`).
- [ ] 4.3 Verify inline duplicate detection in entry creation form.
- [ ] 4.4 Verify inline duplicate detection in entry edit form (does not self-flag, correctly flags collisions with other entries).
- [ ] 4.5 Test invalid/corrupted file import: verify error message displays and user remains on Settings screen.
- [ ] 4.6 Test large file import/export does not block UI (manual or profiling-based check on isolate usage).
- [ ] 4.7 Verify post-import summary feedback displays correct counts for a mixed batch (some skipped, some merged, some new).