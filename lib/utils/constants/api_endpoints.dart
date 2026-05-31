/// API endpoint constants
class ApiEndpoints {
  // MangaDex API
  static const String mangaDexBase = 'https://api.mangadex.org';
  static const String mangaDexSearch = '$mangaDexBase/manga';
  static const String mangaDexChapters = '$mangaDexBase/chapter';
  static const String mangaDexAtHome = '$mangaDexBase/at-home/server';
  static const String mangaDexPing = '$mangaDexBase/ping';

  // Query Parameters
  static const String queryLimit = 'limit';
  static const String queryOffset = 'offset';
  static const String queryTitle = 'title';
  static const String queryLanguage = 'translatedLanguage[]';
  static const String queryManga = 'manga';
  static const String queryOrder = 'order[chapter]';
  static const String queryIncludes = 'includes[]';

  // Defaults
  static const int defaultSearchLimit = 20;
  static const int defaultChapterLimit = 100;
}
