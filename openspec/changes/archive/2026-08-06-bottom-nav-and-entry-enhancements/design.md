## Context

MyLexicon is a Flutter app using Hive for local storage, Riverpod for state management, and go_router for navigation. The current architecture uses a single HomeScreen as the root with push-based navigation to all other screens. The entry model stores a single optional example string. Settings are accessed via an AppBar icon on the dashboard. There is no persistent navigation shell.

## Goals / Non-Goals

**Goals:**
- Introduce a persistent 6-tab bottom navigation bar (Dashboard, Words, Phrases, Idioms, Quotes, Settings)
- Restructure routing to use go_router's `ShellRoute` wrapping the bottom nav shell
- Replace the single `String? example` field with `List<String> examples` (max 5, optional)
- Provide a fan-out FAB on the Dashboard tab and type-specific FABs on category tabs
- Pre-select entry type in the form when launched from a category tab or fan-out option
- Add a "Default Tab" setting persisted in SharedPreferences that controls the initial active tab on app launch

**Non-Goals:**
- Adding any new pub.dev dependencies (all required packages already exist)
- Changing the visual design of existing screens beyond what's necessary for navigation integration
- Syncing data to any remote backend
- Adding search within individual category tabs

## Decisions

### D1: ShellRoute for bottom navigation shell
**Decision**: Use go_router's `ShellRoute` to wrap the 6 tabs in a shared scaffold containing the `BottomNavigationBar`.

**Rationale**: `ShellRoute` is the idiomatic go_router pattern for persistent shell UI (nav bars, drawers). It allows each tab to maintain its own navigator stack, meaning navigating to an entry detail from the Words tab and pressing back returns to Words — not Dashboard. An alternative was using `IndexedStack` with a single navigator; rejected because it breaks deep-linking and the back button behaviour expected with go_router.

**Alternatives considered**: `StatefulShellRoute.indexedStack` (go_router v10+) is even more idiomatic and preserves tab scroll state. Use this if the go_router version supports it (currently `^17.3.0` — check if `StatefulShellRoute` is available).

---

### D2: Tab index persisted in SharedPreferences
**Decision**: Store the default tab index (0–5) in SharedPreferences under key `default_tab_index`. Read it at app startup in a provider. The `GoRouter`'s `initialLocation` is set based on this value.

**Rationale**: SharedPreferences is already a dependency. The tab index maps directly to a route path, making it trivial to set `initialLocation`. Alternative of storing the route path string directly was considered; rejected for being more brittle when routes change.

**Tab index → route mapping**:
| Index | Tab | Route |
|---|---|---|
| 0 | Dashboard | `/` |
| 1 | Words | `/words` |
| 2 | Phrases | `/phrases` |
| 3 | Idioms | `/idioms` |
| 4 | Quotes | `/quotes` |
| 5 | Settings | `/settings` |

---

### D3: HiveField(4) direct replacement — no dual-field migration
**Decision**: Replace `@HiveField(4) String? example` directly with `@HiveField(4) List<String> examples`. Re-run `build_runner`. Require a fresh app install on dev devices.

**Rationale**: The app has no production users. Keeping both fields (dual-source-of-truth) adds permanent code complexity. A one-time reinstall on dev devices has zero cost. This is the cleanest long-term model.

**Alternatives considered**: Adding `@HiveField(11) List<String> examples` alongside the old field and reading from both. Rejected — unnecessary complexity for a dev-stage app with no user data to protect.

---

### D4: Fan-out FAB implemented as an AnimatedList overlay, not a package
**Decision**: Build the fan-out FAB from scratch using Flutter's `AnimatedList` / `AnimatedContainer` + `Stack` + `Overlay`, without adding a speed dial package.

**Rationale**: No new pub.dev dependencies (per non-goals). The interaction is simple enough (4 child buttons, slide-up animation) to implement with standard Flutter animation APIs. The FAB state (open/closed) is local widget state — no Riverpod needed.

---

### D5: Entry type passed via query parameter to entry form
**Decision**: When opening the entry form from a tab FAB or fan-out option, pass the pre-selected type as a query parameter: `/entry-form?type=word`.

**Rationale**: go_router already reads `state.uri.queryParameters` for `entryId`. Extending it with `type` keeps the routing approach consistent. The form reads this parameter in `initState` and sets `_selectedType`, hiding the type picker UI if a type is provided.

---

## Risks / Trade-offs

- **StatefulShellRoute availability**: If the go_router version `^17.3.0` doesn't support `StatefulShellRoute.indexedStack`, use standard `ShellRoute` and accept that tab state (scroll position) resets on tab switch. → Mitigation: check go_router changelog; upgrade if needed (no breaking changes expected at this version range).

- **Hive box corruption on direct field-type replacement**: Replacing `HiveField(4)` from `String?` to `List<String>` will corrupt any existing Hive box data on devices that still have the old schema. → Mitigation: reinstall/clear app data on all dev devices after the model change. Document this in tasks.

- **Fan-out FAB and bottom nav overlap**: The FAB must clear the bottom nav bar height when expanded. → Mitigation: use `MediaQuery.of(context).padding.bottom` + `kBottomNavigationBarHeight` to compute safe offset for fan-out child positioning.

## Migration Plan

1. Update `LexiconEntry` model (`HiveField(4)`: `String?` → `List<String>`)
2. Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. On all dev devices: uninstall app or clear app data to discard old Hive box
4. Re-run the app — Hive opens fresh box with new schema
5. No rollback needed (dev-only change)

## Open Questions

- None — all decisions made during exploration session.
