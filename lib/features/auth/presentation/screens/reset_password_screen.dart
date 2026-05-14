import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_button/app_button.dart';
import '../providers/auth_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await ref.read(forgotPasswordNotifierProvider.notifier).submit(
          tel: _phoneController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ForgotPasswordState>(forgotPasswordNotifierProvider, (_, next) {
      next.whenOrNull(
        error: (message) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
            ),
          );
        },
        success: (message) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
      );
    });

    final state = ref.watch(forgotPasswordNotifierProvider);
    final isLoading = state is ForgotPasswordLoading;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        surfaceTintColor: Colors.transparent,
        title: const Text('Mot de passe oublié'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Réinitialiser le mot de passe',
                style: AppTypography.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Entrez votre numéro de téléphone pour recevoir les instructions.',
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  hintText: '0341234567',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Champ requis';
                  }
                  final normalized = value.replaceAll(RegExp(r'\s+'), '');
                  if (!RegExp(r'^[0-9]{6,20}$').hasMatch(normalized)) {
                    return 'Numero invalide';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Envoyer',
              onPressed: isLoading ? null : _submit,
              isLoading: isLoading,
            ),
            const SizedBox(height: AppSpacing.md),
            Center(
              child: TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: const Text('Retour à la connexion'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
