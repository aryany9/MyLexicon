# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-08-16

### Added
- **Modular Feature Toggles**: Enable or disable any category (`Words`, `Phrases`, `Idioms`, `Quotes`) or `Collections` system-wide. Disabled features cleanly hide from bottom navigation, dashboard stat cards, quick actions, entry form type selector, entry detail badges, and search filters.
- **Custom Navigation Bar Tab Ordering**: Interactive drag-and-drop tab reordering (`ReorderableListView`) directly in Settings (`Navigation & Features`), keeping `Settings` pinned as the final tab item.
- **Reorganized Nested Settings UI**: Refactored Settings into a clean root page with dedicated sub-pages (`Appearance`, `Navigation & Features`, `Tags`, `Data`).
- **Per-Tab Independent Entry List Sorting**: Sort each content-type tab independently (`Newest First`, `Oldest First`, `A–Z`, `Z–A`).
- **Global List Density Preferences**: Choose between `Compact`, `Comfortable`, and `Detailed` display options for entry cards across all lists.
- **Collection-Aware Duplicate Prevention**: Smart duplicate term checks at save time that check term + type + collection membership, avoiding false positives across different collections.
- **CSV Collection Membership Preservation**: Enhanced CSV export/import pipeline preserving collection names, creation of missing collections, and reuse of existing collections on import.
- **OpenSpec Architecture Specs**: Formally documented all system capabilities and change specs under `openspec/specs/`.

### Changed
- **Router Shell Integration**: Moved `/collections` route inside `ShellRoute` so bottom navigation remains visible on the Collections screen.
- **Default Launch Tab Storage**: Migrated default launch tab preference from integer indices to route path strings with automatic first-launch migration and fallback logic.
- **Dynamic FanOut FAB**: Refactored `FanOutFab` to a `ConsumerStatefulWidget` that dynamically filters option choices based on active category feature flags.
- **Updated Android Launcher Icons**: Refreshed native Android launcher icons and updated `README.md` positioning **My Lexicon** as an open-source custom dictionary alternative for Android.

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
