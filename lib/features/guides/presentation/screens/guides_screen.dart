import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  List<_DiseaseData> _buildDiseases(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return [
      _DiseaseData(
        name: loc.guideDisease1Name,
        scientificName: 'Xanthomonas oryzae pv. oryzae',
        icon: Icons.warning_amber_rounded,
        description: loc.guideDisease1Desc,
        symptoms: loc.guideDisease1Symptoms,
        causes: loc.guideDisease1Causes,
        treatments: [
          loc.scanRecBlbEvacuateWater,
          loc.scanRecBlbApplyCopper,
          loc.scanRecBlbAvoidNitrogen,
          loc.scanRecBlbUseResistantVarieties,
        ],
      ),
      _DiseaseData(
        name: loc.guideDisease2Name,
        scientificName: 'Bipolaris oryzae (Cochliobolus miyabeanus)',
        icon: Icons.circle_outlined,
        description: loc.guideDisease2Desc,
        symptoms: loc.guideDisease2Symptoms,
        causes: loc.guideDisease2Causes,
        treatments: [
          loc.scanRecBrownSpotFertilize,
          loc.scanRecBrownSpotApplyFungicide,
          loc.scanRecBrownSpotDrainage,
          loc.scanRecBrownSpotAvoidStress,
        ],
      ),
      _DiseaseData(
        name: loc.guideDisease3Name,
        scientificName: 'Entyloma oryzae',
        icon: Icons.brightness_3_outlined,
        description: loc.guideDisease3Desc,
        symptoms: loc.guideDisease3Symptoms,
        causes: loc.guideDisease3Causes,
        treatments: [
          loc.scanRecLeafSmutTreatSeeds,
          loc.scanRecLeafSmutApplyFungicide,
          loc.scanRecLeafSmutRemovePlants,
          loc.scanRecLeafSmutRotation,
        ],
      ),
      _DiseaseData(
        name: loc.guideDisease4Name,
        scientificName: 'Aucune maladie détectée',
        icon: Icons.check_circle_outline,
        description: loc.guideDisease4Desc,
        symptoms: loc.guideDisease4Symptoms,
        causes: loc.guideDisease4Causes,
        treatments: [
          loc.scanRecHealthyWater,
          loc.scanRecHealthyFertilization,
          loc.scanRecHealthyMonitoring,
          loc.scanRecHealthyRotation,
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final diseases = _buildDiseases(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          const _GuidesHeader(),
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
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: diseases.length,
                itemBuilder: (context, index) {
                  return _DiseaseCard(disease: diseases[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuidesHeader extends StatelessWidget {
  const _GuidesHeader();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: topPadding + 140,
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
                    'Guides des maladies',
                    style: AppTypography.displayLarge.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Fiches d\'identification hors ligne',
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
            child: Icon(
              Icons.menu_book_outlined,
              color: AppColors.textOnPrimary.withAlpha(80),
              size: 72,
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

class _DiseaseData {
  final String name;
  final String scientificName;
  final IconData icon;
  final String description;
  final String symptoms;
  final String causes;
  final List<String> treatments;

  const _DiseaseData({
    required this.name,
    required this.scientificName,
    required this.icon,
    required this.description,
    required this.symptoms,
    required this.causes,
    required this.treatments,
  });
}

class _DiseaseCard extends StatefulWidget {
  const _DiseaseCard({required this.disease});

  final _DiseaseData disease;

  @override
  State<_DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<_DiseaseCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.disease;
    final isHealthy = d.name == 'Plante saine';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Container(
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
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: isHealthy
                            ? AppColors.primaryLight
                            : const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        d.icon,
                        color: isHealthy
                            ? AppColors.primary
                            : AppColors.severityHigh,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.name,
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            d.scientificName,
                            style: AppTypography.bodySmall.copyWith(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      d.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _SectionTitle(title: 'Symptômes'),
                    const SizedBox(height: 4),
                    Text(
                      d.symptoms,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _SectionTitle(title: 'Causes'),
                    const SizedBox(height: 4),
                    Text(
                      d.causes,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _SectionTitle(title: 'Traitements'),
                    const SizedBox(height: 4),
                    ...d.treatments.map(
                      (t) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                t,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    );
  }
}
