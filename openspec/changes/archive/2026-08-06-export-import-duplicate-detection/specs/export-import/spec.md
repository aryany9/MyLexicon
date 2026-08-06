# export-import Specification

## ADDED Requirements

### Requirement: Full Database Export to JSON
The system SHALL allow users to export the entire lexicon database (entries, collections, tags, and metadata) into a structured JSON file.

#### Scenario: User exports database to JSON
- **WHEN** the user selects "Export Data" in Settings and picks JSON format
- **THEN** the system SHALL generate a complete JSON file containing all collections and entries and trigger system file saving or sharing.

### Requirement: Database Export to CSV
The system SHALL allow users to export lexicon entries into a CSV format compatible with external spreadsheet applications.

#### Scenario: User exports entries to CSV
- **WHEN** the user selects "Export Data" in Settings and picks CSV format
- **THEN** the system SHALL generate a formatted CSV file containing id, term, definition, type, tags, examples, collectionName, and favorite status.

### Requirement: Pre-Import File Selection and Preview
The system SHALL parse a selected JSON or CSV import file and render a Pre-Import Preview Screen displaying summary statistics and detected duplicates before writing to local database storage.

#### Scenario: User selects file for import
- **WHEN** the user picks a valid JSON or CSV file to import
- **THEN** the system SHALL navigate to the Pre-Import Preview Screen showing total entries count, total collections count, and detected duplicate count.

#### Scenario: Invalid file format selected
- **WHEN** the user picks an unparseable or corrupted file
- **THEN** the system SHALL display an error message explaining the invalid file format and remain on the Settings screen.
