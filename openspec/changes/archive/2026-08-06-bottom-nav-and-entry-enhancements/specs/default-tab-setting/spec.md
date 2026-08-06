## ADDED Requirements

### Requirement: Default Launch Tab Setting
The system SHALL provide a setting in the Settings screen that allows the user to choose which tab is active when the app starts. The options SHALL be: Dashboard, Words, Phrases, Idioms, Quotes. The selection SHALL be persisted across app restarts using SharedPreferences.

#### Scenario: User sets Words as default tab
- **WHEN** the user selects "Words" as the default tab in Settings and restarts the app
- **THEN** the system SHALL open with the Words tab active, not the Dashboard

#### Scenario: Default is Dashboard if no preference set
- **WHEN** the user has never changed the default tab setting
- **THEN** the system SHALL open with the Dashboard tab active on launch

#### Scenario: Setting persists across restarts
- **WHEN** the user sets "Idioms" as the default tab and backgrounds then re-opens the app
- **THEN** the system SHALL open with the Idioms tab active

### Requirement: Settings Tab Not Selectable as Default
The Settings tab SHALL NOT be available as a default launch tab option in the setting, since landing on Settings on every app open would be disruptive.

#### Scenario: Settings not in default tab options
- **WHEN** the user opens the "Default Tab" setting
- **THEN** the system SHALL display only Dashboard, Words, Phrases, Idioms, and Quotes as selectable options — not Settings

