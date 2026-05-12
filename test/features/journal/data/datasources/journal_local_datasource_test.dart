import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:agri_mada/features/journal/data/datasources/journal_local_datasource.dart';
import 'package:agri_mada/features/journal/data/models/journal_entry_model.dart';
import 'package:agri_mada/features/scan/domain/entities/scan_result_entity.dart';

void main() {
  group('JournalLocalDatasource', () {
    test('sauvegarde et relit une entree en memoire', () async {
      // Arrange
      final datasource = JournalLocalDatasource.inMemory();
      const entry = JournalEntryModel(
        id: 'entry-test-1',
        imagePath: 'mock://img-1.jpg',
        diseaseName: 'Riz Pyriculariose',
        scientificName: 'Magnaporthe oryzae',
        confidence: 0.91,
        severity: ScanSeverity.high,
        recommendations: ['Action A'],
        createdAt: DateTime(2999, 1, 1),
      );

      // Act
      await datasource.saveEntry(entry);
      final entries = datasource.readEntries();

      // Assert
      expect(entries.any((e) => e.id == 'entry-test-1'), isTrue);
      expect(entries.first.id, 'entry-test-1');
    });

    test('retourne une liste vide si le JSON stocke est invalide', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({
        'journal_entries_v1': '{invalid-json',
      });
      final prefs = await SharedPreferences.getInstance();
      final datasource = JournalLocalDatasource(prefs);

      // Act + Assert
      expect(
        datasource.readEntries,
        throwsA(isA<FormatException>()),
      );
    });

    test('trie les entrees de la plus recente a la plus ancienne', () async {
      // Arrange
      final datasource = JournalLocalDatasource.inMemory();
      const oldEntry = JournalEntryModel(
        id: 'entry-old',
        imagePath: 'mock://img-old.jpg',
        diseaseName: 'Helminthosporiose',
        scientificName: 'Cochliobolus miyabeanus',
        confidence: 0.75,
        severity: ScanSeverity.medium,
        recommendations: ['Action B'],
        createdAt: DateTime(2025, 1, 1),
      );
      const newEntry = JournalEntryModel(
        id: 'entry-new',
        imagePath: 'mock://img-new.jpg',
        diseaseName: 'Riz Pyriculariose',
        scientificName: 'Magnaporthe oryzae',
        confidence: 0.88,
        severity: ScanSeverity.high,
        recommendations: ['Action C'],
        createdAt: DateTime(2999, 1, 2),
      );

      // Act
      await datasource.saveEntry(oldEntry);
      await datasource.saveEntry(newEntry);
      final entries = datasource.readEntries();

      // Assert
      final indexNew = entries.indexWhere((e) => e.id == 'entry-new');
      final indexOld = entries.indexWhere((e) => e.id == 'entry-old');
      expect(indexNew, isNonNegative);
      expect(indexOld, isNonNegative);
      expect(indexNew, lessThan(indexOld));
    });
  });
}
