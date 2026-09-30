import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
    Locale('hi'),
    Locale('ru'),
    Locale('uk'),
  ];

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navWords.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get navWords;

  /// No description provided for @navPhrases.
  ///
  /// In en, this message translates to:
  /// **'Phrases'**
  String get navPhrases;

  /// No description provided for @navIdioms.
  ///
  /// In en, this message translates to:
  /// **'Idioms'**
  String get navIdioms;

  /// No description provided for @navQuotes.
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get navQuotes;

  /// No description provided for @navCollections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get navCollections;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'My Lexicon'**
  String get appTitle;

  /// No description provided for @yourLexiconStats.
  ///
  /// In en, this message translates to:
  /// **'Your Lexicon Stats'**
  String get yourLexiconStats;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @recentEntries.
  ///
  /// In en, this message translates to:
  /// **'Recent Entries'**
  String get recentEntries;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @yourTags.
  ///
  /// In en, this message translates to:
  /// **'Your Tags'**
  String get yourTags;

  /// No description provided for @searchTags.
  ///
  /// In en, this message translates to:
  /// **'Search tags'**
  String get searchTags;

  /// No description provided for @yourLexiconIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your Lexicon is Empty'**
  String get yourLexiconIsEmpty;

  /// No description provided for @emptyStateDescription.
  ///
  /// In en, this message translates to:
  /// **'Start adding your favorite words and phrases.'**
  String get emptyStateDescription;

  /// No description provided for @addFirstEntry.
  ///
  /// In en, this message translates to:
  /// **'Add First Entry'**
  String get addFirstEntry;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @typeWord.
  ///
  /// In en, this message translates to:
  /// **'Word'**
  String get typeWord;

  /// No description provided for @typeQuote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get typeQuote;

  /// No description provided for @typePhrase.
  ///
  /// In en, this message translates to:
  /// **'Phrase'**
  String get typePhrase;

  /// No description provided for @typeIdiom.
  ///
  /// In en, this message translates to:
  /// **'Idiom'**
  String get typeIdiom;

  /// No description provided for @typeWords.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get typeWords;

  /// No description provided for @typeQuotes.
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get typeQuotes;

  /// No description provided for @typePhrases.
  ///
  /// In en, this message translates to:
  /// **'Phrases'**
  String get typePhrases;

  /// No description provided for @typeIdioms.
  ///
  /// In en, this message translates to:
  /// **'Idioms'**
  String get typeIdioms;

  /// No description provided for @searchAndFilter.
  ///
  /// In en, this message translates to:
  /// **'Search & Filter'**
  String get searchAndFilter;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search terms, definitions...'**
  String get searchHint;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @addEntry.
  ///
  /// In en, this message translates to:
  /// **'Add Entry'**
  String get addEntry;

  /// No description provided for @addWord.
  ///
  /// In en, this message translates to:
  /// **'Add Word'**
  String get addWord;

  /// No description provided for @addPhrase.
  ///
  /// In en, this message translates to:
  /// **'Add Phrase'**
  String get addPhrase;

  /// No description provided for @addIdiom.
  ///
  /// In en, this message translates to:
  /// **'Add Idiom'**
  String get addIdiom;

  /// No description provided for @addQuote.
  ///
  /// In en, this message translates to:
  /// **'Add Quote'**
  String get addQuote;

  /// No description provided for @editEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit Entry'**
  String get editEntry;

  /// No description provided for @saveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveTooltip;

  /// No description provided for @termLabel.
  ///
  /// In en, this message translates to:
  /// **'Term'**
  String get termLabel;

  /// No description provided for @termHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the term'**
  String get termHint;

  /// No description provided for @definitionLabel.
  ///
  /// In en, this message translates to:
  /// **'Definition'**
  String get definitionLabel;

  /// No description provided for @definitionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the definition'**
  String get definitionHint;

  /// No description provided for @exampleLabel.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get exampleLabel;

  /// No description provided for @exampleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter an example'**
  String get exampleHint;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Enter any additional notes'**
  String get notesHint;

  /// No description provided for @addExample.
  ///
  /// In en, this message translates to:
  /// **'Add Example'**
  String get addExample;

  /// No description provided for @removeExampleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove Example'**
  String get removeExampleTooltip;

  /// No description provided for @selectCollection.
  ///
  /// In en, this message translates to:
  /// **'Select Collection'**
  String get selectCollection;

  /// No description provided for @markAsFavorite.
  ///
  /// In en, this message translates to:
  /// **'Mark as Favorite'**
  String get markAsFavorite;

  /// No description provided for @markAsFavoriteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Easily access this entry later.'**
  String get markAsFavoriteSubtitle;

  /// No description provided for @tagInputHint.
  ///
  /// In en, this message translates to:
  /// **'Add a tag...'**
  String get tagInputHint;

  /// No description provided for @entryCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Entry created successfully'**
  String get entryCreatedSuccess;

  /// No description provided for @entryUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Entry updated successfully'**
  String get entryUpdatedSuccess;

  /// No description provided for @duplicateTermError.
  ///
  /// In en, this message translates to:
  /// **'This {type} already exists'**
  String duplicateTermError(String type);

  /// No description provided for @entryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Entry not found'**
  String get entryNotFound;

  /// No description provided for @entryDetails.
  ///
  /// In en, this message translates to:
  /// **'Entry Details'**
  String get entryDetails;

  /// No description provided for @editTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editTooltip;

  /// No description provided for @deleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteTooltip;

  /// No description provided for @favoriteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favoriteTooltip;

  /// No description provided for @unfavoriteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get unfavoriteTooltip;

  /// No description provided for @deleteEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Entry?'**
  String get deleteEntryTitle;

  /// No description provided for @deleteEntryContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{term}\"? This cannot be undone.'**
  String deleteEntryContent(String term);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully'**
  String get deleteSuccess;

  /// No description provided for @deleteError.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete: {error}'**
  String deleteError(String error);

  /// No description provided for @failedToUpdateFavorite.
  ///
  /// In en, this message translates to:
  /// **'Failed to update favorite status: {error}'**
  String failedToUpdateFavorite(String error);

  /// No description provided for @contextAndMeaning.
  ///
  /// In en, this message translates to:
  /// **'Context & Meaning'**
  String get contextAndMeaning;

  /// No description provided for @meaningAndInterpretation.
  ///
  /// In en, this message translates to:
  /// **'Meaning & Interpretation'**
  String get meaningAndInterpretation;

  /// No description provided for @sourceContext.
  ///
  /// In en, this message translates to:
  /// **'Source Context'**
  String get sourceContext;

  /// No description provided for @examples.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get examples;

  /// No description provided for @exampleUsage.
  ///
  /// In en, this message translates to:
  /// **'Example Usage'**
  String get exampleUsage;

  /// No description provided for @personalNotes.
  ///
  /// In en, this message translates to:
  /// **'Personal Notes'**
  String get personalNotes;

  /// No description provided for @storedOn.
  ///
  /// In en, this message translates to:
  /// **'Stored on {date}'**
  String storedOn(String date);

  /// No description provided for @shareEntry.
  ///
  /// In en, this message translates to:
  /// **'Share Entry'**
  String get shareEntry;

  /// No description provided for @copyEntry.
  ///
  /// In en, this message translates to:
  /// **'Copy Entry'**
  String get copyEntry;

  /// No description provided for @uncategorized.
  ///
  /// In en, this message translates to:
  /// **'Uncategorized'**
  String get uncategorized;

  /// No description provided for @cancelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelTooltip;

  /// No description provided for @toggleSelectAllTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle Select All'**
  String get toggleSelectAllTooltip;

  /// No description provided for @deleteSelectedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected'**
  String get deleteSelectedTooltip;

  /// No description provided for @selectItemsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Select Items'**
  String get selectItemsTooltip;

  /// No description provided for @sortOrderTooltip.
  ///
  /// In en, this message translates to:
  /// **'Sort Order'**
  String get sortOrderTooltip;

  /// No description provided for @sortNewestFirst.
  ///
  /// In en, this message translates to:
  /// **'Newest First'**
  String get sortNewestFirst;

  /// No description provided for @sortOldestFirst.
  ///
  /// In en, this message translates to:
  /// **'Oldest First'**
  String get sortOldestFirst;

  /// No description provided for @sortAtoZ.
  ///
  /// In en, this message translates to:
  /// **'A to Z'**
  String get sortAtoZ;

  /// No description provided for @sortZtoA.
  ///
  /// In en, this message translates to:
  /// **'Z to A'**
  String get sortZtoA;

  /// No description provided for @deleteItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} {label}?'**
  String deleteItemsTitle(int count, String label);

  /// No description provided for @deleteItemsContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the selected {count} {label}? This cannot be undone.'**
  String deleteItemsContent(int count, String label);

  /// No description provided for @deletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'{count} items deleted successfully'**
  String deletedSuccess(int count);

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

  /// No description provided for @addCollection.
  ///
  /// In en, this message translates to:
  /// **'Add Collection'**
  String get addCollection;

  /// No description provided for @editCollection.
  ///
  /// In en, this message translates to:
  /// **'Edit Collection'**
  String get editCollection;

  /// No description provided for @collectionName.
  ///
  /// In en, this message translates to:
  /// **'Collection Name'**
  String get collectionName;

  /// No description provided for @collectionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter collection name'**
  String get collectionNameHint;

  /// No description provided for @collectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Collection Description'**
  String get collectionDescription;

  /// No description provided for @collectionDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter collection description'**
  String get collectionDescriptionHint;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @collectionCreated.
  ///
  /// In en, this message translates to:
  /// **'Collection created successfully'**
  String get collectionCreated;

  /// No description provided for @collectionUpdated.
  ///
  /// In en, this message translates to:
  /// **'Collection updated successfully'**
  String get collectionUpdated;

  /// No description provided for @collectionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Collection deleted successfully'**
  String get collectionDeleted;

  /// No description provided for @deleteCollectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String deleteCollectionTitle(String name);

  /// No description provided for @deleteCollectionContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this collection? Its entries will not be deleted, but they will be removed from this collection.'**
  String get deleteCollectionContent;

  /// No description provided for @editCollectionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit Collection'**
  String get editCollectionTooltip;

  /// No description provided for @deleteCollectionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Collection'**
  String get deleteCollectionTooltip;

  /// No description provided for @entriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} entries'**
  String entriesCount(int count);

  /// No description provided for @noCollections.
  ///
  /// In en, this message translates to:
  /// **'No Collections'**
  String get noCollections;

  /// No description provided for @noCollectionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a collection to organize your entries.'**
  String get noCollectionsDescription;

  /// No description provided for @importPreview.
  ///
  /// In en, this message translates to:
  /// **'Import Preview'**
  String get importPreview;

  /// No description provided for @entriesDetected.
  ///
  /// In en, this message translates to:
  /// **'Entries detected'**
  String get entriesDetected;

  /// No description provided for @collectionsDetected.
  ///
  /// In en, this message translates to:
  /// **'Collections detected'**
  String get collectionsDetected;

  /// No description provided for @potentialDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Potential duplicates'**
  String get potentialDuplicates;

  /// No description provided for @resolutionStrategy.
  ///
  /// In en, this message translates to:
  /// **'Resolution Strategy'**
  String get resolutionStrategy;

  /// No description provided for @skipDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Skip Duplicates'**
  String get skipDuplicates;

  /// No description provided for @overwriteDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Overwrite Duplicates'**
  String get overwriteDuplicates;

  /// No description provided for @mergeDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Merge Duplicates'**
  String get mergeDuplicates;

  /// No description provided for @duplicateMatches.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Matches'**
  String get duplicateMatches;

  /// No description provided for @previewContent.
  ///
  /// In en, this message translates to:
  /// **'Preview Content'**
  String get previewContent;

  /// No description provided for @rawContentLength.
  ///
  /// In en, this message translates to:
  /// **'{length} chars'**
  String rawContentLength(int length);

  /// No description provided for @importNow.
  ///
  /// In en, this message translates to:
  /// **'Import Now'**
  String get importNow;

  /// No description provided for @importing.
  ///
  /// In en, this message translates to:
  /// **'Importing...'**
  String get importing;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailed(String error);

  /// No description provided for @existingEntry.
  ///
  /// In en, this message translates to:
  /// **'{term} ({type})'**
  String existingEntry(String term, String type);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @appearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Theme, typography, layout'**
  String get appearanceSubtitle;

  /// No description provided for @navigationAndFeatures.
  ///
  /// In en, this message translates to:
  /// **'Navigation & Features'**
  String get navigationAndFeatures;

  /// No description provided for @navigationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tabs, startup screen'**
  String get navigationSubtitle;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @tagsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your tags'**
  String get tagsSubtitle;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @dataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import, export, sample data'**
  String get dataSubtitle;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version, licenses, links'**
  String get aboutSubtitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get languageSubtitle;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @pureBlack.
  ///
  /// In en, this message translates to:
  /// **'Pure black (AMOLED)'**
  String get pureBlack;

  /// No description provided for @pureBlackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Uses pure black for dark theme'**
  String get pureBlackSubtitle;

  /// No description provided for @viewOptions.
  ///
  /// In en, this message translates to:
  /// **'View Options'**
  String get viewOptions;

  /// No description provided for @displayDensity.
  ///
  /// In en, this message translates to:
  /// **'Display density'**
  String get displayDensity;

  /// No description provided for @compact.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get compact;

  /// No description provided for @compactDescription.
  ///
  /// In en, this message translates to:
  /// **'Show term only with minimal vertical padding'**
  String get compactDescription;

  /// No description provided for @comfortable.
  ///
  /// In en, this message translates to:
  /// **'Comfortable'**
  String get comfortable;

  /// No description provided for @comfortableDescription.
  ///
  /// In en, this message translates to:
  /// **'Show term and a short one-line definition'**
  String get comfortableDescription;

  /// No description provided for @detailed.
  ///
  /// In en, this message translates to:
  /// **'Detailed'**
  String get detailed;

  /// No description provided for @detailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Show full details including examples and tags'**
  String get detailedDescription;

  /// No description provided for @showTagsOnCards.
  ///
  /// In en, this message translates to:
  /// **'Show tags on cards'**
  String get showTagsOnCards;

  /// No description provided for @showTagsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display entry tags in lists'**
  String get showTagsSubtitle;

  /// No description provided for @showTypeBadges.
  ///
  /// In en, this message translates to:
  /// **'Show type badges'**
  String get showTypeBadges;

  /// No description provided for @showTypeBadgesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show entry type icons'**
  String get showTypeBadgesSubtitle;

  /// No description provided for @typography.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get typography;

  /// No description provided for @fontStyle.
  ///
  /// In en, this message translates to:
  /// **'Font style'**
  String get fontStyle;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @systemFontDescription.
  ///
  /// In en, this message translates to:
  /// **'Default system font'**
  String get systemFontDescription;

  /// No description provided for @serif.
  ///
  /// In en, this message translates to:
  /// **'Serif (Literary)'**
  String get serif;

  /// No description provided for @serifDescription.
  ///
  /// In en, this message translates to:
  /// **'Classic serif font for reading'**
  String get serifDescription;

  /// No description provided for @monospace.
  ///
  /// In en, this message translates to:
  /// **'Monospace'**
  String get monospace;

  /// No description provided for @monospaceDescription.
  ///
  /// In en, this message translates to:
  /// **'Fixed-width font'**
  String get monospaceDescription;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @smallDescription.
  ///
  /// In en, this message translates to:
  /// **'Smaller text'**
  String get smallDescription;

  /// No description provided for @defaultSize.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultSize;

  /// No description provided for @defaultSizeDescription.
  ///
  /// In en, this message translates to:
  /// **'Standard text size'**
  String get defaultSizeDescription;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @largeDescription.
  ///
  /// In en, this message translates to:
  /// **'Larger text'**
  String get largeDescription;

  /// No description provided for @extraLarge.
  ///
  /// In en, this message translates to:
  /// **'Extra Large'**
  String get extraLarge;

  /// No description provided for @extraLargeDescription.
  ///
  /// In en, this message translates to:
  /// **'Maximum text size'**
  String get extraLargeDescription;

  /// No description provided for @defaultLaunchScreen.
  ///
  /// In en, this message translates to:
  /// **'Default Launch Screen'**
  String get defaultLaunchScreen;

  /// No description provided for @defaultLaunchScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose what to see when the app starts'**
  String get defaultLaunchScreenSubtitle;

  /// No description provided for @screenShownWhen.
  ///
  /// In en, this message translates to:
  /// **'Screen shown when'**
  String get screenShownWhen;

  /// No description provided for @chooseStartingScreen.
  ///
  /// In en, this message translates to:
  /// **'Choose your starting screen'**
  String get chooseStartingScreen;

  /// No description provided for @navigationTabOrder.
  ///
  /// In en, this message translates to:
  /// **'Navigation Tab Order'**
  String get navigationTabOrder;

  /// No description provided for @dragToReorder.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get dragToReorder;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @categoryAndFeatureToggles.
  ///
  /// In en, this message translates to:
  /// **'Category & Feature Toggles'**
  String get categoryAndFeatureToggles;

  /// No description provided for @activeFeatures.
  ///
  /// In en, this message translates to:
  /// **'{enabled} of {total} active'**
  String activeFeatures(int enabled, int total);

  /// No description provided for @atLeastOneCategory.
  ///
  /// In en, this message translates to:
  /// **'At least one category must remain enabled'**
  String get atLeastOneCategory;

  /// No description provided for @navigationSegment.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigationSegment;

  /// No description provided for @featuresSegment.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get featuresSegment;

  /// No description provided for @featureWordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your vocabulary'**
  String get featureWordSubtitle;

  /// No description provided for @featureIdiomSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save common expressions'**
  String get featureIdiomSubtitle;

  /// No description provided for @featurePhraseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Store useful phrases'**
  String get featurePhraseSubtitle;

  /// No description provided for @featureQuoteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep inspiring quotes'**
  String get featureQuoteSubtitle;

  /// No description provided for @featureCollectionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Organize into collections'**
  String get featureCollectionsSubtitle;

  /// No description provided for @newTagName.
  ///
  /// In en, this message translates to:
  /// **'New tag name'**
  String get newTagName;

  /// No description provided for @renameTag.
  ///
  /// In en, this message translates to:
  /// **'Rename Tag'**
  String get renameTag;

  /// No description provided for @renameTagTooltip.
  ///
  /// In en, this message translates to:
  /// **'Rename Tag'**
  String get renameTagTooltip;

  /// No description provided for @deleteTagTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Tag'**
  String get deleteTagTooltip;

  /// No description provided for @tagRenamed.
  ///
  /// In en, this message translates to:
  /// **'Tag renamed successfully'**
  String get tagRenamed;

  /// No description provided for @tagRenameError.
  ///
  /// In en, this message translates to:
  /// **'Error renaming tag: {error}'**
  String tagRenameError(String error);

  /// No description provided for @tagDeleted.
  ///
  /// In en, this message translates to:
  /// **'Tag deleted successfully'**
  String get tagDeleted;

  /// No description provided for @tagDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting tag: {error}'**
  String tagDeleteError(String error);

  /// No description provided for @noTags.
  ///
  /// In en, this message translates to:
  /// **'No Tags'**
  String get noTags;

  /// No description provided for @noTagsDescription.
  ///
  /// In en, this message translates to:
  /// **'Tags you create will appear here.'**
  String get noTagsDescription;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @exportDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save to JSON or CSV'**
  String get exportDataSubtitle;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importData;

  /// No description provided for @importDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Load from file'**
  String get importDataSubtitle;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @clearAllDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete everything'**
  String get clearAllDataSubtitle;

  /// No description provided for @loadSampleData.
  ///
  /// In en, this message translates to:
  /// **'Load Sample Data'**
  String get loadSampleData;

  /// No description provided for @loadSampleDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add starter content'**
  String get loadSampleDataSubtitle;

  /// No description provided for @deleteSampleData.
  ///
  /// In en, this message translates to:
  /// **'Delete Sample Data'**
  String get deleteSampleData;

  /// No description provided for @deleteSampleDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Remove sample content'**
  String get deleteSampleDataSubtitle;

  /// No description provided for @clearAllDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data?'**
  String get clearAllDataTitle;

  /// No description provided for @clearAllDataContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all entries and collections? This cannot be undone.'**
  String get clearAllDataContent;

  /// No description provided for @loadSampleDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Load Sample Data?'**
  String get loadSampleDataTitle;

  /// No description provided for @loadSampleDataContent.
  ///
  /// In en, this message translates to:
  /// **'This will add sample entries and collections to your database.'**
  String get loadSampleDataContent;

  /// No description provided for @deleteSampleDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Sample Data?'**
  String get deleteSampleDataTitle;

  /// No description provided for @deleteSampleDataContent.
  ///
  /// In en, this message translates to:
  /// **'This will remove all sample entries and collections from your database.'**
  String get deleteSampleDataContent;

  /// No description provided for @exportDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportDataTitle;

  /// No description provided for @exportJson.
  ///
  /// In en, this message translates to:
  /// **'Export JSON'**
  String get exportJson;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data exported successfully'**
  String get exportSuccess;

  /// No description provided for @exportError.
  ///
  /// In en, this message translates to:
  /// **'Failed to export: {error}'**
  String exportError(String error);

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully imported {count} items'**
  String importSuccess(int count);

  /// No description provided for @importError.
  ///
  /// In en, this message translates to:
  /// **'Failed to import: {error}'**
  String importError(String error);

  /// No description provided for @clearSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data cleared successfully'**
  String get clearSuccess;

  /// No description provided for @sampleDataLoaded.
  ///
  /// In en, this message translates to:
  /// **'Sample data loaded'**
  String get sampleDataLoaded;

  /// No description provided for @sampleDataDeleted.
  ///
  /// In en, this message translates to:
  /// **'Sample data deleted'**
  String get sampleDataDeleted;

  /// No description provided for @sampleDataDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting sample data: {error}'**
  String sampleDataDeleteError(String error);

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @sourceCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View project on GitHub'**
  String get sourceCodeSubtitle;

  /// No description provided for @reportBug.
  ///
  /// In en, this message translates to:
  /// **'Report Bug'**
  String get reportBug;

  /// No description provided for @reportBugSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an issue on GitHub'**
  String get reportBugSubtitle;

  /// No description provided for @starOnGithub.
  ///
  /// In en, this message translates to:
  /// **'Star on GitHub'**
  String get starOnGithub;

  /// No description provided for @starOnGithubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show your support'**
  String get starOnGithubSubtitle;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// No description provided for @versionCopied.
  ///
  /// In en, this message translates to:
  /// **'Version {version} copied to clipboard'**
  String versionCopied(String version);

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @ukrainian.
  ///
  /// In en, this message translates to:
  /// **'Українська (Ukrainian)'**
  String get ukrainian;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Русский (Russian)'**
  String get russian;

  /// No description provided for @persian.
  ///
  /// In en, this message translates to:
  /// **'فارسی (Persian)'**
  String get persian;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी (Hindi)'**
  String get hindi;

  /// No description provided for @errorLoadingEntries.
  ///
  /// In en, this message translates to:
  /// **'Error loading entries: {error}'**
  String errorLoadingEntries(String error);

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(String error);

  /// No description provided for @addNewEntry.
  ///
  /// In en, this message translates to:
  /// **'Add New Entry'**
  String get addNewEntry;

  /// No description provided for @quoteText.
  ///
  /// In en, this message translates to:
  /// **'Quote Text'**
  String get quoteText;

  /// No description provided for @meaningOrDefinition.
  ///
  /// In en, this message translates to:
  /// **'Meaning / Definition'**
  String get meaningOrDefinition;

  /// No description provided for @quoteContextMeaningNotes.
  ///
  /// In en, this message translates to:
  /// **'Context / Meaning / Author Notes'**
  String get quoteContextMeaningNotes;

  /// No description provided for @meaningOrTranslation.
  ///
  /// In en, this message translates to:
  /// **'Meaning / Translation'**
  String get meaningOrTranslation;

  /// No description provided for @meaningOrOrigin.
  ///
  /// In en, this message translates to:
  /// **'Meaning / Origin'**
  String get meaningOrOrigin;

  /// No description provided for @selectEntryType.
  ///
  /// In en, this message translates to:
  /// **'Select Entry Type'**
  String get selectEntryType;

  /// No description provided for @enterFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter {field}...'**
  String enterFieldHint(String field);

  /// No description provided for @fieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'{field} cannot be empty'**
  String fieldCannotBeEmpty(String field);

  /// No description provided for @exampleSentences.
  ///
  /// In en, this message translates to:
  /// **'Example Sentences'**
  String get exampleSentences;

  /// No description provided for @quoteSourceExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Shakespeare - Hamlet, Act III'**
  String get quoteSourceExample;

  /// No description provided for @exampleNth.
  ///
  /// In en, this message translates to:
  /// **'Example {number}...'**
  String exampleNth(int number);

  /// No description provided for @personalNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Personal Notes (Optional)'**
  String get personalNotesOptional;

  /// No description provided for @personalNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Add personal notes, memory triggers, or references...'**
  String get personalNotesHint;

  /// No description provided for @collectionOptional.
  ///
  /// In en, this message translates to:
  /// **'Collection (Optional)'**
  String get collectionOptional;

  /// No description provided for @selectCollectionHint.
  ///
  /// In en, this message translates to:
  /// **'Select a collection...'**
  String get selectCollectionHint;

  /// No description provided for @noneCollection.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get noneCollection;

  /// No description provided for @errorLoadingCollections.
  ///
  /// In en, this message translates to:
  /// **'Error loading collections: {error}'**
  String errorLoadingCollections(String error);

  /// No description provided for @noTagsAddedYet.
  ///
  /// In en, this message translates to:
  /// **'No tags added yet'**
  String get noTagsAddedYet;

  /// No description provided for @updateEntry.
  ///
  /// In en, this message translates to:
  /// **'Update Entry'**
  String get updateEntry;

  /// No description provided for @saveEntry.
  ///
  /// In en, this message translates to:
  /// **'Save Entry'**
  String get saveEntry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa', 'hi', 'ru', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
    case 'hi':
      return AppLocalizationsHi();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
