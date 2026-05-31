import 'package:hive/hive.dart';
import 'package:sayatsu/data/models/chapter_model.dart';

class HiveChapterDatasource {
  static const String boxName = 'chapter_box';

  final Box<ChapterModel> _box;

  HiveChapterDatasource(this._box);

  Future<void> saveChapter(ChapterModel chapter) async {
    await _box.put(chapter.id, chapter);
  }

  Future<void> deleteChapter(String chapterId) async {
    await _box.delete(chapterId);
  }

  Future<ChapterModel?> getChapterById(String chapterId) async {
    return _box.get(chapterId);
  }

  Future<List<ChapterModel>> getChaptersByMangaId(String mangaId) async {
    return _box.values
        .where((chapter) => chapter.mangaId == mangaId)
        .toList();
  }

  Future<void> updateReadProgress(String chapterId, double progress) async {
    final chapter = _box.get(chapterId);
    if (chapter != null) {
      final updated = ChapterModel(
        id: chapter.id,
        mangaId: chapter.mangaId,
        title: chapter.title,
        chapterNumber: chapter.chapterNumber,
        uploadedAt: chapter.uploadedAt,
        isRead: progress >= 0.95,
        readProgress: progress,
        pageCount: chapter.pageCount,
      );
      await _box.put(chapterId, updated);
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}