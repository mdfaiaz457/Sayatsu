class ReadingHistory {
  final String id;
  final String mangaId;
  final String chapterId;
  final double progress; // 0.0 to 1.0
  final DateTime lastReadAt;
  final int currentPage;

  const ReadingHistory({
    required this.id,
    required this.mangaId,
    required this.chapterId,
    required this.progress,
    required this.lastReadAt,
    required this.currentPage,
  });

  ReadingHistory copyWith({
    String? id,
    String? mangaId,
    String? chapterId,
    double? progress,
    DateTime? lastReadAt,
    int? currentPage,
  }) {
    return ReadingHistory(
      id: id ?? this.id,
      mangaId: mangaId ?? this.mangaId,
      chapterId: chapterId ?? this.chapterId,
      progress: progress ?? this.progress,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}