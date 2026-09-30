// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navWords => 'Words';

  @override
  String get navPhrases => 'Phrases';

  @override
  String get navIdioms => 'Idioms';

  @override
  String get navQuotes => 'Quotes';

  @override
  String get navCollections => 'Collections';

  @override
  String get navSettings => 'Settings';

  @override
  String get appTitle => 'My Lexicon';

  @override
  String get yourLexiconStats => 'Your Lexicon Stats';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get recentEntries => 'Recent Entries';

  @override
  String get viewAll => 'View All';

  @override
  String get yourTags => 'Your Tags';

  @override
  String get searchTags => 'Search tags';

  @override
  String get yourLexiconIsEmpty => 'Your Lexicon is Empty';

  @override
  String get emptyStateDescription =>
      'Start adding your favorite words and phrases.';

  @override
  String get addFirstEntry => 'Add First Entry';

  @override
  String get favorites => 'Favorites';

  @override
  String get typeWord => 'Word';

  @override
  String get typeQuote => 'Quote';

  @override
  String get typePhrase => 'Phrase';

  @override
  String get typeIdiom => 'Idiom';

  @override
  String get typeWords => 'Words';

  @override
  String get typeQuotes => 'Quotes';

  @override
  String get typePhrases => 'Phrases';

  @override
  String get typeIdioms => 'Idioms';

  @override
  String get searchAndFilter => 'Search & Filter';

  @override
  String get searchHint => 'Search terms, definitions...';

  @override
  String get reset => 'Reset';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get searchTitle => 'Search';

  @override
  String get addEntry => 'Add Entry';

  @override
  String get addWord => 'Add Word';

  @override
  String get addPhrase => 'Add Phrase';

  @override
  String get addIdiom => 'Add Idiom';

  @override
  String get addQuote => 'Add Quote';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get saveTooltip => 'Save';

  @override
  String get termLabel => 'Term';

  @override
  String get termHint => 'Enter the term';

  @override
  String get definitionLabel => 'Definition';

  @override
  String get definitionHint => 'Enter the definition';

  @override
  String get exampleLabel => 'Example';

  @override
  String get exampleHint => 'Enter an example';

  @override
  String get notesHint => 'Enter any additional notes';

  @override
  String get addExample => 'Add Example';

  @override
  String get removeExampleTooltip => 'Remove Example';

  @override
  String get selectCollection => 'Select Collection';

  @override
  String get markAsFavorite => 'Mark as Favorite';

  @override
  String get markAsFavoriteSubtitle => 'Easily access this entry later.';

  @override
  String get tagInputHint => 'Add a tag...';

  @override
  String get entryCreatedSuccess => 'Entry created successfully';

  @override
  String get entryUpdatedSuccess => 'Entry updated successfully';

  @override
  String duplicateTermError(String type) {
    return 'This $type already exists';
  }

  @override
  String get entryNotFound => 'Entry not found';

  @override
  String get entryDetails => 'Entry Details';

  @override
  String get editTooltip => 'Edit';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get favoriteTooltip => 'Favorite';

  @override
  String get unfavoriteTooltip => 'Unfavorite';

  @override
  String get deleteEntryTitle => 'Delete Entry?';

  @override
  String deleteEntryContent(String term) {
    return 'Are you sure you want to delete \"$term\"? This cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteSuccess => 'Deleted successfully';

  @override
  String deleteError(String error) {
    return 'Failed to delete: $error';
  }

  @override
  String failedToUpdateFavorite(String error) {
    return 'Failed to update favorite status: $error';
  }

  @override
  String get contextAndMeaning => 'Context & Meaning';

  @override
  String get meaningAndInterpretation => 'Meaning & Interpretation';

  @override
  String get sourceContext => 'Source Context';

  @override
  String get examples => 'Examples';

  @override
  String get exampleUsage => 'Example Usage';

  @override
  String get personalNotes => 'Personal Notes';

  @override
  String storedOn(String date) {
    return 'Stored on $date';
  }

  @override
  String get shareEntry => 'Share Entry';

  @override
  String get copyEntry => 'Copy Entry';

  @override
  String get uncategorized => 'Uncategorized';

  @override
  String get cancelTooltip => 'Cancel';

  @override
  String get toggleSelectAllTooltip => 'Toggle Select All';

  @override
  String get deleteSelectedTooltip => 'Delete Selected';

  @override
  String get selectItemsTooltip => 'Select Items';

  @override
  String get sortOrderTooltip => 'Sort Order';

  @override
  String get sortNewestFirst => 'Newest First';

  @override
  String get sortOldestFirst => 'Oldest First';

  @override
  String get sortAtoZ => 'A to Z';

  @override
  String get sortZtoA => 'Z to A';

  @override
  String deleteItemsTitle(int count, String label) {
    return 'Delete $count $label?';
  }

  @override
  String deleteItemsContent(int count, String label) {
    return 'Are you sure you want to delete the selected $count $label? This cannot be undone.';
  }

  @override
  String deletedSuccess(int count) {
    return '$count items deleted successfully';
  }

  @override
  String get collections => 'Collections';

  @override
  String get addCollection => 'Add Collection';

  @override
  String get editCollection => 'Edit Collection';

  @override
  String get collectionName => 'Collection Name';

  @override
  String get collectionNameHint => 'Enter collection name';

  @override
  String get collectionDescription => 'Collection Description';

  @override
  String get collectionDescriptionHint => 'Enter collection description';

  @override
  String get save => 'Save';

  @override
  String get collectionCreated => 'Collection created successfully';

  @override
  String get collectionUpdated => 'Collection updated successfully';

  @override
  String get collectionDeleted => 'Collection deleted successfully';

  @override
  String deleteCollectionTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get deleteCollectionContent =>
      'Are you sure you want to delete this collection? Its entries will not be deleted, but they will be removed from this collection.';

  @override
  String get editCollectionTooltip => 'Edit Collection';

  @override
  String get deleteCollectionTooltip => 'Delete Collection';

  @override
  String entriesCount(int count) {
    return '$count entries';
  }

  @override
  String get noCollections => 'No Collections';

  @override
  String get noCollectionsDescription =>
      'Create a collection to organize your entries.';

  @override
  String get importPreview => 'Import Preview';

  @override
  String get entriesDetected => 'Entries detected';

  @override
  String get collectionsDetected => 'Collections detected';

  @override
  String get potentialDuplicates => 'Potential duplicates';

  @override
  String get resolutionStrategy => 'Resolution Strategy';

  @override
  String get skipDuplicates => 'Skip Duplicates';

  @override
  String get overwriteDuplicates => 'Overwrite Duplicates';

  @override
  String get mergeDuplicates => 'Merge Duplicates';

  @override
  String get duplicateMatches => 'Duplicate Matches';

  @override
  String get previewContent => 'Preview Content';

  @override
  String rawContentLength(int length) {
    return '$length chars';
  }

  @override
  String get importNow => 'Import Now';

  @override
  String get importing => 'Importing...';

  @override
  String importFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String existingEntry(String term, String type) {
    return '$term ($type)';
  }

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceSubtitle => 'Theme, typography, layout';

  @override
  String get navigationAndFeatures => 'Navigation & Features';

  @override
  String get navigationSubtitle => 'Tabs, startup screen';

  @override
  String get tags => 'Tags';

  @override
  String get tagsSubtitle => 'Manage your tags';

  @override
  String get data => 'Data';

  @override
  String get dataSubtitle => 'Import, export, sample data';

  @override
  String get about => 'About';

  @override
  String get aboutSubtitle => 'Version, licenses, links';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Change app language';

  @override
  String get theme => 'Theme';

  @override
  String get pureBlack => 'Pure black (AMOLED)';

  @override
  String get pureBlackSubtitle => 'Uses pure black for dark theme';

  @override
  String get viewOptions => 'View Options';

  @override
  String get displayDensity => 'Display density';

  @override
  String get compact => 'Compact';

  @override
  String get compactDescription =>
      'Show term only with minimal vertical padding';

  @override
  String get comfortable => 'Comfortable';

  @override
  String get comfortableDescription =>
      'Show term and a short one-line definition';

  @override
  String get detailed => 'Detailed';

  @override
  String get detailedDescription =>
      'Show full details including examples and tags';

  @override
  String get showTagsOnCards => 'Show tags on cards';

  @override
  String get showTagsSubtitle => 'Display entry tags in lists';

  @override
  String get showTypeBadges => 'Show type badges';

  @override
  String get showTypeBadgesSubtitle => 'Show entry type icons';

  @override
  String get typography => 'Typography';

  @override
  String get fontStyle => 'Font style';

  @override
  String get system => 'System';

  @override
  String get systemFontDescription => 'Default system font';

  @override
  String get serif => 'Serif (Literary)';

  @override
  String get serifDescription => 'Classic serif font for reading';

  @override
  String get monospace => 'Monospace';

  @override
  String get monospaceDescription => 'Fixed-width font';

  @override
  String get textSize => 'Text size';

  @override
  String get small => 'Small';

  @override
  String get smallDescription => 'Smaller text';

  @override
  String get defaultSize => 'Default';

  @override
  String get defaultSizeDescription => 'Standard text size';

  @override
  String get large => 'Large';

  @override
  String get largeDescription => 'Larger text';

  @override
  String get extraLarge => 'Extra Large';

  @override
  String get extraLargeDescription => 'Maximum text size';

  @override
  String get defaultLaunchScreen => 'Default Launch Screen';

  @override
  String get defaultLaunchScreenSubtitle =>
      'Choose what to see when the app starts';

  @override
  String get screenShownWhen => 'Screen shown when';

  @override
  String get chooseStartingScreen => 'Choose your starting screen';

  @override
  String get navigationTabOrder => 'Navigation Tab Order';

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get disabled => 'Disabled';

  @override
  String get categoryAndFeatureToggles => 'Category & Feature Toggles';

  @override
  String activeFeatures(int enabled, int total) {
    return '$enabled of $total active';
  }

  @override
  String get atLeastOneCategory => 'At least one category must remain enabled';

  @override
  String get navigationSegment => 'Navigation';

  @override
  String get featuresSegment => 'Features';

  @override
  String get featureWordSubtitle => 'Manage your vocabulary';

  @override
  String get featureIdiomSubtitle => 'Save common expressions';

  @override
  String get featurePhraseSubtitle => 'Store useful phrases';

  @override
  String get featureQuoteSubtitle => 'Keep inspiring quotes';

  @override
  String get featureCollectionsSubtitle => 'Organize into collections';

  @override
  String get newTagName => 'New tag name';

  @override
  String get renameTag => 'Rename Tag';

  @override
  String get renameTagTooltip => 'Rename Tag';

  @override
  String get deleteTagTooltip => 'Delete Tag';

  @override
  String get tagRenamed => 'Tag renamed successfully';

  @override
  String tagRenameError(String error) {
    return 'Error renaming tag: $error';
  }

  @override
  String get tagDeleted => 'Tag deleted successfully';

  @override
  String tagDeleteError(String error) {
    return 'Error deleting tag: $error';
  }

  @override
  String get noTags => 'No Tags';

  @override
  String get noTagsDescription => 'Tags you create will appear here.';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportDataSubtitle => 'Save to JSON or CSV';

  @override
  String get importData => 'Import Data';

  @override
  String get importDataSubtitle => 'Load from file';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get clearAllDataSubtitle => 'Delete everything';

  @override
  String get loadSampleData => 'Load Sample Data';

  @override
  String get loadSampleDataSubtitle => 'Add starter content';

  @override
  String get deleteSampleData => 'Delete Sample Data';

  @override
  String get deleteSampleDataSubtitle => 'Remove sample content';

  @override
  String get clearAllDataTitle => 'Clear All Data?';

  @override
  String get clearAllDataContent =>
      'Are you sure you want to delete all entries and collections? This cannot be undone.';

  @override
  String get loadSampleDataTitle => 'Load Sample Data?';

  @override
  String get loadSampleDataContent =>
      'This will add sample entries and collections to your database.';

  @override
  String get deleteSampleDataTitle => 'Delete Sample Data?';

  @override
  String get deleteSampleDataContent =>
      'This will remove all sample entries and collections from your database.';

  @override
  String get exportDataTitle => 'Export Data';

  @override
  String get exportJson => 'Export JSON';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get exportSuccess => 'Data exported successfully';

  @override
  String exportError(String error) {
    return 'Failed to export: $error';
  }

  @override
  String importSuccess(int count) {
    return 'Successfully imported $count items';
  }

  @override
  String importError(String error) {
    return 'Failed to import: $error';
  }

  @override
  String get clearSuccess => 'Data cleared successfully';

  @override
  String get sampleDataLoaded => 'Sample data loaded';

  @override
  String get sampleDataDeleted => 'Sample data deleted';

  @override
  String sampleDataDeleteError(String error) {
    return 'Error deleting sample data: $error';
  }

  @override
  String get sourceCode => 'Source Code';

  @override
  String get sourceCodeSubtitle => 'View project on GitHub';

  @override
  String get reportBug => 'Report Bug';

  @override
  String get reportBugSubtitle => 'Create an issue on GitHub';

  @override
  String get starOnGithub => 'Star on GitHub';

  @override
  String get starOnGithubSubtitle => 'Show your support';

  @override
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String versionCopied(String version) {
    return 'Version $version copied to clipboard';
  }

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get english => 'English';

  @override
  String get ukrainian => 'Українська (Ukrainian)';

  @override
  String get russian => 'Русский (Russian)';

  @override
  String get persian => 'فارسی (Persian)';

  @override
  String get hindi => 'हिन्दी (Hindi)';

  @override
  String errorLoadingEntries(String error) {
    return 'Error loading entries: $error';
  }

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get addNewEntry => 'Add New Entry';

  @override
  String get quoteText => 'Quote Text';

  @override
  String get meaningOrDefinition => 'Meaning / Definition';

  @override
  String get quoteContextMeaningNotes => 'Context / Meaning / Author Notes';

  @override
  String get meaningOrTranslation => 'Meaning / Translation';

  @override
  String get meaningOrOrigin => 'Meaning / Origin';

  @override
  String get selectEntryType => 'Select Entry Type';

  @override
  String enterFieldHint(String field) {
    return 'Enter $field...';
  }

  @override
  String fieldCannotBeEmpty(String field) {
    return '$field cannot be empty';
  }

  @override
  String get exampleSentences => 'Example Sentences';

  @override
  String get quoteSourceExample => 'e.g. Shakespeare - Hamlet, Act III';

  @override
  String exampleNth(int number) {
    return 'Example $number...';
  }

  @override
  String get personalNotesOptional => 'Personal Notes (Optional)';

  @override
  String get personalNotesHint =>
      'Add personal notes, memory triggers, or references...';

  @override
  String get collectionOptional => 'Collection (Optional)';

  @override
  String get selectCollectionHint => 'Select a collection...';

  @override
  String get noneCollection => 'None';

  @override
  String errorLoadingCollections(String error) {
    return 'Error loading collections: $error';
  }

  @override
  String get noTagsAddedYet => 'No tags added yet';

  @override
  String get updateEntry => 'Update Entry';

  @override
  String get saveEntry => 'Save Entry';
}
