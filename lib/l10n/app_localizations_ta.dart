// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get navDashboard => 'முகப்பு';

  @override
  String get navWords => 'சொற்கள்';

  @override
  String get navPhrases => 'சொற்றொடர்கள்';

  @override
  String get navIdioms => 'மரபுத்தொடர்கள்';

  @override
  String get navQuotes => 'மேற்கோள்கள்';

  @override
  String get navCollections => 'தொகுப்புகள்';

  @override
  String get navSettings => 'அமைப்புகள்';

  @override
  String get appTitle => 'My Lexicon';

  @override
  String get yourLexiconStats => 'உங்கள் அகராதி புள்ளிவிவரங்கள்';

  @override
  String get quickActions => 'விரைவுச் செயல்கள்';

  @override
  String get recentEntries => 'சமீபத்திய பதிவுகள்';

  @override
  String get viewAll => 'அனைத்தையும் பார்க்கவும்';

  @override
  String get yourTags => 'உங்கள் குறிச்சொற்கள்';

  @override
  String get searchTags => 'குறிச்சொற்களைத் தேடுங்கள்';

  @override
  String get yourLexiconIsEmpty => 'உங்கள் அகராதி காலியாக உள்ளது';

  @override
  String get emptyStateDescription =>
      'உங்களுக்குப் பிடித்த சொற்கள் மற்றும் சொற்றொடர்களைச் சேர்க்கத் தொடங்குங்கள்.';

  @override
  String get addFirstEntry => 'முதல் பதிவைச் சேர்க்கவும்';

  @override
  String get favorites => 'பிடித்தவை';

  @override
  String get typeWord => 'சொல்';

  @override
  String get typeQuote => 'மேற்கோள்';

  @override
  String get typePhrase => 'சொற்றொடர்';

  @override
  String get typeIdiom => 'மரபுத்தொடர்';

  @override
  String get typeWords => 'சொற்கள்';

  @override
  String get typeQuotes => 'மேற்கோள்கள்';

  @override
  String get typePhrases => 'சொற்றொடர்கள்';

  @override
  String get typeIdioms => 'மரபுத்தொடர்கள்';

  @override
  String get searchAndFilter => 'தேடல் மற்றும் வடிகட்டி';

  @override
  String get searchHint => 'சொற்கள், விளக்கங்களைத் தேடுங்கள்...';

  @override
  String get reset => 'மீட்டமை';

  @override
  String get clearFilters => 'வடிகட்டிகளை அழிக்கவும்';

  @override
  String get searchTitle => 'தேடல்';

  @override
  String get addEntry => 'பதிவைச் சேர்க்கவும்';

  @override
  String get addWord => 'சொல் சேர்க்கவும்';

  @override
  String get addPhrase => 'சொற்றொடர் சேர்க்கவும்';

  @override
  String get addIdiom => 'மரபுத்தொடர் சேர்க்கவும்';

  @override
  String get addQuote => 'மேற்கோள் சேர்க்கவும்';

  @override
  String get editEntry => 'பதிவைத் திருத்தவும்';

  @override
  String get saveTooltip => 'சேமி';

  @override
  String get termLabel => 'சொல் / தலைப்பு';

  @override
  String get termHint => 'சொல்லை உள்ளிடவும்';

  @override
  String get definitionLabel => 'விளக்கம்';

  @override
  String get definitionHint => 'விளக்கத்தை உள்ளிடவும்';

  @override
  String get exampleLabel => 'உதாரணம்';

  @override
  String get exampleHint => 'உதாரணத்தை உள்ளிடவும்';

  @override
  String get notesHint => 'கூடுதல் குறிப்புகளை உள்ளிடவும்';

  @override
  String get addExample => 'உதாரணம் சேர்க்கவும்';

  @override
  String get removeExampleTooltip => 'உதாரணத்தை நீக்கவும்';

  @override
  String get selectCollection => 'தொகுப்பைத் தேர்ந்தெடுக்கவும்';

  @override
  String get markAsFavorite => 'பிடித்ததாகக் குறிக்கவும்';

  @override
  String get markAsFavoriteSubtitle => 'பின்னர் எளிதாக அணுகலாம்.';

  @override
  String get tagInputHint => 'குறிச்சொல் சேர்க்கவும்...';

  @override
  String get entryCreatedSuccess => 'பதிவு வெற்றிகரமாக உருவாக்கப்பட்டது';

  @override
  String get entryUpdatedSuccess => 'பதிவு வெற்றிகரமாகப் புதுப்பிக்கப்பட்டது';

  @override
  String duplicateTermError(String type) {
    return 'இந்த $type ஏற்கனவே உள்ளது';
  }

  @override
  String get entryNotFound => 'பதிவு காணப்படவில்லை';

  @override
  String get entryDetails => 'பதிவு விவரங்கள்';

  @override
  String get editTooltip => 'திருத்து';

  @override
  String get deleteTooltip => 'நீக்கு';

  @override
  String get favoriteTooltip => 'பிடித்தவை';

  @override
  String get unfavoriteTooltip => 'பிடித்தவற்றிலிருந்து நீக்கு';

  @override
  String get deleteEntryTitle => 'பதிவை நீக்கவா?';

  @override
  String deleteEntryContent(String term) {
    return '\"$term\" பதிவை நிச்சயமாக நீக்க விரும்புகிறீர்களா? இதை மீட்டெடுக்க முடியாது.';
  }

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get delete => 'நீக்கு';

  @override
  String get deleteSuccess => 'வெற்றிகரமாக நீக்கப்பட்டது';

  @override
  String deleteError(String error) {
    return 'நீக்குவதில் தோல்வி: $error';
  }

  @override
  String failedToUpdateFavorite(String error) {
    return 'பிடித்த நிலையைப் புதுப்பிப்பதில் தோல்வி: $error';
  }

  @override
  String get contextAndMeaning => 'சூழல் மற்றும் பொருள்';

  @override
  String get meaningAndInterpretation => 'பொருள் மற்றும் விளக்கம்';

  @override
  String get sourceContext => 'மூல சூழல்';

  @override
  String get examples => 'உதாரணங்கள்';

  @override
  String get exampleUsage => 'பயன்பாட்டு உதாரணம்';

  @override
  String get personalNotes => 'தனிப்பட்ட குறிப்புகள்';

  @override
  String storedOn(String date) {
    return '$date அன்று சேமிக்கப்பட்டது';
  }

  @override
  String get shareEntry => 'பதிவைப் பகிரவும்';

  @override
  String get copyEntry => 'பதிவை நகலெடுக்கவும்';

  @override
  String get uncategorized => 'வகைப்படுத்தப்படாதவை';

  @override
  String get cancelTooltip => 'ரத்துசெய்';

  @override
  String get toggleSelectAllTooltip => 'அனைத்தையும் தேர்ந்தெடு';

  @override
  String get deleteSelectedTooltip => 'தேர்ந்தெடுத்தவற்றை நீக்கு';

  @override
  String get selectItemsTooltip => 'உருப்படிகளைத் தேர்ந்தெடு';

  @override
  String get sortOrderTooltip => 'வரிசைப்படுத்தும் முறை';

  @override
  String get sortNewestFirst => 'புதியவை முதலில்';

  @override
  String get sortOldestFirst => 'பழையவை முதலில்';

  @override
  String get sortAtoZ => 'அ முதல் ஃ வரை';

  @override
  String get sortZtoA => 'ஃ முதல் அ வரை';

  @override
  String deleteItemsTitle(int count, String label) {
    return 'தேர்ந்தெடுத்த $count $label உருப்படிகளை நீக்கவா?';
  }

  @override
  String deleteItemsContent(int count, String label) {
    return 'தேர்ந்தெடுக்கப்பட்ட $count $label உருப்படிகளை நிச்சயமாக நீக்க விரும்புகிறீர்களா? இதை மீட்டெடுக்க முடியாது.';
  }

  @override
  String deletedSuccess(int count) {
    return '$count உருப்படிகள் வெற்றிகரமாக நீக்கப்பட்டன';
  }

  @override
  String get collections => 'தொகுப்புகள்';

  @override
  String get addCollection => 'தொகுப்பைச் சேர்க்கவும்';

  @override
  String get editCollection => 'தொகுப்பைத் திருத்தவும்';

  @override
  String get collectionName => 'தொகுப்பின் பெயர்';

  @override
  String get collectionNameHint => 'தொகுப்புப் பெயரை உள்ளிடவும்';

  @override
  String get collectionDescription => 'தொகுப்பு விளக்கம்';

  @override
  String get collectionDescriptionHint => 'தொகுப்பு விளக்கத்தை உள்ளிடவும்';

  @override
  String get save => 'சேமி';

  @override
  String get collectionCreated => 'தொகுப்பு வெற்றிகரமாக உருவாக்கப்பட்டது';

  @override
  String get collectionUpdated => 'தொகுப்பு வெற்றிகரமாகப் புதுப்பிக்கப்பட்டது';

  @override
  String get collectionDeleted => 'தொகுப்பு வெற்றிகரமாக நீக்கப்பட்டது';

  @override
  String deleteCollectionTitle(String name) {
    return '\"$name\" தொகுப்பை நீக்கவா?';
  }

  @override
  String get deleteCollectionContent =>
      'இந்தத் தொகுப்பை நிச்சயமாக நீக்க விரும்புகிறீர்களா? இதிலுள்ள பதிவுகள் நீக்கப்படாது, ஆனால் தொகுப்பிலிருந்து அகற்றப்படும்.';

  @override
  String get editCollectionTooltip => 'தொகுப்பைத் திருத்தவும்';

  @override
  String get deleteCollectionTooltip => 'தொகுப்பை நீக்கவும்';

  @override
  String entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பதிவுகள்',
      one: '1 பதிவு',
    );
    return '$_temp0';
  }

  @override
  String get noCollections => 'தொகுப்புகள் இல்லை';

  @override
  String get noCollectionsDescription =>
      'உங்கள் பதிவுகளை ஒழுங்கமைக்க ஒரு தொகுப்பை உருவாக்கவும்.';

  @override
  String get importPreview => 'இறக்குமதி முன்னோட்டம்';

  @override
  String get entriesDetected => 'கண்டறியப்பட்ட பதிவுகள்';

  @override
  String get collectionsDetected => 'கண்டறியப்பட்ட தொகுப்புகள்';

  @override
  String get potentialDuplicates => 'சாத்தியமான பிரதிகள்';

  @override
  String get resolutionStrategy => 'தீர்வு உத்தி';

  @override
  String get skipDuplicates => 'பிரதிகளைத் தவிர்க்கவும்';

  @override
  String get overwriteDuplicates => 'பிரதிகளை மேலெழுதவும்';

  @override
  String get mergeDuplicates => 'பிரதிகளை இணைக்கவும்';

  @override
  String get duplicateMatches => 'பொருந்தும் பிரதிகள்';

  @override
  String get previewContent => 'கோப்பு உள்ளடக்கம்';

  @override
  String rawContentLength(int length) {
    return '$length எழுத்துகள்';
  }

  @override
  String get importNow => 'இப்போது இறக்குமதி செய்யவும்';

  @override
  String get importing => 'இறக்குமதி செய்யப்படுகிறது...';

  @override
  String importFailed(String error) {
    return 'இறக்குமதி தோல்வியடைந்தது: $error';
  }

  @override
  String existingEntry(String term, String type) {
    return '$term ($type)';
  }

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get appearance => 'தோற்றம்';

  @override
  String get appearanceSubtitle => 'தீம், எழுத்துரு நடை, தளவமைப்பு';

  @override
  String get navigationAndFeatures => 'வழிசெலுத்தல் மற்றும் அம்சங்கள்';

  @override
  String get navigationSubtitle => 'தொடக்கத் திரை, தாவல்கள், அம்சங்கள்';

  @override
  String get tags => 'குறிச்சொற்கள்';

  @override
  String get tagsSubtitle => 'குறிச்சொற்களை நிர்வகிக்கவும்';

  @override
  String get data => 'தரவு';

  @override
  String get dataSubtitle => 'இறக்குமதி, ஏற்றுமதி, மாதிரி தரவு';

  @override
  String get about => 'பற்றி';

  @override
  String get aboutSubtitle => 'பதிப்பு, உரிமங்கள், இணைப்புகள்';

  @override
  String get language => 'மொழி';

  @override
  String get languageSubtitle => 'பயன்பாட்டின் மொழியை மாற்றவும்';

  @override
  String get theme => 'தீம்';

  @override
  String get pureBlack => 'தூய கருப்பு (AMOLED)';

  @override
  String get pureBlackSubtitle =>
      'இருண்ட தீமுக்கு முழுமையான கருப்புப் பின்னணியைப் பயன்படுத்துகிறது';

  @override
  String get viewOptions => 'காட்சி விருப்பங்கள்';

  @override
  String get displayDensity => 'காட்சி அடர்த்தி';

  @override
  String get compact => 'சுருக்கமானது';

  @override
  String get compactDescription =>
      'குறைந்தபட்ச இடைவெளியுடன் சொல்லை மட்டும் காட்டவும்';

  @override
  String get comfortable => 'வசதியானது';

  @override
  String get comfortableDescription =>
      'சொல் மற்றும் சிறிய விளக்கத்தைக் காட்டவும்';

  @override
  String get detailed => 'விரிவானது';

  @override
  String get detailedDescription =>
      'உதாரணங்கள் மற்றும் குறிச்சொற்களுடன் முழு விவரங்களையும் காட்டவும்';

  @override
  String get showTagsOnCards => 'அட்டைகளில் குறிச்சொற்களைக் காட்டவும்';

  @override
  String get showTagsSubtitle =>
      'பட்டியல்களில் பதிவு குறிச்சொற்களைக் காட்டவும்';

  @override
  String get showTypeBadges => 'வகை பேட்ஜ்களைக் காட்டவும்';

  @override
  String get showTypeBadgesSubtitle =>
      'சொல், மேற்கோள், சொற்றொடர் பேட்ஜ்களைக் காட்டவும்';

  @override
  String get typography => 'அச்சுக்கலை';

  @override
  String get fontStyle => 'எழுத்துரு நடை';

  @override
  String get system => 'கணினி இயல்புநிலை';

  @override
  String get systemFontDescription => 'இயல்புநிலை கணினி எழுத்துரு';

  @override
  String get serif => 'செரிஃப் (வாசிப்புக்குரியது)';

  @override
  String get serifDescription => 'வாசிப்பதற்கு வசதியான செரிஃப் எழுத்துரு';

  @override
  String get monospace => 'மோனோஸ்பேஸ்';

  @override
  String get monospaceDescription => 'நிலையான அகல எழுத்துரு';

  @override
  String get textSize => 'எழுத்துரு அளவு';

  @override
  String get small => 'சிறியது';

  @override
  String get smallDescription => 'திரையில் அதிக உள்ளடக்கம்';

  @override
  String get defaultSize => 'இயல்புநிலை';

  @override
  String get defaultSizeDescription => 'நிலையான எழுத்துரு அளவு';

  @override
  String get large => 'பெரியது';

  @override
  String get largeDescription => 'வசதியான வாசிப்புக்கு பெரிய உரை';

  @override
  String get extraLarge => 'மிகப் பெரியது';

  @override
  String get extraLargeDescription => 'அதிகபட்ச வாசிப்புத்திறன்';

  @override
  String get defaultLaunchScreen => 'இயல்புநிலை தொடக்கத் திரை';

  @override
  String get defaultLaunchScreenSubtitle =>
      'பயன்பாட்டைத் திறக்கும்போது தோன்றும் திரை';

  @override
  String get screenShownWhen => 'திறக்கும்போது தோன்றும் திரை';

  @override
  String get chooseStartingScreen => 'தொடக்கத் திரையைத் தேர்ந்தெடுக்கவும்';

  @override
  String get navigationTabOrder => 'வழிசெலுத்தல் தாவல் வரிசை';

  @override
  String get dragToReorder => 'வரிசையை மாற்ற இழுக்கவும்';

  @override
  String get disabled => 'முடக்கப்பட்டது';

  @override
  String get categoryAndFeatureToggles => 'வகைகள் மற்றும் அம்சங்கள்';

  @override
  String activeFeatures(int enabled, int total) {
    return '$total-இல் $enabled செயலில் உள்ளன';
  }

  @override
  String get atLeastOneCategory =>
      'குறைந்தது ஒரு வகையாவது இயக்கப்பட்டிருக்க வேண்டும்';

  @override
  String get navigationSegment => 'வழிசெலுத்தல்';

  @override
  String get featuresSegment => 'அம்சங்கள்';

  @override
  String get featureWordSubtitle => 'உங்கள் சொல்லகராதியை நிர்வகிக்கவும்';

  @override
  String get featureIdiomSubtitle => 'மரபுத்தொடர்களைச் சேமிக்கவும்';

  @override
  String get featurePhraseSubtitle => 'பயனுள்ள சொற்றொடர்களைச் சேமிக்கவும்';

  @override
  String get featureQuoteSubtitle => 'ஊக்கமளிக்கும் மேற்கோள்களைச் சேமிக்கவும்';

  @override
  String get featureCollectionsSubtitle => 'தொகுப்புகளாக ஒழுங்கமைக்கவும்';

  @override
  String get newTagName => 'புதிய குறிச்சொல் பெயர்';

  @override
  String get renameTag => 'பெயர் மாற்றவும்';

  @override
  String get renameTagTooltip => 'குறிச்சொல் பெயர் மாற்றவும்';

  @override
  String get deleteTagTooltip => 'குறிச்சொல்லை நீக்கவும்';

  @override
  String get tagRenamed => 'குறிச்சொல் பெயர் மாற்றப்பட்டது';

  @override
  String tagRenameError(String error) {
    return 'குறிச்சொல் பெயர் மாற்றுவதில் பிழை: $error';
  }

  @override
  String get tagDeleted => 'குறிச்சொல் நீக்கப்பட்டது';

  @override
  String tagDeleteError(String error) {
    return 'குறிச்சொல்லை நீக்குவதில் பிழை: $error';
  }

  @override
  String get noTags => 'குறிச்சொற்கள் இல்லை';

  @override
  String get noTagsDescription =>
      'நீங்கள் உருவாக்கும் குறிச்சொற்கள் இங்கே தோன்றும்.';

  @override
  String get exportData => 'தரவை ஏற்றுமதி செய்';

  @override
  String get exportDataSubtitle => 'JSON அல்லது CSV கோப்பாகச் சேமிக்கவும்';

  @override
  String get importData => 'தரவை இறக்குமதி செய்';

  @override
  String get importDataSubtitle => 'கோப்பிலிருந்து ஏற்றவும்';

  @override
  String get clearAllData => 'எல்லா தரவையும் அழிக்கவும்';

  @override
  String get clearAllDataSubtitle =>
      'அனைத்து பதிவுகளையும் தொகுப்புகளையும் நீக்கவும்';

  @override
  String get loadSampleData => 'மாதிரி தரவை ஏற்றவும்';

  @override
  String get loadSampleDataSubtitle => 'மாதிரி உள்ளடக்கத்தைச் சேர்க்கவும்';

  @override
  String get deleteSampleData => 'மாதிரி தரவை நீக்கவும்';

  @override
  String get deleteSampleDataSubtitle => 'மாதிரி உள்ளடக்கத்தை அகற்றவும்';

  @override
  String get clearAllDataTitle => 'எல்லா தரவையும் அழிக்கவா?';

  @override
  String get clearAllDataContent =>
      'அனைத்து பதிவுகளையும் தொகுப்புகளையும் நிச்சயமாக நீக்க விரும்புகிறீர்களா? இதை மீட்டெடுக்க முடியாது.';

  @override
  String get loadSampleDataTitle => 'மாதிரி தரவை ஏற்றவா?';

  @override
  String get loadSampleDataContent =>
      'இது உங்கள் தரவுத்தளத்தில் மாதிரி பதிவுகளையும் தொகுப்புகளையும் சேர்க்கும்.';

  @override
  String get deleteSampleDataTitle => 'மாதிரி தரவை நீக்கவா?';

  @override
  String get deleteSampleDataContent =>
      'இது உங்கள் தரவுத்தளத்திலிருந்து அனைத்து மாதிரி பதிவுகளையும் தொகுப்புகளையும் அகற்றும்.';

  @override
  String get exportDataTitle => 'ஏற்றுமதி வடிவம்';

  @override
  String get exportJson => 'JSON காப்புப் பிரதி';

  @override
  String get exportCsv => 'CSV விரிதாள்';

  @override
  String get exportSuccess => 'தரவு வெற்றிகரமாக ஏற்றுமதி செய்யப்பட்டது';

  @override
  String exportError(String error) {
    return 'ஏற்றுமதி செய்வதில் தோல்வி: $error';
  }

  @override
  String importSuccess(int count) {
    return '$count உருப்படிகள் வெற்றிகரமாக இறக்குமதி செய்யப்பட்டன';
  }

  @override
  String importError(String error) {
    return 'இறக்குமதியில் தோல்வி: $error';
  }

  @override
  String get clearSuccess => 'தரவு வெற்றிகரமாக அழிக்கப்பட்டது';

  @override
  String get sampleDataLoaded => 'மாதிரி தரவு ஏற்றப்பட்டது';

  @override
  String get sampleDataDeleted => 'மாதிரி தரவு நீக்கப்பட்டது';

  @override
  String sampleDataDeleteError(String error) {
    return 'மாதிரி தரவை நீக்குவதில் பிழை: $error';
  }

  @override
  String get sourceCode => 'மூலக் குறியீடு';

  @override
  String get sourceCodeSubtitle => 'GitHub-இல் திட்டத்தைப் பார்க்கவும்';

  @override
  String get reportBug => 'பிழையைப் புகாரளிக்கவும்';

  @override
  String get reportBugSubtitle => 'GitHub-இல் சிக்கலை உருவாக்கவும்';

  @override
  String get starOnGithub => 'GitHub-இல் Star இடவும்';

  @override
  String get starOnGithubSubtitle => 'உங்கள் ஆதரவைத் தெரிவிக்கவும்';

  @override
  String get openSourceLicenses => 'திறந்த மூல உரிமங்கள்';

  @override
  String versionCopied(String version) {
    return 'பதிப்பு $version நகலெடுக்கப்பட்டது';
  }

  @override
  String get selectLanguage => 'மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get systemDefault => 'கணினி இயல்புநிலை';

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
    return 'பதிவுகளை ஏற்றுவதில் பிழை: $error';
  }

  @override
  String error(String error) {
    return 'பிழை: $error';
  }

  @override
  String get addNewEntry => 'புதிய பதிவு சேர்க்கவும்';

  @override
  String get quoteText => 'மேற்கோள் உரை';

  @override
  String get meaningOrDefinition => 'பொருள் / விளக்கம்';

  @override
  String get quoteContextMeaningNotes =>
      'சூழல் / பொருள் / ஆசிரியர் குறிப்புகள்';

  @override
  String get meaningOrTranslation => 'பொருள் / மொழிபெயர்ப்பு';

  @override
  String get meaningOrOrigin => 'பொருள் / தோற்றம்';

  @override
  String get selectEntryType => 'பதிவு வகையைத் தேர்ந்தெடுக்கவும்';

  @override
  String enterFieldHint(String field) {
    return '$field உள்ளிடவும்...';
  }

  @override
  String fieldCannotBeEmpty(String field) {
    return '$field காலியாக இருக்கக்கூடாது';
  }

  @override
  String get exampleSentences => 'உதாரண வாக்கியங்கள்';

  @override
  String get quoteSourceExample => 'எ.கா. பாரதியார் - பாஞ்சாலி சபதம்';

  @override
  String exampleNth(int number) {
    return 'உதாரணம் $number...';
  }

  @override
  String get personalNotesOptional => 'தனிப்பட்ட குறிப்புகள் (விருப்பத்தேர்வு)';

  @override
  String get personalNotesHint =>
      'தனிப்பட்ட குறிப்புகள் அல்லது நினைவூட்டல்களைச் சேர்க்கவும்...';

  @override
  String get collectionOptional => 'தொகுப்பு (விருப்பத்தேர்வு)';

  @override
  String get selectCollectionHint => 'தொகுப்பைத் தேர்ந்தெடுக்கவும்...';

  @override
  String get noneCollection => 'எதுவுமில்லை';

  @override
  String errorLoadingCollections(String error) {
    return 'தொகுப்புகளை ஏற்றுவதில் பிழை: $error';
  }

  @override
  String get noTagsAddedYet => 'இன்னும் குறிச்சொற்கள் சேர்க்கப்படவில்லை';

  @override
  String get updateEntry => 'பதிவைப் புதுப்பிக்கவும்';

  @override
  String get saveEntry => 'பதிவைச் சேமிக்கவும்';

  @override
  String get themeMode => 'தீம் முறை';

  @override
  String get themeSystem => 'கணினி';

  @override
  String get themeLight => 'வெளிச்சம்';

  @override
  String get themeDark => 'இருள்';

  @override
  String get lightModeTheme => '☀ வெளிச்சப் பயன்முறை தீம்';

  @override
  String get darkModeTheme => '🌙 இருண்ட பயன்முறை தீம்';

  @override
  String get dataImportExport => 'தரவு இறக்குமதி & ஏற்றுமதி';

  @override
  String get exportDataDescription =>
      'உங்கள் அகராதியின் JSON காப்புப் பிரதி அல்லது CSV ஏற்றுமதியை நீங்கள் தேர்வுசெய்யும் இடத்தில் சேமிக்கவும்';

  @override
  String get dataStorage => 'தரவுச் சேமிப்பகம்';

  @override
  String get clearAllLocalData => 'அனைத்து உள்ளூர் தரவையும் அழிக்கவும்';

  @override
  String get clearAllLocalDataSubtitle =>
      'எல்லா சொற்கள், மேற்கோள்கள், தொகுப்புகள் மற்றும் குறிச்சொற்களை நிரந்தரமாக நீக்கவும்';

  @override
  String get developerDebugMode => 'டெவலப்பர் (பிழைத்திருத்த முறை)';

  @override
  String get loadSampleDataSubtitle2 =>
      'ஒவ்வொரு வகையிலும் 10 உருப்படிகளைச் சேர்க்கவும் (40 பதிவுகள்)';

  @override
  String get deleteSampleDataSubtitle2 =>
      'ஏற்றப்பட்ட மாதிரி பதிவுகள் மற்றும் தொகுப்புகளை மட்டும் நீக்கவும்';

  @override
  String get unableToReadFile =>
      'தேர்ந்தெடுக்கப்பட்ட கோப்பைப் படிக்க முடியவில்லை.';

  @override
  String exportSavedTo(String path) {
    return 'ஏற்றுமதி $path பாதையில் சேமிக்கப்பட்டது';
  }

  @override
  String get saveLexiconExport => 'அகராதி ஏற்றுமதியைச் சேமிக்கவும்';

  @override
  String get chooseExportFormat =>
      'உங்கள் காப்புப்பிரதிக்கான ஏற்றுமதி வடிவத்தைத் தேர்ந்தெடுக்கவும்.';

  @override
  String renameTagTitle(String tag) {
    return '#$tag குறிச்சொல் பெயரை மாற்றவா?';
  }

  @override
  String tagRenamedSuccess(String oldTag, String newTag) {
    return '#$oldTag குறிச்சொல் #$newTag என மாற்றப்பட்டது';
  }

  @override
  String deleteTagTitle(String tag) {
    return '#$tag குறிச்சொல்லை நீக்கவா?';
  }

  @override
  String deleteTagContent(String tag) {
    return 'அனைத்துப் பதிவுகளிலிருந்தும் #$tag குறிச்சொல்லை நிச்சயமாக நீக்க விரும்புகிறீர்களா? பதிவுகள் நீக்கப்படாது.';
  }

  @override
  String tagDeletedSuccess(String tag) {
    return '#$tag குறிச்சொல் அனைத்துப் பதிவுகளிலிருந்தும் நீக்கப்பட்டது';
  }

  @override
  String manageTags(int count) {
    return 'குறிச்சொற்களை நிர்வகிக்கவும் ($count)';
  }

  @override
  String get noTagsFoundDatabase =>
      'தரவுத்தளத்தில் குறிச்சொற்கள் எதுவும் இல்லை. பதிவுகளை உருவாக்கும்போது குறிச்சொற்களைச் சேர்க்கலாம்.';

  @override
  String get chooseColor => 'வண்ணத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get collectionNameCannotBeEmpty =>
      'தொகுப்புப் பெயர் காலியாக இருக்கக்கூடாது';

  @override
  String get create => 'உருவாக்கு';

  @override
  String failedToDeleteCollection(String error) {
    return 'தொகுப்பை நீக்குவதில் தோல்வி: $error';
  }

  @override
  String get noCollectionsCreated => 'தொகுப்புகள் உருவாக்கப்படவில்லை';

  @override
  String get noCollectionsCreatedDesc =>
      'உங்கள் பதிவுகளை ஒழுங்கமைக்க தனிப்பயன் கோப்புறைகள்/தொகுப்புகளை உருவாக்கவும்.';

  @override
  String get createFirstCollection => 'முதல் தொகுப்பை உருவாக்கவும்';

  @override
  String get noDescriptionProvided => 'விளக்கம் வழங்கப்படவில்லை';

  @override
  String get noDescriptionProvidedDetailed =>
      'இந்தத் தொகுப்பிற்கு விளக்கம் எதுவும் வழங்கப்படவில்லை.';

  @override
  String get close => 'மூடு';

  @override
  String get collectionIsEmpty => 'தொகுப்பு காலியாக உள்ளது';

  @override
  String get collectionIsEmptyDesc =>
      'இந்தத் தொகுப்பில் இன்னும் பதிவுகள் சேர்க்கப்படவில்லை. பதிவை உருவாக்கும்போது சேர்க்கலாம்.';

  @override
  String get selectATag => 'குறிச்சொல்லைத் தேர்ந்தெடுக்கவும்';

  @override
  String get noTagsFoundInDatabase => 'தரவுத்தளத்தில் குறிச்சொற்கள் இல்லை';

  @override
  String get selectTag => 'குறிச்சொல்லைத் தேர்ந்தெடு';

  @override
  String get noResultsFound => 'முடிவுகள் எதுவும் இல்லை';

  @override
  String get tryAdjustingSearch =>
      'உங்கள் தேடல் சொற்கள் அல்லது வடிகட்டிகளை மாற்றி முயற்சிக்கவும்.';

  @override
  String get startAddingNewEntries =>
      'சேர் பொத்தானைப் பயன்படுத்தி புதிய பதிவுகளைச் சேர்க்கத் தொடங்குங்கள்.';

  @override
  String alreadyExistsInCollection(String collection) {
    return '\"$collection\" தொகுப்பில் ஏற்கனவே உள்ளது';
  }

  @override
  String get alreadyExistsUnassigned => 'தொகுக்கப்படாத பதிவாக ஏற்கனவே உள்ளது';

  @override
  String get duplicateIfDifferentCollection =>
      'இது மற்றொரு தொகுப்பைச் சேர்ந்ததாக இருந்தால், தொகுப்பை மாற்றி மீண்டும் சேமிக்கவும்.';

  @override
  String get duplicateIfDifferentUsage =>
      'இது வேறு பயன்பாடாக இருந்தால், கீழே உள்ள தொகுப்புப் புலத்தைப் பயன்படுத்தி ஒரு தொகுப்பில் ஒதுக்கி மீண்டும் சேமிக்கவும்.';

  @override
  String get duplicateEntryDetected => 'நகல் பதிவு கண்டறியப்பட்டது';

  @override
  String get viewExistingEntry => 'உள்ள பதிவைப் பார்க்கவும்';

  @override
  String get appTagline => 'உங்கள் தனிப்பட்ட அறிவுத் தோழன்';

  @override
  String get links => 'இணைப்புகள்';

  @override
  String get githubUrl => 'github.com/aryany9/MyLexicon';

  @override
  String get ifYouFindUseful => 'My Lexicon பயனுள்ளதாக இருந்தால்';

  @override
  String get legal => 'சட்டப்பூர்வ விவரங்கள்';

  @override
  String get madeWith => 'அன்புடன் உருவாக்கப்பட்டது: ';

  @override
  String get inIndia => ' இந்தியாவில்';

  @override
  String get byAuthor => 'Aryan Yadav மூலம்';

  @override
  String get clearAllDataQuestion => 'எல்லா தரவையும் அழிக்கவா?';

  @override
  String get clearAllDataWarning =>
      'இந்த செயல் உங்கள் சொற்கள், மேற்கோள்கள், சொற்றொடர்கள், மரபுத்தொடர்கள் மற்றும் தொகுப்புகளை நிரந்தரமாக நீக்கும்.\n\nஇதை மீட்டெடுக்க முடியாது. தொடர விரும்புகிறீர்களா?';

  @override
  String get allDataCleared => 'எல்லா தரவும் வெற்றிகரமாக அழிக்கப்பட்டது';

  @override
  String errorClearingData(String error) {
    return 'தரவை அழிப்பதில் பிழை: $error';
  }

  @override
  String get clearEverything => 'எல்லாவற்றையும் அழி';

  @override
  String get loadSampleDataWarning =>
      'இது ஒவ்வொரு வகைக்கும் 10 மாதிரி பதிவுகளையும் தொகுப்புகளையும் சேர்க்கும்.\n\n• ஏற்கனவே உள்ள மாதிரிப் பதிவுகள் புதுப்பிக்கப்படும்.\n• நீங்கள் உருவாக்கிய தனிப்பயன் பதிவுகள் பாதுகாக்கப்படும்.';

  @override
  String loadedSampleEntries(int count) {
    return 'அனைத்து வகைகளிலும் $count மாதிரிப் பதிவுகள் ஏற்றப்பட்டன!';
  }

  @override
  String loadedSampleEntriesSkipped(int added, int skipped) {
    return '$added மாதிரிப் பதிவுகள் ஏற்றப்பட்டன ($skipped ஏற்கனவே உள்ள பிரதிகளாகத் தவிர்க்கப்பட்டன).';
  }

  @override
  String refreshedSampleEntries(int count) {
    return '$count மாதிரிப் பதிவுகள் புதுப்பிக்கப்பட்டன.';
  }

  @override
  String refreshedSampleEntriesSkipped(int updated, int skipped) {
    return '$updated மாதிரிப் பதிவுகள் புதுப்பிக்கப்பட்டன ($skipped தனிப்பயன் பிரதிகள் பாதுகாக்கப்பட்டன).';
  }

  @override
  String allSampleTermsExist(int skipped) {
    return 'அனைத்து $skipped மாதிரி சொற்களும் ஏற்கனவே உங்கள் அகராதியில் உள்ளன.';
  }

  @override
  String errorLoadingSampleData(String error) {
    return 'மாதிரித் தரவை ஏற்றுவதில் பிழை: $error';
  }

  @override
  String get deleteSampleDataQuestion => 'மாதிரி தரவை நீக்கவா?';

  @override
  String get deleteSampleDataWarning =>
      'இது ஏற்றப்பட்ட அனைத்து மாதிரிப் பதிவுகளையும் தொகுப்புகளையும் நீக்கும்.\n\nஉங்கள் தனிப்பயன் பதிவுகள் அப்படியே இருக்கும்.';

  @override
  String deletedSampleEntries(int count) {
    return '$count மாதிரிப் பதிவுகள் மற்றும் தொகுப்புகள் நீக்கப்பட்டன.';
  }

  @override
  String get noSampleEntriesFound =>
      'நீக்குவதற்கு மாதிரிப் பதிவுகள் எதுவும் இல்லை.';

  @override
  String exportFailed(String error) {
    return 'ஏற்றுமதி தோல்வி: $error';
  }

  @override
  String importedEntriesDetails(
    int added,
    int skipped,
    int overwritten,
    int merged,
  ) {
    return '$added புதியவை இறக்குமதி செய்யப்பட்டன, $skipped தவிர்க்கப்பட்டன, $overwritten மேலெழுதப்பட்டன, $merged இணைக்கப்பட்டன.';
  }

  @override
  String aboutSubtitleWithVersion(String version) {
    return 'v$version · உரிமங்கள் மற்றும் இணைப்புகள்';
  }

  @override
  String get tamil => 'தமிழ் (Tamil)';

  @override
  String get telugu => 'తెలుగు (Telugu)';
}
