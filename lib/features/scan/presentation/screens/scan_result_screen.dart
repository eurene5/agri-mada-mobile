import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/test_keys.dart';
import '../../../journal/presentation/providers/journal_provider.dart';
import '../../domain/entities/scan_result_entity.dart';
import '../providers/scan_provider.dart';

class ScanResultScreen extends ConsumerWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(scanNotifierProvider);
    final result = switch (scanState) {
      ScanSuccess(:final result) => result,
      _ => null,
    };

    return Scaffold(
      key: const Key(TestKeys.scanResultScreen),
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
              child: result == null
                  ? _NoResultState(
                      onRescan: () => context.go(AppRoutes.scanning),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        children: [
                          _DiagnosticCard(result: result),
                          const SizedBox(height: AppSpacing.md),
                          _SeverityCard(result: result),
                          const SizedBox(height: AppSpacing.md),
                          _RecommendationsCard(result: result),
                          const SizedBox(height: AppSpacing.md),
                          _TipCard(tip: result.tip),
                          const SizedBox(height: AppSpacing.md),
                          _ActionButtons(
                            onRescan: () => context.go(AppRoutes.scanning),
                            onSave: () async {
                              if (context.mounted) {
                                context.go(AppRoutes.journal);
                              }

                              try {
                                final save = await ref
                                    .read(journalNotifierProvider.notifier)
                                    .saveScanResult(result);

                                if (!context.mounted) {
                                  return;
                                }

                                save.fold(
                                  (failure) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(failure.message)),
                                    );
                                  },
                                  (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Diagnostic enregistré dans le journal'),
                                      ),
                                    );
                                  },
                                );
                              } catch (_) {
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Enregistrement local indisponible'),
                                  ),
                                );
                              }
                            },
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

class _NoResultState extends StatelessWidget {
  const _NoResultState({required this.onRescan});

  final VoidCallback onRescan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_search_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Aucun résultat disponible',
            style: AppTypography.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Lancez un nouveau scan pour obtenir un diagnostic.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            key: const Key(TestKeys.scanResultRescanButton),
            onPressed: onRescan,
            icon: const Icon(Icons.refresh),
            label: const Text('Refaire un scan'),
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
                'Analyse hors ligne terminée',
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

  final ScanResultEntity result;

  @override
  Widget build(BuildContext context) {
    final confidencePercent = (result.confidence * 100).toStringAsFixed(0);

    return Container(
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.cardRadius),
              bottomLeft: Radius.circular(AppSpacing.cardRadius),
            ),
            child: SizedBox(
              width: 116,
              height: 115,
              child: _ScanImagePreview(path: result.imagePath),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.diseaseName,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result.scientificName,
                    style: AppTypography.bodySmall.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.psychology_outlined,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Confiance: $confidencePercent%',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontSize: 11,
                          ),
                        ),
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

class _ScanImagePreview extends StatelessWidget {
  const _ScanImagePreview({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('mock://')) {
      return Container(
        color: AppColors.primaryLight,
        child: const Icon(Icons.grass, color: AppColors.primary, size: 48),
      );
    }

    final file = File(path);
    return Image.file(
      file,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: AppColors.primaryLight,
        child: const Icon(Icons.grass, color: AppColors.primary, size: 48),
      ),
    );
  }
}

class _SeverityCard extends StatelessWidget {
  const _SeverityCard({required this.result});

  final ScanResultEntity result;

  @override
  Widget build(BuildContext context) {
    final severityText = switch (result.severity) {
      ScanSeverity.low => 'Niveau faible - surveillance recommandée',
      ScanSeverity.medium => 'Niveau moyen - traitement préventif conseillé',
      ScanSeverity.high => 'Niveau élevé - intervention recommandée',
    };

    final severityColor = switch (result.severity) {
      ScanSeverity.low => AppColors.severityLow,
      ScanSeverity.medium => AppColors.severityMedium,
      ScanSeverity.high => AppColors.severityHigh,
    };

    final alignment = switch (result.severity) {
      ScanSeverity.low => Alignment.centerLeft,
      ScanSeverity.medium => Alignment.center,
      ScanSeverity.high => Alignment.centerRight,
    };

    return Container(
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
            'Niveau de gravité',
            style:
                AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.md),
          Stack(
            children: [
              Container(
                height: 19,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.severityLow,
                      AppColors.severityMedium,
                      AppColors.severityHigh,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Align(
                alignment: alignment,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: severityColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: severityColor,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  severityText,
                  style: AppTypography.bodySmall.copyWith(
                    color: severityColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecommendationsCard extends StatelessWidget {
  const _RecommendationsCard({required this.result});

  final ScanResultEntity result;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Recommandations adaptées',
            style:
                AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          const Divider(height: AppSpacing.xl),
          for (final recommendation in result.recommendations) ...[
            _RecommendationItem(description: recommendation),
            if (recommendation != result.recommendations.last)
              const Divider(height: AppSpacing.xl),
          ],
        ],
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  const _RecommendationItem({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: const Icon(Icons.spa_outlined,
              color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            description,
            style: AppTypography.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.tip});

  final String tip;

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
              'Astuce: $tip',
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
              key: const Key(TestKeys.scanResultRescanButton),
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
              key: const Key(TestKeys.scanResultSaveButton),
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
