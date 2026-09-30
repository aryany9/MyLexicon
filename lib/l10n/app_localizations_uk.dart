// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get navDashboard => 'Головна';

  @override
  String get navWords => 'Слова';

  @override
  String get navPhrases => 'Фрази';

  @override
  String get navIdioms => 'Ідіоми';

  @override
  String get navQuotes => 'Цитати';

  @override
  String get navCollections => 'Колекції';

  @override
  String get navSettings => 'Налаштування';

  @override
  String get appTitle => 'My Lexicon';

  @override
  String get yourLexiconStats => 'Статистика лексикону';

  @override
  String get quickActions => 'Швидкі дії';

  @override
  String get recentEntries => 'Останні записи';

  @override
  String get viewAll => 'Всі';

  @override
  String get yourTags => 'Ваші теги';

  @override
  String get searchTags => 'Пошук тегів';

  @override
  String get yourLexiconIsEmpty => 'Лексикон порожній';

  @override
  String get emptyStateDescription => 'Додайте слова, фрази або цитати.';

  @override
  String get addFirstEntry => 'Додати запис';

  @override
  String get favorites => 'Улюблені';

  @override
  String get typeWord => 'Слово';

  @override
  String get typeQuote => 'Цитата';

  @override
  String get typePhrase => 'Фраза';

  @override
  String get typeIdiom => 'Ідіома';

  @override
  String get typeWords => 'Слова';

  @override
  String get typeQuotes => 'Цитати';

  @override
  String get typePhrases => 'Фрази';

  @override
  String get typeIdioms => 'Ідіоми';

  @override
  String get searchAndFilter => 'Пошук і фільтр';

  @override
  String get searchHint => 'Пошук терміна або визначення...';

  @override
  String get reset => 'Скинути';

  @override
  String get clearFilters => 'Очистити фільтри';

  @override
  String get searchTitle => 'Пошук';

  @override
  String get addEntry => 'Додати запис';

  @override
  String get addWord => 'Додати слово';

  @override
  String get addPhrase => 'Додати фразу';

  @override
  String get addIdiom => 'Додати ідіому';

  @override
  String get addQuote => 'Додати цитату';

  @override
  String get editEntry => 'Редагувати запис';

  @override
  String get saveTooltip => 'Зберегти';

  @override
  String get termLabel => 'Термін';

  @override
  String get termHint => 'Введіть термін';

  @override
  String get definitionLabel => 'Визначення';

  @override
  String get definitionHint => 'Введіть визначення';

  @override
  String get exampleLabel => 'Приклад';

  @override
  String get exampleHint => 'Введіть приклад';

  @override
  String get notesHint => 'Введіть нотатки';

  @override
  String get addExample => 'Додати приклад';

  @override
  String get removeExampleTooltip => 'Видалити приклад';

  @override
  String get selectCollection => 'Вибрати колекцію';

  @override
  String get markAsFavorite => 'Додати до улюблених';

  @override
  String get markAsFavoriteSubtitle => 'Швидкий доступ до запису.';

  @override
  String get tagInputHint => 'Додати тег...';

  @override
  String get entryCreatedSuccess => 'Запис створено';

  @override
  String get entryUpdatedSuccess => 'Запис оновлено';

  @override
  String duplicateTermError(String type) {
    return 'Цей $type вже існує';
  }

  @override
  String get entryNotFound => 'Запис не знайдено';

  @override
  String get entryDetails => 'Деталі запису';

  @override
  String get editTooltip => 'Редагувати';

  @override
  String get deleteTooltip => 'Видалити';

  @override
  String get favoriteTooltip => 'В улюблені';

  @override
  String get unfavoriteTooltip => 'З улюблених';

  @override
  String get deleteEntryTitle => 'Видалити запис?';

  @override
  String deleteEntryContent(String term) {
    return 'Ви впевнені, що хочете видалити “$term”? Цю дію не можна скасувати.';
  }

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get deleteSuccess => 'Запис видалено';

  @override
  String deleteError(String error) {
    return 'Помилка видалення: $error';
  }

  @override
  String failedToUpdateFavorite(String error) {
    return 'Не вдалося оновити статус улюбленого: $error';
  }

  @override
  String get contextAndMeaning => 'Контекст і значення';

  @override
  String get meaningAndInterpretation => 'Значення та тлумачення';

  @override
  String get sourceContext => 'Контекст джерела';

  @override
  String get examples => 'Приклади';

  @override
  String get exampleUsage => 'Приклад вживання';

  @override
  String get personalNotes => 'Особисті нотатки';

  @override
  String storedOn(String date) {
    return 'Збережено: $date';
  }

  @override
  String get shareEntry => 'Поділитися записом';

  @override
  String get copyEntry => 'Копіювати запис';

  @override
  String get uncategorized => 'Без категорії';

  @override
  String get cancelTooltip => 'Скасувати';

  @override
  String get toggleSelectAllTooltip => 'Вибрати всі';

  @override
  String get deleteSelectedTooltip => 'Видалити вибрані';

  @override
  String get selectItemsTooltip => 'Вибрати';

  @override
  String get sortOrderTooltip => 'Порядок сортування';

  @override
  String get sortNewestFirst => 'Спочатку нові';

  @override
  String get sortOldestFirst => 'Спочатку старі';

  @override
  String get sortAtoZ => 'А → Я';

  @override
  String get sortZtoA => 'Я → А';

  @override
  String deleteItemsTitle(int count, String label) {
    return 'Видалити $count $label?';
  }

  @override
  String deleteItemsContent(int count, String label) {
    return 'Ви впевнені? Цю дію не можна скасувати.';
  }

  @override
  String deletedSuccess(int count) {
    return 'Видалено: $count';
  }

  @override
  String get collections => 'Колекції';

  @override
  String get addCollection => 'Додати колекцію';

  @override
  String get editCollection => 'Редагувати колекцію';

  @override
  String get collectionName => 'Назва колекції';

  @override
  String get collectionNameHint => 'Введіть назву';

  @override
  String get collectionDescription => 'Опис';

  @override
  String get collectionDescriptionHint => 'Введіть опис...';

  @override
  String get save => 'Зберегти';

  @override
  String get collectionCreated => 'Колекцію створено';

  @override
  String get collectionUpdated => 'Колекцію оновлено';

  @override
  String get collectionDeleted => 'Колекцію видалено';

  @override
  String deleteCollectionTitle(String name) {
    return 'Видалити $name?';
  }

  @override
  String get deleteCollectionContent =>
      'Колекцію буде видалено. Записи залишаться.';

  @override
  String get editCollectionTooltip => 'Редагувати колекцію';

  @override
  String get deleteCollectionTooltip => 'Видалити колекцію';

  @override
  String entriesCount(int count) {
    return '$count записів';
  }

  @override
  String get noCollections => 'Немає колекцій';

  @override
  String get noCollectionsDescription =>
      'Створіть колекцію для організації записів.';

  @override
  String get importPreview => 'Попередній перегляд імпорту';

  @override
  String get entriesDetected => 'Записів виявлено';

  @override
  String get collectionsDetected => 'Колекцій виявлено';

  @override
  String get potentialDuplicates => 'Можливі дублікати';

  @override
  String get resolutionStrategy => 'Стратегія вирішення';

  @override
  String get skipDuplicates => 'Пропустити';

  @override
  String get overwriteDuplicates => 'Перезаписати';

  @override
  String get mergeDuplicates => 'Злити';

  @override
  String get duplicateMatches => 'Збіги дублікатів';

  @override
  String get previewContent => 'Вміст файлу';

  @override
  String rawContentLength(int length) {
    return '$length симв.';
  }

  @override
  String get importNow => 'Імпортувати';

  @override
  String get importing => 'Імпортування...';

  @override
  String importFailed(String error) {
    return 'Помилка імпорту: $error';
  }

  @override
  String existingEntry(String term, String type) {
    return '$term ($type)';
  }

  @override
  String get settings => 'Налаштування';

  @override
  String get appearance => 'Зовнішній вигляд';

  @override
  String get appearanceSubtitle => 'Тема, щільність відображення';

  @override
  String get navigationAndFeatures => 'Навігація та функції';

  @override
  String get navigationSubtitle => 'Початковий екран, вкладки, функції';

  @override
  String get tags => 'Теги';

  @override
  String get tagsSubtitle => 'Перейменовувати та видаляти теги';

  @override
  String get data => 'Дані';

  @override
  String get dataSubtitle => 'Експорт, імпорт та очищення';

  @override
  String get about => 'Про додаток';

  @override
  String get aboutSubtitle => 'Версія, посилання, ліцензії';

  @override
  String get language => 'Мова';

  @override
  String get languageSubtitle => 'Вибрати мову інтерфейсу';

  @override
  String get theme => 'Тема';

  @override
  String get pureBlack => 'Чистий чорний (AMOLED)';

  @override
  String get pureBlackSubtitle => 'Використовувати чорний фон у темній темі';

  @override
  String get viewOptions => 'Параметри перегляду';

  @override
  String get displayDensity => 'Щільність відображення';

  @override
  String get compact => 'Компактний';

  @override
  String get compactDescription => 'Показати лише термін';

  @override
  String get comfortable => 'Зручний';

  @override
  String get comfortableDescription => 'Показати термін та визначення';

  @override
  String get detailed => 'Детальний';

  @override
  String get detailedDescription => 'Показати всі деталі';

  @override
  String get showTagsOnCards => 'Показувати теги на картках';

  @override
  String get showTagsSubtitle => 'Відображати чіпи тегів';

  @override
  String get showTypeBadges => 'Показувати значки типу';

  @override
  String get showTypeBadgesSubtitle =>
      'Відображати значки Слово, Фраза, Ідіома, Цитата';

  @override
  String get typography => 'Типографіка';

  @override
  String get fontStyle => 'Стиль шрифту';

  @override
  String get system => 'Системний (за замовчуванням)';

  @override
  String get systemFontDescription => 'Чистий сучасний шрифт';

  @override
  String get serif => 'Серифний';

  @override
  String get serifDescription => 'Класичний шрифт для читання';

  @override
  String get monospace => 'Моноширинний';

  @override
  String get monospaceDescription => 'Шрифт фіксованої ширини';

  @override
  String get textSize => 'Розмір тексту';

  @override
  String get small => 'Малий (85%)';

  @override
  String get smallDescription => 'Більше тексту на екрані';

  @override
  String get defaultSize => 'За замовчуванням (100%)';

  @override
  String get defaultSizeDescription => 'Стандартна читабельність';

  @override
  String get large => 'Великий (115%)';

  @override
  String get largeDescription => 'Збільшений текст';

  @override
  String get extraLarge => 'Дуже великий (130%)';

  @override
  String get extraLargeDescription => 'Максимальна читабельність';

  @override
  String get defaultLaunchScreen => 'Початковий екран';

  @override
  String get defaultLaunchScreenSubtitle => 'Екран запуску MyLexicon';

  @override
  String get screenShownWhen => 'Екран при відкритті';

  @override
  String get chooseStartingScreen => 'Виберіть початковий екран';

  @override
  String get navigationTabOrder => 'Порядок вкладок навігації';

  @override
  String get dragToReorder => 'Перетягніть для зміни порядку.';

  @override
  String get disabled => 'Вимкнено';

  @override
  String get categoryAndFeatureToggles => 'Категорії та функції';

  @override
  String activeFeatures(int enabled, int total) {
    return '$enabled із $total активних';
  }

  @override
  String get atLeastOneCategory =>
      'Принаймні одна категорія має бути ввімкнена';

  @override
  String get navigationSegment => 'Навігація';

  @override
  String get featuresSegment => 'Функції';

  @override
  String get featureWordSubtitle => 'Словниковий запас';

  @override
  String get featureIdiomSubtitle => 'Образні вирази';

  @override
  String get featurePhraseSubtitle => 'Поширені фрази';

  @override
  String get featureQuoteSubtitle => 'Цитати та нотатки';

  @override
  String get featureCollectionsSubtitle => 'Організувати у колекції';

  @override
  String get newTagName => 'Нова назва тегу';

  @override
  String get renameTag => 'Перейменувати';

  @override
  String get renameTagTooltip => 'Перейменувати тег';

  @override
  String get deleteTagTooltip => 'Видалити тег';

  @override
  String get tagRenamed => 'Тег перейменовано';

  @override
  String tagRenameError(String error) {
    return 'Помилка: $error';
  }

  @override
  String get tagDeleted => 'Тег видалено';

  @override
  String tagDeleteError(String error) {
    return 'Помилка: $error';
  }

  @override
  String get noTags => 'Немає тегів';

  @override
  String get noTagsDescription => 'Додайте теги до записів.';

  @override
  String get exportData => 'Експорт даних';

  @override
  String get exportDataSubtitle => 'Зберегти дані у файл';

  @override
  String get importData => 'Імпорт даних';

  @override
  String get importDataSubtitle => 'Завантажити дані з файлу';

  @override
  String get clearAllData => 'Очистити всі дані';

  @override
  String get clearAllDataSubtitle => 'Видалити всі записи та колекції';

  @override
  String get loadSampleData => 'Завантажити зразкові дані';

  @override
  String get loadSampleDataSubtitle => 'Додати тестові записи';

  @override
  String get deleteSampleData => 'Видалити зразкові дані';

  @override
  String get deleteSampleDataSubtitle => 'Видалити тестові записи';

  @override
  String get clearAllDataTitle => 'Очистити всі дані?';

  @override
  String get clearAllDataContent =>
      'Ви впевнені? Усі записи та колекції будуть видалені.';

  @override
  String get loadSampleDataTitle => 'Завантажити зразкові дані?';

  @override
  String get loadSampleDataContent => 'Це додасть тестові записи та колекції.';

  @override
  String get deleteSampleDataTitle => 'Видалити зразкові дані?';

  @override
  String get deleteSampleDataContent =>
      'Зразкові записи та колекції будуть видалені.';

  @override
  String get exportDataTitle => 'Формат експорту';

  @override
  String get exportJson => 'JSON резервна копія';

  @override
  String get exportCsv => 'CSV таблиця';

  @override
  String get exportSuccess => 'Дані успішно експортовано';

  @override
  String exportError(String error) {
    return 'Помилка експорту: $error';
  }

  @override
  String importSuccess(int count) {
    return 'Імпортовано $count записів';
  }

  @override
  String importError(String error) {
    return 'Помилка імпорту: $error';
  }

  @override
  String get clearSuccess => 'Всі дані видалено';

  @override
  String get sampleDataLoaded => 'Зразкові дані завантажено';

  @override
  String get sampleDataDeleted => 'Зразкові дані видалено';

  @override
  String sampleDataDeleteError(String error) {
    return 'Помилка: $error';
  }

  @override
  String get sourceCode => 'Вихідний код';

  @override
  String get sourceCodeSubtitle => 'Переглянути на GitHub';

  @override
  String get reportBug => 'Повідомити про помилку';

  @override
  String get reportBugSubtitle => 'Відкрити завдання на GitHub';

  @override
  String get starOnGithub => 'Зірочка на GitHub';

  @override
  String get starOnGithubSubtitle => 'Підтримати проект';

  @override
  String get openSourceLicenses => 'Ліцензії відкритого коду';

  @override
  String versionCopied(String version) {
    return 'Версію $version скопійовано';
  }

  @override
  String get selectLanguage => 'Вибрати мову';

  @override
  String get systemDefault => 'За замовчуванням системи';

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
    return 'Помилка завантаження: $error';
  }

  @override
  String error(String error) {
    return 'Помилка: $error';
  }

  @override
  String get addNewEntry => 'Додати новий запис';

  @override
  String get quoteText => 'Текст цитати';

  @override
  String get meaningOrDefinition => 'Значення / Визначення';

  @override
  String get quoteContextMeaningNotes =>
      'Контекст / Значення / Примітки автора';

  @override
  String get meaningOrTranslation => 'Значення / Переклад';

  @override
  String get meaningOrOrigin => 'Значення / Походження';

  @override
  String get selectEntryType => 'Виберіть тип запису';

  @override
  String enterFieldHint(String field) {
    return 'Введіть $field...';
  }

  @override
  String fieldCannotBeEmpty(String field) {
    return '$field не може бути порожнім';
  }

  @override
  String get exampleSentences => 'Приклади речень';

  @override
  String get quoteSourceExample => 'напр., Шекспір — Гамлет, Дія III';

  @override
  String exampleNth(int number) {
    return 'Приклад $number...';
  }

  @override
  String get personalNotesOptional => 'Особисті нотатки (необов\'язково)';

  @override
  String get personalNotesHint =>
      'Додайте особисті нотатки, асоціації чи посилання...';

  @override
  String get collectionOptional => 'Колекція (необов\'язково)';

  @override
  String get selectCollectionHint => 'Виберіть колекцію...';

  @override
  String get noneCollection => 'Немає';

  @override
  String errorLoadingCollections(String error) {
    return 'Помилка завантаження колекцій: $error';
  }

  @override
  String get noTagsAddedYet => 'Тегів ще не додано';

  @override
  String get updateEntry => 'Оновити запис';

  @override
  String get saveEntry => 'Зберегти запис';
}
