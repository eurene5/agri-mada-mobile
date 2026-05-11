// Providers Riverpod pour la session locale et le profil utilisateur
// Partagés par tous les écrans de l'application

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local_db/session_service.dart';

/// Fournit le service de session (singleton)
final sessionServiceProvider = Provider<SessionService>(
  (_) => SessionService.instance,
);

/// État de la session : null = non connecté, Map = profil chargé
final sessionProvider = FutureProvider<Map<String, String?>>((ref) async {
  final service = ref.read(sessionServiceProvider);
  final isLoggedIn = await service.isLoggedIn();
  if (!isLoggedIn) return {};
  return service.getProfile();
});

/// True si l'utilisateur a une session locale valide
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  return SessionService.instance.isLoggedIn();
});
