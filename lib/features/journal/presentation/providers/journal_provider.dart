import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failure.dart';
import '../../../scan/domain/entities/scan_result_entity.dart';
import '../../data/datasources/journal_local_datasource.dart';
import '../../data/repositories/journal_repository_impl.dart';
import '../../domain/entities/journal_entry_entity.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../domain/usecases/get_journal_entries_usecase.dart';
import '../../domain/usecases/save_journal_entry_usecase.dart';

part 'journal_provider.freezed.dart';
part 'journal_provider.g.dart';

@freezed
class JournalState with _$JournalState {
  const factory JournalState.initial() = JournalInitial;
  const factory JournalState.loading() = JournalLoading;
  const factory JournalState.loaded(List<JournalEntryEntity> entries) =
      JournalLoaded;
  const factory JournalState.empty() = JournalEmpty;
  const factory JournalState.error(String message) = JournalError;
}

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async =>
    SharedPreferences.getInstance();

@riverpod
Future<JournalLocalDatasource> journalLocalDatasource(Ref ref) async {
  try {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return JournalLocalDatasource(prefs);
  } catch (_) {
    return JournalLocalDatasource.inMemory();
  }
}

@riverpod
Future<JournalRepository> journalRepository(Ref ref) async {
  final datasource = await ref.watch(journalLocalDatasourceProvider.future);
  return JournalRepositoryImpl(datasource);
}

@riverpod
Future<GetJournalEntriesUseCase> getJournalEntriesUseCase(Ref ref) async {
  final repository = await ref.watch(journalRepositoryProvider.future);
  return GetJournalEntriesUseCase(repository);
}

@riverpod
Future<SaveJournalEntryUseCase> saveJournalEntryUseCase(Ref ref) async {
  final repository = await ref.watch(journalRepositoryProvider.future);
  return SaveJournalEntryUseCase(repository);
}

@riverpod
class JournalNotifier extends _$JournalNotifier {
  @override
  JournalState build() => const JournalState.initial();

  Future<void> loadEntries() async {
    state = const JournalState.loading();

    final usecase = await ref.read(getJournalEntriesUseCaseProvider.future);
    final result = await usecase.call();

    state = result.fold(
      (failure) => JournalState.error(_toMessage(failure)),
      (entries) => entries.isEmpty
          ? const JournalState.empty()
          : JournalState.loaded(entries),
    );
  }

  Future<Either<Failure, Unit>> saveScanResult(
    ScanResultEntity scanResult,
  ) async {
    final entry = JournalEntryEntity(
      id: scanResult.id,
      imagePath: scanResult.imagePath,
      diseaseName: scanResult.diseaseName,
      scientificName: scanResult.scientificName,
      confidence: scanResult.confidence,
      severity: scanResult.severity,
      recommendations: scanResult.recommendations,
      createdAt: scanResult.analyzedAt,
    );

    final usecase = await ref.read(saveJournalEntryUseCaseProvider.future);
    final saved = await usecase.call(entry: entry);

    await saved.match(
      (_) async {
        state = JournalState.error(_toMessage(_));
      },
      (_) async {
        await loadEntries();
      },
    );

    return saved;
  }

  String _toMessage(Failure failure) => failure.message;
}
