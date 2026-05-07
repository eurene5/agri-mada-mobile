import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/test_keys.dart';
import '../../domain/repositories/scan_repository.dart';
import '../providers/scan_provider.dart';

class ScanningScreen extends ConsumerWidget {
  const ScanningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scanNotifierProvider);
    final isBusy = switch (state) {
      ScanCapturing() || ScanAnalyzing() => true,
      _ => false,
    };

    final statusText = switch (state) {
      ScanCapturing() => 'Ouverture de la caméra...',
      ScanAnalyzing() => 'Analyse locale en cours...',
      _ => 'L\'analyse se fait hors ligne',
    };

    return Scaffold(
      key: const Key(TestKeys.scanningScreen),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fond caméra simulé
          Container(
            color: Colors.black87,
            child: Center(
              child: _CameraViewfinder(
                statusText: statusText,
                isBusy: isBusy,
                onCapture: () async {
                  await ref
                      .read(scanNotifierProvider.notifier)
                      .captureAndAnalyze(
                        source: ScanImageSource.camera,
                      );

                  if (!context.mounted) {
                    return;
                  }

                  switch (ref.read(scanNotifierProvider)) {
                    case ScanSuccess():
                      context.go(AppRoutes.scanResult);
                    case ScanError(:final message):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                      ref.read(scanNotifierProvider.notifier).clear();
                    default:
                      break;
                  }
                },
              ),
            ),
          ),
          // Overlay header
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _ScanHeader(),
          ),
          // Bouton annuler
          Positioned(
            bottom: 60,
            left: AppSpacing.screenHorizontal,
            right: AppSpacing.screenHorizontal,
            child: _CancelButton(
              onCancel: () => context.go(AppRoutes.home),
            ),
          ),
          if (isBusy)
            Container(
              color: Colors.black.withAlpha(120),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CameraViewfinder extends StatelessWidget {
  const _CameraViewfinder({
    required this.statusText,
    required this.isBusy,
    required this.onCapture,
  });

  final String statusText;
  final bool isBusy;
  final VoidCallback onCapture;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.camera_alt_outlined,
            color: AppColors.primary,
            size: 64,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Pointez la caméra vers\nla feuille de riz',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            statusText,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _CaptureFab(
            isBusy: isBusy,
            onTap: isBusy ? null : onCapture,
          ),
        ],
      ),
    );
  }
}

class _CaptureFab extends StatelessWidget {
  const _CaptureFab({
    required this.isBusy,
    required this.onTap,
  });

  final bool isBusy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Prendre une photo',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          key: const Key(TestKeys.scanningCaptureFab),
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isBusy ? AppColors.textSecondary : AppColors.primary,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Icon(
            Icons.circle,
            color: AppColors.textOnPrimary,
            size: 40,
          ),
        ),
      ),
    );
  }
}

class _ScanHeader extends StatelessWidget {
  const _ScanHeader();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        topPadding + AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withAlpha(180),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'Retour',
            child: GestureDetector(
              onTap: () => context.go(AppRoutes.home),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            'Scanner une feuille',
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.onCancel});

  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Annuler le scan',
      child: GestureDetector(
        key: const Key(TestKeys.scanningCancelButton),
        onTap: onCancel,
        child: Container(
          height: 59,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            'ANNULER',
            style: AppTypography.labelMedium.copyWith(
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
