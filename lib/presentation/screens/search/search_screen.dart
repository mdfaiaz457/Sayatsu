import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayatsu/config/theme/app_colors.dart';
import 'package:sayatsu/config/theme/app_typography.dart';
import 'package:sayatsu/presentation/providers/app_providers.dart';
import 'package:sayatsu/presentation/screens/library/widgets/manga_grid.dart';
import 'package:sayatsu/presentation/widgets/error_widget.dart';
import 'package:sayatsu/presentation/widgets/loading_shimmer.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen();

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search manga...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {});
            ref.read(searchQueryProvider.notifier).state = value;
          },
        ),
      ),
      body: searchResults.when(
        data: (manga) {
          if (_searchController.text.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Search for manga',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (manga.isEmpty) {
            return ErrorWidgetCustom(
              title: 'No Results',
              message: 'No manga found for "${_searchController.text}"',
              icon: Icons.search_off,
            );
          }

          return MangaGrid(
            manga: manga,
            scrollController: _scrollController,
          );
        },
        loading: () => const MangaGridShimmer(),
        error: (error, stack) => ErrorWidgetCustom(
          title: 'Search Error',
          message: 'Failed to search: $error',
          onRetry: () => ref.refresh(searchResultsProvider),
        ),
      ),
    );
  }
}
