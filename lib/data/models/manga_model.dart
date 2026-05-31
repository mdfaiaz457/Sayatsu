import 'package:hive/hive.dart';
import 'package:sayatsu/domain/entities/manga.dart';

part 'manga_model.g.dart';

@HiveType(typeId: 0)
class MangaModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String coverUrl;

  @HiveField(5)
  final String sourceId;

  @HiveField(6)
  final List<String> genres;

  @HiveField(7)
  final double rating;

  @HiveField(8)
  final int totalChapters;

  @HiveField(9)
  final DateTime lastUpdated;

  @HiveField(10)
  final bool isFavorite;

  @HiveField(11)
  final String status;

  MangaModel({
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

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    return MangaModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
      sourceId: json['sourceId'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalChapters: json['totalChapters'] ?? 0,
      lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? '') ?? DateTime.now(),
      isFavorite: json['isFavorite'] ?? false,
      status: json['status'] ?? 'ongoing',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverUrl': coverUrl,
      'sourceId': sourceId,
      'genres': genres,
      'rating': rating,
      'totalChapters': totalChapters,
      'lastUpdated': lastUpdated.toIso8601String(),
      'isFavorite': isFavorite,
      'status': status,
    };
  }

  Manga toDomain() {
    return Manga(
      id: id,
      title: title,
      author: author,
      description: description,
      coverUrl: coverUrl,
      sourceId: sourceId,
      genres: genres,
      rating: rating,
      totalChapters: totalChapters,
      lastUpdated: lastUpdated,
      isFavorite: isFavorite,
      status: status,
    );
  }
}