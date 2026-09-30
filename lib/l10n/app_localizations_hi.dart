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
    return '$count प्रविष्टियां';
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
}
