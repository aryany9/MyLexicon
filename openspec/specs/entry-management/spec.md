# entry-management Specification

## Purpose
TBD - created by archiving change create-mylexicon. Update Purpose after archive.

## Requirements

### Requirement: Create Lexicon Entry
The system SHALL allow users to create a lexicon entry with a selected type (word, quote, phrase, idiom), term/text, definition/meaning, up to 5 optional example sentences, personal notes, tags, and collections. The entry type picker SHALL only be shown in the entry form when no type is pre-selected via the launch context. The system SHALL provide real-time duplicate term detection warnings when the entered term matches an existing entry.

#### Scenario: Create Valid Entry
- **WHEN** the user selects the type "word", enters term "Serendipity" and definition "The occurrence of events by chance in a happy or beneficial way", and saves the entry
- **THEN** the system SHALL save the entry to local storage and display it in the list

#### Scenario: Real-time Inline Duplicate Warning Triggered
- **WHEN** the user types a term that already exists in the database
- **THEN** the system SHALL immediately display a warning indicating the term is a duplicate, without preventing the user from continuing or saving

#### Scenario: Create Entry Without Required Term
- **WHEN** the user tries to save an entry without entering the term/text
- **THEN** the system SHALL display a validation error message and prevent saving

#### Scenario: Create Entry With Multiple Examples
- **WHEN** the user adds 3 example sentences and saves the entry
- **THEN** the system SHALL save all 3 examples and display them on the entry detail screen

#### Scenario: Example count limit enforced
- **WHEN** the user already has 5 example sentences in the form
- **THEN** the system SHALL disable or hide the "Add Example" button, preventing a 6th example from being added

### Requirement: Read/View Lexicon Entry
The system SHALL display all attributes of a saved lexicon entry, including type, term, definition/meaning, all example sentences (as a numbered list), personal notes, tags, collections, favorite status, and created timestamp.

#### Scenario: View Entry Details
- **WHEN** the user taps on a lexicon entry in any list view
- **THEN** the system SHALL open the detail screen showing all attributes of that specific entry

#### Scenario: View Multiple Examples
- **WHEN** a lexicon entry has 3 saved example sentences
- **THEN** the system SHALL display all 3 examples as a numbered list on the entry detail screen

### Requirement: Update Lexicon Entry
The system SHALL allow users to modify any field of an existing lexicon entry, including adding, editing, or removing individual example sentences, and save the changes to local storage.

#### Scenario: Edit Entry and Save
- **WHEN** the user edits the definition of a word entry and taps the save button
- **THEN** the system SHALL update the entry in the local database and show the updated details

#### Scenario: Remove an Example From Entry
- **WHEN** the user removes one of 3 existing example sentences and saves
- **THEN** the system SHALL save the entry with 2 example sentences

### Requirement: Delete Lexicon Entry
The system SHALL allow users to permanently delete a lexicon entry after confirming their intention.

#### Scenario: Delete Entry Confirmed
- **WHEN** the user taps the delete action on an entry and confirms the deletion dialog
- **THEN** the system SHALL remove the entry from local storage and return the user to the list screen
