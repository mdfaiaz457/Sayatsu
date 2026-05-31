/// Abstract base class for manga sources
/// Implement this to add support for new manga websites
abstract class MangaSource {
  /// Unique identifier for the source
  String get id;

  /// Display name of the source
  String get name;

  /// Base URL of the manga website
  String get baseUrl;

  /// Version of the source extension
  String get version => '1.0.0';

  /// Search manga by query
  /// Returns list of manga with basic info (id, title, author, coverUrl)
  Future<List<Map<String, dynamic>>> search(String query);

  /// Get detailed information about a manga
  Future<Map<String, dynamic>> getMangaDetails(String mangaId);

  /// Get list of chapters for a manga
  /// Should return in descending order (newest first)
  Future<List<Map<String, dynamic>>> getChapters(String mangaId);

  /// Get page URLs for a specific chapter
  Future<List<String>> getPages(String mangaId, String chapterId);

  /// Get manga cover image URL
  Future<String> getCoverUrl(String mangaId);

  /// Verify if source is active/reachable
  Future<bool> isAvailable();

  /// Get source-specific metadata
  Future<Map<String, dynamic>> getMetadata() async {
    return {
      'id': id,
      'name': name,
      'baseUrl': baseUrl,
      'version': version,
    };
  }
}