// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get navDashboard => 'डैशबोर्ड';

  @override
  String get navWords => 'शब्द';

  @override
  String get navPhrases => 'वाक्यांश';

  @override
  String get navIdioms => 'मुहावरे';

  @override
  String get navQuotes => 'उद्धरण';

  @override
  String get navCollections => 'संग्रह';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get appTitle => 'My Lexicon';

  @override
  String get yourLexiconStats => 'आपके शब्दकोश की जानकारी';

  @override
  String get quickActions => 'त्वरित क्रियाएं';

  @override
  String get recentEntries => 'हाल की प्रविष्टियां';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String get yourTags => 'आपके टैग';

  @override
  String get searchTags => 'टैग खोजें';

  @override
  String get yourLexiconIsEmpty => 'शब्दकोश खाली है';

  @override
  String get emptyStateDescription => 'शब्द, वाक्यांश या उद्धरण जोड़ें।';

  @override
  String get addFirstEntry => 'पहली प्रविष्टि जोड़ें';

  @override
  String get favorites => 'पसंदीदा';

  @override
  String get typeWord => 'शब्द';

  @override
  String get typeQuote => 'उद्धरण';

  @override
  String get typePhrase => 'वाक्यांश';

  @override
  String get typeIdiom => 'मुहावरा';

  @override
  String get typeWords => 'शब्द';

  @override
  String get typeQuotes => 'उद्धरण';

  @override
  String get typePhrases => 'वाक्यांश';

  @override
  String get typeIdioms => 'मुहावरे';

  @override
  String get searchAndFilter => 'खोज और फ़िल्टर';

  @override
  String get searchHint => 'शब्द या परिभाषा खोजें...';

  @override
  String get reset => 'रीसेट';

  @override
  String get clearFilters => 'फ़िल्टर हटाएं';

  @override
  String get searchTitle => 'खोज';

  @override
  String get addEntry => 'प्रविष्टि जोड़ें';

  @override
  String get addWord => 'शब्द जोड़ें';

  @override
  String get addPhrase => 'वाक्यांश जोड़ें';

  @override
  String get addIdiom => 'मुहावरा जोड़ें';

  @override
  String get addQuote => 'उद्धरण जोड़ें';

  @override
  String get editEntry => 'प्रविष्टि संपादित करें';

  @override
  String get saveTooltip => 'सहेजें';

  @override
  String get termLabel => 'शब्द';

  @override
  String get termHint => 'शब्द दर्ज करें';

  @override
  String get definitionLabel => 'परिभाषा';

  @override
  String get definitionHint => 'परिभाषा दर्ज करें';

  @override
  String get exampleLabel => 'उदाहरण';

  @override
  String get exampleHint => 'उदाहरण दर्ज करें';

  @override
  String get notesHint => 'नोट्स दर्ज करें';

  @override
  String get addExample => 'उदाहरण जोड़ें';

  @override
  String get removeExampleTooltip => 'उदाहरण हटाएं';

  @override
  String get selectCollection => 'संग्रह चुनें';

  @override
  String get markAsFavorite => 'पसंदीदा में जोड़ें';

  @override
  String get markAsFavoriteSubtitle => 'इस प्रविष्टि तक त्वरित पहुंच।';

  @override
  String get tagInputHint => 'टैग जोड़ें...';

  @override
  String get entryCreatedSuccess => 'प्रविष्टि बनाई गई';

  @override
  String get entryUpdatedSuccess => 'प्रविष्टि अपडेट की गई';

  @override
  String duplicateTermError(String type) {
    return 'यह $type पहले से मौजूद है';
  }

  @override
  String get entryNotFound => 'प्रविष्टि नहीं मिली';

  @override
  String get entryDetails => 'प्रविष्टि विवरण';

  @override
  String get editTooltip => 'संपादित करें';

  @override
  String get deleteTooltip => 'हटाएं';

  @override
  String get favoriteTooltip => 'पसंदीदा में जोड़ें';

  @override
  String get unfavoriteTooltip => 'पसंदीदा से हटाएं';

  @override
  String get deleteEntryTitle => 'प्रविष्टि हटाएं?';

  @override
  String deleteEntryContent(String term) {
    return 'क्या आप “$term” को हटाना चाहते हैं? यह क्रिया वापस नहीं की जा सकती।';
  }

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get deleteSuccess => 'प्रविष्टि हटाई गई';

  @override
  String deleteError(String error) {
    return 'हटाने में त्रुटि: $error';
  }

  @override
  String failedToUpdateFavorite(String error) {
    return 'पसंदीदा स्थिति अपडेट करने में विफल: $error';
  }

  @override
  String get contextAndMeaning => 'संदर्भ और अर्थ';

  @override
  String get meaningAndInterpretation => 'अर्थ और व्याख्या';

  @override
  String get sourceContext => 'स्रोत संदर्भ';

  @override
  String get examples => 'उदाहरण';

  @override
  String get exampleUsage => 'उदाहरण उपयोग';

  @override
  String get personalNotes => 'व्यक्तिगत नोट्स';

  @override
  String storedOn(String date) {
    return 'सहेजा गया: $date';
  }

  @override
  String get shareEntry => 'प्रविष्टि साझा करें';

  @override
  String get copyEntry => 'प्रविष्टि कॉपी करें';

  @override
  String get uncategorized => 'अवर्गीकृत';

  @override
  String get cancelTooltip => 'रद्द करें';

  @override
  String get toggleSelectAllTooltip => 'सभी चुनें';

  @override
  String get deleteSelectedTooltip => 'चुनी हुई हटाएं';

  @override
  String get selectItemsTooltip => 'चुनें';

  @override
  String get sortOrderTooltip => 'क्रम';

  @override
  String get sortNewestFirst => 'नए पहले';

  @override
  String get sortOldestFirst => 'पुराने पहले';

  @override
  String get sortAtoZ => 'अ → ज्ञ';

  @override
  String get sortZtoA => 'ज्ञ → अ';

  @override
  String deleteItemsTitle(int count, String label) {
    return '$count $label हटाएं?';
  }

  @override
  String deleteItemsContent(int count, String label) {
    return 'क्या आप निश्चित हैं? यह क्रिया वापस नहीं की जा सकती।';
  }

  @override
  String deletedSuccess(int count) {
    return 'हटाए गए: $count';
  }

  @override
  String get collections => 'संग्रह';

  @override
  String get addCollection => 'संग्रह जोड़ें';

  @override
  String get editCollection => 'संग्रह संपादित करें';

  @override
  String get collectionName => 'संग्रह का नाम';

  @override
  String get collectionNameHint => 'नाम दर्ज करें';

  @override
  String get collectionDescription => 'विवरण';

  @override
  String get collectionDescriptionHint => 'विवरण दर्ज करें...';

  @override
  String get save => 'सहेजें';

  @override
  String get collectionCreated => 'संग्रह बनाया गया';

  @override
  String get collectionUpdated => 'संग्रह अपडेट किया गया';

  @override
  String get collectionDeleted => 'संग्रह हटाया गया';

  @override
  String deleteCollectionTitle(String name) {
    return '$name हटाएं?';
  }

  @override
  String get deleteCollectionContent =>
      'संग्रह हटाया जाएगा। प्रविष्टियां रहेंगी।';

  @override
  String get editCollectionTooltip => 'संग्रह संपादित करें';

  @override
  String get deleteCollectionTooltip => 'संग्रह हटाएं';

  @override
  String entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्रविष्टियां',
      one: '1 प्रविष्टि',
    );
    return '$_temp0';
  }

  @override
  String get noCollections => 'कोई संग्रह नहीं';

  @override
  String get noCollectionsDescription =>
      'प्रविष्टियां व्यवस्थित करने के लिए संग्रह बनाएं।';

  @override
  String get importPreview => 'आयात पूर्वावलोकन';

  @override
  String get entriesDetected => 'प्रविष्टियां मिलीं';

  @override
  String get collectionsDetected => 'संग्रह मिले';

  @override
  String get potentialDuplicates => 'संभावित डुप्लीकेट';

  @override
  String get resolutionStrategy => 'समाधान रणनीति';

  @override
  String get skipDuplicates => 'छोड़ें';

  @override
  String get overwriteDuplicates => 'ओवरराइट करें';

  @override
  String get mergeDuplicates => 'मर्ज करें';

  @override
  String get duplicateMatches => 'डुप्लीकेट मिलान';

  @override
  String get previewContent => 'फ़ाइल सामग्री';

  @override
  String rawContentLength(int length) {
    return '$length अक्षर';
  }

  @override
  String get importNow => 'अभी आयात करें';

  @override
  String get importing => 'आयात हो रहा है...';

  @override
  String importFailed(String error) {
    return 'आयात विफल: $error';
  }

  @override
  String existingEntry(String term, String type) {
    return '$term ($type)';
  }

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get appearance => 'दिखावट';

  @override
  String get appearanceSubtitle => 'थीम, प्रदर्शन घनत्व';

  @override
  String get navigationAndFeatures => 'नेविगेशन और सुविधाएं';

  @override
  String get navigationSubtitle => 'प्रारंभिक टैब, क्रम, सुविधाएं';

  @override
  String get tags => 'टैग';

  @override
  String get tagsSubtitle => 'टैग का नाम बदलें और हटाएं';

  @override
  String get data => 'डेटा';

  @override
  String get dataSubtitle => 'निर्यात, आयात और साफ़ करें';

  @override
  String get about => 'के बारे में';

  @override
  String get aboutSubtitle => 'संस्करण, लिंक, लाइसेंस';

  @override
  String get language => 'भाषा';

  @override
  String get languageSubtitle => 'इंटरफ़ेस भाषा चुनें';

  @override
  String get theme => 'थीम';

  @override
  String get pureBlack => 'शुद्ध काला (AMOLED)';

  @override
  String get pureBlackSubtitle => 'डार्क मोड में काली पृष्ठभूमि';

  @override
  String get viewOptions => 'देखने के विकल्प';

  @override
  String get displayDensity => 'प्रदर्शन घनत्व';

  @override
  String get compact => 'संक्षिप्त';

  @override
  String get compactDescription => 'केवल शब्द दिखाएं';

  @override
  String get comfortable => 'सुविधाजनक';

  @override
  String get comfortableDescription => 'शब्द और परिभाषा दिखाएं';

  @override
  String get detailed => 'विस्तृत';

  @override
  String get detailedDescription => 'सभी विवरण दिखाएं';

  @override
  String get showTagsOnCards => 'कार्ड पर टैग दिखाएं';

  @override
  String get showTagsSubtitle => 'टैग चिप्स प्रदर्शित करें';

  @override
  String get showTypeBadges => 'प्रकार बैज दिखाएं';

  @override
  String get showTypeBadgesSubtitle => 'शब्द, वाक्यांश, मुहावरा, उद्धरण बैज';

  @override
  String get typography => 'टाइपोग्राफी';

  @override
  String get fontStyle => 'फ़ॉन्ट शैली';

  @override
  String get system => 'सिस्टम (डिफ़ॉल्ट)';

  @override
  String get systemFontDescription => 'स्वच्छ आधुनिक फ़ॉन्ट';

  @override
  String get serif => 'सेरिफ़';

  @override
  String get serifDescription => 'पढ़ने के लिए क्लासिक फ़ॉन्ट';

  @override
  String get monospace => 'मोनोस्पेस';

  @override
  String get monospaceDescription => 'निश्चित-चौड़ाई फ़ॉन्ट';

  @override
  String get textSize => 'टेक्स्ट आकार';

  @override
  String get small => 'छोटा (85%)';

  @override
  String get smallDescription => 'स्क्रीन पर अधिक टेक्स्ट';

  @override
  String get defaultSize => 'डिफ़ॉल्ट (100%)';

  @override
  String get defaultSizeDescription => 'मानक पठनीयता';

  @override
  String get large => 'बड़ा (115%)';

  @override
  String get largeDescription => 'बड़ा टेक्स्ट';

  @override
  String get extraLarge => 'बहुत बड़ा (130%)';

  @override
  String get extraLargeDescription => 'अधिकतम पठनीयता';

  @override
  String get defaultLaunchScreen => 'डिफ़ॉल्ट लॉन्च स्क्रीन';

  @override
  String get defaultLaunchScreenSubtitle =>
      'MyLexicon खुलने पर दिखने वाली स्क्रीन';

  @override
  String get screenShownWhen => 'खुलने पर स्क्रीन';

  @override
  String get chooseStartingScreen => 'प्रारंभिक स्क्रीन चुनें';

  @override
  String get navigationTabOrder => 'नेविगेशन टैब क्रम';

  @override
  String get dragToReorder => 'क्रम बदलने के लिए खींचें।';

  @override
  String get disabled => 'अक्षम';

  @override
  String get categoryAndFeatureToggles => 'श्रेणी और सुविधा';

  @override
  String activeFeatures(int enabled, int total) {
    return '$total में से $enabled सक्रिय';
  }

  @override
  String get atLeastOneCategory => 'कम से कम एक श्रेणी सक्षम होनी चाहिए';

  @override
  String get navigationSegment => 'नेविगेशन';

  @override
  String get featuresSegment => 'सुविधाएं';

  @override
  String get featureWordSubtitle => 'शब्द और परिभाषाएं';

  @override
  String get featureIdiomSubtitle => 'मुहावरे और अर्थ';

  @override
  String get featurePhraseSubtitle => 'सामान्य वाक्यांश';

  @override
  String get featureQuoteSubtitle => 'यादगार उद्धरण';

  @override
  String get featureCollectionsSubtitle => 'संग्रह में व्यवस्थित करें';

  @override
  String get newTagName => 'नया टैग नाम';

  @override
  String get renameTag => 'नाम बदलें';

  @override
  String get renameTagTooltip => 'टैग का नाम बदलें';

  @override
  String get deleteTagTooltip => 'टैग हटाएं';

  @override
  String get tagRenamed => 'टैग का नाम बदला गया';

  @override
  String tagRenameError(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get tagDeleted => 'टैग हटाया गया';

  @override
  String tagDeleteError(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get noTags => 'कोई टैग नहीं';

  @override
  String get noTagsDescription => 'प्रविष्टियों में टैग जोड़ें।';

  @override
  String get exportData => 'डेटा निर्यात करें';

  @override
  String get exportDataSubtitle => 'डेटा को फ़ाइल में सहेजें';

  @override
  String get importData => 'डेटा आयात करें';

  @override
  String get importDataSubtitle => 'फ़ाइल से डेटा लोड करें';

  @override
  String get clearAllData => 'सभी डेटा साफ़ करें';

  @override
  String get clearAllDataSubtitle => 'सभी प्रविष्टियां और संग्रह हटाएं';

  @override
  String get loadSampleData => 'नमूना डेटा लोड करें';

  @override
  String get loadSampleDataSubtitle => 'परीक्षण प्रविष्टियां जोड़ें';

  @override
  String get deleteSampleData => 'नमूना डेटा हटाएं';

  @override
  String get deleteSampleDataSubtitle => 'परीक्षण प्रविष्टियां हटाएं';

  @override
  String get clearAllDataTitle => 'सभी डेटा साफ़ करें?';

  @override
  String get clearAllDataContent =>
      'क्या आप निश्चित हैं? सभी प्रविष्टियां और संग्रह हटा दिए जाएंगे।';

  @override
  String get loadSampleDataTitle => 'नमूना डेटा लोड करें?';

  @override
  String get loadSampleDataContent =>
      'नमूना प्रविष्टियां और संग्रह जोड़े जाएंगे।';

  @override
  String get deleteSampleDataTitle => 'नमूना डेटा हटाएं?';

  @override
  String get deleteSampleDataContent =>
      'नमूना प्रविष्टियां और संग्रह हटाए जाएंगे।';

  @override
  String get exportDataTitle => 'निर्यात प्रारूप';

  @override
  String get exportJson => 'JSON बैकअप';

  @override
  String get exportCsv => 'CSV स्प्रेडशीट';

  @override
  String get exportSuccess => 'डेटा सफलतापूर्वक निर्यात किया गया';

  @override
  String exportError(String error) {
    return 'निर्यात त्रुटि: $error';
  }

  @override
  String importSuccess(int count) {
    return '$count प्रविष्टियां आयात की गईं';
  }

  @override
  String importError(String error) {
    return 'आयात त्रुटि: $error';
  }

  @override
  String get clearSuccess => 'सभी डेटा हटा दिया गया';

  @override
  String get sampleDataLoaded => 'नमूना डेटा लोड हो गया';

  @override
  String get sampleDataDeleted => 'नमूना डेटा हटाया गया';

  @override
  String sampleDataDeleteError(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get sourceCode => 'स्रोत कोड';

  @override
  String get sourceCodeSubtitle => 'GitHub पर देखें';

  @override
  String get reportBug => 'बग रिपोर्ट करें';

  @override
  String get reportBugSubtitle => 'GitHub पर इश्यू खोलें';

  @override
  String get starOnGithub => 'GitHub पर स्टार';

  @override
  String get starOnGithubSubtitle => 'यदि My Lexicon उपयोगी है';

  @override
  String get openSourceLicenses => 'ओपन सोर्स लाइसेंस';

  @override
  String versionCopied(String version) {
    return 'संस्करण $version कॉपी किया गया';
  }

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

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
    return 'लोड करने में त्रुटि: $error';
  }

  @override
  String error(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get addNewEntry => 'नई प्रविष्टि जोड़ें';

  @override
  String get quoteText => 'उद्धरण का पाठ';

  @override
  String get meaningOrDefinition => 'अर्थ / परिभाषा';

  @override
  String get quoteContextMeaningNotes => 'संदर्भ / अर्थ / लेखक की टिप्पणी';

  @override
  String get meaningOrTranslation => 'अर्थ / अनुवाद';

  @override
  String get meaningOrOrigin => 'अर्थ / उत्पत्ति';

  @override
  String get selectEntryType => 'प्रविष्टि का प्रकार चुनें';

  @override
  String enterFieldHint(String field) {
    return '$field दर्ज करें...';
  }

  @override
  String fieldCannotBeEmpty(String field) {
    return '$field खाली नहीं हो सकता';
  }

  @override
  String get exampleSentences => 'उदाहरण वाक्य';

  @override
  String get quoteSourceExample => 'उदा. शेक्सपियर - हेमलेट, अंक III';

  @override
  String exampleNth(int number) {
    return 'उदाहरण $number...';
  }

  @override
  String get personalNotesOptional => 'व्यक्तिगत नोट्स (वैकल्पिक)';

  @override
  String get personalNotesHint =>
      'व्यक्तिगत नोट्स, स्मृति संकेत या संदर्भ जोड़ें...';

  @override
  String get collectionOptional => 'संग्रह (वैकल्पिक)';

  @override
  String get selectCollectionHint => 'एक संग्रह चुनें...';

  @override
  String get noneCollection => 'कोई नहीं';

  @override
  String errorLoadingCollections(String error) {
    return 'संग्रह लोड करने में त्रुटि: $error';
  }

  @override
  String get noTagsAddedYet => 'अभी तक कोई टैग नहीं जोड़ा गया';

  @override
  String get updateEntry => 'प्रविष्टि अपडेट करें';

  @override
  String get saveEntry => 'प्रविष्टि सहेजें';

  @override
  String get themeMode => 'थीम मोड';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get lightModeTheme => '☀ लाइट मोड थीम';

  @override
  String get darkModeTheme => '🌙 डार्क मोड थीम';

  @override
  String get dataImportExport => 'डेटा आयात और निर्यात';

  @override
  String get exportDataDescription =>
      'अपने लेक्सिकॉन का JSON बैकअप या CSV निर्यात अपने पसंदीदा स्थान पर सहेजें';

  @override
  String get dataStorage => 'डेटा संग्रहण';

  @override
  String get clearAllLocalData => 'सभी स्थानीय डेटा साफ़ करें';

  @override
  String get clearAllLocalDataSubtitle =>
      'सभी शब्द, उद्धरण, संग्रह और टैग स्थायी रूप से हटाएं';

  @override
  String get developerDebugMode => 'डेवलपर (डीबग मोड)';

  @override
  String get loadSampleDataSubtitle2 =>
      'प्रत्येक श्रेणी में 10 प्रविष्टियां जोड़ें (40 प्रविष्टियां)';

  @override
  String get deleteSampleDataSubtitle2 =>
      'केवल लोड की गई नमूना प्रविष्टियां और संग्रह हटाएं';

  @override
  String get unableToReadFile => 'चयनित फ़ाइल पढ़ने में असमर्थ।';

  @override
  String exportSavedTo(String path) {
    return 'निर्यात $path पर सहेजा गया';
  }

  @override
  String get saveLexiconExport => 'लेक्सिकॉन निर्यात सहेजें';

  @override
  String get chooseExportFormat =>
      'लेक्सिकॉन बैकअप के लिए निर्यात प्रारूप चुनें।';

  @override
  String renameTagTitle(String tag) {
    return 'टैग #$tag का नाम बदलें';
  }

  @override
  String tagRenamedSuccess(String oldTag, String newTag) {
    return 'टैग #$oldTag का नाम बदलकर #$newTag कर दिया गया';
  }

  @override
  String deleteTagTitle(String tag) {
    return 'टैग #$tag हटाएं?';
  }

  @override
  String deleteTagContent(String tag) {
    return 'क्या आप वाकई सभी प्रविष्टियों से टैग #$tag हटाना चाहते हैं? प्रविष्टियां स्वयं नहीं हटाई जाएंगी।';
  }

  @override
  String tagDeletedSuccess(String tag) {
    return 'टैग #$tag सभी प्रविष्टियों से हटा दिया गया';
  }

  @override
  String manageTags(int count) {
    return 'टैग प्रबंधित करें ($count)';
  }

  @override
  String get noTagsFoundDatabase =>
      'डेटाबेस में कोई टैग नहीं मिला। प्रविष्टियां बनाते या संपादित करते समय टैग जोड़े जा सकते हैं।';

  @override
  String get chooseColor => 'रंग चुनें';

  @override
  String get collectionNameCannotBeEmpty => 'संग्रह का नाम खाली नहीं हो सकता';

  @override
  String get create => 'बनाएं';

  @override
  String failedToDeleteCollection(String error) {
    return 'संग्रह हटाने में विफल: $error';
  }

  @override
  String get noCollectionsCreated => 'कोई संग्रह नहीं बनाया गया';

  @override
  String get noCollectionsCreatedDesc =>
      'पुनरीक्षण के लिए अपनी लेक्सिकॉन प्रविष्टियों को समूहित करने हेतु कस्टम फ़ोल्डर/संग्रह बनाएं।';

  @override
  String get createFirstCollection => 'पहला संग्रह बनाएं';

  @override
  String get noDescriptionProvided => 'कोई विवरण नहीं दिया गया';

  @override
  String get noDescriptionProvidedDetailed =>
      'इस संग्रह के लिए कोई विवरण नहीं दिया गया है।';

  @override
  String get close => 'बंद करें';

  @override
  String get collectionIsEmpty => 'संग्रह खाली है';

  @override
  String get collectionIsEmptyDesc =>
      'इस संग्रह में अभी तक कोई प्रविष्टि नहीं जोड़ी गई है। आप प्रविष्टि बनाते या संपादित करते समय इन्हें जोड़ सकते हैं।';

  @override
  String get selectATag => 'एक टैग चुनें';

  @override
  String get noTagsFoundInDatabase => 'डेटाबेस में कोई टैग नहीं मिला';

  @override
  String get selectTag => 'टैग चुनें';

  @override
  String get noResultsFound => 'कोई परिणाम नहीं मिला';

  @override
  String get tryAdjustingSearch => 'अपने खोज शब्द या फ़िल्टर बदलकर देखें।';

  @override
  String get startAddingNewEntries =>
      'जोड़ें बटन का उपयोग करके नई प्रविष्टियां जोड़ना प्रारंभ करें।';

  @override
  String alreadyExistsInCollection(String collection) {
    return 'पहले से ही \"$collection\" में मौजूद है';
  }

  @override
  String get alreadyExistsUnassigned =>
      'पहले से ही बिना संग्रह वाली प्रविष्टि के रूप में मौजूद है';

  @override
  String get duplicateIfDifferentCollection =>
      'यदि यह प्रविष्टि किसी अन्य संग्रह की है, तो नीचे संग्रह फ़ील्ड बदलें और पुनः सहेजें।';

  @override
  String get duplicateIfDifferentUsage =>
      'यदि यह एक अलग उपयोग है, तो नीचे दिए गए संग्रह फ़ील्ड का उपयोग करके इसे किसी विशिष्ट संग्रह में असाइन करें और पुनः सहेजें।';

  @override
  String get duplicateEntryDetected => 'डुप्लिकेट प्रविष्टि पाई गई';

  @override
  String get viewExistingEntry => 'मौजूदा प्रविष्टि देखें';

  @override
  String get appTagline => 'आपका व्यक्तिगत ज्ञान साथी';

  @override
  String get links => 'लिंक्स';

  @override
  String get githubUrl => 'github.com/aryany9/MyLexicon';

  @override
  String get ifYouFindUseful => 'यदि My Lexicon आपके लिए उपयोगी है';

  @override
  String get legal => 'कानूनी जानकारी';

  @override
  String get madeWith => 'के साथ निर्मित ';

  @override
  String get inIndia => ' भारत में';

  @override
  String get byAuthor => 'Aryan Yadav द्वारा';

  @override
  String get clearAllDataQuestion => 'सभी डेटा साफ़ करें?';

  @override
  String get clearAllDataWarning =>
      'यह क्रिया आपके सभी संग्रहीत शब्दों, उद्धरणों, वाक्यांशों, मुहावरों और संग्रहों को स्थायी रूप से हटा देगी।\n\nयह क्रिया वापस नहीं ली जा सकती। क्या आप जारी रखना चाहते हैं?';

  @override
  String get allDataCleared => 'सभी डेटा सफलतापूर्वक साफ़ कर दिया गया';

  @override
  String errorClearingData(String error) {
    return 'डेटा साफ़ करने में त्रुटि: $error';
  }

  @override
  String get clearEverything => 'सब कुछ साफ़ करें';

  @override
  String get loadSampleDataWarning =>
      'यह नमूना संग्रहों के साथ प्रत्येक श्रेणी के लिए 10 चयनित प्रविष्टियां (10 शब्द, 10 वाक्यांश, 10 मुहावरे और 10 उद्धरण) जोड़ेगा।\n\n• मौजूदा नमूना प्रविष्टियां अपडेट हो जाएंगी।\n• मेल खाने वाले शब्दों के साथ आपके द्वारा बनाई गई कोई भी कस्टम प्रविष्टि सुरक्षित रहेगी।';

  @override
  String loadedSampleEntries(int count) {
    return 'सभी श्रेणियों में $count नमूना प्रविष्टियां लोड की गईं!';
  }

  @override
  String loadedSampleEntriesSkipped(int added, int skipped) {
    return '$added नमूना प्रविष्टियां लोड की गईं ($skipped मौजूदा कस्टम डुप्लिकेट के रूप में छोड़ दी गईं)।';
  }

  @override
  String refreshedSampleEntries(int count) {
    return '$count नमूना प्रविष्टियां अपडेट की गईं।';
  }

  @override
  String refreshedSampleEntriesSkipped(int updated, int skipped) {
    return '$updated नमूना प्रविष्टियां अपडेट की गईं ($skipped कस्टम प्रविष्टियां सुरक्षित रखी गईं)।';
  }

  @override
  String allSampleTermsExist(int skipped) {
    return 'सभी $skipped नमूना शब्द पहले से ही आपके लेक्सिकॉन में कस्टम प्रविष्टियों के रूप में मौजूद हैं।';
  }

  @override
  String errorLoadingSampleData(String error) {
    return 'नमूना डेटा लोड करने में त्रुटि: $error';
  }

  @override
  String get deleteSampleDataQuestion => 'नमूना डेटा हटाएं?';

  @override
  String get deleteSampleDataWarning =>
      'यह सभी लोड की गई नमूना प्रविष्टियों और संग्रहों को हटा देगा।\n\nआपकी अपनी प्रविष्टियां और संग्रह सुरक्षित रहेंगे।';

  @override
  String deletedSampleEntries(int count) {
    return '$count नमूना प्रविष्टियां और संग्रह हटाए गए।';
  }

  @override
  String get noSampleEntriesFound =>
      'हटाने के लिए कोई नमूना प्रविष्टि नहीं मिली।';

  @override
  String exportFailed(String error) {
    return 'निर्यात विफल: $error';
  }

  @override
  String importedEntriesDetails(
    int added,
    int skipped,
    int overwritten,
    int merged,
  ) {
    return '$added नई आयात की गईं, $skipped छोड़ी गईं, $overwritten ओवरराइट की गईं, $merged मर्ज की गईं।';
  }

  @override
  String aboutSubtitleWithVersion(String version) {
    return 'v$version · लाइसेंस और लिंक';
  }

  @override
  String get tamil => 'தமிழ் (Tamil)';

  @override
  String get telugu => 'తెలుగు (Telugu)';
}
