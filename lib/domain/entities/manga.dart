class Manga {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String sourceId;
  final List<String> genres;
  final double rating;
  final int totalChapters;
  final DateTime lastUpdated;
  final bool isFavorite;
  final String status; // ongoing, completed, hiatus

  const Manga({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.sourceId,
    required this.genres,
    required this.rating,
    required this.totalChapters,
    required this.lastUpdated,
    this.isFavorite = false,
    this.status = 'ongoing',
  });

  Manga copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? coverUrl,
    String? sourceId,
    List<String>? genres,
    double? rating,
    int? totalChapters,
    DateTime? lastUpdated,
    bool? isFavorite,
    String? status,
  }) {
    return Manga(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      sourceId: sourceId ?? this.sourceId,
      genres: genres ?? this.genres,
      rating: rating ?? this.rating,
      totalChapters: totalChapters ?? this.totalChapters,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
    );
  }
}