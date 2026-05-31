class AppConstants {
  // API Endpoints
  static const String mangaDexBaseUrl = 'https://api.mangadex.org';
  
  // Storage Keys
  static const String lastReadMangaKey = 'last_read_manga';
  static const String libraryKey = 'manga_library';
  static const String readingProgressKey = 'reading_progress';
  
  // Reader Settings
  static const double minBrightness = 0.3;
  static const double maxBrightness = 1.5;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration debounceSearchDuration = Duration(milliseconds: 500);
}
