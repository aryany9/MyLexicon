## Why

People who want to expand their vocabulary and general knowledge often encounter new words, quotes, phrases, and idioms but forget them quickly without a dedicated tool. MyLexicon provides a modern, offline-first personal knowledge management system that allows users to store, organize, and view their custom lexicon elements in one place.

## What Changes

- Initialize the MyLexicon Flutter application with a feature-first architecture supporting Android.
- Implement local offline-first storage for user entries, tags, and collections.
- Create UI screens for:
  - Home Dashboard (showing stats, quick actions, and direct access to categories/collections/favorites)
  - Entry Management (create, view, edit, delete words/quotes/phrases/idioms with tags, meanings, notes, and collections)
  - Search & Filters (dynamic search with filters for entry type, tag, collection, and favorites)
  - Settings (theme management, clear data)

## Capabilities

### New Capabilities
- `entry-management`: Create, read, update, and delete lexicon entries (words, quotes, phrases, idioms, personal notes) with custom attributes (meanings, examples, tags, collections).
- `organization-favorites`: Group entries into collections, label them with tags, and mark items as favorites for easy access and organization.

### Modified Capabilities

*(None)*

## Impact

- **Client Codebase**: Initial setup of the project structure following the feature-first layout under `lib/`.
- **Database/Storage**: Setup of local persistent storage (using a fully stable package like Hive or stable SQLite/Drift) to support offline-first capabilities.
- **Dependencies**: Addition of essential packages (e.g., for state management like flutter_riverpod, database like hive, and utility packages).
- **Navigation/Routing**: Implementation of app routing (using go_router).

## Parked Features (Future Considerations)

- **Type-Specific Metadata**: Supporting specialized attributes for different lexicon types (such as `author` and `source` for quotes, or `partOfSpeech` and `ipa`/phonetics for words) will be implemented in the next feature iteration.
- **Local Backup & Restore**: Implementing local file import/export (JSON/CSV) for data portability and backup safety is deferred to a future phase.
