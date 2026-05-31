import 'package:hive/hive.dart';

part 'reading_history_model.g.dart';

@HiveType(typeId: 2)
class ReadingHistoryModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String mangaId;

  @HiveField(2)
  final String chapterId;

  @HiveField(3)
  final double progress; // 0.0 to 1.0

  @HiveField(4)
  final DateTime lastReadAt;

  @HiveField(5)
  final int currentPage;

  ReadingHistoryModel({
    required this.id,
    required this.mangaId,
    required this.chapterId,
    required this.progress,
    required this.lastReadAt,
    required this.currentPage,
  });

  factory ReadingHistoryModel.fromJson(Map<String, dynamic> json) {
    return ReadingHistoryModel(
      id: json['id'] ?? '',
      mangaId: json['mangaId'] ?? '',
      chapterId: json['chapterId'] ?? '',
      progress: (json['progress'] ?? 0.0).toDouble(),
      lastReadAt: DateTime.tryParse(json['lastReadAt'] ?? '') ?? DateTime.now(),
      currentPage: json['currentPage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mangaId': mangaId,
      'chapterId': chapterId,
      'progress': progress,
      'lastReadAt': lastReadAt.toIso8601String(),
      'currentPage': currentPage,
    };
  }
}
