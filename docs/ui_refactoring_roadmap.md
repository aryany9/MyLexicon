# UI Component Refactoring Roadmap (Pillar 3)

> **Note**: This document captures the planned UI component refactoring and consolidation strategy for `my_lexicon`. This work is deferred for a subsequent update after Export/Import and Duplicate Detection are implemented.

---

## 1. Objectives

- Eliminate code duplication across feature screens (`dictionary`, `collections`, `home`, `settings`, `search`).
- Standardize design tokens, spacing, typography, cards, search bars, chips, and modal sheets.
- Build a central **UI Component Kit** under `lib/widgets/` or `lib/core/widgets/`.

---

## 2. Component Extraction Plan

### A. Atom & Molecule Components
1. **`LexiconSearchBar`**
   - **Locations**: `home_screen.dart`, `search_screen.dart`
   - **Features**: Built-in debounce, clear button, custom trailing filter icon action.

2. **`LexiconEntryTile` / `LexiconEntryCard`**
   - **Locations**: `home_screen.dart`, `category_list_screen.dart`, `search_screen.dart`, `collections_screen.dart`
   - **Features**: Displays term, pronunciation, tags, type badge, quick favorite toggle, swipe actions.

3. **`LexiconTypeBadge` & `TagChipGroup`**
   - **Locations**: `entry_detail_screen.dart`, `entry_form_screen.dart`, list screens
   - **Features**: Consistent HSL color mapping based on `LexiconType` (Word, Phrase, Idiom, Quote).

4. **`EmptyStateWidget`**
   - **Locations**: Search results, empty collections, empty categories
   - **Features**: Configurable vector/icon, title, message, and call-to-action button.

5. **`SectionHeader`**
   - **Locations**: Dashboard widgets, home screen sections, settings groups
   - **Features**: Title, optional subtitle, and "See All" or action button.

### B. Organisms & Dialogs
1. **`LexiconFilterBottomSheet`**
   - Standardized sheet for filtering entries by Type, Tags, Collection, Favorite status.

2. **`LexiconConfirmDialog`**
   - Standardized dialog for delete/clear actions with warning iconography and primary/secondary actions.

---

## 3. Execution Phase (Future Scope)
1. Extract atomic widgets to `lib/widgets/`.
2. Refactor `home_screen.dart` and `search_screen.dart` to consume shared search & card widgets.
3. Refactor `category_list_screen.dart` and `collections_screen.dart`.
4. Audit widget tree for unused style properties and enforce central theme tokens.
