import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: const SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HomeHeader(),
                    SizedBox(height: AppSpacing.md),
                    _SearchBar(),
                    SizedBox(height: AppSpacing.lg),
                    _SummaryCard(),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      'Nos Services',
                      style: AppTypography.headlineMedium,
                    ),
                    SizedBox(height: AppSpacing.md),
                    _ServicesGrid(),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          _ScanFab(onTap: () => context.go(AppRoutes.scanning)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _HomeBottomNav(),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Menu hamburger
        Semantics(
          button: true,
          label: 'Ouvrir le menu',
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.menu,
                  color: AppColors.textPrimary, size: 20),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bonjour, Soa!',
              style: AppTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Prêt pour une analyse ?',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.primary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const Spacer(),
        // Mode hors ligne
        Row(
          children: [
            const Icon(Icons.wifi_off, color: AppColors.primary, size: 18),
            const SizedBox(width: 4),
            Text(
              'Mode hors ligne',
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 49,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: AppSpacing.md),
                const Icon(Icons.search,
                    color: AppColors.textSecondary, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'recherche...',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Bouton filtre
        Container(
          width: 49,
          height: 49,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child:
              const Icon(Icons.tune, color: AppColors.textOnPrimary, size: 22),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 171,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Résumé de votre exploitation",
                    style: AppTypography.headlineMedium.copyWith(fontSize: 16),
                    maxLines: 2,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'Système prêt',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Dernier diagnostic : il ya 2 jours',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(AppSpacing.cardRadius),
              bottomRight: Radius.circular(AppSpacing.cardRadius),
            ),
            child: Image.asset(
              'assets/images/rice_summary.png',
              width: 128,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 128,
                height: 140,
                color: AppColors.primaryLight,
                child:
                    const Icon(Icons.grass, color: AppColors.primary, size: 48),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesGrid extends StatelessWidget {
  const _ServicesGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio:
          AppSpacing.serviceCardWidth / AppSpacing.serviceCardHeight,
      children: const [
        _ServiceCard(
          title: 'Mes parcelles',
          description:
              'Suivez vos rizières, surfaces cultivées et l\'état sanitaire de chaque parcelle',
          iconPath: 'assets/images/service_parcelles.png',
          iconFallback: Icons.map_outlined,
        ),
        _ServiceCard(
          title: 'État des cultures',
          description:
              'Consultez l\'état global de vos cultures et les niveaux de risque actuels',
          iconPath: 'assets/images/service_cultures.png',
          iconFallback: Icons.bar_chart_outlined,
        ),
        _ServiceCard(
          title: 'Solutions agricoles',
          description:
              'Découvrez les traitements biologiques et solutions locales recommandées',
          iconPath: 'assets/images/service_solutions.png',
          iconFallback: Icons.science_outlined,
        ),
        _ServiceCard(
          title: 'Prévenir les maladies',
          description:
              'Apprenez les bonnes pratiques pour protéger vos rizières et éviter les pertes',
          iconPath: 'assets/images/service_prevention.png',
          iconFallback: Icons.health_and_safety_outlined,
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.iconFallback,
  });

  final String title;
  final String description;
  final String iconPath;
  final IconData iconFallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            iconPath,
            width: 64,
            height: 50,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              iconFallback,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: AppSpacing.xs),
          Expanded(
            child: Text(
              description,
              style: AppTypography.bodySmall.copyWith(fontSize: 11),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanFab extends StatelessWidget {
  const _ScanFab({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Scanner une plante',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(100),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: AppColors.textOnPrimary,
            size: 36,
          ),
        ),
      ),
    );
  }
}

class _HomeBottomNav extends StatelessWidget {
  const _HomeBottomNav();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 79,
      color: AppColors.navBar,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Accueil',
            isSelected: true,
            onTap: () {},
          ),
          const SizedBox(width: 60),
          _NavItem(
            icon: Icons.book_outlined,
            label: 'Journal',
            isSelected: false,
            onTap: () => context.go(AppRoutes.journal),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.caption.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
