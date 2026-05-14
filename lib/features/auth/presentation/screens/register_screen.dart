import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_button/app_button.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _regionController = TextEditingController();
  final _telController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _regionController.dispose();
    _telController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await ref.read(registerNotifierProvider.notifier).register(
          nom: _nomController.text.trim(),
          prenom: _prenomController.text.trim(),
          region: _regionController.text.trim(),
          tel: _telController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<RegisterState>(registerNotifierProvider, (_, next) {
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
        success: () {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inscription reussie')),
          );
          context.go(AppRoutes.login);
        },
      );
    });

    final registerState = ref.watch(registerNotifierProvider);
    final isLoading = registerState is RegisterLoading;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        surfaceTintColor: Colors.transparent,
        title: const Text('Créer un compte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inscription agriculteur',
                style: AppTypography.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Renseignez vos informations pour créer votre accès.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              _Field(controller: _nomController, label: 'Nom', hint: 'Rakoto'),
              const SizedBox(height: AppSpacing.md),
              _Field(
                controller: _prenomController,
                label: 'Prénom',
                hint: 'Jean',
              ),
              const SizedBox(height: AppSpacing.md),
              _Field(
                controller: _regionController,
                label: 'Région',
                hint: 'Analamanga',
              ),
              const SizedBox(height: AppSpacing.md),
              _Field(
                controller: _telController,
                label: 'Téléphone',
                hint: '0341234567',
                keyboardType: TextInputType.phone,
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
              const SizedBox(height: AppSpacing.md),
              _Field(
                controller: _passwordController,
                label: 'Mot de passe',
                hint: '••••••••',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Champ requis';
                  }
                  if (value.length < 6) {
                    return 'Minimum 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Créer mon compte',
                onPressed: isLoading ? null : _register,
                isLoading: isLoading,
              ),
              const SizedBox(height: AppSpacing.md),
              Center(
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text('J’ai déjà un compte'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Champ requis';
            }
            return null;
          },
    );
  }
}
