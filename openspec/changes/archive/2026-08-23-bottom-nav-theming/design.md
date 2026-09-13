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

### D1 — Explicit `navigationBarTheme`, `bottomNavBackgroundColor`, and `floatingActionButtonTheme`
 
**Decision:** Configure `NavigationBarThemeData`, `BottomNavigationBarThemeData`, and `FloatingActionButtonThemeData` for every palette preset inside `_buildTheme`:
- `backgroundColor: bottomNavBackgroundColor` explicitly calibrated to VS Code's Activity Bar / Status Bar palettes (e.g. `#1E1F1C` for Monokai, `#073642` for Solarized Dark, `#00172E` for Abyss, `#EDEDF4` for Quiet Light, `#F0F0F0` for One Light).
- `systemNavigationBarColor: bottomNavBackgroundColor` for Android edge-to-edge system bar continuity.
- `elevation: 0`
- `indicatorColor: primaryColor.withValues(alpha: isDark ? 0.85 : 0.80)` providing a solid pill background.
- `iconTheme`: `WidgetStateProperty.resolveWith` returning `fabForegroundColor` (or luminance-based dark/light contrast) when selected, matching the FAB icon contrast model, and muted tone (45% opacity white on dark, 40% opacity black on light) when unselected.
- `height: 62`
- `labelBehavior: NavigationDestinationLabelBehavior.alwaysHide`
- `floatingActionButtonTheme`: `backgroundColor: primaryColor`, `foregroundColor: fabForegroundColor ?? (luminance > 0.35 ? #111827 : Colors.white)` to guarantee crisp readability on bright primaries (Monokai lime, Solarized yellow, Kimbie amber, Abyss cyan).
 
**Rationale:** Centralizing navigation bar and FAB styling inside `ThemeData` gives all palettes native Material 3 pill animation and harmonious, high-contrast icon rendering that precisely matches VS Code's UI hierarchy.
 
---
 
### D2 — `AppShell` M3 Navigation Migration
 
**Decision:** In `lib/core/shell/app_shell.dart`, replace `BottomNavigationBar` + `BottomNavigationBarItem` with `NavigationBar` + `NavigationDestination`, wrapped in a `Container` with a 1px top border matching `cardBorderColor`.
 
**Rationale:** `NavigationBar` is Flutter's official Material 3 component for top-level app switching, supporting accessibility, smooth indicator motion, and theme delegation.
 
---
 
### D3 — Modernize Dropdown in Navigation Settings
 
**Decision:** In `navigation_settings_page.dart`, replace the unstyled `DropdownButton` with a clean Material 3 styled container with `DropdownButtonHideUnderline`, rounded border, surface background, and trailing chevron.
 
**Rationale:** Brings the navigation settings page to visual parity with the modern segmented controls on the appearance settings page.

## Risks / Trade-offs

- **Risk:** 7 tabs on very narrow screens (e.g. 320px).  
  → **Mitigation:** Setting `labelBehavior: NavigationDestinationLabelBehavior.alwaysHide` and compact padding in `NavigationDestination` ensures items never wrap or overflow.
