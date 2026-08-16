## ADDED Requirements

### Requirement: Category Feature Toggles in Settings
The system SHALL provide toggle switches in the Settings > Navigation & Launch sub-page for each lexicon category feature (`Words`, `Phrases`, `Idioms`, `Quotes`) and for the `Collections` feature. The state of each toggle SHALL be persisted across app restarts via `SharedPreferences`.

#### Scenario: User disables a category feature
- **WHEN** the user turns off the toggle switch for "Phrases" in Settings
- **THEN** the system SHALL save the preference and update the UI system-wide to hide Phrases immediately

#### Scenario: At least one category feature must remain enabled
- **WHEN** the user attempts to disable the last remaining enabled category feature
- **THEN** the system SHALL prevent disabling it and display an informational message requiring at least one active category

#### Scenario: User disables Collections feature
- **WHEN** the user turns off the "Collections" toggle in Settings
- **THEN** the Collections tab SHALL be removed from the bottom navigation bar, the Collections quick action on the Dashboard SHALL be hidden, and the collection badge on Entry Detail SHALL be hidden

### Requirement: System-Wide Category Hiding
When a category feature is disabled, the system SHALL hide that category from the Dashboard stat cards, FanOut FAB add-options, Entry creation form type selector, and Search filter options.

#### Scenario: Dashboard hides disabled category stat card
- **WHEN** "Phrases" is disabled
- **THEN** the Dashboard stat grid SHALL NOT display the Phrases count card

#### Scenario: FanOut FAB hides disabled category option
- **WHEN** "Idioms" is disabled
- **THEN** the FanOut FAB SHALL NOT show the "Add Idiom" fan-out option

#### Scenario: Entry form hides disabled category
- **WHEN** "Phrases" is disabled
- **THEN** the Entry creation form's `SegmentedButton` SHALL NOT include "Phrase" as a selectable type

#### Scenario: Entry form handles single enabled type
- **WHEN** only one category feature remains enabled
- **THEN** the Entry creation form SHALL still function correctly with only that one type available

#### Scenario: Recent Entries shows all types regardless of toggle
- **WHEN** "Phrases" is disabled and the user views the Dashboard Recent Entries list
- **THEN** existing Phrase entries SHALL still appear in the Recent Entries list

### Requirement: Settings Nested Sub-Page Navigation
The Settings screen SHALL be reorganized into a root page of section tiles that navigate to dedicated sub-pages using push navigation. Sub-pages SHALL be: Appearance, Navigation & Launch, Tags, Data.

#### Scenario: User navigates to Appearance sub-page
- **WHEN** the user taps "Appearance" on the Settings root screen
- **THEN** the system SHALL push an Appearance sub-page containing App Theme and List Density settings

#### Scenario: User navigates to Navigation & Launch sub-page
- **WHEN** the user taps "Navigation & Launch" on the Settings root screen
- **THEN** the system SHALL push a sub-page containing the Default Launch Tab setting and all Feature Toggle switches

#### Scenario: User navigates to Tags sub-page
- **WHEN** the user taps "Tags" on the Settings root screen
- **THEN** the system SHALL push a sub-page with the full Manage Tags list

#### Scenario: User navigates to Data sub-page
- **WHEN** the user taps "Data" on the Settings root screen
- **THEN** the system SHALL push a sub-page with Export, Import, and Clear All Data options
