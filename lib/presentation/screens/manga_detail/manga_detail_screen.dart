import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayatsu/config/theme/app_colors.dart';
import 'package:sayatsu/config/theme/app_typography.dart';
import 'package:sayatsu/presentation/providers/app_providers.dart';
import 'package:sayatsu/presentation/widgets/error_widget.dart';

class MangaDetailScreen extends ConsumerStatefulWidget {
  final dynamic mangaArg;

  const MangaDetailScreen({required this.mangaArg});

  @override
  ConsumerState<MangaDetailScreen> createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends ConsumerState<MangaDetailScreen> {
  late String mangaId;
  late String sourceId;

  @override
  void initState() {
    super.initState();
    // Handle both string ID and Manga entity
    if (widget.mangaArg is String) {
      mangaId = widget.mangaArg;
      sourceId = 'mangadex'; // default
    } else {
      mangaId = widget.mangaArg.id;
      sourceId = widget.mangaArg.sourceId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chaptersAsyncValue =
        ref.watch(chaptersProvider((mangaId, sourceId)));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text('Manga Details', style: AppTypography.heading2),
      ),
      body: chaptersAsyncValue.when(
        data: (chapters) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with cover and info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.surface,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.mangaArg.coverUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.mangaArg.title,
                              style: AppTypography.heading3,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'By ${widget.mangaArg.author}',
                              style: AppTypography.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.mangaArg.rating}',
                                  style: AppTypography.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Chapters List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Chapters (${chapters.length})',
                    style: AppTypography.heading3,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        chapters[index].title,
                        style: AppTypography.bodyMedium,
                      ),
                      tileColor: index.isEven
                          ? AppColors.surface
                          : Colors.transparent,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/reader',
                          arguments: {
                            'mangaId': mangaId,
                            'chapterId': chapters[index].id,
                            'sourceId': sourceId,
                            'totalPages': chapters[index].pageCount,
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.accentColor),
        ),
        error: (error, stack) => ErrorWidgetCustom(
          title: 'Failed to Load',
          message: 'Could not load chapters: $error',
        ),
      ),
    );
  }
}
