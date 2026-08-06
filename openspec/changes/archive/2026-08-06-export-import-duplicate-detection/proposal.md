## Why

Users currently have no way to back up their lexicon data, export words for offline studying or external software (e.g. Anki, Excel), or import datasets in bulk. Additionally, importing data or manually creating entries risks introducing duplicate terms without a clear conflict resolution strategy or real-time inline warnings.

## What Changes

- **Full Database Export**: Support exporting all lexicon entries, collections, tags, and metadata to structured JSON (complete schema backup) and CSV formats.
- **Pre-Import Preview & Strategy Selection**: Provide an interactive file picker and pre-import preview screen showing total entries detected, duplicate conflicts found, and strategy selector (Skip, Overwrite, Merge).
- **Import Conflict Engine**: Process batch imports while respecting the user's chosen conflict resolution policy (Skip existing, Overwrite existing entry, or Merge tags/examples).
- **Single-Entry Inline Duplicate Warning**: Detect case-insensitive term duplicates in real-time within `entry_form_screen.dart`, rendering an inline warning card with quick navigation to view/edit the conflicting entry.

## Capabilities

### New Capabilities
- `export-import`: Full database export (JSON and CSV format) and pre-import preview & execution engine.
- `duplicate-detection`: Intelligent duplicate conflict detection during bulk import and real-time inline detection during single-entry creation.

### Modified Capabilities
- `entry-management`: Enhance single-entry creation flow to support real-time duplicate checks and duplicate warning presentation.

## Impact

- **Database / Services**: Addition of `ExportImportService` and enhancement of `DatabaseService` to execute batch operations and collision lookups.
- **UI Screens**: New `ImportPreviewScreen`, updated `SettingsScreen` (for export/import triggers), updated `EntryFormScreen` (for live duplicate warning cards).
- **Dependencies**: Integration of `file_picker` (or native file standard pickers) and `share_plus` / `path_provider` for file export and system share sheets.
