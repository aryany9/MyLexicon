## 1. Setup and Infrastructure

- [x] 1.1 Add required dependencies (`flutter_riverpod`, `go_router`, `hive`, `hive_flutter`, `path_provider`, `uuid`, `shared_preferences`) and dev dependencies (`build_runner`, `hive_generator`) to `pubspec.yaml`
- [x] 1.2 Define the `LexiconType` enum (`word`, `quote`, `phrase`, `idiom`) and Hive models for `LexiconEntry` and `LexiconCollection` under `lib/models/`, assign and document fixed Hive `typeId`s for each adapter (e.g. `0` = LexiconEntry, `1` = LexiconCollection, `2` = LexiconType) to avoid future collisions, register the TypeAdapters, and run the build_runner generator
- [x] 1.3 Implement the database service and provider class in `lib/core/services/` to initialize Hive and expose entry and collection box operations (CRUD, search, stats), including validation rules (non-empty `term`/`definition`, duplicate-term handling) and the collection-deletion policy (orphan entries by setting `collectionId = null` rather than cascade-deleting entries)
- [x] 1.4 Configure the GoRouter router under `lib/routes/` and set up standard dark/light themes with Material 3 enabled (`useMaterial3: true`) under `lib/core/theme/`
- [x] 1.5 Implement app bootstrap in `main.dart`: call `WidgetsFlutterBinding.ensureInitialized()`, `Hive.initFlutter()`, register all TypeAdapters, open required boxes, and wrap the app in `ProviderScope` before `runApp`
- [x] 1.6 Configure Android project basics: `applicationId`, minimum SDK version, app display name, and launcher icon

## 2. Entry Management Feature

- [x] 2.1 Create the dashboard screen under `lib/features/home/` displaying total entry stats, recent items, quick action shortcuts, and an empty-state view for first launch (zero entries)
- [x] 2.2 Create the entry edit/creation screen under `lib/features/dictionary/` supporting type selection, text fields, collections selector, and tag tagging (tag input with autocomplete against existing tags), with UUIDs generated via the `uuid` package on creation
- [x] 2.3 Create the entry details screen displaying full attributes and actions (edit, delete, favorite), with a delete confirmation dialog before removal
- [x] 2.4 Build feature category lists for words, quotes, phrases, and idioms, including an empty-state view when a category has no entries, with a defined default sort order (e.g. most recently added first)

## 3. Organization, Search, and Favorites

- [x] 3.1 Implement search and filter view under `lib/features/search/` with case-insensitive substring text search (matching `term` and `definition`) and filter chips (type, tag, favorites), including an empty-state view for no results
- [x] 3.2 Implement collections management screens under `lib/features/collections/` to create, rename, list, and delete custom categories, including a delete confirmation dialog that explains entries in the collection will be unassigned (not deleted)
- [x] 3.3 Add favorites toggle functionality in list cards, details screen, and database layer, and show a dedicated favorites filter
- [x] 3.4 Display tag index in dashboard or sidebar and allow filtering of lexicon entries by selected tag
- [x] 3.5 Implement tag management: rename a tag across all entries, delete a tag from all entries, and prevent duplicate/whitespace-only tags at input time

## 4. Settings

- [x] 4.1 Create the Settings screen under `lib/features/settings/` with theme selection (light/dark/system), persisted via `shared_preferences` and applied on app relaunch
- [x] 4.2 Implement "Clear all data" action with an explicit confirmation dialog (stating the action is irreversible) that wipes the Hive boxes

## 5. Testing

- [x] 5.1 Add unit tests for the database service layer (CRUD, search/filter logic, collection-deletion orphaning behavior)
- [ ] 5.2 Add widget tests for core flows: creating an entry, favoriting, filtering by tag, and deleting a collection