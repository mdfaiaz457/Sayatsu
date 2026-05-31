import 'package:sayatsu/data/datasources/local/hive_chapter_datasource.dart';
import 'package:sayatsu/data/datasources/remote/manga_source.dart';
import 'package:sayatsu/data/models/chapter_model.dart';
import 'package:sayatsu/domain/entities/chapter.dart';

class ChapterRepository {
  final HiveChapterDatasource _localDatasource;
  final Map<String, MangaSource> _sources;

  ChapterRepository({
    required HiveChapterDatasource localDatasource,
    required Map<String, MangaSource> sources,
  })
      : _localDatasource = localDatasource,
        _sources = sources;

  /// Get chapters for a manga
  Future<List<Chapter>> getChapters(String mangaId, String sourceId) async {
    try {
      final source = _sources[sourceId];
      if (source == null) throw Exception('Source not found: $sourceId');

      final remoteChapters = await source.getChapters(mangaId);

      // Save to local cache
      for (final chapter in remoteChapters) {
        final model = ChapterModel(
          id: chapter['id'],
          mangaId: mangaId,
          title: chapter['title'],
          chapterNumber: chapter['chapterNumber'] ?? 0.0,
          uploadedAt: chapter['uploadedAt'] ?? DateTime.now(),
          pageCount: chapter['pageCount'] ?? 0,
        );
        await _localDatasource.saveChapter(model);
      }

      return remoteChapters
          .map((ch) => Chapter(
                id: ch['id'],
                mangaId: mangaId,
                title: ch['title'],
                chapterNumber: ch['chapterNumber'] ?? 0.0,
                uploadedAt: ch['uploadedAt'] ?? DateTime.now(),
                pageCount: ch['pageCount'] ?? 0,
              ))
          .toList();
    } catch (e) {
      print('Error fetching chapters: $e');
      return [];
    }
  }

  /// Get pages for a chapter
  Future<List<String>> getPages(String mangaId, String chapterId, String sourceId) async {
    try {
      final source = _sources[sourceId];
      if (source == null) throw Exception('Source not found: $sourceId');

      return await source.getPages(mangaId, chapterId);
    } catch (e) {
      print('Error fetching pages: $e');
      return [];
    }
  }

  /// Update reading progress for a chapter
  Future<void> updateReadProgress(String chapterId, double progress) async {
    await _localDatasource.updateReadProgress(chapterId, progress);
  }

  /// Get chapter by ID from local storage
  Future<Chapter?> getChapterById(String chapterId) async {
    final model = await _localDatasource.getChapterById(chapterId);
    return model?.toDomain();
  }
}