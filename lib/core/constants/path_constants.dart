class PathConstants {
  const PathConstants._();

  static const String home = '/';
  static const String search = '/search';
  static const String collections = '/collections';
  static const String settings = '/settings';
  static const String entryForm = '/entry-form';
  static const String category = '/category';

  static String entryDetail(String id) => '/entry/$id';
  static String categoryByType(String type) => '$category/$type';
  static String searchByTag(String tag) => '$search?tag=$tag';
  static String searchFavorites() => '$search?favorite=true';
  static String searchFocusTags() => '$search?focusTags=true';
  static String entryFormWithId(String id) => '$entryForm?id=$id';
}
