import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/journal_entry_entity.dart';

abstract interface class JournalRepository {
  Future<Either<Failure, List<JournalEntryEntity>>> getEntries();

  Future<Either<Failure, Unit>> saveEntry({
    required JournalEntryEntity entry,
  });
}
