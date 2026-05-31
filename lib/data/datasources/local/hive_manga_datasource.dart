import 'package:hive/hive.dart';
import 'package:sayatsu/data/models/manga_model.dart';

class HiveMangaDatasource {
  static const String boxName = 'manga_box';

  final Box<MangaModel> _box;

  HiveMangaDatasource(this._box);

  /// Save or update manga in local database
  Future<void> saveManga(MangaModel manga) async {
    await _box.put(manga.id, manga);
  }

  /// Delete manga from local database
  Future<void> deleteManga(String mangaId) async {
    await _box.delete(mangaId);
  }

  /// Get manga by ID
  Future<MangaModel?> getMangaById(String mangaId) async {
    return _box.get(mangaId);
  }

  /// Get all manga
  Future<List<MangaModel>> getAllManga() async {
    return _box.values.toList();
  }

  /// Get all favorite manga
  Future<List<MangaModel>> getFavoriteManga() async {
    return _box.values.where((manga) => manga.isFavorite).toList();
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String mangaId) async {
    final manga = _box.get(mangaId);
    if (manga != null) {
      final updated = MangaModel(
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
        isFavorite: !manga.isFavorite,
      );
      await _box.put(mangaId, updated);
    }
  }

  /// Clear all data
  Future<void> clearAll() async {
    await _box.clear();
  }

  /// Search manga by title
  Future<List<MangaModel>> searchByTitle(String query) async {
    final allManga = _box.values.toList();
    return allManga
        .where((manga) => manga.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}