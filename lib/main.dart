import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayatsu/config/theme/app_theme.dart';
import 'package:sayatsu/presentation/screens/history/history_screen.dart';
import 'package:sayatsu/presentation/screens/library/library_screen.dart';
import 'package:sayatsu/presentation/screens/manga_detail/manga_detail_screen.dart';
import 'package:sayatsu/presentation/screens/reader/reader_screen.dart';
import 'package:sayatsu/presentation/screens/search/search_screen.dart';
import 'package:sayatsu/presentation/screens/settings/settings_screen.dart';
import 'package:sayatsu/presentation/widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Hive and set up dependencies
  runApp(const ProviderScope(child: SayatsuApp()));
}

class SayatsuApp extends ConsumerWidget {
  const SayatsuApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Sayatsu',
      theme: AppTheme.darkTheme,
      home: const SayatsuHome(),
      routes: {
        '/library': (_) => const LibraryScreen(),
        '/search': (_) => const SearchScreen(),
        '/history': (_) => const HistoryScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/manga-detail': (context) {
          final arg = ModalRoute.of(context)?.settings.arguments;
          return MangaDetailScreen(mangaArg: arg);
        },
        '/reader': (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          return ReaderScreen(
            mangaId: args['mangaId'],
            chapterId: args['chapterId'],
            sourceId: args['sourceId'],
            totalPages: args['totalPages'] ?? 0,
          );
        },
      },
    );
  }
}

class SayatsuHome extends ConsumerStatefulWidget {
  const SayatsuHome();

  @override
  ConsumerState<SayatsuHome> createState() => _SayatsuHomeState();
}

class _SayatsuHomeState extends ConsumerState<SayatsuHome> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const LibraryScreen(),
    const SearchScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  void _onNavItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SayatsuBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}
