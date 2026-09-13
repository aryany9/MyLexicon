## ADDED Requirements

### Requirement: Palette catalogue
The system SHALL provide a fixed catalogue of named theme palettes. Each palette SHALL be identified by a unique `AppThemeName` enum value and SHALL produce a complete `ThemeData` object. Palettes SHALL be tagged as either light-compatible or dark-compatible (not both, except Solarized which has distinct variants for each).

The initial catalogue SHALL include:

| Name | Slot | Character |
|---|---|---|
| `defaultLight` | Light | Indigo seed, white/grey-50 surfaces (current light theme) |
| `defaultDark` | Dark | Indigo seed, grey-900/grey-800 surfaces (current dark theme) |
| `solarizedLight` | Light | Warm cream background (#FDF6E3), muted blue-green accent |
| `solarizedDark` | Dark | Deep teal background (#002B36), warm yellow accent |
| `abyss` | Dark | Very deep navy (#000C18) background, cyan accent |
| `kimbieDark` | Dark | Warm dark brown (#221A0F), amber/orange accent |
| `monokai` | Dark | Dark charcoal (#272822), vibrant green accent |
| `oneLight` | Light | Soft warm white (#FAFAFA), purple-blue accent |

#### Scenario: Registry lookup by name
- **WHEN** the system resolves `AppThemeRegistry.all[AppThemeName.abyss]`
- **THEN** it SHALL return the Abyss `ThemeData` without creating a new instance

#### Scenario: Light palette filter
- **WHEN** the system requests `AppThemeRegistry.lightPalettes`
- **THEN** it SHALL return only palettes tagged as light-compatible (`defaultLight`, `solarizedLight`, `oneLight`)

#### Scenario: Dark palette filter
- **WHEN** the system requests `AppThemeRegistry.darkPalettes`
- **THEN** it SHALL return only palettes tagged as dark-compatible (`defaultDark`, `solarizedDark`, `abyss`, `kimbieDark`, `monokai`)

### Requirement: Palette visual fidelity
Each palette's `ThemeData` SHALL set at minimum: `scaffoldBackgroundColor`, `colorScheme` (with appropriate `brightness`, `primary`, `surface`), `appBarTheme` (including `systemOverlayStyle` matching the palette's scaffold/nav bar color and icon brightness), `cardTheme`, `chipTheme` (rounded pill shape consistent with existing style), `navigationBarTheme` (matching `bottomNavBackgroundColor`, elevation 0, solid accent pill indicator, high-contrast active icon, muted inactive icon), `bottomNavigationBarTheme`, `floatingActionButtonTheme` (primary background, `fabForegroundColor` contrasting against primary accent), `inputDecorationTheme`, and `elevatedButtonTheme`. These SHALL visually reflect the character of the named palette.

#### Scenario: Abyss scaffold colour
- **WHEN** the Abyss palette is active
- **THEN** `Theme.of(context).scaffoldBackgroundColor` SHALL return a colour with lightness ≤ 10% (very dark navy/black)

#### Scenario: Solarized Light scaffold colour
- **WHEN** the Solarized Light palette is active
- **THEN** `Theme.of(context).scaffoldBackgroundColor` SHALL return a warm cream tone (hue near yellow, high lightness)

#### Scenario: Navigation bar and FAB themes defined
- **WHEN** any palette is retrieved from `AppThemeRegistry`
- **THEN** its `ThemeData.navigationBarTheme` SHALL have non-null `backgroundColor`, `elevation = 0`, non-null `indicatorColor`, and `height = 62`, and its `ThemeData.floatingActionButtonTheme` SHALL have non-null `backgroundColor` and `foregroundColor`

### Requirement: No runtime palette construction
The system SHALL pre-construct all `ThemeData` objects at app initialisation (static registry). It SHALL NOT construct palette `ThemeData` objects on each widget rebuild.

#### Scenario: Repeated registry access
- **WHEN** `AppThemeRegistry.all` is accessed multiple times during a session
- **THEN** the same object references SHALL be returned each time (referential equality)
