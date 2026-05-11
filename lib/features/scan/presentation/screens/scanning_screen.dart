// Écran de scan - Capture photo et analyse IA hors-ligne
// Flow : Choisir parcelle → Prendre photo → Analyse TFLite → Résultat

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../journal/data/repositories/parcelle_local_repository.dart';
import '../../../journal/presentation/providers/journal_provider.dart';
import '../../../../core/local_db/models/parcelle_local.dart';
import '../providers/scan_provider.dart';

class ScanningScreen extends ConsumerStatefulWidget {
  const ScanningScreen({super.key});

  @override
  ConsumerState<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends ConsumerState<ScanningScreen> {
  final _picker = ImagePicker();
  ParcelleLocal? _selectedParcelle;

  Future<void> _pickAndAnalyze(ImageSource source) async {
    // 1. Sélectionner une parcelle si pas encore fait
    if (_selectedParcelle == null) {
      final parcelles = await ref.read(parcelleRepositoryProvider).getAllParcelles();
      if (!mounted) return;
      if (parcelles.isEmpty) {
        _showNoParcelleDailog();
        return;
      }
      final selected = await _showParcelleSelector(parcelles);
      if (selected == null) return;
      setState(() => _selectedParcelle = selected);
    }

    // 2. Prendre/choisir la photo
    final xFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1024,
    );
    if (xFile == null) return;
    final imageFile = File(xFile.path);

    // 3. Lancer l'analyse IA
    if (!mounted) return;
    final result = await ref.read(scanNotifierProvider.notifier).analyzeImage(imageFile);
    if (result == null) return;

    // 4. Sauvegarder dans Isar
    await ref.read(scanNotifierProvider.notifier).saveDiagnostic(
      parcelleLocalId: _selectedParcelle!.id,
      result: result,
      imagePath: xFile.path,
    );

    // 5. Invalider le journal pour qu'il se recharge
    ref.invalidate(journalAgricoleProvider);

    if (!mounted) return;
    context.go(AppRoutes.scanResult);
  }

  Future<ParcelleLocal?> _showParcelleSelector(List<ParcelleLocal> parcelles) async {
    return showModalBottomSheet<ParcelleLocal>(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.textSecondary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 16),
              Text('Choisir une parcelle', style: AppTypography.headlineMedium),
              const SizedBox(height: 8),
              ...parcelles.map((p) => ListTile(
                leading: const Icon(Icons.map_outlined, color: AppColors.primary),
                title: Text(p.nomParcelle),
                subtitle: p.surface != null ? Text('${p.surface} ha') : null,
                onTap: () => Navigator.of(ctx).pop(p),
              )),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showNoParcelleDailog() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Aucune parcelle'),
        content: const Text('Créez d\'abord une parcelle dans votre journal agricole avant de scanner.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
          TextButton(
            onPressed: () { Navigator.of(context).pop(); context.go(AppRoutes.journal); },
            child: const Text('Aller au journal'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(scanNotifierProvider);
    final isLoading = scanState is AsyncLoading;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black87,
            child: Center(
              child: _CameraViewfinder(
                isLoading: isLoading,
                selectedParcelle: _selectedParcelle,
                onCamera: () => _pickAndAnalyze(ImageSource.camera),
                onGallery: () => _pickAndAnalyze(ImageSource.gallery),
              ),
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: _ScanHeader()),
          if (!isLoading)
            Positioned(
              bottom: 60,
              left: AppSpacing.screenHorizontal,
              right: AppSpacing.screenHorizontal,
              child: _CancelButton(onCancel: () => context.go(AppRoutes.home)),
            ),
        ],
      ),
    );
  }
}

class _CameraViewfinder extends StatelessWidget {
  const _CameraViewfinder({
    required this.isLoading,
    required this.selectedParcelle,
    required this.onCamera,
    required this.onGallery,
  });

  final bool isLoading;
  final ParcelleLocal? selectedParcelle;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

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
          if (isLoading) ...[
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: AppSpacing.md),
            Text('Analyse en cours...', style: AppTypography.bodyMedium.copyWith(color: AppColors.textOnPrimary)),
          ] else ...[
            const Icon(Icons.camera_alt_outlined, color: AppColors.primary, size: 64),
            const SizedBox(height: AppSpacing.md),
            if (selectedParcelle != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primary.withAlpha(40), borderRadius: BorderRadius.circular(8)),
                child: Text('📍 ${selectedParcelle!.nomParcelle}', style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
              ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Pointez la caméra vers\nla feuille de riz',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textOnPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text("L'analyse se fait hors ligne", style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
            const SizedBox(height: AppSpacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton galerie
                GestureDetector(
                  onTap: onGallery,
                  child: Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withAlpha(30), border: Border.all(color: Colors.white, width: 2)),
                    child: const Icon(Icons.photo_library_outlined, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: AppSpacing.xl),
                // Bouton capture
                GestureDetector(
                  onTap: onCamera,
                  child: Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary, border: Border.all(color: Colors.white, width: 3)),
                    child: const Icon(Icons.circle, color: AppColors.textOnPrimary, size: 40),
                  ),
                ),
              ],
            ),
          ],
        ],
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
        AppSpacing.screenHorizontal, topPadding + AppSpacing.sm,
        AppSpacing.screenHorizontal, AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.black.withAlpha(180), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go(AppRoutes.home),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Text('Scanner une feuille', style: AppTypography.headlineMedium.copyWith(color: AppColors.textOnPrimary)),
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
    return GestureDetector(
      onTap: onCancel,
      child: Container(
        height: 59,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(30),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: Colors.white.withAlpha(80), width: 1),
        ),
        alignment: Alignment.center,
        child: Text('ANNULER', style: AppTypography.labelMedium.copyWith(letterSpacing: 1.5)),
      ),
    );
  }
}
