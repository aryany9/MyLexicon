## ADDED Requirements

### Requirement: Per-Tab Entry Sort Preference
The system SHALL provide a sort preference for each content-type tab (Words, Quotes, Phrases, Idioms) independently. The sort preference SHALL be persisted across app sessions. The sort SHALL NOT apply to the collection detail view or the search screen. The available sort orders SHALL be: Newest First (default), Oldest First, A–Z (alphabetical ascending by term), and Z–A (alphabetical descending by term).

#### Scenario: Default sort is Newest First on first launch
- **WHEN** a user opens the app for the first time or has no saved sort preference
- **THEN** entries in every content-type tab SHALL be sorted newest first (most recently created at the top)

#### Scenario: User changes sort order to A–Z on the Words tab
- **WHEN** the user opens the Words tab and selects "A–Z" from the sort menu in the AppBar
- **THEN** the Words list SHALL immediately re-sort alphabetically ascending by term

#### Scenario: Sort preference persists after app restart
- **WHEN** the user sets the Quotes tab sort to "Oldest First" and restarts the app
- **THEN** the Quotes tab SHALL still display entries sorted oldest first

#### Scenario: Sort preferences are independent per tab
- **WHEN** the user sets Words to "A–Z" and Quotes to "Newest First"
- **THEN** the Words tab SHALL show entries A–Z and the Quotes tab SHALL show entries newest first simultaneously

#### Scenario: Collection detail view is unaffected by tab sort preference
- **WHEN** the user opens a user-created Collection detail view
- **THEN** entries SHALL be displayed in the default sort order (newest first) regardless of any per-tab sort preference

#### Scenario: Search screen is unaffected by tab sort preference
- **WHEN** the user opens the search screen and searches for a term
- **THEN** search results SHALL not have a sort control and SHALL use the default sort order
