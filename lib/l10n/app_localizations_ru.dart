// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navDashboard => 'Главная';

  @override
  String get navWords => 'Слова';

  @override
  String get navPhrases => 'Фразы';

  @override
  String get navIdioms => 'Идиомы';

  @override
  String get navQuotes => 'Цитаты';

  @override
  String get navCollections => 'Коллекции';

  @override
  String get navSettings => 'Настройки';

  @override
  String get appTitle => 'My Lexicon';

  @override
  String get yourLexiconStats => 'Статистика лексикона';

  @override
  String get quickActions => 'Быстрые действия';

  @override
  String get recentEntries => 'Последние записи';

  @override
  String get viewAll => 'Все';

  @override
  String get yourTags => 'Ваши теги';

  @override
  String get searchTags => 'Поиск тегов';

  @override
  String get yourLexiconIsEmpty => 'Лексикон пуст';

  @override
  String get emptyStateDescription => 'Добавьте слова, фразы или цитаты.';

  @override
  String get addFirstEntry => 'Добавить запись';

  @override
  String get favorites => 'Избранное';

  @override
  String get typeWord => 'Слово';

  @override
  String get typeQuote => 'Цитата';

  @override
  String get typePhrase => 'Фраза';

  @override
  String get typeIdiom => 'Идиома';

  @override
  String get typeWords => 'Слова';

  @override
  String get typeQuotes => 'Цитаты';

  @override
  String get typePhrases => 'Фразы';

  @override
  String get typeIdioms => 'Идиомы';

  @override
  String get searchAndFilter => 'Поиск и фильтр';

  @override
  String get searchHint => 'Поиск термина или определения...';

  @override
  String get reset => 'Сбросить';

  @override
  String get clearFilters => 'Очистить фильтры';

  @override
  String get searchTitle => 'Поиск';

  @override
  String get addEntry => 'Добавить запись';

  @override
  String get addWord => 'Добавить слово';

  @override
  String get addPhrase => 'Добавить фразу';

  @override
  String get addIdiom => 'Добавить идиому';

  @override
  String get addQuote => 'Добавить цитату';

  @override
  String get editEntry => 'Редактировать запись';

  @override
  String get saveTooltip => 'Сохранить';

  @override
  String get termLabel => 'Термин';

  @override
  String get termHint => 'Введите термин';

  @override
  String get definitionLabel => 'Определение';

  @override
  String get definitionHint => 'Введите определение';

  @override
  String get exampleLabel => 'Пример';

  @override
  String get exampleHint => 'Введите пример';

  @override
  String get notesHint => 'Введите заметки';

  @override
  String get addExample => 'Добавить пример';

  @override
  String get removeExampleTooltip => 'Удалить пример';

  @override
  String get selectCollection => 'Выбрать коллекцию';

  @override
  String get markAsFavorite => 'В избранное';

  @override
  String get markAsFavoriteSubtitle => 'Быстрый доступ к записи.';

  @override
  String get tagInputHint => 'Добавить тег...';

  @override
  String get entryCreatedSuccess => 'Запись создана';

  @override
  String get entryUpdatedSuccess => 'Запись обновлена';

  @override
  String duplicateTermError(String type) {
    return 'Этот $type уже существует';
  }

  @override
  String get entryNotFound => 'Запись не найдена';

  @override
  String get entryDetails => 'Детали записи';

  @override
  String get editTooltip => 'Редактировать';

  @override
  String get deleteTooltip => 'Удалить';

  @override
  String get favoriteTooltip => 'В избранное';

  @override
  String get unfavoriteTooltip => 'Из избранного';

  @override
  String get deleteEntryTitle => 'Удалить запись?';

  @override
  String deleteEntryContent(String term) {
    return 'Вы уверены, что хотите удалить «$term»? Это действие необратимо.';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteSuccess => 'Запись удалена';

  @override
  String deleteError(String error) {
    return 'Ошибка удаления: $error';
  }

  @override
  String failedToUpdateFavorite(String error) {
    return 'Не удалось обновить статус избранного: $error';
  }

  @override
  String get contextAndMeaning => 'Контекст и значение';

  @override
  String get meaningAndInterpretation => 'Значение и толкование';

  @override
  String get sourceContext => 'Контекст источника';

  @override
  String get examples => 'Примеры';

  @override
  String get exampleUsage => 'Пример использования';

  @override
  String get personalNotes => 'Личные заметки';

  @override
  String storedOn(String date) {
    return 'Сохранено: $date';
  }

  @override
  String get shareEntry => 'Поделиться записью';

  @override
  String get copyEntry => 'Копировать запись';

  @override
  String get uncategorized => 'Без категории';

  @override
  String get cancelTooltip => 'Отмена';

  @override
  String get toggleSelectAllTooltip => 'Выбрать все';

  @override
  String get deleteSelectedTooltip => 'Удалить выбранные';

  @override
  String get selectItemsTooltip => 'Выбрать';

  @override
  String get sortOrderTooltip => 'Порядок сортировки';

  @override
  String get sortNewestFirst => 'Сначала новые';

  @override
  String get sortOldestFirst => 'Сначала старые';

  @override
  String get sortAtoZ => 'А → Я';

  @override
  String get sortZtoA => 'Я → А';

  @override
  String deleteItemsTitle(int count, String label) {
    return 'Удалить $count $label?';
  }

  @override
  String deleteItemsContent(int count, String label) {
    return 'Вы уверены? Это действие необратимо.';
  }

  @override
  String deletedSuccess(int count) {
    return 'Удалено: $count';
  }

  @override
  String get collections => 'Коллекции';

  @override
  String get addCollection => 'Добавить коллекцию';

  @override
  String get editCollection => 'Редактировать коллекцию';

  @override
  String get collectionName => 'Название коллекции';

  @override
  String get collectionNameHint => 'Введите название';

  @override
  String get collectionDescription => 'Описание';

  @override
  String get collectionDescriptionHint => 'Введите описание...';

  @override
  String get save => 'Сохранить';

  @override
  String get collectionCreated => 'Коллекция создана';

  @override
  String get collectionUpdated => 'Коллекция обновлена';

  @override
  String get collectionDeleted => 'Коллекция удалена';

  @override
  String deleteCollectionTitle(String name) {
    return 'Удалить $name?';
  }

  @override
  String get deleteCollectionContent =>
      'Коллекция будет удалена. Записи останутся.';

  @override
  String get editCollectionTooltip => 'Редактировать коллекцию';

  @override
  String get deleteCollectionTooltip => 'Удалить коллекцию';

  @override
  String entriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count записей',
      many: '$count записей',
      few: '$count записи',
      one: '$count запись',
    );
    return '$_temp0';
  }

  @override
  String get noCollections => 'Нет коллекций';

  @override
  String get noCollectionsDescription =>
      'Создайте коллекцию для организации записей.';

  @override
  String get importPreview => 'Предварительный просмотр импорта';

  @override
  String get entriesDetected => 'Записей обнаружено';

  @override
  String get collectionsDetected => 'Коллекций обнаружено';

  @override
  String get potentialDuplicates => 'Возможные дубликаты';

  @override
  String get resolutionStrategy => 'Стратегия разрешения';

  @override
  String get skipDuplicates => 'Пропустить';

  @override
  String get overwriteDuplicates => 'Перезаписать';

  @override
  String get mergeDuplicates => 'Объединить';

  @override
  String get duplicateMatches => 'Совпадения дубликатов';

  @override
  String get previewContent => 'Содержимое файла';

  @override
  String rawContentLength(int length) {
    return '$length симв.';
  }

  @override
  String get importNow => 'Импортировать';

  @override
  String get importing => 'Импортирование...';

  @override
  String importFailed(String error) {
    return 'Ошибка импорта: $error';
  }

  @override
  String existingEntry(String term, String type) {
    return '$term ($type)';
  }

  @override
  String get settings => 'Настройки';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get appearanceSubtitle => 'Тема, плотность отображения';

  @override
  String get navigationAndFeatures => 'Навигация и функции';

  @override
  String get navigationSubtitle => 'Начальный экран, вкладки, функции';

  @override
  String get tags => 'Теги';

  @override
  String get tagsSubtitle => 'Переименовывать и удалять теги';

  @override
  String get data => 'Данные';

  @override
  String get dataSubtitle => 'Экспорт, импорт и очистка';

  @override
  String get about => 'О приложении';

  @override
  String get aboutSubtitle => 'Версия, ссылки, лицензии';

  @override
  String get language => 'Язык';

  @override
  String get languageSubtitle => 'Выбрать язык интерфейса';

  @override
  String get theme => 'Тема';

  @override
  String get pureBlack => 'Чистый чёрный (AMOLED)';

  @override
  String get pureBlackSubtitle => 'Использовать чёрный фон в тёмной теме';

  @override
  String get viewOptions => 'Параметры отображения';

  @override
  String get displayDensity => 'Плотность отображения';

  @override
  String get compact => 'Компактный';

  @override
  String get compactDescription => 'Показать только термин';

  @override
  String get comfortable => 'Удобный';

  @override
  String get comfortableDescription => 'Показать термин и определение';

  @override
  String get detailed => 'Подробный';

  @override
  String get detailedDescription => 'Показать все детали';

  @override
  String get showTagsOnCards => 'Показывать теги на карточках';

  @override
  String get showTagsSubtitle => 'Отображать чипы тегов';

  @override
  String get showTypeBadges => 'Показывать значки типа';

  @override
  String get showTypeBadgesSubtitle =>
      'Отображать значки Слово, Фраза, Идиома, Цитата';

  @override
  String get typography => 'Типографика';

  @override
  String get fontStyle => 'Стиль шрифта';

  @override
  String get system => 'Системный (по умолчанию)';

  @override
  String get systemFontDescription => 'Чистый современный шрифт';

  @override
  String get serif => 'Серифный';

  @override
  String get serifDescription => 'Классический шрифт для чтения';

  @override
  String get monospace => 'Моноширинный';

  @override
  String get monospaceDescription => 'Шрифт фиксированной ширины';

  @override
  String get textSize => 'Размер текста';

  @override
  String get small => 'Маленький (85%)';

  @override
  String get smallDescription => 'Больше текста на экране';

  @override
  String get defaultSize => 'По умолчанию (100%)';

  @override
  String get defaultSizeDescription => 'Стандартная читаемость';

  @override
  String get large => 'Большой (115%)';

  @override
  String get largeDescription => 'Увеличенный текст';

  @override
  String get extraLarge => 'Очень большой (130%)';

  @override
  String get extraLargeDescription => 'Максимальная читаемость';

  @override
  String get defaultLaunchScreen => 'Начальный экран';

  @override
  String get defaultLaunchScreenSubtitle => 'Экран запуска MyLexicon';

  @override
  String get screenShownWhen => 'Экран при открытии';

  @override
  String get chooseStartingScreen => 'Выберите начальный экран';

  @override
  String get navigationTabOrder => 'Порядок вкладок навигации';

  @override
  String get dragToReorder => 'Перетащите для изменения порядка.';

  @override
  String get disabled => 'Отключено';

  @override
  String get categoryAndFeatureToggles => 'Категории и функции';

  @override
  String activeFeatures(int enabled, int total) {
    return '$enabled из $total активных';
  }

  @override
  String get atLeastOneCategory =>
      'Хотя бы одна категория должна быть включена';

  @override
  String get navigationSegment => 'Навигация';

  @override
  String get featuresSegment => 'Функции';

  @override
  String get featureWordSubtitle => 'Словарный запас';

  @override
  String get featureIdiomSubtitle => 'Образные выражения';

  @override
  String get featurePhraseSubtitle => 'Распространённые фразы';

  @override
  String get featureQuoteSubtitle => 'Цитаты и заметки';

  @override
  String get featureCollectionsSubtitle => 'Организовать в коллекции';

  @override
  String get newTagName => 'Новое название тега';

  @override
  String get renameTag => 'Переименовать';

  @override
  String get renameTagTooltip => 'Переименовать тег';

  @override
  String get deleteTagTooltip => 'Удалить тег';

  @override
  String get tagRenamed => 'Тег переименован';

  @override
  String tagRenameError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get tagDeleted => 'Тег удалён';

  @override
  String tagDeleteError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get noTags => 'Нет тегов';

  @override
  String get noTagsDescription => 'Добавьте теги к записям.';

  @override
  String get exportData => 'Экспорт данных';

  @override
  String get exportDataSubtitle => 'Сохранить данные в файл';

  @override
  String get importData => 'Импорт данных';

  @override
  String get importDataSubtitle => 'Загрузить данные из файла';

  @override
  String get clearAllData => 'Очистить все данные';

  @override
  String get clearAllDataSubtitle => 'Удалить все записи и коллекции';

  @override
  String get loadSampleData => 'Загрузить примеры данных';

  @override
  String get loadSampleDataSubtitle => 'Добавить тестовые записи';

  @override
  String get deleteSampleData => 'Удалить примеры данных';

  @override
  String get deleteSampleDataSubtitle => 'Удалить тестовые записи';

  @override
  String get clearAllDataTitle => 'Очистить все данные?';

  @override
  String get clearAllDataContent =>
      'Вы уверены? Все записи и коллекции будут удалены.';

  @override
  String get loadSampleDataTitle => 'Загрузить примеры данных?';

  @override
  String get loadSampleDataContent =>
      'Это добавит тестовые записи и коллекции.';

  @override
  String get deleteSampleDataTitle => 'Удалить примеры данных?';

  @override
  String get deleteSampleDataContent =>
      'Примеры записей и коллекций будут удалены.';

  @override
  String get exportDataTitle => 'Формат экспорта';

  @override
  String get exportJson => 'Резервная копия JSON';

  @override
  String get exportCsv => 'Таблица CSV';

  @override
  String get exportSuccess => 'Данные успешно экспортированы';

  @override
  String exportError(String error) {
    return 'Ошибка экспорта: $error';
  }

  @override
  String importSuccess(int count) {
    return 'Импортировано $count записей';
  }

  @override
  String importError(String error) {
    return 'Ошибка импорта: $error';
  }

  @override
  String get clearSuccess => 'Все данные удалены';

  @override
  String get sampleDataLoaded => 'Примеры данных загружены';

  @override
  String get sampleDataDeleted => 'Примеры данных удалены';

  @override
  String sampleDataDeleteError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get sourceCode => 'Исходный код';

  @override
  String get sourceCodeSubtitle => 'Просмотреть на GitHub';

  @override
  String get reportBug => 'Сообщить об ошибке';

  @override
  String get reportBugSubtitle => 'Открыть задачу на GitHub';

  @override
  String get starOnGithub => 'Звёздочка на GitHub';

  @override
  String get starOnGithubSubtitle => 'Поддержать проект';

  @override
  String get openSourceLicenses => 'Лицензии открытого ПО';

  @override
  String versionCopied(String version) {
    return 'Версия $version скопирована';
  }

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get systemDefault => 'Системный по умолчанию';

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
    return 'Ошибка загрузки: $error';
  }

  @override
  String error(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get addNewEntry => 'Добавить новую запись';

  @override
  String get quoteText => 'Текст цитаты';

  @override
  String get meaningOrDefinition => 'Значение / Определение';

  @override
  String get quoteContextMeaningNotes => 'Контекст / Значение / Заметки автора';

  @override
  String get meaningOrTranslation => 'Значение / Перевод';

  @override
  String get meaningOrOrigin => 'Значение / Происхождение';

  @override
  String get selectEntryType => 'Выберите тип записи';

  @override
  String enterFieldHint(String field) {
    return 'Введите $field...';
  }

  @override
  String fieldCannotBeEmpty(String field) {
    return '$field не может быть пустым';
  }

  @override
  String get exampleSentences => 'Примеры предложений';

  @override
  String get quoteSourceExample => 'напр., Шекспир — Гамлет, Действие III';

  @override
  String exampleNth(int number) {
    return 'Пример $number...';
  }

  @override
  String get personalNotesOptional => 'Личные заметки (необязательно)';

  @override
  String get personalNotesHint =>
      'Добавьте личные заметки, ассоциации или ссылки...';

  @override
  String get collectionOptional => 'Коллекция (необязательно)';

  @override
  String get selectCollectionHint => 'Выберите коллекцию...';

  @override
  String get noneCollection => 'Нет';

  @override
  String errorLoadingCollections(String error) {
    return 'Ошибка загрузки коллекций: $error';
  }

  @override
  String get noTagsAddedYet => 'Теги ещё не добавлены';

  @override
  String get updateEntry => 'Обновить запись';

  @override
  String get saveEntry => 'Сохранить запись';

  @override
  String get themeMode => 'Режим темы';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get lightModeTheme => '☀ Светлая тема';

  @override
  String get darkModeTheme => '🌙 Тёмная тема';

  @override
  String get dataImportExport => 'Импорт и экспорт данных';

  @override
  String get exportDataDescription =>
      'Сохраните резервную копию JSON или экспорт CSV вашего лексикона в выбранное место';

  @override
  String get dataStorage => 'Хранилище данных';

  @override
  String get clearAllLocalData => 'Очистить все локальные данные';

  @override
  String get clearAllLocalDataSubtitle =>
      'Безвозвратно удалить все слова, цитаты, коллекции и теги';

  @override
  String get developerDebugMode => 'Разработчик (Режим отладки)';

  @override
  String get loadSampleDataSubtitle2 =>
      'Добавить по 10 элементов в каждую категорию (40 записей)';

  @override
  String get deleteSampleDataSubtitle2 =>
      'Удалить только загруженные примеры записей и коллекций';

  @override
  String get unableToReadFile => 'Не удалось прочитать выбранный файл.';

  @override
  String exportSavedTo(String path) {
    return 'Экспорт сохранён в $path';
  }

  @override
  String get saveLexiconExport => 'Сохранить экспорт лексикона';

  @override
  String get chooseExportFormat =>
      'Выберите формат экспорта для резервной копии лексикона.';

  @override
  String renameTagTitle(String tag) {
    return 'Переименовать тег #$tag';
  }

  @override
  String tagRenamedSuccess(String oldTag, String newTag) {
    return 'Тег #$oldTag переименован в #$newTag';
  }

  @override
  String deleteTagTitle(String tag) {
    return 'Удалить тег #$tag?';
  }

  @override
  String deleteTagContent(String tag) {
    return 'Вы уверены, что хотите удалить тег #$tag из всех записей? Сами записи НЕ будут удалены.';
  }

  @override
  String tagDeletedSuccess(String tag) {
    return 'Тег #$tag удалён из всех записей';
  }

  @override
  String manageTags(int count) {
    return 'Управление тегами ($count)';
  }

  @override
  String get noTagsFoundDatabase =>
      'В базе данных не найдено тегов. Теги можно добавлять при создании или редактировании записей.';

  @override
  String get chooseColor => 'Выбрать цвет';

  @override
  String get collectionNameCannotBeEmpty =>
      'Название коллекции не может быть пустым';

  @override
  String get create => 'Создать';

  @override
  String failedToDeleteCollection(String error) {
    return 'Не удалось удалить коллекцию: $error';
  }

  @override
  String get noCollectionsCreated => 'Коллекции не созданы';

  @override
  String get noCollectionsCreatedDesc =>
      'Создавайте свои папки/коллекции для группировки записей и удобного повторения.';

  @override
  String get createFirstCollection => 'Создать первую коллекцию';

  @override
  String get noDescriptionProvided => 'Описание отсутствует';

  @override
  String get noDescriptionProvidedDetailed =>
      'Для этой коллекции нет описания.';

  @override
  String get close => 'Закрыть';

  @override
  String get collectionIsEmpty => 'Коллекция пуста';

  @override
  String get collectionIsEmptyDesc =>
      'В эту коллекцию ещё не добавлено ни одной записи. Вы можете назначить их при создании или редактировании записи.';

  @override
  String get selectATag => 'Выбрать тег';

  @override
  String get noTagsFoundInDatabase => 'В базе данных не найдено тегов';

  @override
  String get selectTag => 'Выбрать тег';

  @override
  String get noResultsFound => 'Ничего не найдено';

  @override
  String get tryAdjustingSearch =>
      'Попробуйте изменить поисковый запрос или параметры фильтра.';

  @override
  String get startAddingNewEntries =>
      'Начните добавлять новые записи с помощью кнопки добавления.';

  @override
  String alreadyExistsInCollection(String collection) {
    return 'Уже существует в \"$collection\"';
  }

  @override
  String get alreadyExistsUnassigned =>
      'Уже существует как запись без коллекции';

  @override
  String get duplicateIfDifferentCollection =>
      'Если эта запись принадлежит к другой коллекции, измените поле «Коллекция» ниже и нажмите «Сохранить» снова.';

  @override
  String get duplicateIfDifferentUsage =>
      'Если это другое значение, назначьте его определённой коллекции в поле «Коллекция» ниже и нажмите «Сохранить» снова.';

  @override
  String get duplicateEntryDetected => 'Обнаружен дубликат записи';

  @override
  String get viewExistingEntry => 'Просмотреть существующую запись';

  @override
  String get appTagline => 'Ваш персональный компаньон для знаний';

  @override
  String get links => 'Ссылки';

  @override
  String get githubUrl => 'github.com/aryany9/MyLexicon';

  @override
  String get ifYouFindUseful => 'Если My Lexicon вам полезен';

  @override
  String get legal => 'Правовая информация';

  @override
  String get madeWith => 'Сделано с ';

  @override
  String get inIndia => ' в Индии';

  @override
  String get byAuthor => 'от Aryan Yadav';

  @override
  String get clearAllDataQuestion => 'Очистить все данные?';

  @override
  String get clearAllDataWarning =>
      'Это действие навсегда удалит все сохранённые слова, цитаты, фразы, идиомы и коллекции.\n\nЭто действие необратимо. Вы уверены, что хотите продолжить?';

  @override
  String get allDataCleared => 'Все данные успешно очищены';

  @override
  String errorClearingData(String error) {
    return 'Ошибка очистки данных: $error';
  }

  @override
  String get clearEverything => 'Очистить всё';

  @override
  String get loadSampleDataWarning =>
      'Будет добавлено по 10 отобранных записей для каждой категории (10 слов, 10 фраз, 10 идиом и 10 цитат) вместе с примерами коллекций.\n\n• Существующие примеры записей будут обновлены.\n• Любые созданные вами записи с совпадающими терминами будут сохранены.';

  @override
  String loadedSampleEntries(int count) {
    return 'Загружено $count примеров записей во всех категориях!';
  }

  @override
  String loadedSampleEntriesSkipped(int added, int skipped) {
    return 'Загружено $added примеров записей ($skipped пропущено из-за наличия ваших дубликатов).';
  }

  @override
  String refreshedSampleEntries(int count) {
    return 'Обновлено $count примеров записей.';
  }

  @override
  String refreshedSampleEntriesSkipped(int updated, int skipped) {
    return 'Обновлено $updated примеров записей ($skipped ваших дубликатов сохранено).';
  }

  @override
  String allSampleTermsExist(int skipped) {
    return 'Все $skipped примерных терминов уже есть в вашем лексиконе как пользовательские записи.';
  }

  @override
  String errorLoadingSampleData(String error) {
    return 'Ошибка загрузки примеров данных: $error';
  }

  @override
  String get deleteSampleDataQuestion => 'Удалить примеры данных?';

  @override
  String get deleteSampleDataWarning =>
      'Это удалит все загруженные примеры записей и примеры коллекций.\n\nВаши собственные записи и коллекции останутся нетронутыми.';

  @override
  String deletedSampleEntries(int count) {
    return 'Удалено $count примеров записей и коллекций.';
  }

  @override
  String get noSampleEntriesFound =>
      'Примеров записей для удаления не найдено.';

  @override
  String exportFailed(String error) {
    return 'Ошибка экспорта: $error';
  }

  @override
  String importedEntriesDetails(
    int added,
    int skipped,
    int overwritten,
    int merged,
  ) {
    return 'Импортировано: $added новых, $skipped пропущено, $overwritten перезаписано, $merged объединено.';
  }

  @override
  String aboutSubtitleWithVersion(String version) {
    return 'v$version · Лицензии и ссылки';
  }

  @override
  String get tamil => 'தமிழ் (Tamil)';

  @override
  String get telugu => 'తెలుగు (Telugu)';
}
