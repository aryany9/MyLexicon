// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get navDashboard => 'داشبورد';

  @override
  String get navWords => 'کلمات';

  @override
  String get navPhrases => 'عبارات';

  @override
  String get navIdioms => 'اصطلاحات';

  @override
  String get navQuotes => 'نقل‌قول‌ها';

  @override
  String get navCollections => 'مجموعه‌ها';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get appTitle => 'My Lexicon';

  @override
  String get yourLexiconStats => 'آمار لغت‌نامه';

  @override
  String get quickActions => 'اقدامات سریع';

  @override
  String get recentEntries => 'ورودی‌های اخیر';

  @override
  String get viewAll => 'همه';

  @override
  String get yourTags => 'برچسب‌های شما';

  @override
  String get searchTags => 'جستجوی برچسب‌ها';

  @override
  String get yourLexiconIsEmpty => 'لغت‌نامه خالی است';

  @override
  String get emptyStateDescription => 'کلمات، عبارات یا نقل‌قول‌ها اضافه کنید.';

  @override
  String get addFirstEntry => 'افزودن اولین ورودی';

  @override
  String get favorites => 'موردعلاقه‌ها';

  @override
  String get typeWord => 'کلمه';

  @override
  String get typeQuote => 'نقل‌قول';

  @override
  String get typePhrase => 'عبارت';

  @override
  String get typeIdiom => 'اصطلاح';

  @override
  String get typeWords => 'کلمات';

  @override
  String get typeQuotes => 'نقل‌قول‌ها';

  @override
  String get typePhrases => 'عبارات';

  @override
  String get typeIdioms => 'اصطلاحات';

  @override
  String get searchAndFilter => 'جستجو و فیلتر';

  @override
  String get searchHint => 'جستجوی اصطلاح یا تعریف...';

  @override
  String get reset => 'بازنشانی';

  @override
  String get clearFilters => 'پاک کردن فیلترها';

  @override
  String get searchTitle => 'جستجو';

  @override
  String get addEntry => 'افزودن ورودی';

  @override
  String get addWord => 'افزودن کلمه';

  @override
  String get addPhrase => 'افزودن عبارت';

  @override
  String get addIdiom => 'افزودن اصطلاح';

  @override
  String get addQuote => 'افزودن نقل‌قول';

  @override
  String get editEntry => 'ویرایش ورودی';

  @override
  String get saveTooltip => 'ذخیره';

  @override
  String get termLabel => 'اصطلاح';

  @override
  String get termHint => 'اصطلاح را وارد کنید';

  @override
  String get definitionLabel => 'تعریف';

  @override
  String get definitionHint => 'تعریف را وارد کنید';

  @override
  String get exampleLabel => 'مثال';

  @override
  String get exampleHint => 'مثال را وارد کنید';

  @override
  String get notesHint => 'یادداشت‌ها را وارد کنید';

  @override
  String get addExample => 'افزودن مثال';

  @override
  String get removeExampleTooltip => 'حذف مثال';

  @override
  String get selectCollection => 'انتخاب مجموعه';

  @override
  String get markAsFavorite => 'افزودن به موردعلاقه';

  @override
  String get markAsFavoriteSubtitle => 'دسترسی سریع به این ورودی.';

  @override
  String get tagInputHint => 'افزودن برچسب...';

  @override
  String get entryCreatedSuccess => 'ورودی ایجاد شد';

  @override
  String get entryUpdatedSuccess => 'ورودی به‌روز شد';

  @override
  String duplicateTermError(String type) {
    return 'این $type از قبل وجود دارد';
  }

  @override
  String get entryNotFound => 'ورودی یافت نشد';

  @override
  String get entryDetails => 'جزئیات ورودی';

  @override
  String get editTooltip => 'ویرایش';

  @override
  String get deleteTooltip => 'حذف';

  @override
  String get favoriteTooltip => 'افزودن به موردعلاقه';

  @override
  String get unfavoriteTooltip => 'حذف از موردعلاقه';

  @override
  String get deleteEntryTitle => 'حذف ورودی؟';

  @override
  String deleteEntryContent(String term) {
    return 'آیا مطمئن هستید که می‌خواهید “$term” را حذف کنید؟ این عمل قابل بازگشت نیست.';
  }

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get deleteSuccess => 'ورودی حذف شد';

  @override
  String deleteError(String error) {
    return 'خطا در حذف: $error';
  }

  @override
  String failedToUpdateFavorite(String error) {
    return 'به‌روزرسانی وضعیت موردعلاقه انجام نشد: $error';
  }

  @override
  String get contextAndMeaning => 'زمینه و معنی';

  @override
  String get meaningAndInterpretation => 'معنی و تفسیر';

  @override
  String get sourceContext => 'زمینه منبع';

  @override
  String get examples => 'مثال‌ها';

  @override
  String get exampleUsage => 'نمونه کاربرد';

  @override
  String get personalNotes => 'یادداشت‌های شخصی';

  @override
  String storedOn(String date) {
    return 'ذخیره‌شده در $date';
  }

  @override
  String get shareEntry => 'اشتراک‌گذاری ورودی';

  @override
  String get copyEntry => 'کپی ورودی';

  @override
  String get uncategorized => 'دسته‌بندی نشده';

  @override
  String get cancelTooltip => 'لغو';

  @override
  String get toggleSelectAllTooltip => 'انتخاب همه';

  @override
  String get deleteSelectedTooltip => 'حذف موارد انتخابی';

  @override
  String get selectItemsTooltip => 'انتخاب';

  @override
  String get sortOrderTooltip => 'ترتیب مرتب‌سازی';

  @override
  String get sortNewestFirst => 'جدیدترین ابتدا';

  @override
  String get sortOldestFirst => 'قدیمی‌ترین ابتدا';

  @override
  String get sortAtoZ => 'الف → ی';

  @override
  String get sortZtoA => 'ی → الف';

  @override
  String deleteItemsTitle(int count, String label) {
    return 'حذف $count $label؟';
  }

  @override
  String deleteItemsContent(int count, String label) {
    return 'آیا مطمئن هستید؟ این عمل قابل بازگشت نیست.';
  }

  @override
  String deletedSuccess(int count) {
    return 'حذف شد: $count';
  }

  @override
  String get collections => 'مجموعه‌ها';

  @override
  String get addCollection => 'افزودن مجموعه';

  @override
  String get editCollection => 'ویرایش مجموعه';

  @override
  String get collectionName => 'نام مجموعه';

  @override
  String get collectionNameHint => 'نام را وارد کنید';

  @override
  String get collectionDescription => 'توضیحات';

  @override
  String get collectionDescriptionHint => 'توضیحات را وارد کنید...';

  @override
  String get save => 'ذخیره';

  @override
  String get collectionCreated => 'مجموعه ایجاد شد';

  @override
  String get collectionUpdated => 'مجموعه به‌روز شد';

  @override
  String get collectionDeleted => 'مجموعه حذف شد';

  @override
  String deleteCollectionTitle(String name) {
    return 'حذف $name؟';
  }

  @override
  String get deleteCollectionContent =>
      'مجموعه حذف خواهد شد. ورودی‌ها باقی می‌مانند.';

  @override
  String get editCollectionTooltip => 'ویرایش مجموعه';

  @override
  String get deleteCollectionTooltip => 'حذف مجموعه';

  @override
  String entriesCount(int count) {
    return '$count ورودی';
  }

  @override
  String get noCollections => 'مجموعه‌ای وجود ندارد';

  @override
  String get noCollectionsDescription =>
      'یک مجموعه برای سازماندهی ورودی‌ها ایجاد کنید.';

  @override
  String get importPreview => 'پیش‌نمایش وارد کردن';

  @override
  String get entriesDetected => 'ورودی‌های یافت‌شده';

  @override
  String get collectionsDetected => 'مجموعه‌های یافت‌شده';

  @override
  String get potentialDuplicates => 'موارد تکراری احتمالی';

  @override
  String get resolutionStrategy => 'استراتژی حل تعارض';

  @override
  String get skipDuplicates => 'رد کردن';

  @override
  String get overwriteDuplicates => 'بازنویسی';

  @override
  String get mergeDuplicates => 'ادغام';

  @override
  String get duplicateMatches => 'موارد تکراری یافت‌شده';

  @override
  String get previewContent => 'محتوای فایل';

  @override
  String rawContentLength(int length) {
    return '$length کاراکتر';
  }

  @override
  String get importNow => 'وارد کردن';

  @override
  String get importing => 'در حال وارد کردن...';

  @override
  String importFailed(String error) {
    return 'خطا در وارد کردن: $error';
  }

  @override
  String existingEntry(String term, String type) {
    return '$term ($type)';
  }

  @override
  String get settings => 'تنظیمات';

  @override
  String get appearance => 'ظاهر';

  @override
  String get appearanceSubtitle => 'تم، تراکم نمایش';

  @override
  String get navigationAndFeatures => 'ناوبری و ویژگی‌ها';

  @override
  String get navigationSubtitle => 'صفحه شروع، برگه‌ها، ویژگی‌ها';

  @override
  String get tags => 'برچسب‌ها';

  @override
  String get tagsSubtitle => 'تغییر نام و حذف برچسب‌ها';

  @override
  String get data => 'داده‌ها';

  @override
  String get dataSubtitle => 'صادر کردن، وارد کردن و پاک کردن';

  @override
  String get about => 'درباره';

  @override
  String get aboutSubtitle => 'نسخه، پیوندها، مجوزها';

  @override
  String get language => 'زبان';

  @override
  String get languageSubtitle => 'انتخاب زبان رابط کاربری';

  @override
  String get theme => 'تم';

  @override
  String get pureBlack => 'سیاه خالص (AMOLED)';

  @override
  String get pureBlackSubtitle => 'استفاده از پس‌زمینه سیاه در حالت تاریک';

  @override
  String get viewOptions => 'گزینه‌های نمایش';

  @override
  String get displayDensity => 'تراکم نمایش';

  @override
  String get compact => 'فشرده';

  @override
  String get compactDescription => 'فقط اصطلاح را نشان بده';

  @override
  String get comfortable => 'راحت';

  @override
  String get comfortableDescription => 'اصطلاح و تعریف را نشان بده';

  @override
  String get detailed => 'تفصیلی';

  @override
  String get detailedDescription => 'همه جزئیات را نشان بده';

  @override
  String get showTagsOnCards => 'نمایش برچسب‌ها روی کارت‌ها';

  @override
  String get showTagsSubtitle => 'نمایش تراشه‌های برچسب';

  @override
  String get showTypeBadges => 'نمایش نشان‌های نوع';

  @override
  String get showTypeBadgesSubtitle =>
      'نمایش نشان‌های کلمه، عبارت، اصطلاح، نقل‌قول';

  @override
  String get typography => 'تایپوگرافی';

  @override
  String get fontStyle => 'سبک فونت';

  @override
  String get system => 'سیستمی (پیش‌فرض)';

  @override
  String get systemFontDescription => 'فونت مدرن و تمیز';

  @override
  String get serif => 'سریف';

  @override
  String get serifDescription => 'فونت کلاسیک برای خواندن';

  @override
  String get monospace => 'تک‌فاصله';

  @override
  String get monospaceDescription => 'فونت با عرض ثابت';

  @override
  String get textSize => 'اندازه متن';

  @override
  String get small => 'کوچک (85%)';

  @override
  String get smallDescription => 'متن بیشتر روی صفحه';

  @override
  String get defaultSize => 'پیش‌فرض (100%)';

  @override
  String get defaultSizeDescription => 'خوانایی استاندارد';

  @override
  String get large => 'بزرگ (115%)';

  @override
  String get largeDescription => 'متن بزرگ‌تر';

  @override
  String get extraLarge => 'خیلی بزرگ (130%)';

  @override
  String get extraLargeDescription => 'حداکثر خوانایی';

  @override
  String get defaultLaunchScreen => 'صفحه پیش‌فرض';

  @override
  String get defaultLaunchScreenSubtitle =>
      'صفحه نمایش هنگام باز شدن MyLexicon';

  @override
  String get screenShownWhen => 'صفحه هنگام باز شدن';

  @override
  String get chooseStartingScreen => 'صفحه شروع را انتخاب کنید';

  @override
  String get navigationTabOrder => 'ترتیب برگه‌های ناوبری';

  @override
  String get dragToReorder => 'برای تغییر ترتیب بکشید.';

  @override
  String get disabled => 'غیرفعال';

  @override
  String get categoryAndFeatureToggles => 'دسته‌بندی‌ها و ویژگی‌ها';

  @override
  String activeFeatures(int enabled, int total) {
    return '$enabled از $total فعال';
  }

  @override
  String get atLeastOneCategory => 'حداقل یک دسته‌بندی باید فعال باشد';

  @override
  String get navigationSegment => 'ناوبری';

  @override
  String get featuresSegment => 'ویژگی‌ها';

  @override
  String get featureWordSubtitle => 'واژگان';

  @override
  String get featureIdiomSubtitle => 'عبارات مجازی';

  @override
  String get featurePhraseSubtitle => 'عبارات رایج';

  @override
  String get featureQuoteSubtitle => 'نقل‌قول‌ها و یادداشت‌ها';

  @override
  String get featureCollectionsSubtitle => 'سازماندهی در مجموعه‌ها';

  @override
  String get newTagName => 'نام جدید برچسب';

  @override
  String get renameTag => 'تغییر نام';

  @override
  String get renameTagTooltip => 'تغییر نام برچسب';

  @override
  String get deleteTagTooltip => 'حذف برچسب';

  @override
  String get tagRenamed => 'برچسب تغییر نام یافت';

  @override
  String tagRenameError(String error) {
    return 'خطا: $error';
  }

  @override
  String get tagDeleted => 'برچسب حذف شد';

  @override
  String tagDeleteError(String error) {
    return 'خطا: $error';
  }

  @override
  String get noTags => 'برچسبی وجود ندارد';

  @override
  String get noTagsDescription => 'برچسب‌ها را به ورودی‌ها اضافه کنید.';

  @override
  String get exportData => 'صادر کردن داده';

  @override
  String get exportDataSubtitle => 'ذخیره داده در فایل';

  @override
  String get importData => 'وارد کردن داده';

  @override
  String get importDataSubtitle => 'بارگذاری داده از فایل';

  @override
  String get clearAllData => 'پاک کردن همه داده‌ها';

  @override
  String get clearAllDataSubtitle => 'حذف همه ورودی‌ها و مجموعه‌ها';

  @override
  String get loadSampleData => 'بارگذاری داده نمونه';

  @override
  String get loadSampleDataSubtitle => 'افزودن ورودی‌های تستی برای نمایش';

  @override
  String get deleteSampleData => 'حذف داده نمونه';

  @override
  String get deleteSampleDataSubtitle => 'حذف ورودی‌های تستی';

  @override
  String get clearAllDataTitle => 'پاک کردن همه داده‌ها؟';

  @override
  String get clearAllDataContent =>
      'آیا مطمئن هستید؟ همه ورودی‌ها و مجموعه‌ها برای همیشه حذف خواهند شد.';

  @override
  String get loadSampleDataTitle => 'بارگذاری داده نمونه؟';

  @override
  String get loadSampleDataContent =>
      'این کار ورودی‌ها و مجموعه‌های تستی را به لغت‌نامه شما اضافه می‌کند.';

  @override
  String get deleteSampleDataTitle => 'حذف داده نمونه؟';

  @override
  String get deleteSampleDataContent =>
      'این کار ورودی‌ها و مجموعه‌های نمونه را حذف می‌کند.';

  @override
  String get exportDataTitle => 'فرمت صادر کردن';

  @override
  String get exportJson => 'پشتیبان‌گیری JSON';

  @override
  String get exportCsv => 'صفحه گسترده CSV';

  @override
  String get exportSuccess => 'داده‌ها با موفقیت صادر شدند';

  @override
  String exportError(String error) {
    return 'خطا در صادر کردن: $error';
  }

  @override
  String importSuccess(int count) {
    return '$count ورودی وارد شد';
  }

  @override
  String importError(String error) {
    return 'خطا در وارد کردن: $error';
  }

  @override
  String get clearSuccess => 'همه داده‌ها پاک شدند';

  @override
  String get sampleDataLoaded => 'داده‌های نمونه بارگذاری شدند';

  @override
  String get sampleDataDeleted => 'داده‌های نمونه حذف شدند';

  @override
  String sampleDataDeleteError(String error) {
    return 'خطا در حذف داده‌های نمونه: $error';
  }

  @override
  String get sourceCode => 'کد منبع';

  @override
  String get sourceCodeSubtitle => 'مشاهده در GitHub';

  @override
  String get reportBug => 'گزارش مشکل';

  @override
  String get reportBugSubtitle => 'باز کردن یک مسئله در GitHub';

  @override
  String get starOnGithub => 'ستاره در GitHub';

  @override
  String get starOnGithubSubtitle => 'پشتیبانی از پروژه';

  @override
  String get openSourceLicenses => 'مجوزهای متن‌باز';

  @override
  String versionCopied(String version) {
    return 'نسخه $version در کلیپ‌بورد کپی شد';
  }

  @override
  String get selectLanguage => 'انتخاب زبان';

  @override
  String get systemDefault => 'پیش‌فرض سیستم';

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
    return 'خطا در بارگذاری: $error';
  }

  @override
  String error(String error) {
    return 'خطا: $error';
  }

  @override
  String get addNewEntry => 'افزودن ورودی جدید';

  @override
  String get quoteText => 'متن نقل‌قول';

  @override
  String get meaningOrDefinition => 'معنی / تعریف';

  @override
  String get quoteContextMeaningNotes => 'زمینه / معنی / یادداشت‌های نویسنده';

  @override
  String get meaningOrTranslation => 'معنی / ترجمه';

  @override
  String get meaningOrOrigin => 'معنی / ریشه';

  @override
  String get selectEntryType => 'انتخاب نوع ورودی';

  @override
  String enterFieldHint(String field) {
    return '$field را وارد کنید...';
  }

  @override
  String fieldCannotBeEmpty(String field) {
    return '$field نمی‌تواند خالی باشد';
  }

  @override
  String get exampleSentences => 'جملات نمونه';

  @override
  String get quoteSourceExample => 'مثلاً: شکسپیر - هملت، پرده ۳';

  @override
  String exampleNth(int number) {
    return 'مثال $number...';
  }

  @override
  String get personalNotesOptional => 'یادداشت‌های شخصی (اختیاری)';

  @override
  String get personalNotesHint =>
      'افزودن یادداشت‌های شخصی، سرنخ‌ها یا ارجاعات...';

  @override
  String get collectionOptional => 'مجموعه (اختیاری)';

  @override
  String get selectCollectionHint => 'انتخاب یک مجموعه...';

  @override
  String get noneCollection => 'هیچ‌کدام';

  @override
  String errorLoadingCollections(String error) {
    return 'خطا در بارگذاری مجموعه‌ها: $error';
  }

  @override
  String get noTagsAddedYet => 'هنوز برچسبی اضافه نشده است';

  @override
  String get updateEntry => 'به‌روزرسانی ورودی';

  @override
  String get saveEntry => 'ذخیره ورودی';

  @override
  String get themeMode => 'حالت تم';

  @override
  String get themeSystem => 'سیستمی';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get lightModeTheme => '☀ تم حالت روشن';

  @override
  String get darkModeTheme => '🌙 تم حالت تاریک';

  @override
  String get dataImportExport => 'صادر کردن و وارد کردن داده';

  @override
  String get exportDataDescription =>
      'ذخیره نسخه پشتیبان JSON یا جدول CSV از لغت‌نامه در مکان انتخابی شما';

  @override
  String get dataStorage => 'ذخیره‌سازی داده';

  @override
  String get clearAllLocalData => 'پاک کردن تمام داده‌های محلی';

  @override
  String get clearAllLocalDataSubtitle =>
      'حذف دائمی تمام کلمات، نقل‌قول‌ها، مجموعه‌ها و برچسب‌ها';

  @override
  String get developerDebugMode => 'توسعه‌دهنده (حالت اشکال‌زدایی)';

  @override
  String get loadSampleDataSubtitle2 =>
      'افزودن ۱۰ مورد در هر دسته‌بندی (۴۰ ورودی)';

  @override
  String get deleteSampleDataSubtitle2 =>
      'فقط حذف ورودی‌ها و مجموعه‌های نمونه بارگذاری‌شده';

  @override
  String get unableToReadFile => 'خواندن فایل انتخاب‌شده امکان‌پذیر نیست.';

  @override
  String exportSavedTo(String path) {
    return 'صادرات در $path ذخیره شد';
  }

  @override
  String get saveLexiconExport => 'ذخیره صادرات لغت‌نامه';

  @override
  String get chooseExportFormat =>
      'فرمت صادر کردن نسخه پشتیبان لغت‌نامه را انتخاب کنید.';

  @override
  String renameTagTitle(String tag) {
    return 'تغییر نام برچسب #$tag';
  }

  @override
  String tagRenamedSuccess(String oldTag, String newTag) {
    return 'برچسب #$oldTag به #$newTag تغییر نام یافت';
  }

  @override
  String deleteTagTitle(String tag) {
    return 'حذف برچسب #$tag؟';
  }

  @override
  String deleteTagContent(String tag) {
    return 'آیا مطمئن هستید که می‌خواهید برچسب #$tag را از تمام ورودی‌ها حذف کنید؟ خود ورودی‌ها حذف نخواهند شد.';
  }

  @override
  String tagDeletedSuccess(String tag) {
    return 'برچسب #$tag از تمام ورودی‌ها حذف شد';
  }

  @override
  String manageTags(int count) {
    return 'مدیریت برچسب‌ها ($count)';
  }

  @override
  String get noTagsFoundDatabase =>
      'هیچ برچسبی در پایگاه داده یافت نشد. برچسب‌ها را می‌توان هنگام ایجاد یا ویرایش ورودی‌ها اضافه کرد.';

  @override
  String get chooseColor => 'انتخاب رنگ';

  @override
  String get collectionNameCannotBeEmpty => 'نام مجموعه نمی‌تواند خالی باشد';

  @override
  String get create => 'ایجاد';

  @override
  String failedToDeleteCollection(String error) {
    return 'خطا در حذف مجموعه: $error';
  }

  @override
  String get noCollectionsCreated => 'هیچ مجموعه‌ای ایجاد نشده است';

  @override
  String get noCollectionsCreatedDesc =>
      'پوشه‌ها/مجموعه‌های سفارشی ایجاد کنید تا ورودی‌های لغت‌نامه خود را برای مرور سازماندهی کنید.';

  @override
  String get createFirstCollection => 'ایجاد اولین مجموعه';

  @override
  String get noDescriptionProvided => 'توضیحاتی ارائه نشده است';

  @override
  String get noDescriptionProvidedDetailed =>
      'هیچ توضیحی برای این مجموعه ارائه نشده است.';

  @override
  String get close => 'بستن';

  @override
  String get collectionIsEmpty => 'مجموعه خالی است';

  @override
  String get collectionIsEmptyDesc =>
      'هنوز هیچ ورودی به این مجموعه اختصاص نیافته است. می‌توانید هنگام ایجاد یا ویرایش ورودی آنها را اختصاص دهید.';

  @override
  String get selectATag => 'انتخاب یک برچسب';

  @override
  String get noTagsFoundInDatabase => 'هیچ برچسبی در پایگاه داده یافت نشد';

  @override
  String get selectTag => 'انتخاب برچسب';

  @override
  String get noResultsFound => 'نتیجه‌ای یافت نشد';

  @override
  String get tryAdjustingSearch => 'عبارت جستجو یا فیلترها را تغییر دهید.';

  @override
  String get startAddingNewEntries =>
      'با استفاده از دکمه افزودن، ورودی‌های جدید اضافه کنید.';

  @override
  String alreadyExistsInCollection(String collection) {
    return 'از قبل در «$collection» وجود دارد';
  }

  @override
  String get alreadyExistsUnassigned =>
      'از قبل به عنوان ورودی بدون مجموعه وجود دارد';

  @override
  String get duplicateIfDifferentCollection =>
      'اگر این ورودی متعلق به مجموعه دیگری است، فیلد مجموعه را در زیر تغییر دهید و دوباره روی ذخیره ضربه بزنید.';

  @override
  String get duplicateIfDifferentUsage =>
      'اگر این یک کاربرد متفاوت است، آن را با استفاده از فیلد مجموعه در زیر به یک مجموعه خاص اختصاص دهید و دوباره ذخیره کنید.';

  @override
  String get duplicateEntryDetected => 'ورودی تکراری شناسایی شد';

  @override
  String get viewExistingEntry => 'مشاهده ورودی موجود';

  @override
  String get appTagline => 'همراه دانش شخصی شما';

  @override
  String get links => 'پیوندها';

  @override
  String get githubUrl => 'github.com/aryany9/MyLexicon';

  @override
  String get ifYouFindUseful => 'اگر My Lexicon برای شما مفید است';

  @override
  String get legal => 'قوانین و مجوزها';

  @override
  String get madeWith => 'ساخته شده با ';

  @override
  String get inIndia => ' در هند';

  @override
  String get byAuthor => 'توسط Aryan Yadav';

  @override
  String get clearAllDataQuestion => 'پاک کردن تمام داده‌ها؟';

  @override
  String get clearAllDataWarning =>
      'این عمل تمام کلمات، نقل‌قول‌ها، عبارات، اصطلاحات و مجموعه‌های ذخیره‌شده شما را برای همیشه حذف می‌کند.\n\nاین عمل غیرقابل بازگشت است. آیا مطمئن هستید؟';

  @override
  String get allDataCleared => 'تمام داده‌ها با موفقیت پاک شدند';

  @override
  String errorClearingData(String error) {
    return 'خطا در پاک کردن داده‌ها: $error';
  }

  @override
  String get clearEverything => 'پاک کردن همه‌چیز';

  @override
  String get loadSampleDataWarning =>
      'این عمل ۱۰ ورودی منتخب برای هر دسته‌بندی (۱۰ کلمه، ۱۰ عبارت، ۱۰ اصطلاح و ۱۰ نقل‌قول) به همراه مجموعه‌های نمونه اضافه می‌کند.\n\n• ورودی‌های نمونه موجود به‌روزرسانی می‌شوند.\n• هرگونه ورودی سفارشی که با اصطلاحات منطبق ایجاد کرده‌اید حفظ می‌شود.';

  @override
  String loadedSampleEntries(int count) {
    return '$count ورودی نمونه در تمام دسته‌بندی‌ها بارگذاری شد!';
  }

  @override
  String loadedSampleEntriesSkipped(int added, int skipped) {
    return '$added ورودی نمونه بارگذاری شد ($skipped مورد به عنوان ورودی تکراری سفارشی نادیده گرفته شد).';
  }

  @override
  String refreshedSampleEntries(int count) {
    return '$count ورودی نمونه بازنشانی شد.';
  }

  @override
  String refreshedSampleEntriesSkipped(int updated, int skipped) {
    return '$updated ورودی نمونه بازنشانی شد ($skipped ورودی سفارشی حفظ شد).';
  }

  @override
  String allSampleTermsExist(int skipped) {
    return 'تمام $skipped اصطلاح نمونه از قبل در لغت‌نامه شما به عنوان ورودی سفارشی وجود دارند.';
  }

  @override
  String errorLoadingSampleData(String error) {
    return 'خطا در بارگذاری داده‌های نمونه: $error';
  }

  @override
  String get deleteSampleDataQuestion => 'حذف داده‌های نمونه؟';

  @override
  String get deleteSampleDataWarning =>
      'این عمل تمام ورودی‌ها و مجموعه‌های نمونه را حذف خواهد کرد.\n\nورودی‌ها و مجموعه‌های سفارشی خودتان دست‌نخورده باقی می‌مانند.';

  @override
  String deletedSampleEntries(int count) {
    return '$count ورودی و مجموعه نمونه حذف شدند.';
  }

  @override
  String get noSampleEntriesFound => 'هیچ ورودی نمونه‌ای برای حذف یافت نشد.';

  @override
  String exportFailed(String error) {
    return 'خطا در صدور: $error';
  }

  @override
  String importedEntriesDetails(
    int added,
    int skipped,
    int overwritten,
    int merged,
  ) {
    return '$added مورد جدید وارد شد، $skipped مورد رد شد، $overwritten مورد بازنویسی شد، $merged مورد ادغام شد.';
  }

  @override
  String aboutSubtitleWithVersion(String version) {
    return 'نسخه $version · مجوزها و پیوندها';
  }

  @override
  String get tamil => 'தமிழ் (Tamil)';

  @override
  String get telugu => 'తెలుగు (Telugu)';
}
