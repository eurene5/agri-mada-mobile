import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/test_keys.dart';
import '../../../../core/widgets/app_button/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              const _WelcomeLogo(),
              const Spacer(),
              const _WelcomeHero(),
              const Spacer(),
              _WelcomeTexts(),
              const SizedBox(height: AppSpacing.xl),
              _WelcomeActions(
                onStart: () => context.go(AppRoutes.home),
                onLogin: () => context.go(AppRoutes.login),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeLogo extends StatelessWidget {
  const _WelcomeLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'AgriMada',
          style: AppTypography.displayMedium,
        ),
        const SizedBox(width: AppSpacing.xs),
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class _WelcomeHero extends StatelessWidget {
  const _WelcomeHero();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 269,
      width: 269,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Cercle principal
          Container(
            width: 269,
            height: 269,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryLight,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/welcome_hero.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primaryLight,
                  child: const Icon(
                    Icons.person,
                    size: 120,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          // Décoration haut droite
          const Positioned(
            top: -10,
            right: -10,
            child: _DecorativeCircle(
              size: 38,
              imagePath: 'assets/images/deco_rice_1.png',
            ),
          ),
          // Décoration bas gauche
          const Positioned(
            bottom: -20,
            left: -20,
            child: _DecorativeCircle(
              size: 46,
              imagePath: 'assets/images/deco_rice_2.png',
            ),
          ),
          // Décoration bas droite
          const Positioned(
            bottom: 10,
            right: -10,
            child: _DecorativeCircle(
              size: 28,
              imagePath: 'assets/images/deco_rice_3.png',
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({
    required this.size,
    required this.imagePath,
  });

  final double size;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryLight,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.primaryLight,
          ),
        ),
      ),
    );
  }
}

class _WelcomeTexts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "L'intelligence au service de vos rizières",
          style: AppTypography.headlineLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          "Un riz sain et protégé grâce à l'expertise AgriMada.",
          style: AppTypography.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _WelcomeActions extends StatelessWidget {
  const _WelcomeActions({
    required this.onStart,
    required this.onLogin,
  });

  final VoidCallback onStart;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          key: const Key(TestKeys.welcomeStartButton),
          label: 'Commencer',
          onPressed: onStart,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Se connecter',
          onPressed: onLogin,
          variant: AppButtonVariant.secondary,
        ),
      ],
    );
  }
}
