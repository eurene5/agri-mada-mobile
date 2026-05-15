import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class PreventionScreen extends StatelessWidget {
  const PreventionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          _PreventionHeader(loc: loc),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    const _Grabber(),
                    const SizedBox(height: AppSpacing.md),
                    _AstucePreventionCard(loc: loc),
                    const SizedBox(height: AppSpacing.lg),
                    _AstuceDuMoment(loc: loc),
                    const SizedBox(height: AppSpacing.lg),
                    _PourquoiEfficaceCard(loc: loc),
                    const SizedBox(height: AppSpacing.md),
                    _BonASavoirCard(loc: loc),
                    const SizedBox(height: AppSpacing.lg),
                    _CommentFaireSection(loc: loc),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreventionHeader extends StatelessWidget {
  const _PreventionHeader({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: topPadding + 180,
      child: Stack(
        children: [
          Positioned(
            top: topPadding + 40,
            left: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    loc.preventionTitle,
                    style: AppTypography.displayLarge.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  loc.preventionSubtitle,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: topPadding + 20,
            right: 20,
            child: SvgPicture.asset(
              'assets/images/deco_prevention.svg',
              width: 72,
              height: 72,
              colorFilter: const ColorFilter.mode(
                AppColors.textOnPrimary,
                BlendMode.srcIn,
              ),
              errorBuilder: (_, __, ___) => Icon(
                Icons.eco_outlined,
                color: AppColors.textOnPrimary.withAlpha(80),
                size: 72,
              ),
            ),
          ),
          Positioned(
            top: topPadding + 8,
            left: 16,
            child: GestureDetector(
              onTap: () => context.canPop() ? context.pop() : context.go(AppRoutes.home),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textOnPrimary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.grabber,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

class _AstucePreventionCard extends StatelessWidget {
  const _AstucePreventionCard({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.preventionAstuceTitle,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            loc.preventionAstuceDesc,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AstuceDuMoment extends StatelessWidget {
  const _AstuceDuMoment({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.preventionAstuceMoment,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            loc.preventionWaterManagement,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryLight,
            ),
            child: const Center(
              child: Icon(
                Icons.water_drop_outlined,
                color: AppColors.primary,
                size: 64,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            loc.preventionWaterDesc,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PourquoiEfficaceCard extends StatelessWidget {
  const _PourquoiEfficaceCard({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/shield_icon.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.shield_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                loc.preventionPourquoi,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            loc.preventionPourquoiDesc,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BonASavoirCard extends StatelessWidget {
  const _BonASavoirCard({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.preventionBonASavoir,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            loc.preventionBonASavoirDesc,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentFaireSection extends StatelessWidget {
  const _CommentFaireSection({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.preventionCommentFaire,
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _TipCard(
          number: 1,
          text: loc.preventionTip1,
        ),
        const SizedBox(height: AppSpacing.sm),
        _TipCard(
          number: 2,
          text: loc.preventionTip2,
        ),
        const SizedBox(height: AppSpacing.sm),
        _TipCard(
          number: 3,
          text: loc.preventionTip3,
        ),
        const SizedBox(height: AppSpacing.sm),
        _TipCard(
          number: 4,
          text: loc.preventionTip4,
        ),
        const SizedBox(height: AppSpacing.sm),
        _TipCard(
          number: 5,
          text: loc.preventionTip5,
        ),
      ],
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({
    required this.number,
    required this.text,
  });

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: AppColors.primaryLight,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/tip_bg.svg',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
