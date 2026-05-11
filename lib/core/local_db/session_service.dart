// Service de session locale sécurisée
// Stocke le token JWT et le profil utilisateur dans flutter_secure_storage
// (données chiffrées sur l'appareil — non accessible sans déverrouillage)
// Permet à l'agriculteur de rester connecté sans internet.

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionService {
  SessionService._();
  static final SessionService instance = SessionService._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Clés de stockage
  static const _keyToken = 'auth_token';
  static const _keyUserId = 'user_id';
  static const _keyNom = 'user_nom';
  static const _keyPrenom = 'user_prenom';
  static const _keyTel = 'user_tel';
  static const _keyRegion = 'user_region';

  // --- Sauvegarde (après connexion internet réussie) ---

  Future<void> saveSession({
    required String token,
    required int userId,
    required String nom,
    required String prenom,
    required String tel,
    required String region,
  }) async {
    await Future.wait([
      _storage.write(key: _keyToken, value: token),
      _storage.write(key: _keyUserId, value: userId.toString()),
      _storage.write(key: _keyNom, value: nom),
      _storage.write(key: _keyPrenom, value: prenom),
      _storage.write(key: _keyTel, value: tel),
      _storage.write(key: _keyRegion, value: region),
    ]);
  }

  // --- Lecture ---

  Future<String?> getToken() => _storage.read(key: _keyToken);
  Future<int?> getUserId() async {
    final v = await _storage.read(key: _keyUserId);
    return v != null ? int.tryParse(v) : null;
  }

  Future<String?> getNom() => _storage.read(key: _keyNom);
  Future<String?> getPrenom() => _storage.read(key: _keyPrenom);
  Future<String?> getTel() => _storage.read(key: _keyTel);
  Future<String?> getRegion() => _storage.read(key: _keyRegion);

  /// Retourne true si l'utilisateur a déjà une session enregistrée
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Retourne le profil complet de l'utilisateur en mémoire
  Future<Map<String, String?>> getProfile() async {
    return {
      'nom': await getNom(),
      'prenom': await getPrenom(),
      'tel': await getTel(),
      'region': await getRegion(),
    };
  }

  // --- Déconnexion ---

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}
