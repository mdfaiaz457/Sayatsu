import 'package:dio/dio.dart';
import 'package:sayatsu/data/datasources/remote/manga_source.dart';

class MangaDexSource implements MangaSource {
  final Dio _dio;

  MangaDexSource({Dio? dio}) : _dio = dio ?? Dio();

  @override
  String get id => 'mangadex';

  @override
  String get name => 'MangaDex';

  @override
  String get baseUrl => 'https://api.mangadex.org';

  @override
  Future<List<Map<String, dynamic>>> search(String query) async {
    try {
      final response = await _dio.get(
        '$baseUrl/manga',
        queryParameters: {
          'title': query,
          'limit': 20,
          'offset': 0,
          'includes[]': 'cover_art',
        },
      );

      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((e) {
        final attributes = e['attributes'] ?? {};
        final titleEn = attributes['title']?['en'] ?? attributes['title']?.values.first ?? 'Unknown';
        return {
          'id': e['id'],
          'title': titleEn,
          'description': attributes['description']?['en'] ?? '',
          'coverUrl': _getCoverUrl(e['id'], e['relationships'] ?? []),
          'author': 'Unknown',
          'genres': _extractTags(attributes['tags'] ?? []),
          'rating': 0.0,
          'totalChapters': 0,
        };
      }).toList();
    } on DioException catch (e) {
      throw Exception('MangaDex search failed: ${e.message}');
    } catch (e) {
      throw Exception('MangaDex search failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getMangaDetails(String mangaId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/manga/$mangaId',
        queryParameters: {'includes[]': 'author'},
      );
      final attributes = response.data['data']['attributes'];
      final titleEn = attributes['title']?['en'] ?? attributes['title']?.values.first ?? 'Unknown';

      return {
        'id': mangaId,
        'title': titleEn,
        'author': 'Unknown',
        'description': attributes['description']?['en'] ?? '',
        'rating': 0.0,
        'genres': _extractTags(attributes['tags'] ?? []),
        'totalChapters': 0,
        'status': attributes['status'] ?? 'unknown',
      };
    } on DioException catch (e) {
      throw Exception('Failed to fetch manga details: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch manga details: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getChapters(String mangaId) async {
    try {
      const limit = 500;
      const offset = 0;

      final response = await _dio.get(
        '$baseUrl/chapter',
        queryParameters: {
          'manga': mangaId,
          'limit': limit,
          'offset': offset,
          'translatedLanguage[]': 'en',
          'order[chapter]': 'desc',
        },
      );

      final List<dynamic> data = response.data['data'] ?? [];
      return data.asMap().entries.map((entry) {
        final chapter = entry.value;
        final attributes = chapter['attributes'];
        final chapterNum = attributes['chapter'] ?? '0';

        return {
          'id': chapter['id'],
          'title': attributes['title'] ?? 'Chapter $chapterNum',
          'chapterNumber': double.tryParse(chapterNum) ?? 0.0,
          'uploadedAt': DateTime.parse(attributes['publishAt'] ?? DateTime.now().toIso8601String()),
          'pageCount': int.tryParse(attributes['pages'] ?? '0') ?? 0,
        };
      }).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch chapters: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch chapters: $e');
    }
  }

  @override
  Future<List<String>> getPages(String mangaId, String chapterId) async {
    try {
      final response = await _dio.get('$baseUrl/at-home/server/$chapterId');

      final baseUrl = response.data['baseUrl'];
      final chapter = response.data['chapter'];
      final pages = chapter['dataSaver'] as List<dynamic>;

      return pages
          .map((page) => '$baseUrl/data-saver/$chapterId/$page')
          .cast<String>()
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch pages: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch pages: $e');
    }
  }

  @override
  Future<String> getCoverUrl(String mangaId) async {
    return 'https://uploads.mangadex.org/covers/$mangaId/cover.jpg';
  }

  @override
  Future<bool> isAvailable() async {
    try {
      await _dio.get('$baseUrl/ping');
      return true;
    } catch (_) {
      return false;
    }
  }

  String _getCoverUrl(String mangaId, List<dynamic> relationships) {
    try {
      final coverArt = relationships
          .firstWhere((r) => r['type'] == 'cover_art', orElse: () => null);
      if (coverArt != null) {
        final filename = coverArt['attributes']['fileName'];
        return 'https://uploads.mangadex.org/covers/$mangaId/$filename';
      }
    } catch (_) {}
    return 'https://uploads.mangadex.org/covers/$mangaId/cover.jpg';
  }

  List<String> _extractTags(List<dynamic> tags) {
    return tags
        .map((tag) => tag['attributes']?['name']?['en'] ?? '')
        .where((name) => name.isNotEmpty)
        .cast<String>()
        .toList();
  }
}