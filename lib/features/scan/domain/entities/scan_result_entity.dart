import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_result_entity.freezed.dart';

enum ScanSeverity { low, medium, high }

@freezed
class ScanResultEntity with _$ScanResultEntity {
  const factory ScanResultEntity({
    required String id,
    required String imagePath,
    required String diseaseName,
    required String scientificName,
    required double confidence,
    required ScanSeverity severity,
    required List<String> recommendations,
    required String tip,
    required DateTime analyzedAt,
  }) = _ScanResultEntity;
}
