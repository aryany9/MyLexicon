## Why

Users who use MyLexicon primarily for specific vocabulary types (e.g. Words and Quotes) find irrelevant categories (such as Phrases or Idioms) cluttering their bottom navigation bar, home dashboard, entry creation forms, and search filters. Allowing users to toggle individual category features — and optionally the Collections feature — on or off in Settings makes the app feel completely tailored and uncluttered. Furthermore, users want the ability to **reorder the tabs** in their bottom navigation bar so their most-used features appear in their preferred order (with Settings pinned at the end). In the same pass, the Settings screen itself is reorganized into grouped sub-pages to give each section breathing room.

## What Changes

- **Category Feature Toggles**: Add per-category enable/disable toggles for `Words`, `Phrases`, `Idioms`, and `Quotes` in Settings. The `Collections` feature also gets a toggle (optional but recommended for power users who don't use collections).
- **Custom Navigation Tab Reordering**: Allow users to drag and reorder tabs (Dashboard, Words, Phrases, Idioms, Quotes, Collections) directly in Settings using drag handles (`≡`). Settings is permanently pinned as the last tab item.
- **Dynamic Bottom Navigation Bar**: Tabs for disabled features are removed from the bar, while enabled tabs render in the custom order defined by the user.
- **System-Wide Feature Hiding** — when a feature is disabled, it disappears from:
  - **Dashboard stat cards** (`_buildStatsGrid` in `home_screen.dart`): disabled category cards are hidden.
  - **FanOut FAB** (`lib/widgets/fan_out_fab.dart`): disabled category add-options are omitted from the fan-out menu.
  - **Home Quick Actions row**: the Collections shortcut button is hidden when Collections is disabled.
  - **Entry Add/Edit Form**: disabled categories are removed from the `SegmentedButton` type selector.
  - **Entry Detail Screen**: collection badge/chip is hidden when Collections is disabled.
  - **Search & Filters**: disabled category types are excluded from filter chips.
  - **Default Launch Tab**: disabled features cannot be selected as the default launch tab; if the currently saved default is disabled, it falls back to Dashboard.
- **Settings Reorganization**: Flatten all settings into logical grouped sub-pages (Appearance, Navigation & Launch, Tags, Data). Each group is a tappable `ListTile` that `push()`es to a dedicated sub-screen.
- **State Persistence**: Feature flags and custom tab order stored in `SharedPreferences`, managed reactively via Riverpod.

## Capabilities

### New Capabilities
- `category-feature-toggles`: State management, persistence, and Settings UI for enabling/disabling individual lexicon category features (`Words`, `Phrases`, `Idioms`, `Quotes`) and optionally the `Collections` feature.
- `navigation-tab-reordering`: Custom drag-and-drop ordering of bottom navigation tabs (Dashboard, Words, Phrases, Idioms, Quotes, Collections) with Settings pinned at the end.
- `settings-navigation`: Reorganized Settings screen using nested sub-page navigation (Appearance, Navigation & Launch, Tags, Data).

### Modified Capabilities
- `bottom-navigation`: Dynamic rendering and custom ordering of bottom navigation items based on active feature toggles and user tab order preference. `Settings` is always the last item.
- `default-tab-setting`: Default launch tab selection restricted to currently enabled features only; fallback to Dashboard when the saved default is disabled.

## Impact

- `lib/core/providers/feature_flags_provider.dart`: Provider for managing feature toggle state and persistence.
- `lib/core/providers/tab_order_provider.dart`: New provider for managing custom bottom navigation tab ordering.
- `lib/core/shell/app_shell.dart`: Dynamic `BottomNavigationBarItem` list construction ordered by `tabOrderProvider` and filtered by `featureFlagsProvider`.
- `lib/features/settings/sub_pages/navigation_settings_page.dart`: Interactive `ReorderableListView` with drag handles for sorting tabs.
- `lib/widgets/fan_out_fab.dart`: `ConsumerStatefulWidget` to read `featureFlagsProvider` and conditionally render add-options.
- `lib/features/settings/settings_screen.dart`: Refactored into a root navigation list + dedicated sub-screen widgets for each section.
- `lib/features/home/home_screen.dart`: Conditional rendering of stat cards, quick actions (Collections button), and recent entries filtering.
- `lib/features/dictionary/entry_form_screen.dart`: Conditional rendering of type `SegmentedButton` options.
- `lib/features/dictionary/entry_detail_screen.dart`: Hide collection badge/chip when Collections is disabled.
- `lib/features/search/search_screen.dart`: Filter options respect active feature flags.
