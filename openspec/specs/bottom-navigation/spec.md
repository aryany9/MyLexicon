## ADDED Requirements

### Requirement: Persistent Bottom Navigation Bar
The system SHALL display a persistent bottom navigation bar with 6 equal-width tabs: Dashboard, Words, Phrases, Idioms, Quotes, and Settings. The bar SHALL remain visible on all tab screens.

#### Scenario: Navigate to Words tab
- **WHEN** the user taps the "Words" tab in the bottom navigation bar
- **THEN** the system SHALL display the Words category list screen without pushing a new route onto the navigation stack

#### Scenario: Navigate to Settings tab
- **WHEN** the user taps the "Settings" tab in the bottom navigation bar
- **THEN** the system SHALL display the Settings screen and the Settings icon SHALL no longer appear in the Dashboard AppBar

#### Scenario: Active tab indicator
- **WHEN** the user is on any tab
- **THEN** the system SHALL visually highlight the active tab icon and label to distinguish it from inactive tabs

#### Scenario: Tab preserves navigation stack
- **WHEN** the user navigates to an entry detail from the Words tab and taps back
- **THEN** the system SHALL return to the Words tab list, not to the Dashboard

### Requirement: Dashboard AppBar Cleanup
The system SHALL remove the Settings icon button from the Dashboard AppBar after the Settings tab is added to the bottom navigation bar. The Search icon SHALL remain in the Dashboard AppBar.

#### Scenario: Dashboard AppBar has no settings icon
- **WHEN** the user opens the Dashboard tab
- **THEN** the system SHALL display only the Search icon in the AppBar actions, with no Settings icon

