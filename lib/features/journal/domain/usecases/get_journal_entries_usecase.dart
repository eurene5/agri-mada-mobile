import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/journal_entry_entity.dart';
import '../repositories/journal_repository.dart';

class GetJournalEntriesUseCase {
  const GetJournalEntriesUseCase(this._repository);

  final JournalRepository _repository;

  Future<Either<Failure, List<JournalEntryEntity>>> call() {
    return _repository.getEntries();
  }
}
