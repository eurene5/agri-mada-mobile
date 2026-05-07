import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

import 'package:agri_mada/features/scan/data/datasources/scan_local_datasource.dart';
import 'package:agri_mada/features/scan/domain/repositories/scan_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ScanLocalDatasource datasource;

  setUp(() {
    datasource = ScanLocalDatasource(ImagePicker());
  });

  group('ScanLocalDatasource', () {
    testWidgets('retourne un chemin mock en environnement de test widget',
        (tester) async {
      // Act
      final path = await datasource.captureImagePath(
        source: ScanImageSource.camera,
      );

      // Assert
      expect(path, 'mock://captured-image.jpg');
    });

    test('retourne un resultat coherent pour une image mock', () async {
      // Act
      final result = await datasource.analyzeImage(
        imagePath: 'mock://captured-image.jpg',
      );

      // Assert
      expect(result.id, startsWith('scan-'));
      expect(result.imagePath, 'mock://captured-image.jpg');
      expect(result.confidence, inInclusiveRange(0.62, 0.94));
      expect(result.recommendations, isNotEmpty);
    });

    test('leve ScanInvalidImageException pour une image trop legere', () async {
      // Arrange
      final tempDir = await Directory.systemTemp.createTemp('scan_test_');
      final file = File('${tempDir.path}/tiny.jpg');
      await file.writeAsBytes(List<int>.filled(2000, 1));

      // Act + Assert
      expect(
        () => datasource.analyzeImage(imagePath: file.path),
        throwsA(isA<ScanInvalidImageException>()),
      );

      // Cleanup
      await tempDir.delete(recursive: true);
    });
  });
}
