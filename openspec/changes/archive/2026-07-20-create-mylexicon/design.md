## Context

The MyLexicon app is a new personal knowledge management application built using Flutter. The goal is to allow users to store, view, search, tag, and group words, phrases, idioms, quotes, and notes. The project is structured with a feature-first architecture, as specified in the README. The app is currently targeting the Android platform, with future compatibility for iOS and other platforms in mind. It needs to support a fully offline-first experience with robust local storage, fast search, tag filtering, and collections.

## Goals / Non-Goals

**Goals:**
- Implement a fully functional, offline-first Flutter application for Android.
- Establish the feature-first architecture folders and files under `lib/`.
- Set up a highly stable, lightweight local database for lexicon entries and collections.
- Provide a clean, premium, and modern Material 3 user interface matching best practices (responsive layouts, smooth transitions, readable typography, dark/light theme support).
- Build the core features: Home Dashboard, Entry Management (CRUD), Organization (Collections/Tags/Favorites), and Search & Filters.

**Non-Goals:**
- Review system or flashcards (removed from scope per user request).
- Cloud synchronization or online user authentication (out of scope for this offline-first version).
- iOS-specific platform integration features (only targeting Android platform configuration for now).
- External dictionary API integrations (users manually store their own entries).

## Decisions

### 1. Local Offline-First Storage Database
- **Decision**: Use **Hive** (with `hive_flutter`) for local data persistence.
- **Rationale**:
  - Hive is a lightweight, blazing-fast, pure Dart key-value database. Since it is written in pure Dart, it does not rely on any native binaries or C/C++ compilation, avoiding any Android build tools or platform compatibility errors (perfectly satisfying the "stable only" requirement).
  - It supports custom adapters for object storage and fast read/write operations.
  - Alternatives considered:
    - *Isar*: Extremely fast, but the stable 3.x version has compiling issues on newer Flutter/Gradle SDK setups, and the 4.x version is still in pre-release/beta.
    - *SQLite/Drift*: Excellent relational choice, but has higher setup overhead and requires compiling native SQLite binaries. Hive offers direct Dart-level stability.

### 2. State Management
- **Decision**: Use **Flutter Riverpod** for application state management.
- **Rationale**:
  - Riverpod is compile-safe, testable, and doesn't rely on the widget tree for lookup.
  - It aligns perfectly with the feature-first architecture where controllers/providers can reside within each feature folder.
  - Alternatives considered:
    - *Bloc/Cubit*: Highly structured, but introduces significant boilerplate for simple local states.

### 3. Navigation & Routing
- **Decision**: Use **GoRouter** for routing and navigation.
- **Rationale**:
  - GoRouter is the officially recommended routing package for Flutter, supporting declarative navigation.

### 4. UI Design System
- **Decision**: Use **Material 3 (M3)** design system for the user interface.
- **Rationale**:
  - Material 3 provides modern, responsive components (such as NavigationBars, Card designs, Filled/Tonal/Outlined Buttons, and modern TextField states) out of the box in Flutter.
  - We will enable it globally in our `ThemeData` by setting `useMaterial3: true`.
  - It supports dynamic colors and rich styling that makes the app feel premium.
  - Alternatives considered:
    - *Material 2*: Outdated visual aesthetics.
    - *Cupertino (iOS styling)*: Not optimal since we are launching on Android first.

### 5. Database Schema Structure (Hive Objects)
We will define two main Hive Box structures:
- **LexiconEntry** (Box name: `lexicon_entries`):
  - `String id` (UUID/unique key)
  - `String term`
  - `String definition`
  - `String type` (enum/string: word, quote, phrase, idiom)
  - `String? example`
  - `String? notes`
  - `List<String> tags`
  - `String? collectionId`
  - `bool isFavorite`
  - `DateTime createdAt`
- **LexiconCollection** (Box name: `lexicon_collections`):
  - `String id` (UUID/unique key)
  - `String name`
  - `String? description`
  - `int colorValue` (for custom collection styling)
  - `DateTime createdAt`

## Risks / Trade-offs

- **[Risk] Hive Indexing / Query Power**: Since Hive is a key-value store, filtering lists (like filtering entries by tag, type, or favorite) must be performed in-memory on the loaded list of entries.
  - *Mitigation*: Because personal lexicons typically contain thousands of entries at most (rather than millions), in-memory filtering and search in Dart is extremely fast (well under 5ms) and will not affect performance. We will index entries locally in a list provider.
- **[Risk] Code Generation**: Hive requires `hive_generator` and `build_runner` to generate TypeAdapters.
  - *Mitigation*: Run `flutter pub run build_runner build --delete-conflicting-outputs` whenever the model schemas are updated.

## Parked Items / Future Scope

- **Type-Specific Metadata (Parked)**: Support for `author` and `source` (for quotes), and `partOfSpeech` and `ipa` (for words) will be added in a future update. The current model will rely on `notes` or `definition` for these attributes.
- **Local Backup & Restore (Parked)**: JSON export/import functions will be defined in a future version.
