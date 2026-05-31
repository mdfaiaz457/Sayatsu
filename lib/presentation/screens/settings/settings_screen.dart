import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayatsu/config/theme/app_colors.dart';
import 'package:sayatsu/config/theme/app_typography.dart';
import 'package:sayatsu/presentation/providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          'Settings',
          style: AppTypography.heading1,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Display Settings
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Display',
              style: AppTypography.heading3,
            ),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                ref.read(isDarkModeProvider.notifier).state = value;
              },
              activeColor: AppColors.accentColor,
            ),
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          // Reader Settings
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Reader',
              style: AppTypography.heading3,
            ),
          ),
          ListTile(
            title: const Text('Reading Direction'),
            subtitle: const Text('Vertical'),
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Double-tap to Zoom'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.accentColor,
            ),
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          // About Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'About',
              style: AppTypography.heading3,
            ),
          ),
          ListTile(
            title: const Text('Version'),
            subtitle: const Text('0.1.0'),
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
