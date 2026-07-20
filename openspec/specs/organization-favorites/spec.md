# organization-favorites Specification

## Purpose
TBD - created by archiving change create-mylexicon. Update Purpose after archive.
## Requirements
### Requirement: Manage Collections
The system SHALL allow users to create, view, rename, and delete custom collections to group lexicon entries.

#### Scenario: Create a Collection
- **WHEN** the user creates a new collection with the name "GRE Vocabulary"
- **THEN** the system SHALL save the collection in local storage and make it available for entry assignment

#### Scenario: Assign Entry to Collection
- **WHEN** the user assigns an entry to "GRE Vocabulary"
- **THEN** the system SHALL update the entry's collection association in the database

### Requirement: Categorize Entries by Tags
The system SHALL support adding multiple text tags to lexicon entries and filtering entries based on a selected tag.

#### Scenario: Add Tags to Entry
- **WHEN** the user adds tags "adjective" and "literary" to an entry and saves
- **THEN** the system SHALL store these tags with the entry and update the tag index

#### Scenario: Filter List by Tag
- **WHEN** the user clicks on the "literary" tag in the filter bar
- **THEN** the system SHALL display only entries that contain the "literary" tag

### Requirement: Toggle Favorite Status
The system SHALL allow users to favorite and unfavorite any lexicon entry, and filter their lexicon entries list to show only favorites.

#### Scenario: Toggle Favorite on Entry
- **WHEN** the user taps the favorite icon on an entry card
- **THEN** the system SHALL toggle the favorite status (true/false) in local storage and update the UI indicator

#### Scenario: Filter List by Favorites
- **WHEN** the user toggles the "Favorites Only" filter on the dashboard or list screen
- **THEN** the system SHALL display only favorited lexicon entries

