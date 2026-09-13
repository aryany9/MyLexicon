## ADDED Requirements

### Requirement: Theme preference state
The system SHALL maintain an `AppThemePreference` value object containing three fields:
- `mode`: `ThemeMode` — one of `light`, `dark`, or `system`
- `lightThemeName`: `AppThemeName` — the palette to use in light mode (default: `defaultLight`)
- `darkThemeName`: `AppThemeName` — the palette to use in dark mode (default: `defaultDark`)

#### Scenario: Default preference on first launch
- **WHEN** no theme preferences have been persisted
- **THEN** the system SHALL use `mode = ThemeMode.system`, `lightThemeName = defaultLight`, `darkThemeName = defaultDark`

#### Scenario: Preference fields are independent
- **WHEN** the user updates `darkThemeName` to `abyss`
- **THEN** `lightThemeName` and `mode` SHALL remain unchanged

### Requirement: Persistence across launches
The system SHALL persist `AppThemePreference` to `SharedPreferences` using three keys: `app_theme_mode`, `app_light_theme`, `app_dark_theme`. Preferences SHALL be loaded asynchronously at app startup and applied before the first frame renders.

#### Scenario: Preference survives app restart
- **WHEN** the user sets dark theme to Kimbie Dark and restarts the app
- **THEN** the dark theme SHALL still be Kimbie Dark after restart

#### Scenario: Unknown persisted value is handled gracefully
- **WHEN** a persisted theme name does not match any `AppThemeName` value (e.g., from a future downgrade)
- **THEN** the system SHALL fall back to the default for that slot without crashing

### Requirement: Runtime theme resolution
The system SHALL resolve the active `ThemeData` pair at runtime by mapping `lightThemeName` and `darkThemeName` through `AppThemeRegistry`. The resolved pair SHALL be passed to `MaterialApp` as `theme` (light slot) and `darkTheme` (dark slot), with `themeMode` set from `mode`. Flutter's framework SHALL handle OS-brightness switching automatically when `themeMode` is `ThemeMode.system`.

#### Scenario: System mode auto-switches
- **WHEN** `mode` is `ThemeMode.system` and the OS switches from light to dark
- **THEN** the app SHALL display the `darkThemeName` palette without any user action

#### Scenario: Light mode ignores OS brightness
- **WHEN** `mode` is `ThemeMode.light` and the OS is in dark mode
- **THEN** the app SHALL display the `lightThemeName` palette

#### Scenario: Dark mode ignores OS brightness
- **WHEN** `mode` is `ThemeMode.dark` and the OS is in light mode
- **THEN** the app SHALL display the `darkThemeName` palette

### Requirement: Settings UI — mode toggle
The Appearance settings page SHALL display a segmented or radio control for selecting `mode` with labels "Light", "Dark", and "System". Changing the mode SHALL take effect immediately without requiring a save action.

#### Scenario: Mode change is immediate
- **WHEN** the user taps "Dark" in the mode toggle
- **THEN** the app theme SHALL switch to the dark palette within the same frame

### Requirement: Settings UI — palette pickers
The Appearance settings page SHALL display two palette picker rows:
- ☀ **Light Mode Theme** — shows only light-compatible palettes
- 🌙 **Dark Mode Theme** — shows only dark-compatible palettes

Each palette SHALL be represented as a swatch card showing at minimum: background colour, surface colour, and primary accent colour. The currently selected palette for each slot SHALL be visually distinguished (e.g., border ring in primary colour). Both rows SHALL always be visible regardless of the active mode.

#### Scenario: Light swatch selection
- **WHEN** the user taps the "Solarized Light" swatch in the light row
- **THEN** `lightThemeName` SHALL be set to `solarizedLight` and the swatch SHALL show as selected

#### Scenario: Dark swatch selection
- **WHEN** the user taps the "Abyss" swatch in the dark row
- **THEN** `darkThemeName` SHALL be set to `abyss` and if the current effective mode is dark, the app theme SHALL update immediately

#### Scenario: Both rows always visible
- **WHEN** the user is on the Appearance settings page with mode set to "Light"
- **THEN** both the light palette row and dark palette row SHALL be visible and interactive
