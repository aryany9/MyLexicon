## MODIFIED Requirements

### Requirement: Database Export to CSV
The system SHALL allow users to export their lexicon entries to a CSV file format to enable easy viewing and basic editing in spreadsheet applications. The CSV export SHALL include a collection name column that records the name of any collection the entry belongs to. CSV is considered a spreadsheet-friendly data exchange format and is NOT a complete backup format; collection metadata beyond the name (color, description, creation date) and empty collections (containing no entries) are not guaranteed to be preserved through a CSV round-trip. JSON SHALL remain the format for complete backup and restoration.

#### Scenario: CSV export includes collection names
- **WHEN** the user exports their lexicon to CSV and an entry belongs to a collection
- **THEN** the exported CSV row SHALL include the collection name in the collectionName column

### Requirement: CSV Import Preserves Collection Membership
The system SHALL correctly restore collection membership when importing from a CSV file. During CSV import, the system SHALL extract all unique collection names from the CSV rows and resolve each name against the existing database. If a collection with that name already exists (case-insensitive match), the system SHALL reuse the existing collection. If no matching collection exists, the system SHALL create a new collection using the name from the CSV and default values for all other metadata (color, description, createdAt). Imported entries SHALL be assigned to the resolved collection IDs. The import preview SHALL show the number of collections that will be created or reused.

#### Scenario: CSV import with existing collection reuses it
- **WHEN** the user imports a CSV file containing entries assigned to "English" and a collection named "English" already exists in the database
- **THEN** the imported entries SHALL be assigned to the existing "English" collection and no duplicate collection SHALL be created

#### Scenario: CSV import creates missing collection
- **WHEN** the user imports a CSV file containing entries assigned to "German Phrases" and no such collection exists in the database
- **THEN** the system SHALL create a new "German Phrases" collection with default metadata and assign the imported entries to it

#### Scenario: CSV import preview shows collections
- **WHEN** the user selects a CSV file for import containing entries from two collections
- **THEN** the import preview SHALL indicate the collections involved (new or existing) rather than showing zero collections

#### Scenario: CSV export followed by CSV import preserves collection membership
- **WHEN** the user exports their lexicon to CSV and then imports that CSV into a clean database
- **THEN** each imported entry SHALL belong to the same collection it was in before the export

#### Scenario: Empty collections are not reconstructed from CSV
- **WHEN** the user imports a CSV file and a collection that existed in the source database had no entries
- **THEN** that empty collection SHALL NOT appear in the imported database (accepted limitation of CSV format)

### Requirement: Pre-Import File Selection and Preview
The system SHALL allow users to select a JSON backup file or CSV file for import and display a summary of its contents (e.g., number of entries, collections) before proceeding with the import process.

#### Scenario: Preview shows entry and collection counts for CSV
- **WHEN** the user selects a CSV file for import
- **THEN** the preview SHALL display the number of entries and the number of collections (new or reused) that will result from the import
