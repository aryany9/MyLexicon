## 1. Data Model — Multiple Examples

- [x] 1.1 Update `LexiconEntry` in `lib/models/lexicon_entry.dart`: change `@HiveField(4) String? example` to `@HiveField(4) List<String> examples`
- [x] 1.2 Run `flutter pub run build_runner build --delete-conflicting-outputs` to regenerate `lexicon_entry.g.dart`
- [x] 1.3 Uninstall/clear app data on all dev devices to discard old Hive box schema

## 2. Routing — ShellRoute & Bottom Navigation Shell

- [x] 2.1 Create `lib/core/shell/app_shell.dart` — a `StatefulWidget` scaffold containing a `BottomNavigationBar` with 6 tabs (Dashboard, Words, Phrases, Idioms, Quotes, Settings) and a `child` body slot
- [x] 2.2 Refactor `lib/routes/app_router.dart` to wrap all 6 tab routes in a `ShellRoute` (or `StatefulShellRoute.indexedStack` if available) using `AppShell` as the shell widget
- [x] 2.3 Define 6 top-level tab routes: `/` (Dashboard), `/words`, `/phrases`, `/idioms`, `/quotes`, `/settings`
- [x] 2.4 Move sub-routes (`/entry/:id`, `/entry-form`, `/search`, `/collections`) as nested routes under the shell, so deep-linking works correctly
- [x] 2.5 Wire `BottomNavigationBar` `onTap` to `context.go(tabRoute)` and keep `currentIndex` synced with `GoRouterState`

## 3. Dashboard Tab — Cleanup & Fan-out FAB

- [x] 3.1 Remove the Settings `IconButton` from the Dashboard AppBar in `lib/features/home/home_screen.dart`
- [x] 3.2 Replace the existing `FloatingActionButton.extended` on `HomeScreen` with a custom fan-out FAB widget
- [x] 3.3 Create fan-out FAB widget (can be inline or in `lib/widgets/fan_out_fab.dart`): collapsed state shows a `+` icon; expanded state animates 4 sub-buttons (Add Word, Add Phrase, Add Idiom, Add Quote) sliding upward with labels
- [x] 3.4 Wire each sub-button to `context.push('/entry-form?type=<typeName>')` and collapse the FAB after navigation
- [x] 3.5 Add a dismissible scrim/barrier behind the expanded FAB that collapses it on tap

## 4. Category Tabs — Words, Phrases, Idioms, Quotes

- [x] 4.1 Repurpose or create a screen for each tab that wraps `CategoryListScreen` content (or reuse `CategoryListScreen` directly with the type pre-set from the route)
- [x] 4.2 Replace the FAB in each category screen with `FloatingActionButton.extended` labelled "Add Word" / "Add Phrase" / "Add Idiom" / "Add Quote"
- [x] 4.3 Wire each category FAB to `context.push('/entry-form?type=<typeName>')`

## 5. Entry Form — Conditional Type Picker & Multi-Example Input

- [x] 5.1 Update `EntryFormScreen` to accept `type` from `state.uri.queryParameters['type']` and set `_selectedType` accordingly in `initState`
- [x] 5.2 Hide the type picker UI in the form when `type` was provided as a query parameter
- [x] 5.3 Replace the single `_exampleController` with a `List<TextEditingController>` for multi-example support (initially empty; user can add up to 5)
- [x] 5.4 Add an "Add Example" button in the form that appends a new text field row (disabled/hidden when 5 examples already exist)
- [x] 5.5 Add a remove (×) button on each example row to delete that specific example
- [x] 5.6 Update `_loadEntry()` to populate `_exampleControllers` from `entry.examples`
- [x] 5.7 Update the save logic to write `examples: _exampleControllers.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList()` to the entry

## 6. Entry Detail — Display Multiple Examples

- [x] 6.1 Update `lib/features/dictionary/entry_detail_screen.dart` to read `entry.examples` (list) instead of `entry.example` (single string)
- [x] 6.2 Render examples as a numbered list (e.g. `1. ...`, `2. ...`) in the detail view; show nothing if the list is empty

## 7. Default Tab Setting — Provider & Settings UI

- [x] 7.1 Create `lib/core/providers/tab_provider.dart` with a `StateNotifierProvider` that reads/writes `default_tab_index` from SharedPreferences
- [x] 7.2 Update `GoRouter` `initialLocation` to be dynamically set from the persisted tab index on app startup (read before `runApp`)
- [x] 7.3 Add a "Default Tab" section to `lib/features/settings/settings_screen.dart` with a `ListTile` or segmented control showing 5 options: Dashboard, Words, Phrases, Idioms, Quotes
- [x] 7.4 Wire the setting UI to the `TabProvider` so selecting an option saves to SharedPreferences immediately

## 8. Settings Tab Integration

- [x] 8.1 Verify `SettingsScreen` renders correctly as a bottom nav tab (no `AppBar` back button issues, correct scroll behaviour)
- [x] 8.2 Remove any `context.push('/settings')` calls that are now redundant (replaced by tab navigation)

## 9. Cleanup & Verification

- [x] 9.1 Search codebase for all references to `entry.example` (singular) and update to `entry.examples` or appropriate list access
- [x] 9.2 Verify back-navigation works correctly from entry detail to the originating tab (not always Dashboard)
- [x] 9.3 Smoke-test all 6 tabs, fan-out FAB, typed FABs, multi-example add/edit/remove, and default tab setting
- [x] 9.4 Verify the app launches to the correct tab based on the persisted default tab setting
