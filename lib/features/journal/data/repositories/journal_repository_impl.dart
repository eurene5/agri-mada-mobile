import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/journal_entry_entity.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/journal_local_datasource.dart';
import '../models/journal_entry_model.dart';

class JournalRepositoryImpl implements JournalRepository {
  const JournalRepositoryImpl(this._local);

  final JournalLocalDatasource _local;

  @override
  Future<Either<Failure, List<JournalEntryEntity>>> getEntries() async {
    try {
      final models = _local.readEntries();
      return Right(models.map((model) => model.toEntity()).toList());
    } catch (e, st) {
      AppLogger.error('Erreur lecture journal', error: e, stackTrace: st);
      return Left(CacheFailure('Lecture du journal impossible: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveEntry({
    required JournalEntryEntity entry,
  }) async {
    try {
      await _local.saveEntry(entry.toModel());
      return const Right(unit);
    } catch (e, st) {
      AppLogger.error('Erreur sauvegarde journal', error: e, stackTrace: st);
      return Left(CacheFailure('Sauvegarde du journal impossible: $e'));
    }
  }
}
