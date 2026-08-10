## MODIFIED Requirements

### Requirement: Create Lexicon Entry
The system SHALL allow users to create a lexicon entry with a selected type (word, quote, phrase, idiom), term/text, definition/meaning, up to 5 optional example sentences, personal notes, tags, and collections. The entry type picker SHALL only be shown in the entry form when no type is pre-selected via the launch context. The system SHALL perform a collection-aware duplicate check when the user saves the entry, after a collection has been selected, and SHALL display a warning if a duplicate is found in the same collection. The system SHALL NOT perform a real-time duplicate check while the user is typing the term.

#### Scenario: Create Valid Entry
- **WHEN** the user selects the type "word", enters term "Serendipity" and definition "The occurrence of events by chance in a happy or beneficial way", and saves the entry
- **THEN** the system SHALL save the entry to local storage and display it in the list

#### Scenario: Duplicate check runs at save time not while typing
- **WHEN** the user types a term that already exists in the database but has not yet pressed Save Entry
- **THEN** the system SHALL NOT display any duplicate warning

#### Scenario: Duplicate detected at save shows inline warning
- **WHEN** the user presses Save Entry and the entered term, type, and selected collection match an existing entry
- **THEN** the system SHALL abort the save and display an inline duplicate warning with the collection name and a link to the existing entry

#### Scenario: Create Entry Without Required Term
- **WHEN** the user tries to save an entry without entering the term/text
- **THEN** the system SHALL display a validation error message and prevent saving

#### Scenario: Create Entry With Multiple Examples
- **WHEN** the user adds 3 example sentences and saves the entry
- **THEN** the system SHALL save all 3 examples and display them on the entry detail screen

#### Scenario: Example count limit enforced
- **WHEN** the user already has 5 example sentences in the form
- **THEN** the system SHALL disable or hide the "Add Example" button, preventing a 6th example from being added
