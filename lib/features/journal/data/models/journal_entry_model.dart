import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../scan/domain/entities/scan_result_entity.dart';
import '../../domain/entities/journal_entry_entity.dart';

part 'journal_entry_model.freezed.dart';
part 'journal_entry_model.g.dart';

@freezed
class JournalEntryModel with _$JournalEntryModel {
  const factory JournalEntryModel({
    required String id,
    required String imagePath,
    required String diseaseName,
    required String scientificName,
    required double confidence,
    required ScanSeverity severity,
    required List<String> recommendations,
    required DateTime createdAt,
  }) = _JournalEntryModel;

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryModelFromJson(json);
}

extension JournalEntryModelMapper on JournalEntryModel {
  JournalEntryEntity toEntity() => JournalEntryEntity(
        id: id,
        imagePath: imagePath,
        diseaseName: diseaseName,
        scientificName: scientificName,
        confidence: confidence,
        severity: severity,
        recommendations: recommendations,
        createdAt: createdAt,
      );
}

extension JournalEntryEntityMapper on JournalEntryEntity {
  JournalEntryModel toModel() => JournalEntryModel(
        id: id,
        imagePath: imagePath,
        diseaseName: diseaseName,
        scientificName: scientificName,
        confidence: confidence,
        severity: severity,
        recommendations: recommendations,
        createdAt: createdAt,
      );
}
