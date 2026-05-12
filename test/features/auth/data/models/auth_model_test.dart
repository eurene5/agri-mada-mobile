import 'package:flutter_test/flutter_test.dart';

import 'package:agri_mada/features/auth/data/models/auth_model.dart';
import 'package:agri_mada/features/auth/domain/entities/auth_entity.dart';

void main() {
  const tJson = <String, dynamic>{
    'access_token': 'access-token',
    'token_type': 'bearer',
  };

  const tModel = AuthModel(
    accessToken: 'access-token',
    tokenType: 'bearer',
  );

  group('AuthModel', () {
    test('fromJson crée un AuthModel valide', () {
      expect(AuthModel.fromJson(tJson), tModel);
    });

    test('toJson produit la Map attendue', () {
      final json = tModel.toJson();
      expect(json['access_token'], 'access-token');
      expect(json['token_type'], 'bearer');
    });

    test('toEntity retourne un AuthToken cohérent', () {
      final entity = tModel.toEntity();
      expect(entity.accessToken, tModel.accessToken);
      expect(entity.tokenType, tModel.tokenType);
      expect(entity, isA<AuthToken>());
    });
  });
}
