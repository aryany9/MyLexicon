## Context

MyLexicon uses a single `AppTheme` class with two static `ThemeData` getters (`lightTheme`, `darkTheme`), both hardcoded to an indigo seed. A `ThemeModeNotifier` (Riverpod `StateNotifier<ThemeMode>`) in `main.dart` persists the active `ThemeMode` via `SharedPreferences` and feeds it into `MaterialApp.router`. There are no specs today for theming — it is purely implementation-level.

## Goals / Non-Goals

**Goals:**
- Introduce a curated palette catalogue (8 palettes: 3 light, 5 dark) each represented as a complete `ThemeData`
- Allow users to independently choose a light-slot theme and a dark-slot theme
- Auto-switch between the two chosen themes when mode is "System"
- Persist both slot choices and the active mode across launches
- Keep the existing Light / Dark / System mode toggle UX familiar and unchanged

**Non-Goals:**
- Custom colour pickers or user-defined palettes
- Font / typography theming
- Per-screen or per-feature theme overrides
- Syncing theme preferences to a remote backend
- Dark variants for palettes that don't have a meaningful light counterpart (e.g., no "Abyss Light")

## Decisions

### D1 — Replace `ThemeModeNotifier` with `AppThemePreferenceNotifier`

**Decision:** Remove the `themeModeProvider` / `ThemeModeNotifier` from `main.dart` and introduce a dedicated `AppThemePreferenceNotifier` (Riverpod `StateNotifier<AppThemePreference>`) in `lib/core/providers/theme_preference_provider.dart`.

**Rationale:** The current notifier only holds `ThemeMode`. The new state must hold three values: `mode`, `lightThemeName`, `darkThemeName`. Keeping theme state in a dedicated file also removes the current anti-pattern of provider code living in `main.dart`.

**Alternative considered:** Extend `ThemeModeNotifier` with additional fields. Rejected — conflates brightness with palette, and the class name becomes misleading.

---

### D2 — Palette Registry as a static map in `AppThemeRegistry`

**Decision:** Create `lib/core/theme/app_theme_registry.dart` housing an `AppThemeRegistry` class with:
- An `AppThemeName` enum (one value per palette)
- A `static Map<AppThemeName, ThemeData> all` registry
- Helper getters `lightPalettes` / `darkPalettes` for the UI picker

**Rationale:** A static map is the simplest lookup that avoids rebuilding `ThemeData` objects on every render. It also makes adding future palettes trivially easy (one enum value + one entry in the map).

**Alternative considered:** Generating `ThemeData` on-demand via a factory. Rejected — no benefit for a small fixed catalogue, adds unnecessary object churn.

---

### D3 — Resolve active `ThemeData` pair inside `MaterialApp.router`

**Decision:** `MyLexiconApp` watches `appThemePreferenceProvider` and calls `AppThemeRegistry.resolve(pref)` to get `(ThemeData light, ThemeData dark, ThemeMode mode)`, then passes all three to `MaterialApp.router`.

**Rationale:** `MaterialApp` natively supports `theme`, `darkTheme`, and `themeMode`. When `themeMode` is `ThemeMode.system`, Flutter's framework handles the OS-brightness switch automatically — we don't need to implement any switching logic ourselves.

**Alternative considered:** Constructing a single `ThemeData` and passing it as `theme` only. Rejected — loses the native system-brightness switching capability.

---

### D4 — SharedPreferences keys

Three keys:
- `app_theme_mode` → `"light" | "dark" | "system"` (reuses existing key for backwards-compat)
- `app_light_theme` → `AppThemeName.name` string (default: `"defaultLight"`)
- `app_dark_theme` → `AppThemeName.name` string (default: `"defaultDark"`)

On first launch (keys absent), defaults are the existing indigo palettes — zero visual regression.

---

### D5 — Appearance UI: two swatch rows, always visible

**Decision:** The Appearance settings page renders two horizontally-scrollable swatch rows under the existing mode toggle:
- ☀ **Light Mode Theme** — shows only light-compatible palettes
- 🌙 **Dark Mode Theme** — shows only dark-compatible palettes

Each swatch is a small rounded card showing the palette's background, surface, and primary colours with the palette name beneath. The active selection has a primary-coloured border ring.

**Rationale:** Always showing both rows (regardless of the current mode) lets users configure both slots before switching modes. The visual swatch communicates the palette character without requiring the user to understand naming conventions.

**Alternative considered:** Only showing the relevant row based on the active mode. Rejected — hides capability and confuses users switching modes after configuration.

## Risks / Trade-offs

- **Risk:** Dark-only palettes (Abyss, Kimbie Dark, Monokai) have no light counterpart, so the light row will always have fewer options. → **Mitigation:** "Default Light" and "Solarized Light" / "One Light" provide sufficient variety; the asymmetry is intentional and clearly visible in the UI.
- **Risk:** Existing users have `app_theme_mode` persisted as `"system" | "light" | "dark"` — the new notifier reads the same key, so no migration is needed. → **No mitigation required.**
- **Risk:** `ThemeModeNotifier` is currently imported by `appearance_settings_page.dart` via `main.dart`. Removing it will break the import. → **Mitigation:** The new `theme_preference_provider.dart` will be the single import point; the settings page will be updated as part of this change.

## Migration Plan

1. Add `AppThemeName` enum and `AppThemeRegistry` — no breaking changes yet
2. Add `AppThemePreference` model and `AppThemePreferenceNotifier` provider
3. Update `main.dart`: swap `themeModeProvider` for `appThemePreferenceProvider`; keep old SharedPrefs key for mode for backwards-compat
4. Update `appearance_settings_page.dart` to use the new provider and render swatches
5. Delete `ThemeModeNotifier` from `main.dart`

**Rollback:** If the preference file is malformed or unknown names appear, the notifier falls back to `defaultLight` / `defaultDark` with `ThemeMode.system`.

## Open Questions

- None — all decisions were resolved during exploration.
