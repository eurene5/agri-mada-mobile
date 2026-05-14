import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/ai/model_version_service.dart';
import '../../../../core/local_db/session_service.dart';
import '../../../../core/widgets/app_button/app_button.dart';
import '../../../auth/presentation/providers/session_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, this.consultationMode = false});

  final bool consultationMode;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  final List<_OnboardingSlideData> _slides = const [
    _OnboardingSlideData(
      title: 'Photographiez la feuille malade',
      description:
          'Placez la feuille dans le cadre. Gardez 20-30 cm de distance et une bonne lumière naturelle.',
      icon: Icons.photo_camera_outlined,
    ),
    _OnboardingSlideData(
      title: 'L\'IA analyse hors ligne',
      description:
          'Pas besoin d\'internet. Le diagnostic fonctionne directement sur votre téléphone.',
      icon: Icons.psychology_outlined,
    ),
    _OnboardingSlideData(
      title: 'Consultez le diagnostic',
      description:
          'Visualisez la gravité détectée, la confiance de l\'analyse et les recommandations adaptées.',
      icon: Icons.fact_check_outlined,
    ),
    _OnboardingSlideData(
      title: 'Suivez vos parcelles',
      description:
          'Retrouvez l\'historique des analyses de chaque parcelle dans le journal agricole.',
      icon: Icons.map_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastSlide => _currentIndex == _slides.length - 1;

  Future<void> _skip() async {
    if (!widget.consultationMode) {
      await SessionService.instance.setOnboardingDone(true);
      if (!mounted) return;
      final isLoggedIn = await SessionService.instance.isLoggedIn();
      if (!mounted) return;
      context.go(isLoggedIn ? AppRoutes.home : AppRoutes.welcome);
      return;
    }
    if (!mounted) return;
    context.pop();
  }

  Future<void> _next() async {
    if (_isLastSlide) {
      await _skip();
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bootstrapAsync = ref.watch(appBootstrapProvider);
    final bootstrap = bootstrapAsync.valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              _OnboardingTopBar(
                consultationMode: widget.consultationMode,
                onSkip: _skip,
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return _OnboardingSlide(slide: slide);
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _OnboardingIndicator(
                total: _slides.length,
                currentIndex: _currentIndex,
              ),
              const SizedBox(height: AppSpacing.md),
              _ModelVersionCard(),
              const SizedBox(height: AppSpacing.sm),
              _RuntimeStatusCard(bootstrap: bootstrap),
              const SizedBox(height: AppSpacing.lg),
              if (!widget.consultationMode)
                AppButton(
                  label: _isLastSlide ? 'Commencer' : 'Suivant',
                  onPressed: _next,
                )
              else
                AppButton(
                  label: 'Fermer',
                  variant: AppButtonVariant.secondary,
                  onPressed: () => context.pop(),
                ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingTopBar extends StatelessWidget {
  const _OnboardingTopBar({
    required this.consultationMode,
    required this.onSkip,
  });

  final bool consultationMode;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          consultationMode ? 'Aide AgriMada' : 'Bienvenue',
          style: AppTypography.headlineMedium,
        ),
        const Spacer(),
        TextButton(
          onPressed: onSkip,
          child: Text(
            consultationMode ? 'Fermer' : 'Passer',
            style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.slide});

  final _OnboardingSlideData slide;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border:
                  Border.all(color: AppColors.primary.withAlpha(60), width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(slide.icon, size: 90, color: AppColors.primary),
                const SizedBox(height: AppSpacing.md),
                Text(
                  slide.title,
                  style: AppTypography.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(
                    slide.description,
                    style: AppTypography.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingIndicator extends StatelessWidget {
  const _OnboardingIndicator({
    required this.total,
    required this.currentIndex,
  });

  final int total;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.textSecondary,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}

class _ModelVersionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelVersionInfo>(
      future: ModelVersionService.instance.load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final info = snapshot.data!;
        final maladies = info.maladiesSupportees.join(', ');

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version du modèle IA', style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'v${info.version} - ${info.date}',
                style:
                    AppTypography.bodySmall.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Maladies supportées: $maladies',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RuntimeStatusCard extends StatelessWidget {
  const _RuntimeStatusCard({required this.bootstrap});

  final AppBootstrapSnapshot? bootstrap;

  @override
  Widget build(BuildContext context) {
    final isAiReady = bootstrap?.isAiReady ?? false;
    final modelVersion = bootstrap?.modelVersion?.version;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Statut de l\'application', style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isAiReady
                ? 'IA disponible sur cet appareil'
                : 'IA indisponible, mode degrade',
            style: AppTypography.bodySmall,
          ),
          if (modelVersion != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Version active: v$modelVersion',
              style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
            ),
          ],
        ],
      ),
    );
  }
}

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}
