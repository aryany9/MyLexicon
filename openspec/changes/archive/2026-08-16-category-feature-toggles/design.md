## Context

`MyLexicon` has 4 category types (`Words`, `Phrases`, `Idioms`, `Quotes`) and a `Collections` feature. The bottom navigation bar in `lib/core/shell/app_shell.dart` renders all tabs statically. The `FanOutFab` in `lib/widgets/fan_out_fab.dart` is a plain `StatefulWidget` with all 4 category add-options hardcoded — it has no access to a `WidgetRef`. The Settings screen (`lib/features/settings/settings_screen.dart`) is a single flat `ListView` with 7 sections and will become unmanageable when feature toggles are added. The `tab_provider.dart` uses static `switch`-based `tabIndexToPath` / `pathToTabIndex` helpers that will break as soon as tabs are dynamically added or removed. The `/collections` route is also currently outside the `ShellRoute` in `app_router.dart`, meaning it does not render the bottom navigation bar.

## Goals / Non-Goals

**Goals:**
- Introduce a `featureFlagsProvider` (Riverpod + SharedPreferences) covering `Words`, `Phrases`, `Idioms`, `Quotes`, and `Collections`.
- Introduce a `tabOrderProvider` to allow users to custom-sort bottom navigation tabs with drag handles (`≡`) in Settings, keeping Settings pinned as the last tab item.
- Dynamically build `BottomNavigationBarItem` list ordered by `tabOrderProvider` and filtered by `featureFlagsProvider`.
- Refactor `FanOutFab` into a `ConsumerWidget` so it can conditionally render add-options.
- Hide disabled features across Dashboard stat cards, FanOut FAB, Entry form type picker, Entry detail collection badge, and Search filters.
- Move `/collections` route inside the `ShellRoute` in `app_router.dart`.
- Restructure Settings screen into a root page + nested sub-pages.

**Non-Goals:**
- Allowing `Settings` tab to be moved away from the last position.
- Deleting underlying Hive database records when a feature is disabled.
- Blocking existing data from being edited if its category/collection feature is disabled.

## Decisions

### Decision 1: Feature Flags Provider (`featureFlagsProvider`)
- **Choice**: `StateNotifierProvider<FeatureFlagsNotifier, Map<AppFeature, bool>>` backed by `SharedPreferences`.
- Use a dedicated `enum AppFeature { word, phrase, idiom, quote, collections }` rather than reusing `LexiconType`, because `collections` is not a `LexiconType`.
- **SharedPreferences keys**: `'feature_word'`, `'feature_phrase'`, `'feature_idiom'`, `'feature_quote'`, `'feature_collections'`. Default for all: `true`.
- Enforce invariant: at least one of the category features (`word`, `phrase`, `idiom`, `quote`) must remain enabled.

### Decision 2: Dynamic Tab List & Custom Tab Ordering in `AppShell`
- **Choice**: `AppShell` (converted to `ConsumerWidget`) reads `tabOrderProvider` (for list order) and `featureFlagsProvider` (for visibility filtering).
- **Tab ordering**: `tabOrderProvider` manages a persisted `List<String>` of route paths (`'/'`, `'/category/word'`, `'/category/phrase'`, `'/category/idiom'`, `'/category/quote'`, `'/collections'`). `'/settings'` is strictly pinned at the end.
- **Index math**: `currentIndex` is computed by finding the index of the current route's path in the ordered and filtered visible list. `onTap(index)` uses `visibleTabs[index].path` to navigate.

### Decision 3: FanOut FAB Refactor
- **Choice**: Convert `FanOutFab` to a `ConsumerStatefulWidget`. Read `featureFlagsProvider` inside `build()`. Build the options list dynamically — only include options for enabled category features.

### Decision 4: Collections in GoRouter Shell
- **Choice**: Move the `/collections` GoRoute inside the `ShellRoute` in `app_router.dart` so it renders with the bottom navigation bar.

### Decision 5: Settings Sub-Page Navigation & Tab Reorder UI
- **Choice**: Replace the flat `ListView` `SettingsScreen` with a root screen of tappable section tiles (chevron-right), each `push()`ing to a dedicated sub-screen.
- **Sub-pages**:
  - **Appearance** — App Theme, List Density
  - **Navigation & Launch** — Default Launch Tab, Reorderable Tab List (`ReorderableListView` with `≡` drag handles), Feature Toggles
  - **Tags** — Manage Tags list (rename/delete)
  - **Data** — Export, Import, Clear All Data

### Decision 6: Recent Entries on Home — Not Filtered
- **Choice**: The "Recent Entries" section on the Home screen continues to show entries from ALL types, even if that type's feature is disabled.

### Decision 7: Tab Reordering Persistence & Pinning (`tabOrderProvider`)
- **Choice**: `StateNotifierProvider<TabOrderNotifier, List<String>>` stored under SharedPreferences key `'navigation_tab_order'`.
- Default order: `['/', '/category/word', '/category/phrase', '/category/idiom', '/category/quote', '/collections']`.
- In `ReorderableListView` in `NavigationSettingsPage`, only moveable tabs are draggable. `/settings` is always appended at the end of the bottom navigation bar.

## Risks / Trade-offs

- **[Risk] Tab active when its feature is disabled**: User is on `/category/phrase` and disables Phrases.
  - *Mitigation*: In `featureFlagsProvider.notifier.toggle()`, after persisting the change, if `GoRouter`'s current location is the disabled feature's path, `context.go('/')` to redirect to Dashboard.
- **[Risk] Saved default tab becomes disabled**: The `defaultTabProvider` stores an integer index; if tabs shift, the saved index may point to the wrong tab.
  - *Mitigation*: Store default tab as a path string (e.g. `'/category/word'`) instead of an integer index. On load, if the stored path's feature is disabled, fallback to `'/'`.

## Migration Plan

- `defaultTabProvider` currently stores an `int`. Update to store a `String` path. Read the old int key on first launch, convert to path, then write the new string key. Remove the old key.
- `tabOrderProvider` loads custom path order from `'navigation_tab_order'`. If absent, defaults to standard initial path order.
