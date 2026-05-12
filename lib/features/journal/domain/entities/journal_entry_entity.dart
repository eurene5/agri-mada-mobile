import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../scan/domain/entities/scan_result_entity.dart';

part 'journal_entry_entity.freezed.dart';

@freezed
class JournalEntryEntity with _$JournalEntryEntity {
  const factory JournalEntryEntity({
    required String id,
    required String imagePath,
    required String diseaseName,
    required String scientificName,
    required double confidence,
    required ScanSeverity severity,
    required List<String> recommendations,
    required DateTime createdAt,
  }) = _JournalEntryEntity;
}
