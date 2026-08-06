# duplicate-detection Specification

## ADDED Requirements

### Requirement: Import Conflict Resolution Strategy Selection
The system SHALL provide strategy options (`Skip`, `Overwrite`, `Merge`) on the Pre-Import Preview Screen to determine how duplicate entries are handled.

#### Scenario: User selects Skip strategy
- **WHEN** the user selects the "Skip" resolution strategy and confirms import
- **THEN** the system SHALL insert only new entries into local storage and leave existing duplicate entries untouched.

#### Scenario: User selects Overwrite strategy
- **WHEN** the user selects the "Overwrite" resolution strategy and confirms import
- **THEN** the system SHALL replace existing entries matching the incoming term and type with the imported entry data.

#### Scenario: User selects Merge strategy
- **WHEN** the user selects the "Merge" resolution strategy and confirms import
- **THEN** the system SHALL retain existing entries, append new non-duplicate example sentences, and merge tag sets.
