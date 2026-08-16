## MODIFIED Requirements

### Requirement: Import Conflict Resolution Strategy Selection
The system SHALL prompt the user to select a conflict resolution strategy (e.g., Skip, Replace, Merge) when importing data that contains entries already existing in the local database. During import, two entries are considered duplicates if they have the same normalized term and the same type AND their collection memberships overlap. Entries are NOT considered duplicates solely because they share the same term across different collections.

#### Scenario: Import duplicate detected when collections overlap
- **WHEN** the user imports an entry with term "ephemeral", type "word", collection "English" and an entry with the same term and type already exists in collection "English"
- **THEN** the system SHALL detect a duplicate and apply the selected conflict resolution strategy

#### Scenario: Import allows same term in different collections
- **WHEN** the user imports an entry with term "ephemeral", type "word", collection "Native Language" and an entry with the same term and type already exists only in collection "English"
- **THEN** the system SHALL NOT treat this as a duplicate and SHALL import the entry as a new entry

### Requirement: Collection-Aware Entry Creation Duplicate Check
The system SHALL prevent saving a new or edited entry when it is a duplicate of an existing entry in the same collection. Two entries are duplicates if: their normalized terms are equal, their types are equal, AND their collection memberships overlap (they share at least one collection ID). If both the new and existing entry have no collection membership, they SHALL be considered duplicates. If one entry has collection membership and the other does not, they SHALL NOT be considered duplicates.

The duplicate check SHALL occur at save time (when the user presses Save Entry), after the target collection has been selected. The system SHALL NOT perform a real-time duplicate check while the user is typing the term before a collection has been chosen.

When a duplicate is detected at save time, the system SHALL abort the save, display an inline warning identifying the duplicate entry and the collection in which it exists, and provide a way to navigate to the existing entry.

#### Scenario: Same term and type in same collection is rejected
- **WHEN** the user enters term "ephemeral" with type "word", selects collection "English", and presses Save Entry, and an entry "ephemeral" (word) already exists in collection "English"
- **THEN** the system SHALL abort the save and display a duplicate warning identifying the existing entry and the collection "English"

#### Scenario: Same term and type in different collections is allowed
- **WHEN** the user enters term "ephemeral" with type "word", selects collection "Native Language", and presses Save Entry, and an entry "ephemeral" (word) exists only in collection "English"
- **THEN** the system SHALL save the entry successfully without any duplicate warning

#### Scenario: Same term with different type is always allowed
- **WHEN** the user enters term "ephemeral" with type "quote", selects any collection, and presses Save Entry, and an entry "ephemeral" (word) exists in any collection
- **THEN** the system SHALL save the entry successfully without any duplicate warning

#### Scenario: Both unassigned entries with same term and type are rejected
- **WHEN** the user enters term "ephemeral" with type "word", selects no collection, and presses Save Entry, and an entry "ephemeral" (word) already exists with no collection
- **THEN** the system SHALL abort the save and display a duplicate warning for the unassigned entry

#### Scenario: One assigned one unassigned same term is allowed
- **WHEN** the user enters term "ephemeral" with type "word", selects no collection, and presses Save Entry, and an entry "ephemeral" (word) already exists in collection "English"
- **THEN** the system SHALL save the entry successfully without any duplicate warning

#### Scenario: Duplicate warning names the conflicting collection
- **WHEN** a duplicate is detected at save time and the existing duplicate entry belongs to collection "English"
- **THEN** the duplicate warning SHALL state that the entry already exists in "English"

#### Scenario: View Existing Entry is accessible from duplicate warning
- **WHEN** a duplicate warning is displayed after a failed save attempt
- **THEN** the warning SHALL include a button or link that navigates the user to the existing duplicate entry's detail screen
