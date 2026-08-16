## ADDED Requirements

### Requirement: Global List Density Preference
The system SHALL provide a global display preference for list density that controls how much information is shown per entry in all entry list views. The density preference SHALL apply to: the Words list, Quotes list, Phrases list, Idioms list, and entries shown inside user-created Collection detail views. The preference SHALL be persisted across app sessions. The default density SHALL be Detailed, which preserves the current behaviour for existing users.

Density is a presentation-level concept. The specific fields rendered at each density level are determined per content type (Words, Quotes, Phrases, Idioms) rather than defined globally. Compact, Comfortable, and Detailed represent the amount of information and vertical space consumed, while each content type decides what information is appropriate at each level.

The three density levels SHALL be:

- **Compact**: Show only the minimum information necessary (primarily the term). Must provide a meaningful reduction in vertical space compared to other levels — not merely hiding the definition while keeping equivalent padding.
- **Comfortable**: Show the term plus a short piece of contextual information (e.g. a one-line definition). Balance between information density and vertical space.
- **Detailed**: Show all available entry information including definition, examples, and tags. This is the current/default behaviour.

The density setting SHALL NOT be configurable per content-type tab or per user-created Collection.

#### Scenario: Default density is Detailed on first launch
- **WHEN** a user opens the app for the first time or has no saved density preference
- **THEN** entry lists SHALL render using the Detailed density (current full-card behaviour)

#### Scenario: Compact density shows only the term
- **WHEN** the user selects Compact density
- **THEN** each entry in the Words list SHALL display only the word/term with minimal vertical padding

#### Scenario: Comfortable density shows term and short definition
- **WHEN** the user selects Comfortable density
- **THEN** each entry in the Words list SHALL display the word and a truncated one-line definition

#### Scenario: Density applies to collection detail view
- **WHEN** the user opens a user-created Collection and the density is set to Compact
- **THEN** entries in the collection detail view SHALL also render in Compact mode

#### Scenario: Density preference persists after app restart
- **WHEN** the user sets density to Compact and restarts the app
- **THEN** all entry lists SHALL still render in Compact density

#### Scenario: Density setting is accessible from Settings
- **WHEN** the user opens the Settings screen
- **THEN** a Display section SHALL be present containing a list density selector with Compact, Comfortable, and Detailed options and a short description for each
