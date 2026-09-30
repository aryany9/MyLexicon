## ADDED Requirements

### Requirement: Application Localization Infrastructure
The application SHALL support runtime localization via Flutter's official `flutter_localizations` and code-generated `AppLocalizations` delegates.

#### Scenario: Fallback to English when string missing
- **WHEN** an entry key is not translated in a specific locale
- **THEN** the system SHALL fall back to displaying the English string from `app_en.arb`

#### Scenario: System locale detection
- **WHEN** the user launches the app with locale preference set to "System Default"
- **THEN** the system SHALL adopt the device's system language if supported, or fall back to English if unsupported

### Requirement: Language Selection and Persistence
The application SHALL allow the user to select an active language or choose the system default, persisting this selection in `SharedPreferences`.

#### Scenario: User changes language in settings
- **WHEN** the user selects a supported language from the Language settings page
- **THEN** the application SHALL immediately update the interface language without requiring an app restart
- **THEN** the selected locale SHALL be persisted in local storage

#### Scenario: User selects system default
- **WHEN** the user selects "System Default" from the Language settings page
- **THEN** the application SHALL dynamically match the operating system's locale

### Requirement: Supported Initial Languages
The application SHALL provide complete translated UI strings for English (`en`), Ukrainian (`uk`), Russian (`ru`), Persian (`fa`), and Hindi (`hi`).

#### Scenario: Interface rendered in Ukrainian
- **WHEN** the active locale is Ukrainian (`uk`)
- **THEN** navigation tabs, dashboard sections, entry form fields, and action buttons SHALL display in Ukrainian Cyrillic

#### Scenario: Interface rendered in Russian
- **WHEN** the active locale is Russian (`ru`)
- **THEN** navigation tabs, dashboard sections, entry form fields, and action buttons SHALL display in Russian Cyrillic

#### Scenario: Interface rendered in Persian
- **WHEN** the active locale is Persian (`fa`)
- **THEN** navigation tabs, dashboard sections, entry form fields, and action buttons SHALL display in Persian Perso-Arabic script

#### Scenario: Interface rendered in Hindi
- **WHEN** the active locale is Hindi (`hi`)
- **THEN** navigation tabs, dashboard sections, entry form fields, and action buttons SHALL display in Hindi Devanagari script

### Requirement: Right-to-Left (RTL) Layout Adaptation
When the active language is Persian (`fa`), the application SHALL render the user interface using Right-to-Left directionality.

#### Scenario: Persian RTL layout positioning
- **WHEN** Persian (`fa`) is selected
- **THEN** the app directionality SHALL be set to `TextDirection.rtl`
- **THEN** `FanOutFab` and contextual floating action buttons SHALL align and expand from the start corner appropriately
- **THEN** list tiles, app bar titles, and content alignment SHALL follow RTL conventions

### Requirement: Language Settings Screen
The application SHALL provide a dedicated `LanguageSettingsPage` accessible from the root Settings screen.

#### Scenario: Navigating to Language settings
- **WHEN** the user taps the "Language" list tile on the Settings screen
- **THEN** the application SHALL push the `LanguageSettingsPage` onto the inner navigation stack
- **THEN** the language list SHALL display each supported language option showing its native endonym (e.g. "हिन्दी (Hindi)") and a radio selection indicator

#### Scenario: Back navigation from Language settings
- **WHEN** the user performs a back gesture or taps the back button on `LanguageSettingsPage`
- **THEN** the page SHALL pop back to the root Settings screen without exiting to the dashboard or home

### Requirement: Localized Feedback Messages (SnackBars and Dialogs)
All user-facing feedback messages displayed via `SnackBar`, confirmation dialogs, and error banners SHALL be localized through `AppLocalizations` and SHALL NOT contain hardcoded English strings.

#### Scenario: SnackBar after data export
- **WHEN** the user triggers a data export action in `DataSettingsPage`
- **THEN** the success or failure SnackBar message SHALL display in the currently active locale

#### Scenario: Feature toggle constraint message
- **WHEN** the user attempts to disable the last remaining enabled category in `NavigationSettingsPage`
- **THEN** the SnackBar warning (`'At least one category must remain enabled'`) SHALL display in the currently active locale

#### Scenario: Tag rename feedback
- **WHEN** the user renames or deletes a tag in `TagsSettingsPage`
- **THEN** the confirmation SnackBar SHALL display in the currently active locale

### Requirement: Locale-Aware Date Formatting
Entry creation dates displayed in the application SHALL use `DateFormat` with an explicit locale argument derived from the currently active `Locale`, so that month names and date ordering reflect the user's selected language.

#### Scenario: Date displayed in Ukrainian
- **WHEN** the active locale is Ukrainian (`uk`) and the user views an entry's detail screen
- **THEN** the creation date SHALL display month names in Ukrainian (e.g. `вересень` for September) rather than English

#### Scenario: Date displayed in Persian
- **WHEN** the active locale is Persian (`fa`) and the user views an entry's detail screen
- **THEN** the creation date SHALL display month names in Persian script while retaining Western (`0-9`) digits for the day and year values

### Requirement: No Raw Enum Names in Localized UI
The application SHALL NOT display raw Dart enum identifiers (e.g. `word`, `quote`, `phrase`, `idiom` from `LexiconType.name`, or `duplicate.existingEntry.type.name`) as visible text to the user. All type labels rendered in cards, badges, import preview screens, and search filters SHALL use the localized label resolved via the `AppLocalizations` extension.

#### Scenario: Type badge on WordsCard in Hindi
- **WHEN** the active locale is Hindi (`hi`) and a word entry card is displayed
- **THEN** the type badge SHALL display the localized Hindi label (e.g. `शब्द`) and SHALL NOT display the raw English enum string `WORD`

#### Scenario: Import preview duplicate list in Russian
- **WHEN** the active locale is Russian (`ru`) and the import preview screen shows duplicate matches
- **THEN** the duplicate entry type label SHALL display in Russian Cyrillic and SHALL NOT display the raw English enum value `word`, `quote`, etc.

### Requirement: Localized Floating Action Buttons and Action Menus
The application SHALL localize all Floating Action Button (FAB) labels, fan-out action options, and interactive action tooltips across all supported languages without hardcoded English fallbacks.

#### Scenario: FanOutFab options rendered in target locale
- **WHEN** the user opens the `FanOutFab` on the home screen in a non-English locale (e.g. Hindi `hi` or Ukrainian `uk`)
- **THEN** the individual speed-dial options SHALL render localized labels (e.g. `शब्द जोड़ें`, `वाक्यांश जोड़ें` in Hindi; `Додати слово`, `Додати фразу` in Ukrainian)
- **THEN** the main FAB and close FAB tooltips SHALL render localized strings (`addEntry`, `cancel`)

#### Scenario: CategoryListScreen extended FAB label in target locale
- **WHEN** the user navigates to a category screen in any supported locale
- **THEN** the extended FAB label SHALL display the localized action phrase (e.g. `widget.type.localizedAdd(l10n)`) rather than an English string

### Requirement: Localized Entry Detail Sections and Metadata
The application's `EntryDetailScreen` SHALL render all semantic section headers, example usage indicators, personal notes headers, metadata timestamps, and favorite status error messages in the active locale.

#### Scenario: Section headers adapted to entry type in Russian
- **WHEN** the user views a quote or idiom entry detail in Russian (`ru`)
- **THEN** quotes SHALL display `Контекст и значение` (`contextAndMeaning`) and `Контекст источника` (`sourceContext`)
- **THEN** idioms SHALL display `Значение и толкование` (`meaningAndInterpretation`)
- **THEN** words and phrases SHALL display `Определение` (`definitionLabel`) and `Примеры` / `Пример использования`
- **THEN** personal notes SHALL display `Личные заметки` (`personalNotes`) and creation date SHALL display `Сохранено: <formattedDate>` (`storedOn`)

### Requirement: Localized Entry Form Screen
The application's `EntryFormScreen` SHALL localize all user-facing strings including AppBar titles, segmented button options, dynamic term/definition labels, input hints, validation error messages, examples/source context section labels, personal notes, collection selector dropdown, tags input/chips, favorite switch, and submission buttons.

#### Scenario: Form validation and type selection in non-English locale
- **WHEN** the user creates or edits an entry in a non-English locale (e.g. Russian `ru`)
- **THEN** the screen title SHALL display `Добавить новую запись` (`addNewEntry`) or `Редактировать запись` (`editEntry`)
- **THEN** type selector segments SHALL display localized types (`Слово`, `Цитата`, `Фраза`, `Идиома`)
- **THEN** form field validation errors on empty submission SHALL display localized messages (e.g. `Слово не может быть пустым`)
- **THEN** the save button SHALL display `Сохранить запись` (`saveEntry`) or `Обновить запись` (`updateEntry`)
