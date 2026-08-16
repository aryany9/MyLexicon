## 1. Feature Flags Provider

- [x] 1.1 Define `enum AppFeature { word, phrase, idiom, quote, collections }` in `lib/core/models/app_feature.dart`.
- [x] 1.2 Create `lib/core/providers/feature_flags_provider.dart` with a `StateNotifierProvider<FeatureFlagsNotifier, Map<AppFeature, bool>>` backed by `SharedPreferences`. Keys: `'feature_word'`, `'feature_phrase'`, `'feature_idiom'`, `'feature_quote'`, `'feature_collections'`. Defaults all `true`.
- [x] 1.3 Implement `toggle(AppFeature feature)` method that enforces the invariant: at least one category feature (`word`, `phrase`, `idiom`, `quote`) must remain enabled.
- [x] 1.4 Add a convenience getter `enabledCategories` → `List<AppFeature>` returning only enabled category features (excludes `collections`).

## 2. GoRouter Shell: Move Collections Inside ShellRoute

- [x] 2.1 Move the `/collections` `GoRoute` from the top-level routes into the `ShellRoute` in `lib/routes/app_router.dart` so the bottom navigation bar is visible on the Collections screen.

## 3. Dynamic Bottom Navigation Shell

- [x] 3.1 Convert `AppShell` to a `ConsumerWidget`. Define an ordered constant list of all possible tab descriptors (`{ AppFeature? feature, String path, IconData icon, String label }`). `Dashboard` and `Settings` have `feature: null`.
- [x] 3.2 In `AppShell.build()`, filter the tab descriptor list by `featureFlagsProvider` to produce the visible tab list. Compute `currentIndex` by matching the current route path against the visible list.
- [x] 3.3 On `onTap(index)`, navigate to `visibleTabs[index].path`. Remove reliance on static `tabIndexToPath` / `pathToTabIndex` helpers.
- [x] 3.4 Handle active-tab-disabled redirect: in `featureFlagsProvider.notifier.toggle()`, after persisting, if the current GoRouter location belongs to the now-disabled feature, call `context.go('/')`.

## 4. Default Tab Provider: Migrate from Int to Path String

- [x] 4.1 Update `defaultTabProvider` in `tab_provider.dart` to store and load a `String` route path (e.g. `'/'`, `'/category/word'`) instead of an integer index.
- [x] 4.2 Add first-launch migration: on load, if the old integer key (`'default_tab_index'`) exists, convert to a path string, write the new key (`'default_tab_path'`), and delete the old key.
- [x] 4.3 Update `createAppRouter` to use the stored path string as `initialLocation`.
- [x] 4.4 Add fallback: when loading the stored default path, if that feature is disabled, return `'/'` and reset the stored preference to `'/'`.

## 5. Settings: Restructure into Nested Sub-Pages

- [x] 5.1 Refactor `lib/features/settings/settings_screen.dart` into a root page of tappable `ListTile` rows (with trailing `chevron_right`), one per sub-section.
- [x] 5.2 Create `lib/features/settings/sub_pages/appearance_settings_page.dart` containing App Theme (dropdown) and List Density (radio group).
- [x] 5.3 Create `lib/features/settings/sub_pages/navigation_settings_page.dart` containing Default Launch Tab (dropdown, filtered) and Feature Toggle switches for all `AppFeature` values.
- [x] 5.4 Create `lib/features/settings/sub_pages/tags_settings_page.dart` containing the full Manage Tags list (rename/delete).
- [x] 5.5 Create `lib/features/settings/sub_pages/data_settings_page.dart` containing Export, Import, and Clear All Data options.
- [x] 5.6 Wire up push navigation from the root Settings page to each sub-page.

## 6. FanOut FAB: Dynamic Options

- [x] 6.1 Convert `FanOutFab` (`lib/widgets/fan_out_fab.dart`) from `StatefulWidget` to `ConsumerStatefulWidget`.
- [x] 6.2 In `build()`, read `featureFlagsProvider` and build the fan-out options list dynamically — include only options for enabled category features.
- [x] 6.3 If zero category options are enabled (should not happen due to invariant), render the FAB as a single `+` button navigating to `/entry-form` with no pre-selected type.

## 7. System-Wide Feature Hiding

- [x] 7.1 Update `lib/features/home/home_screen.dart` `_buildStatsGrid` to conditionally include stat cards only for enabled category features.
- [x] 7.2 Update `lib/features/home/home_screen.dart` `_buildQuickActions` to hide the Collections quick action button when Collections is disabled.
- [x] 7.3 Update `lib/features/dictionary/entry_form_screen.dart` to filter the `SegmentedButton` type options to only show enabled category features.
- [x] 7.4 Update `lib/features/dictionary/entry_detail_screen.dart` to hide the collection badge/chip when the Collections feature is disabled.
- [x] 7.5 Update `lib/features/search/search_screen.dart` to omit disabled category types from filter options.
- [x] 7.6 Update the Default Launch Tab dropdown in `navigation_settings_page.dart` to only list enabled feature paths.

## 8. Cleanup & Verification

- [x] 8.1 Mark `tabIndexToPath` and `pathToTabIndex` as deprecated, then remove them once all call sites are updated.
- [x] 8.2 Run `flutter analyze` and resolve all warnings.
- [x] 8.3 Test: toggle each category off and verify it disappears from bottom nav, FAB, stat cards, entry form, and search filters.
- [x] 8.4 Test: disable Collections and verify tab, home quick action, and entry detail collection badge all hide.
- [x] 8.5 Test: set a default tab, disable that feature, restart app — confirm it launches on Dashboard.
- [x] 8.6 Test: navigate to all Settings sub-pages and confirm correct content, back navigation, and reactivity.

## 9. Navigation Bar Tab Sorting (Reordering)

- [x] 9.1 Create `lib/core/providers/tab_order_provider.dart` with a `StateNotifierProvider<TabOrderNotifier, List<String>>` backed by `SharedPreferences` key `'navigation_tab_order'`. Default order: `['/', '/category/word', '/category/phrase', '/category/idiom', '/category/quote', '/collections']`.
- [x] 9.2 Update `lib/core/shell/app_shell.dart` to order `visibleTabs` according to `tabOrderProvider` before building `BottomNavigationBarItem` list, keeping `Settings` (`'/settings'`) pinned as the final tab item.
- [x] 9.3 Add a "Tab Order" reorderable section in `lib/features/settings/sub_pages/navigation_settings_page.dart` using `ReorderableListView` with drag handles (`≡`), allowing users to reorder moveable tabs directly on the sub-page.
- [x] 9.4 Run `flutter analyze` and verify 0 issues found.
