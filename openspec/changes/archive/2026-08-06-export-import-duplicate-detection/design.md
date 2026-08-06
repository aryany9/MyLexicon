## Context

`my_lexicon` uses Hive local database storage (`Box<LexiconEntry>` and `Box<LexiconCollection>`). While `DatabaseService` provides basic single-entry duplicate checking, it lacks bulk export/import capabilities, pre-import preview mechanics, resolution strategies for incoming duplicate entries, and real-time inline warnings during single entry creation.

## Goals / Non-Goals

**Goals:**
- Provide full database export in both JSON (complete schema with collections & tags) and CSV formats.
- Implement an interactive **Import Preview Screen** that parses selected files, calculates total entries/collections, highlights potential duplicates, and lets the user choose a resolution policy (Skip, Overwrite, Merge).
- Add an **ExportImportService** to handle file reading, format validation, parsing, serialization, and batch database execution.
- Add real-time duplicate checking on `entry_form_screen.dart` with inline warning cards and quick navigation to existing entries.

**Non-Goals:**
- Implementing a dedicated standalone duplicate manager screen in Settings (explicitly excluded based on user feedback).
- Global UI component refactoring across all screens (noted down in `docs/ui_refactoring_roadmap.md` for a separate change).

## Decisions

### Decision 1: Data Serialization & File Formats
- **JSON Format**: Includes a top-level metadata wrapper:
  ```json
  {
    "version": 1,
    "exportedAt": "2026-07-22T20:13:00Z",
    "collections": [...],
    "entries": [...]
  }
  ```
  Guarantees 100% loss-less backup and restore.
- **CSV Format**: Flattens entry attributes into columns: `id`, `term`, `definition`, `type`, `tags` (pipe or comma separated), `examples` (semicolon separated), `collectionName`, `isFavorite`.

### Decision 2: Import Conflict Resolution Strategies
- **`Skip`**: Discards incoming entries that match an existing term + type (case-insensitive).
- **`Overwrite`**: Replaces existing entry fields with incoming data.
- **`Merge`**: Keeps existing entry ID and definition, merges tags (set union), and appends unique example sentences.

### Decision 3: Real-Time Inline Duplicate Detection in Form
- Add a debounced listener (300ms) on the `term` text controller in `entry_form_screen.dart`.
- Query `DatabaseService` for matching terms under the selected `LexiconType` (excluding current entry ID if editing).
- Render an inline warning widget (`DuplicateWarningCard`) below the term field with a "View Existing Entry" action button.

## Risks / Trade-offs

- **[Risk] Large File Import UI Freeze** → **Mitigation**: Perform JSON/CSV parsing asynchronously using Flutter `compute` / isolate workers.
- **[Risk] CSV Formatting & Special Characters** → **Mitigation**: Use standard RFC 4180 compliant CSV parser/encoder to safely handle quotes, commas, and line breaks in definitions.
- **[Risk] Invalid Schema or Corrupted File Import** → **Mitigation**: Validate file headers & structure before rendering the preview screen; display clear error dialogs for unparseable files.
