## MODIFIED Requirements

### Requirement: Persistent Bottom Navigation Bar
The system SHALL display a persistent Material 3 bottom navigation bar (`NavigationBar`). `Settings` tab SHALL always be pinned as the final tab in the navigation bar. `Dashboard` tab and enabled feature tabs (`Words`, `Phrases`, `Idioms`, `Quotes`, `Collections`) SHALL be rendered in the custom order configured by the user. Disabled features SHALL be omitted while maintaining active-tab highlighting and tab order. The navigation bar SHALL integrate with the active theme palette, rendering with elevation 0, dedicated VS Code-calibrated bottom navigation background, active accent pill indicator, high-contrast active icon, and a subtle 1px top border matching the theme card border.

#### Scenario: Navigate to Words tab
- **WHEN** the user taps the "Words" tab in the bottom navigation bar
- **THEN** the system SHALL display the Words category list screen without pushing a new route onto the navigation stack

#### Scenario: Navigate to Settings tab
- **WHEN** the user taps the "Settings" tab in the bottom navigation bar
- **THEN** the system SHALL display the Settings screen as the last tab item

#### Scenario: Active tab pill indicator
- **WHEN** the user is on any tab
- **THEN** the system SHALL visually highlight the active tab with a theme-colored pill indicator and an icon contrasting against the pill matching the FAB contrast model

#### Scenario: Tab preserves navigation stack
- **WHEN** the user navigates to an entry detail from the Words tab and taps back
- **THEN** the system SHALL return to the Words tab list, not to the Dashboard

#### Scenario: Custom tab reordering
- **WHEN** the user reorders tabs in Settings (e.g., moves Quotes before Words)
- **THEN** the bottom navigation bar SHALL immediately update to reflect the new tab sequence, keeping Settings pinned at the end

#### Scenario: Dynamic item rendering based on feature toggles and custom order
- **WHEN** a category feature (e.g. "Phrases") is disabled in Settings
- **THEN** the bottom navigation bar SHALL dynamically omit the Phrases tab while rendering all remaining enabled tabs in their saved custom order

#### Scenario: Active tab disabled
- **WHEN** the user is currently on the "Phrases" tab and disables Phrases in Settings
- **THEN** the system SHALL immediately navigate to the Dashboard tab

#### Scenario: Collections tab hidden when disabled
- **WHEN** the Collections feature is disabled
- **THEN** the bottom navigation bar SHALL NOT show the Collections tab

#### Scenario: Collections navigable via shell
- **WHEN** the Collections feature is enabled
- **THEN** navigating to the Collections tab SHALL render the Collections screen within the shared scaffold (bottom nav bar visible)

#### Scenario: Palette-harmonized visual styling
- **WHEN** the user switches to any theme palette (e.g. Abyss, Solarized Dark, Monokai, Kimbie Dark)
- **THEN** the bottom navigation bar SHALL adopt the palette's VS Code-calibrated `bottomNavBackgroundColor`, render with elevation 0, display a 1px top border, and render an active pill indicator with high-contrast icon matching `fabForegroundColor`
