import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../l10n/app_localizations.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pop();
    context.go(route);
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pop();
    await ref.read(authNotifierProvider.notifier).logout();
    if (!context.mounted) return;
    context.go(AppRoutes.splash);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context);
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.eco_outlined,
                      color: AppColors.textOnPrimary, size: 36),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'AgriMada',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  Text(
                    loc.homeReadyForAnalysis,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                children: [
                  ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: Text(loc.homeTabHome),
                    onTap: () => _navigate(context, AppRoutes.home),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book_outlined),
                    title: Text(loc.homeTabJournal),
                    onTap: () => _navigate(context, AppRoutes.journal),
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Scan'),
                    onTap: () => _navigate(context, AppRoutes.scanning),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Paramètres'),
                    onTap: () => _navigate(context, AppRoutes.settings),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: AppColors.error),
                    title: const Text('Déconnexion'),
                    onTap: () => _logout(context, ref),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
