## MODIFIED Requirements

### Requirement: Default Launch Tab Setting
The system SHALL provide a setting in the Settings > Navigation & Launch sub-page that allows the user to choose which tab is active when the app starts. Selectable options SHALL only include currently enabled features (Dashboard is always selectable). The selection SHALL be persisted as a route path string (not an integer index) across app restarts using `SharedPreferences`.

#### Scenario: User sets Words as default tab
- **WHEN** the user selects "Words" as the default tab and restarts the app
- **THEN** the system SHALL open with the Words tab active

#### Scenario: Default is Dashboard if no preference set
- **WHEN** the user has never changed the default tab setting
- **THEN** the system SHALL open with the Dashboard tab active on launch

#### Scenario: Setting persists across restarts
- **WHEN** the user sets "Idioms" as the default tab and backgrounds then re-opens the app
- **THEN** the system SHALL open with the Idioms tab active

#### Scenario: Disabled features omitted from default tab options
- **WHEN** "Phrases" is disabled in Settings
- **THEN** "Phrases" SHALL NOT appear in the Default Launch Tab selection

#### Scenario: Fallback to Dashboard when default tab is disabled
- **WHEN** the user's saved default tab feature is subsequently disabled
- **THEN** the app SHALL launch on the Dashboard tab instead and update the saved preference to Dashboard

### Requirement: Settings Tab Not Selectable as Default
The Settings tab SHALL NOT be available as a default launch tab option.

#### Scenario: Settings not in default tab options
- **WHEN** the user opens the Default Launch Tab setting
- **THEN** the system SHALL NOT display Settings as a selectable option
