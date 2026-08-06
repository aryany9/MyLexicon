## ADDED Requirements

### Requirement: Fan-out FAB on Dashboard
The system SHALL display a fan-out floating action button on the Dashboard tab. When tapped, it SHALL expand to show four options: "Add Word", "Add Phrase", "Add Idiom", and "Add Quote". Tapping outside the expanded FAB or tapping the close button SHALL collapse it.

#### Scenario: Fan-out FAB expands on Dashboard
- **WHEN** the user taps the FAB on the Dashboard tab
- **THEN** the system SHALL animate four labelled sub-buttons into view above the FAB, one per entry type (Word, Phrase, Idiom, Quote)

#### Scenario: Selecting a fan-out option opens pre-typed form
- **WHEN** the user taps "Add Word" from the fan-out FAB
- **THEN** the system SHALL navigate to the entry form with the type pre-set to "word" and the type picker hidden

#### Scenario: Fan-out FAB collapses on outside tap
- **WHEN** the fan-out FAB is expanded and the user taps anywhere outside the FAB buttons
- **THEN** the system SHALL animate the sub-buttons out of view and return to the collapsed FAB state

### Requirement: Type-Specific FAB on Category Tabs
The system SHALL display a simple floating action button on each category tab (Words, Phrases, Idioms, Quotes). The button SHALL be labelled with the tab's entry type (e.g. "Add Word" on the Words tab). Tapping it SHALL open the entry form with that type pre-selected.

#### Scenario: Words tab FAB opens pre-typed form
- **WHEN** the user taps the FAB on the Words tab
- **THEN** the system SHALL navigate to the entry form with type pre-set to "word" and the type picker hidden

#### Scenario: Idioms tab FAB opens pre-typed form
- **WHEN** the user taps the FAB on the Idioms tab
- **THEN** the system SHALL navigate to the entry form with type pre-set to "idiom" and the type picker hidden

### Requirement: Entry Form Hides Type Picker When Pre-Selected
The system SHALL hide the entry type picker in the entry form when the form is launched with a pre-selected type via the `type` query parameter. The type picker SHALL remain visible when the form is opened without a pre-selected type (e.g. from a future generic "add" shortcut).

#### Scenario: Type picker hidden when type pre-selected
- **WHEN** the entry form is opened with query parameter `?type=phrase`
- **THEN** the system SHALL set the selected type to "phrase" and SHALL NOT display the type selection UI

#### Scenario: Type picker visible when no type provided
- **WHEN** the entry form is opened without a `type` query parameter
- **THEN** the system SHALL display the type selection UI so the user can choose the entry type

