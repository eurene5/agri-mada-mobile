import 'package:flutter_test/flutter_test.dart';

import 'package:agri_mada/features/auth/data/models/auth_model.dart';
import 'package:agri_mada/features/auth/domain/entities/auth_entity.dart';

void main() {
  const tJson = <String, dynamic>{
    'user_id': 'user-001',
    'email': 'user@agrimada.mg',
    'access_token': 'access-token',
    'refresh_token': 'refresh-token',
    'display_name': 'Jean Rakoto',
    'avatar_url': null,
  };

  const tModel = AuthModel(
    userId: 'user-001',
    email: 'user@agrimada.mg',
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
    displayName: 'Jean Rakoto',
  );

  group('AuthModel', () {
    test('fromJson crée un AuthModel valide', () {
      expect(AuthModel.fromJson(tJson), tModel);
    });

    test('toJson produit la Map attendue', () {
      final json = tModel.toJson();
      expect(json['user_id'], 'user-001');
      expect(json['email'], 'user@agrimada.mg');
      expect(json['access_token'], 'access-token');
      expect(json['refresh_token'], 'refresh-token');
      expect(json['display_name'], 'Jean Rakoto');
    });

    test('toEntity retourne un AuthEntity cohérent', () {
      final entity = tModel.toEntity();
      expect(entity.userId, tModel.userId);
      expect(entity.email, tModel.email);
      expect(entity.accessToken, tModel.accessToken);
      expect(entity.refreshToken, tModel.refreshToken);
      expect(entity.displayName, tModel.displayName);
      expect(entity, isA<AuthEntity>());
    });
  });
}
