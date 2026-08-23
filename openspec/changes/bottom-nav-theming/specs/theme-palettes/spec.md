## MODIFIED Requirements

### Requirement: Palette visual fidelity
Each palette's `ThemeData` SHALL set at minimum: `scaffoldBackgroundColor`, `colorScheme` (with appropriate `brightness`, `primary`, `surface`), `appBarTheme` (including `systemOverlayStyle` matching the palette's scaffold/nav bar color and icon brightness), `cardTheme`, `chipTheme` (rounded pill shape consistent with existing style), `navigationBarTheme` (matching surface background, elevation 0, primary active icon, accent pill indicator, muted inactive icon), `inputDecorationTheme`, and `elevatedButtonTheme`. These SHALL visually reflect the character of the named palette.

#### Scenario: Abyss scaffold colour
- **WHEN** the Abyss palette is active
- **THEN** `Theme.of(context).scaffoldBackgroundColor` SHALL return a colour with lightness ≤ 10% (very dark navy/black)

#### Scenario: Solarized Light scaffold colour
- **WHEN** the Solarized Light palette is active
- **THEN** `Theme.of(context).scaffoldBackgroundColor` SHALL return a warm cream tone (hue near yellow, high lightness)

#### Scenario: Navigation bar theme defined
- **WHEN** any palette is retrieved from `AppThemeRegistry`
- **THEN** its `ThemeData.navigationBarTheme` SHALL have non-null `backgroundColor`, `elevation = 0`, non-null `indicatorColor`, and `height = 62`
