import 'package:hive/hive.dart';
import 'package:sayatsu/domain/entities/chapter.dart';

part 'chapter_model.g.dart';

@HiveType(typeId: 1)
class ChapterModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String mangaId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final double chapterNumber;

  @HiveField(4)
  final DateTime uploadedAt;

  @HiveField(5)
  final bool isRead;

  @HiveField(6)
  final double readProgress;

  @HiveField(7)
  final int pageCount;

  ChapterModel({
    required this.id,
    required this.mangaId,
    required this.title,
    required this.chapterNumber,
    required this.uploadedAt,
    this.isRead = false,
    this.readProgress = 0.0,
    required this.pageCount,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] ?? '',
      mangaId: json['mangaId'] ?? '',
      title: json['title'] ?? '',
      chapterNumber: (json['chapterNumber'] ?? 0).toDouble(),
      uploadedAt: DateTime.tryParse(json['uploadedAt'] ?? '') ?? DateTime.now(),
      isRead: json['isRead'] ?? false,
      readProgress: (json['readProgress'] ?? 0.0).toDouble(),
      pageCount: json['pageCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mangaId': mangaId,
      'title': title,
      'chapterNumber': chapterNumber,
      'uploadedAt': uploadedAt.toIso8601String(),
      'isRead': isRead,
      'readProgress': readProgress,
      'pageCount': pageCount,
    };
  }

  Chapter toDomain() {
    return Chapter(
      id: id,
      mangaId: mangaId,
      title: title,
      chapterNumber: chapterNumber,
      uploadedAt: uploadedAt,
      isRead: isRead,
      readProgress: readProgress,
      pageCount: pageCount,
    );
  }
}