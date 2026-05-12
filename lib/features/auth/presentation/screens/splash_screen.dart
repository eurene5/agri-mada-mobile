import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/local_db/session_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Vérification de la session locale — pas besoin d'internet
    final isLoggedIn = await SessionService.instance.isLoggedIn();
    if (!mounted) return;

    if (isLoggedIn) {
      // Session valide : aller directement à l'accueil (mode hors-ligne)
      context.go(AppRoutes.home);
    } else {
      // Première utilisation : afficher l'écran de bienvenue
      context.go(AppRoutes.welcome);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: const _SplashContent(),
          ),
        ),
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/splash_rice.png',
          width: 180,
          height: 237,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const _RicePlaceholder(),
        ),
        const SizedBox(height: AppSpacing.lg),
        const _AgriMadaLogo(),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Diagnostiquer les maladies du riz, hors ligne',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _RicePlaceholder extends StatelessWidget {
  const _RicePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 237,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: const Icon(
        Icons.grass,
        size: 80,
        color: AppColors.primary,
      ),
    );
  }
}

class _AgriMadaLogo extends StatelessWidget {
  const _AgriMadaLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'AgriMada',
          style: AppTypography.displayMedium,
        ),
        const SizedBox(width: AppSpacing.xs),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
