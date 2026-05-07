import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/journal_entry_entity.dart';
import '../repositories/journal_repository.dart';

class SaveJournalEntryUseCase {
  const SaveJournalEntryUseCase(this._repository);

  final JournalRepository _repository;

  Future<Either<Failure, Unit>> call({
    required JournalEntryEntity entry,
  }) {
    return _repository.saveEntry(entry: entry);
  }
}
