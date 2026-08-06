## Why

MyLexicon's current navigation relies on a flat AppBar with push-based routing, making the app feel disconnected between its core content types (Words, Phrases, Idioms, Quotes). Users who primarily use one category must always return through a dashboard they don't need. Adding persistent bottom navigation, a contextual FAB, and multiple examples per entry makes the app significantly faster to use and more aligned with how people actually engage with a personal lexicon.

## What Changes

- **Bottom navigation bar** added with 6 tabs: Dashboard, Words, Phrases, Idioms, Quotes, Settings
- **Settings removed from Dashboard AppBar** — it now lives exclusively in the bottom nav bar
- **Fan-out FAB on Dashboard** — expands to reveal "Add Word", "Add Phrase", "Add Idiom", "Add Quote" options
- **Typed FAB on category tabs** — Words tab FAB says "Add Word" with type pre-selected; same for Phrases, Idioms, Quotes
- **Entry type picker removed from entry form** when launched with a pre-selected type
- **Multiple examples per entry** — replaces the single `String? example` field with `List<String> examples` (optional, max 5)
- **Hive model migration** — `HiveField(4)` changes from `String? example` to `List<String> examples`; `build_runner` re-run required
- **Homescreen switcher in Settings** — user can set which tab is active on app launch; persisted via SharedPreferences

## Capabilities

### New Capabilities

- `bottom-navigation`: Persistent 6-tab bottom navigation bar using ShellRoute; replaces push-based navigation between core sections
- `contextual-fab`: Fan-out FAB on dashboard tab; type-specific FAB on category tabs; pre-selects entry type in the form
- `default-tab-setting`: Setting that persists and restores the user's preferred launch tab via SharedPreferences

### Modified Capabilities

- `entry-management`: The example field changes from a single optional string to an optional list of up to 5 strings; entry form conditionally hides the type picker when a type is pre-supplied

## Impact

- **`lib/models/lexicon_entry.dart`** — `HiveField(4)` type changes (`String?` → `List<String>`); requires `build_runner` re-run and dev device reinstall
- **`lib/models/lexicon_entry.g.dart`** — regenerated adapter
- **`lib/routes/app_router.dart`** — restructured to use `ShellRoute` wrapping 5 content tabs + Settings; `initialLocation` driven by persisted preference
- **`lib/features/home/home_screen.dart`** — becomes the Dashboard tab content; loses Settings AppBar icon; gains fan-out FAB
- **`lib/features/dictionary/entry_form_screen.dart`** — type picker conditionally shown; `example` field replaced with dynamic multi-example input (max 5)
- **`lib/features/dictionary/entry_detail_screen.dart`** — displays `examples` as a numbered list
- **`lib/features/settings/settings_screen.dart`** — new "Default Tab" setting section added; Settings screen becomes a nav tab (no longer push-navigated)
- **New files**: `lib/core/shell/app_shell.dart`, `lib/core/providers/tab_provider.dart`
- **No new pub dependencies required** — `shared_preferences`, `go_router`, and `flutter_riverpod` already present
