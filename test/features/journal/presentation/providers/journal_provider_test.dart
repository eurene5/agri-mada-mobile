import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/journal/domain/entities/journal_entry_entity.dart';
import 'package:agri_mada/features/journal/domain/usecases/get_journal_entries_usecase.dart';
import 'package:agri_mada/features/journal/domain/usecases/save_journal_entry_usecase.dart';
import 'package:agri_mada/features/journal/presentation/providers/journal_provider.dart';
import 'package:agri_mada/features/scan/domain/entities/scan_result_entity.dart';

class MockGetJournalEntriesUseCase extends Mock
    implements GetJournalEntriesUseCase {}

class MockSaveJournalEntryUseCase extends Mock
    implements SaveJournalEntryUseCase {}

class FakeJournalEntryEntity extends Fake implements JournalEntryEntity {}

void main() {
  late ProviderContainer container;
  late MockGetJournalEntriesUseCase mockGetUseCase;
  late MockSaveJournalEntryUseCase mockSaveUseCase;

  final tEntry = JournalEntryEntity(
    id: 'journal-1',
    imagePath: 'mock://img.jpg',
    diseaseName: 'Riz Pyriculariose',
    scientificName: 'Magnaporthe oryzae',
    confidence: 0.82,
    severity: ScanSeverity.high,
    recommendations: ['Action'],
    createdAt: DateTime(2026, 1, 1),
  );

  final tScanResult = ScanResultEntity(
    id: 'journal-1',
    imagePath: 'mock://img.jpg',
    diseaseName: 'Riz Pyriculariose',
    scientificName: 'Magnaporthe oryzae',
    confidence: 0.82,
    severity: ScanSeverity.high,
    recommendations: ['Action'],
    tip: 'Surveiller la parcelle',
    analyzedAt: DateTime(2026, 1, 1),
  );

  setUpAll(() {
    registerFallbackValue(FakeJournalEntryEntity());
  });

  setUp(() {
    mockGetUseCase = MockGetJournalEntriesUseCase();
    mockSaveUseCase = MockSaveJournalEntryUseCase();

    container = ProviderContainer(
      overrides: [
        getJournalEntriesUseCaseProvider.overrideWith(
          (ref) async => mockGetUseCase,
        ),
        saveJournalEntryUseCaseProvider.overrideWith(
          (ref) async => mockSaveUseCase,
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('JournalNotifier', () {
    test('l etat initial est JournalState.initial', () {
      expect(
        container.read(journalNotifierProvider),
        const JournalState.initial(),
      );
    });

    test('passe par loading puis loaded quand loadEntries reussit', () async {
      // Arrange
      when(() => mockGetUseCase.call())
          .thenAnswer((_) async => Right([tEntry]));

      final states = <JournalState>[];
      container.listen(journalNotifierProvider, (_, next) => states.add(next));

      // Act
      await container.read(journalNotifierProvider.notifier).loadEntries();

      // Assert
      expect(states[0], const JournalState.loading());
      expect(states[1], JournalState.loaded([tEntry]));
      verify(() => mockGetUseCase.call()).called(1);
    });

    test('saveScanResult recharge la liste apres sauvegarde reussie', () async {
      // Arrange
      when(() => mockSaveUseCase.call(entry: any(named: 'entry')))
          .thenAnswer((_) async => const Right(unit));
      when(() => mockGetUseCase.call())
          .thenAnswer((_) async => Right([tEntry]));

      // Act
      final result =
          await container.read(journalNotifierProvider.notifier).saveScanResult(
                tScanResult,
              );

      // Assert
      expect(result, const Right(unit));
      expect(
        container.read(journalNotifierProvider),
        JournalState.loaded([tEntry]),
      );
      verify(() => mockSaveUseCase.call(entry: any(named: 'entry'))).called(1);
      verify(() => mockGetUseCase.call()).called(1);
    });

    test('saveScanResult retourne une erreur quand la sauvegarde echoue',
        () async {
      // Arrange
      when(() => mockSaveUseCase.call(entry: any(named: 'entry')))
          .thenAnswer((_) async => const Left(CacheFailure('Sauvegarde KO')));

      // Act
      final result =
          await container.read(journalNotifierProvider.notifier).saveScanResult(
                tScanResult,
              );

      // Assert
      expect(result.isLeft(), isTrue);
      expect(
        container.read(journalNotifierProvider),
        const JournalState.error('Sauvegarde KO'),
      );
      verify(() => mockSaveUseCase.call(entry: any(named: 'entry'))).called(1);
      verifyNever(() => mockGetUseCase.call());
    });
  });
}
