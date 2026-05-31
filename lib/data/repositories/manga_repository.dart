import 'package:sayatsu/data/datasources/local/hive_manga_datasource.dart';
import 'package:sayatsu/data/datasources/remote/manga_source.dart';
import 'package:sayatsu/data/models/manga_model.dart';
import 'package:sayatsu/domain/entities/manga.dart';

class MangaRepository {
  final HiveMangaDatasource _localDatasource;
  final List<MangaSource> _remoteSources;

  MangaRepository({
    required HiveMangaDatasource localDatasource,
    required List<MangaSource> remoteSources,
  })
      : _localDatasource = localDatasource,
        _remoteSources = remoteSources;

  /// Search manga across all available sources
  /// Aggregates results from multiple sources
  Future<List<Manga>> searchManga(String query) async {
    final results = <Manga>[];
    final seenIds = <String>{};

    for (final source in _remoteSources) {
      try {
        final sourceResults = await source.search(query);
        for (final result in sourceResults) {
          final uniqueId = '${source.id}_${result['id']}';
          if (!seenIds.contains(uniqueId)) {
            seenIds.add(uniqueId);
            results.add(
              Manga(
                id: result['id'],
                title: result['title'],
                author: result['author'],
                description: result['description'] ?? '',
                coverUrl: result['coverUrl'],
                sourceId: source.id,
                genres: result['genres'] ?? [],
                rating: result['rating'] ?? 0.0,
                totalChapters: result['totalChapters'] ?? 0,
                lastUpdated: DateTime.now(),
              ),
            );
          }
        }
      } catch (e) {
        print('Error searching ${source.name}: $e');
      }
    }

    return results;
  }

  /// Get all favorite manga from local storage
  Future<List<Manga>> getLibrary() async {
    final localManga = await _localDatasource.getFavoriteManga();
    return localManga.map((m) => m.toDomain()).toList();
  }

  /// Add manga to library (mark as favorite)
  Future<void> addToLibrary(Manga manga) async {
    final model = MangaModel(
      id: manga.id,
      title: manga.title,
      author: manga.author,
      description: manga.description,
      coverUrl: manga.coverUrl,
      sourceId: manga.sourceId,
      genres: manga.genres,
      rating: manga.rating,
      totalChapters: manga.totalChapters,
      lastUpdated: manga.lastUpdated,
      isFavorite: true,
      status: manga.status,
    );
    await _localDatasource.saveManga(model);
  }

  /// Remove manga from library
  Future<void> removeFromLibrary(String mangaId) async {
    await _localDatasource.deleteManga(mangaId);
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String mangaId) async {
    await _localDatasource.toggleFavorite(mangaId);
  }

  /// Get manga details from a specific source
  Future<Manga?> getMangaDetails(String mangaId, String sourceId) async {
    try {
      final source = _remoteSources.firstWhere((s) => s.id == sourceId);
      final details = await source.getMangaDetails(mangaId);

      return Manga(
        id: mangaId,
        title: details['title'],
        author: details['author'],
        description: details['description'],
        coverUrl: details['coverUrl'] ?? '',
        sourceId: sourceId,
        genres: details['genres'] ?? [],
        rating: details['rating'] ?? 0.0,
        totalChapters: details['totalChapters'] ?? 0,
        lastUpdated: DateTime.now(),
        status: details['status'] ?? 'ongoing',
      );
    } catch (e) {
      print('Error fetching manga details: $e');
      return null;
    }
  }

  /// Get available sources
  List<MangaSource> getAvailableSources() => _remoteSources;
}