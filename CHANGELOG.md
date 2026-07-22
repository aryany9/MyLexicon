# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-07-22

### Added
- **Full Database Export**: Export entire lexicon database (entries, collections, tags, and metadata) to structured JSON format.
- **CSV Export**: Export lexicon entries to CSV format for external spreadsheet applications.
- **Import Preview Screen**: Pre-import file analysis showing total entries, collections, and detected duplicates before database insertion.
- **Conflict Resolution Strategies**: Support for `Skip`, `Overwrite`, and `Merge` strategies when importing duplicate entries.
- **Real-Time Duplicate Detection**: Real-time inline duplicate term warning during single-entry creation/editing (`DuplicateWarningCard`).

### Changed
- Enhanced `DatabaseService` with batch import handling and conflict resolution policies.
- Integrated `file_picker`, `share_plus`, and `path_provider` dependencies for cross-platform file export and import.
- Added isolate/compute execution for large export/import parsing tasks to keep the UI responsive.
