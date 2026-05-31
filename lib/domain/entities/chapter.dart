class Chapter {
  final String id;
  final String mangaId;
  final String title;
  final double chapterNumber;
  final DateTime uploadedAt;
  final bool isRead;
  final double readProgress; // 0.0 to 1.0
  final int pageCount;

  const Chapter({
    required this.id,
    required this.mangaId,
    required this.title,
    required this.chapterNumber,
    required this.uploadedAt,
    this.isRead = false,
    this.readProgress = 0.0,
    required this.pageCount,
  });

  Chapter copyWith({
    String? id,
    String? mangaId,
    String? title,
    double? chapterNumber,
    DateTime? uploadedAt,
    bool? isRead,
    double? readProgress,
    int? pageCount,
  }) {
    return Chapter(
      id: id ?? this.id,
      mangaId: mangaId ?? this.mangaId,
      title: title ?? this.title,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      isRead: isRead ?? this.isRead,
      readProgress: readProgress ?? this.readProgress,
      pageCount: pageCount ?? this.pageCount,
    );
  }
}