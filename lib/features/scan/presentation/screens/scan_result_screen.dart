import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:agri_mada/l10n/app_localizations.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/local_db/models/diagnostic_local.dart';
import '../../domain/entities/diagnostic_result.dart';
import '../providers/scan_provider.dart';

class ScanResultScreen extends ConsumerStatefulWidget {
  const ScanResultScreen({super.key});

  @override
  ConsumerState<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends ConsumerState<ScanResultScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedItem(Widget child, int index) {
    final animation = Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          (index * 0.1).clamp(0.0, 1.0),
          (index * 0.1 + 0.6).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      ),
    );
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          (index * 0.1).clamp(0.0, 1.0),
          (index * 0.1 + 0.6).clamp(0.0, 1.0),
          curve: Curves.easeOut,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: animation.value,
        child: Opacity(opacity: fadeAnimation.value, child: child),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final scanState = ref.watch(scanNotifierProvider);
    final scanNotifier = ref.read(scanNotifierProvider.notifier);
    final result = switch (scanState) {
      ScanSuccess(:final result) => result,
      _ => null,
    };
    final lastSavedDiagnostic = scanNotifier.lastSavedDiagnostic;

    if (result == null) {
      ref.listen<ScanState>(scanNotifierProvider, (_, next) {
        if (next is! ScanSuccess && context.mounted) {
          context.go(AppRoutes.scanning);
        }
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          const _ScanResultHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.cardRadius),
                  topRight: Radius.circular(AppSpacing.cardRadius),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    _buildAnimatedItem(_DiagnosticCard(result: result), 0),
                    const SizedBox(height: AppSpacing.md),
                    _buildAnimatedItem(_SeverityCard(gravite: result.niveauGravite ?? 'aucune'), 1),
                    const SizedBox(height: AppSpacing.md),
                    _buildAnimatedItem(_RecommendationsCard(
                        recommandations: result.recommandations), 2),
                    const SizedBox(height: AppSpacing.md),
                    _buildAnimatedItem(const _TipCard(), 3),
                    const SizedBox(height: AppSpacing.md),
                    _buildAnimatedItem(_ActionButtons(
                      onSave: () async {
                        final savedDiagnostic =
                            await scanNotifier.persistLastDiagnostic();
                        if (!context.mounted) return;

                        if (savedDiagnostic == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loc.scanResultSaveFailed),
                            ),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(loc.scanResultSaved),
                          ),
                        );
                        context.go(AppRoutes.journal);
                      },
                      onRescan: () {
                        ref.read(scanNotifierProvider.notifier).reset();
                        context.go(AppRoutes.scanning);
                      },
                    ), 4),
                    const SizedBox(height: AppSpacing.md),
                    _buildAnimatedItem(_ShareButton(
                      onShare: () async {
                        try {
                          await Share.share(
                            _buildShareText(
                              context: context,
                              result: result,
                              savedDiagnostic: lastSavedDiagnostic,
                            ),
                          );
                        } catch (_) {
                          // Partage annulé ou indisponible.
                        }
                      },
                    ), 5),
                    const SizedBox(height: AppSpacing.lg),
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

class _ScanResultHeader extends StatelessWidget {
  const _ScanResultHeader();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final topPadding = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        topPadding + AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: loc.scanResultBackSemantics,
            child: GestureDetector(
              onTap: () => context.go(AppRoutes.home),
              child: const Icon(Icons.arrow_back_ios, size: 22),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.scanResultTitle,
                style: AppTypography.headlineMedium,
              ),
              Text(
                loc.scanResultSubtitle,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagnosticCard extends StatelessWidget {
  const _DiagnosticCard({required this.result});
  final DiagnosticResult result;

  String _displayName(AppLocalizations loc) => switch (result.maladieDetectee) {
        'Bacterial leaf blight' => loc.diseaseBacterialLeafBlight,
        'Brown spot' => loc.diseaseBrownSpot,
        'Leaf smut' => loc.diseaseLeafSmut,
        _ => loc.diseaseHealthy,
      };

  String _confidence(AppLocalizations loc) =>
      loc.scanResultConfidence((result.confiance * 100).toStringAsFixed(0));

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isHealthy = result.maladieDetectee.toLowerCase() == 'healthy';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.cardRadius),
              bottomLeft: Radius.circular(AppSpacing.cardRadius),
            ),
            child: Container(
              width: 116,
              height: 115,
              color:
                  isHealthy ? AppColors.primaryLight : const Color(0xFFFFF3E0),
              child: Icon(
                isHealthy
                    ? Icons.check_circle_outline
                    : Icons.bug_report_outlined,
                color: isHealthy ? AppColors.primary : AppColors.severityHigh,
                size: 48,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _displayName(loc),
                    style: AppTypography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(result.maladieDetectee,
                      style: AppTypography.bodySmall
                          .copyWith(fontStyle: FontStyle.italic)),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.psychology_outlined,
                            color: AppColors.primary, size: 14),
                        const SizedBox(width: 4),
                        Text(_confidence(loc),
                            style: AppTypography.bodySmall.copyWith(
                                color: AppColors.primary, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _buildShareText({
  required BuildContext context,
  required DiagnosticResult result,
  DiagnosticLocal? savedDiagnostic,
}) {
  final loc = AppLocalizations.of(context);
  final date = DateFormat('dd/MM/yyyy').format(
    savedDiagnostic?.dateDiagnostic ?? DateTime.now(),
  );
  final disease = switch (result.maladieDetectee) {
    'Bacterial leaf blight' => loc.diseaseBacterialLeafBlight,
    'Brown spot' => loc.diseaseBrownSpot,
    'Leaf smut' => loc.diseaseLeafSmut,
    _ => result.maladieDetectee,
  };
  final confidence = (result.confiance * 100).toStringAsFixed(0);

  return [
    loc.scanShareTitle,
    loc.scanShareCulture,
    loc.scanShareDisease(disease),
    loc.scanShareConfidence(confidence),
    loc.scanShareDate(date),
  ].join('\n');
}

/// Résout un identifiant de clé ARB de recommandation vers une chaîne localisée.
String _resolveRecommendation(AppLocalizations loc, String key) =>
    switch (key) {
      'scanRecBlbEvacuateWater' => loc.scanRecBlbEvacuateWater,
      'scanRecBlbApplyCopper' => loc.scanRecBlbApplyCopper,
      'scanRecBlbAvoidNitrogen' => loc.scanRecBlbAvoidNitrogen,
      'scanRecBlbUseResistantVarieties' => loc.scanRecBlbUseResistantVarieties,
      'scanRecBrownSpotFertilize' => loc.scanRecBrownSpotFertilize,
      'scanRecBrownSpotApplyFungicide' => loc.scanRecBrownSpotApplyFungicide,
      'scanRecBrownSpotDrainage' => loc.scanRecBrownSpotDrainage,
      'scanRecBrownSpotAvoidStress' => loc.scanRecBrownSpotAvoidStress,
      'scanRecLeafSmutTreatSeeds' => loc.scanRecLeafSmutTreatSeeds,
      'scanRecLeafSmutApplyFungicide' => loc.scanRecLeafSmutApplyFungicide,
      'scanRecLeafSmutRemovePlants' => loc.scanRecLeafSmutRemovePlants,
      'scanRecLeafSmutRotation' => loc.scanRecLeafSmutRotation,
      _ => loc.scanRecHealthy,
    };

class _SeverityCard extends StatelessWidget {
  const _SeverityCard({required this.gravite});
  final String gravite;

  double get _severityPosition => switch (gravite) {
        'aucune' => 0.0,
        'faible' => 0.15,
        'modéré' => 0.55,
        'sévère' => 0.95,
        _ => 0.95,
      };

  Color get _severityColor => switch (gravite) {
        'aucune' || 'faible' => AppColors.severityLow,
        'modéré' => AppColors.severityMedium,
        'sévère' => AppColors.severityHigh,
        _ => AppColors.severityHigh,
      };

  String _severityLabel(AppLocalizations loc) => switch (gravite) {
        'aucune' => loc.scanSeverityNoneStatus,
        'faible' => loc.scanSeverityLowStatus,
        'modéré' => loc.scanSeverityMediumStatus,
        'sévère' => loc.scanSeverityHighStatus,
        _ => loc.scanSeverityHighStatus,
      };

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loc.scanSeverityTitle,
              style: AppTypography.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 19,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColors.severityLow,
                        AppColors.severityMedium,
                        AppColors.severityHigh
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutCubic,
                    tween: Tween<double>(begin: 0.0, end: _severityPosition),
                    builder: (context, value, child) {
                      return Positioned(
                        left: (constraints.maxWidth * value)
                            .clamp(0.0, constraints.maxWidth - 11),
                        top: 4,
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                              color: _severityColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2)),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(loc.scanSeverityLow, style: AppTypography.bodySmall),
              Text(loc.scanSeverityMedium, style: AppTypography.bodySmall),
              Text(loc.scanSeverityHigh, style: AppTypography.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.info_outline, color: _severityColor, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                  child: Text(_severityLabel(loc),
                      style: AppTypography.bodySmall
                          .copyWith(color: _severityColor))),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecommendationsCard extends StatelessWidget {
  const _RecommendationsCard({required this.recommandations});
  final List<String> recommandations;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loc.scanRecommendationsTitle,
              style: AppTypography.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600)),
          const Divider(height: AppSpacing.xl),
          ...recommandations.map((r) => Column(
                children: [
                  _RecommendationItem(
                    icon: Icons.spa_outlined,
                    title: loc.scanRecommendationItemTitle,
                    description: _resolveRecommendation(loc, r),
                  ),
                  if (r != recommandations.last)
                    const Divider(height: AppSpacing.xl),
                ],
              )),
        ],
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  const _RecommendationItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 66,
          height: 71,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: Icon(icon, color: AppColors.primary, size: 32),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(description, style: AppTypography.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline,
              color: AppColors.primary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              loc.scanTip,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.onRescan,
    required this.onSave,
  });

  final VoidCallback onRescan;
  final Future<void> Function() onSave;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Semantics(
            button: true,
            label: loc.scanRescanSemantics,
            child: OutlinedButton.icon(
              onPressed: onRescan,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(loc.scanRescan),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Semantics(
            button: true,
            label: loc.scanSaveJournalSemantics,
            child: ElevatedButton.icon(
              onPressed: () {
                onSave();
              },
              icon: const Icon(Icons.bookmark_outline, size: 18),
              label: Text(
                loc.commonSave,
                overflow: TextOverflow.ellipsis,
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.onShare});

  final Future<void> Function() onShare;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: loc.scanShareSemantics,
      child: OutlinedButton.icon(
        onPressed: () {
          onShare();
        },
        icon: const Icon(Icons.share_outlined, size: 18),
        label: Text(loc.scanShare),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: AppColors.primary),
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
        ),
      ),
    );
  }
}
