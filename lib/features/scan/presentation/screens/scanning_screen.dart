import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class ScanningScreen extends StatelessWidget {
  const ScanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fond caméra simulé
          Container(
            color: Colors.black87,
            child: const Center(
              child: _CameraViewfinder(),
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
        ],
      ),
    );
  }
}

class _CameraViewfinder extends StatelessWidget {
  const _CameraViewfinder();

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
            'L\'analyse se fait hors ligne',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _CaptureFab(),
        ],
      ),
    );
  }
}

class _CaptureFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Prendre une photo',
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.scanResult),
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
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
