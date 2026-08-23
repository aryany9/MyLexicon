## Context

MyLexicon provides 8 distinct editor-style theme palettes (`defaultLight`, `defaultDark`, `solarizedLight`, `solarizedDark`, `abyss`, `kimbieDark`, `monokai`, `oneLight`). Navigation in `AppShell` is currently powered by a legacy M2 `BottomNavigationBar`, and default startup tab selection in `navigation_settings_page.dart` uses a legacy `DropdownButton`. These components should be upgraded to modern Material 3 while preserving the app's clean, compact reading layout and dynamic 3-to-7 tab scaling.

## Goals / Non-Goals

**Goals:**
- Upgrade `AppShell` to modern Material 3 `NavigationBar` with `NavigationDestination`.
- Provide smooth theme-colored pill indicators (`indicatorColor`) behind the active tab on each palette.
- Keep the navigation bar compact (~62px height, `labelBehavior: alwaysHide`) to ensure 7 tabs fit comfortably on small screens with zero overflow.
- Eliminate muddy M2 drop-shadow elevation (`elevation: 0`).
- Provide a subtle 1px top border matching the active palette's card border for crisp separation.
- Modernize the legacy `DropdownButton` in `navigation_settings_page.dart`.

**Non-Goals:**
- Permanent text labels on the bottom navigation bar (icons only preserves density).
- Custom per-tab background animations.

## Decisions

### D1 — Explicit `navigationBarTheme` in `AppThemeRegistry._buildTheme`

**Decision:** Configure `NavigationBarThemeData` for every palette preset inside `_buildTheme`:
- `backgroundColor: surfaceColor`
- `elevation: 0`
- `indicatorColor: primaryColor.withValues(alpha: 0.20)` (or `primaryColor.withValues(alpha: 0.25)` for dark palettes)
- `iconTheme`: `WidgetStateProperty.resolveWith` returning `primaryColor` when selected, and muted tone (45% opacity white on dark, 40% opacity black on light) when unselected
- `height: 62`
- `labelBehavior: NavigationDestinationLabelBehavior.alwaysHide`

**Rationale:** Centralizing navigation bar styling inside `ThemeData` gives all 8 palettes native Material 3 pill animation while keeping icon contrast and surface colors perfectly harmonized.

---

### D2 — `AppShell` M3 Navigation Migration

**Decision:** In `lib/core/shell/app_shell.dart`, replace `BottomNavigationBar` + `BottomNavigationBarItem` with `NavigationBar` + `NavigationDestination`, wrapped in a `Container` with a 1px top border matching `cardBorderColor`.

**Rationale:** `NavigationBar` is Flutter's official Material 3 component for top-level app switching, supporting accessibility, smooth indicator motion, and theme delegation.

---

### D3 — Modernize Dropdown in Navigation Settings

**Decision:** In `navigation_settings_page.dart`, replace the unstyled `DropdownButton` with a clean Material 3 styled selector or `DropdownMenu` with proper rounded border, surface background, and trailing chevron.

**Rationale:** Brings the navigation settings page to visual parity with the modern segmented controls on the appearance settings page.

## Risks / Trade-offs

- **Risk:** 7 tabs on very narrow screens (e.g. 320px).  
  → **Mitigation:** Setting `labelBehavior: NavigationDestinationLabelBehavior.alwaysHide` and compact padding in `NavigationDestination` ensures items never wrap or overflow.
