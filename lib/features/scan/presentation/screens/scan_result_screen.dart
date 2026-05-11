import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/ai/tflite_service.dart';
import '../providers/scan_provider.dart';

class ScanResultScreen extends ConsumerWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(scanNotifierProvider);
    final result = scanState.valueOrNull;
    if (result == null) {
      // Fallback si on arrive ici sans résultat
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go(AppRoutes.scanning));
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
                    _DiagnosticCard(result: result),
                    const SizedBox(height: AppSpacing.md),
                    _SeverityCard(gravite: result.niveauGravite),
                    const SizedBox(height: AppSpacing.md),
                    _RecommendationsCard(recommandations: result.recommandations),
                    const SizedBox(height: AppSpacing.md),
                    const _TipCard(),
                    const SizedBox(height: AppSpacing.md),
                    _ActionButtons(
                      onRescan: () {
                        ref.read(scanNotifierProvider.notifier).reset();
                        context.go(AppRoutes.scanning);
                      },
                      onSave: () => context.go(AppRoutes.journal),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const _ShareButton(),
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
            label: 'Retour',
            child: GestureDetector(
              onTap: () => context.go(AppRoutes.home),
              child: const Icon(Icons.arrow_back_ios, size: 22),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Résultat de l'analyse",
                style: AppTypography.headlineMedium,
              ),
              Text(
                'Analyse hors ligne terminé',
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

  String get _displayName => switch (result.maladieDetectee) {
    'Bacterial leaf blight' => 'Brûlure bactérienne',
    'Brown spot' => 'Tache brune',
    'Leaf smut' => 'Charbon foliaire',
    _ => 'Plante saine',
  };

  String get _confidence => '${(result.confiance * 100).toStringAsFixed(0)}% de confiance';

  @override
  Widget build(BuildContext context) {
    final isHealthy = result.maladieDetectee.toLowerCase() == 'healthy';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8, offset: const Offset(0, 2)),
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
              width: 116, height: 115,
              color: isHealthy ? AppColors.primaryLight : const Color(0xFFFFF3E0),
              child: Icon(
                isHealthy ? Icons.check_circle_outline : Icons.bug_report_outlined,
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
                  Text(_displayName, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(result.maladieDetectee, style: AppTypography.bodySmall.copyWith(fontStyle: FontStyle.italic)),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.psychology_outlined, color: AppColors.primary, size: 14),
                        const SizedBox(width: 4),
                        Text(_confidence, style: AppTypography.bodySmall.copyWith(color: AppColors.primary, fontSize: 11)),
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

class _SeverityCard extends StatelessWidget {
  const _SeverityCard({required this.gravite});
  final String gravite;

  double get _severityPosition => switch (gravite) {
    'aucune' => 0.0,
    'faible' => 0.15,
    'modéré' => 0.55,
    _ => 0.95,
  };

  Color get _severityColor => switch (gravite) {
    'aucune' || 'faible' => AppColors.severityLow,
    'modéré' => AppColors.severityMedium,
    _ => AppColors.severityHigh,
  };

  String get _severityLabel => switch (gravite) {
    'aucune' => 'Aucune — Plante saine',
    'faible' => 'Faible — Surveiller',
    'modéré' => 'Modéré — Intervention conseillée',
    _ => 'Élevé — Intervention urgente',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Niveau de gravité', style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 19,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [AppColors.severityLow, AppColors.severityMedium, AppColors.severityHigh]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Positioned(
                    left: (constraints.maxWidth * _severityPosition).clamp(0.0, constraints.maxWidth - 11),
                    top: 4,
                    child: Container(
                      width: 11, height: 11,
                      decoration: BoxDecoration(color: _severityColor, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Faible', style: AppTypography.bodySmall),
            Text('Moyen', style: AppTypography.bodySmall),
            Text('Élevé', style: AppTypography.bodySmall),
          ]),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.info_outline, color: _severityColor, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: Text(_severityLabel, style: AppTypography.bodySmall.copyWith(color: _severityColor))),
            ],
          ),
        ],
      ),
    );
  }
}

class _SeverityIndicator extends StatelessWidget {
  const _SeverityIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11, height: 11,
      decoration: const BoxDecoration(
        color: AppColors.severityHigh,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _RecommendationsCard extends StatelessWidget {
  const _RecommendationsCard({required this.recommandations});
  final List<String> recommandations;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recommandations adaptées', style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          const Divider(height: AppSpacing.xl),
          ...recommandations.map((r) => Column(
            children: [
              _RecommendationItem(
                icon: Icons.spa_outlined,
                title: 'Recommandation',
                description: r,
              ),
              if (r != recommandations.last) const Divider(height: AppSpacing.xl),
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
              "Astuce : évitez l'arrosage excessif pendant 3 jours",
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
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Semantics(
            button: true,
            label: 'Refaire un scan',
            child: OutlinedButton.icon(
              onPressed: onRescan,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Refaire un scan'),
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
            label: 'Enregistrer dans le journal',
            child: ElevatedButton.icon(
              onPressed: onSave,
              icon: const Icon(Icons.bookmark_outline, size: 18),
              label: const Text(
                'Enregistrer',
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
  const _ShareButton();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Partager le résultat',
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.share_outlined, size: 18),
        label: const Text('Partager le résultat'),
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
