import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/scan_result_entity.dart';

part 'scan_result_model.freezed.dart';
part 'scan_result_model.g.dart';

@freezed
class ScanResultModel with _$ScanResultModel {
  const factory ScanResultModel({
    required String id,
    required String imagePath,
    required String diseaseName,
    required String scientificName,
    required double confidence,
    required ScanSeverity severity,
    required List<String> recommendations,
    required String tip,
    required DateTime analyzedAt,
  }) = _ScanResultModel;

  factory ScanResultModel.fromJson(Map<String, dynamic> json) =>
      _$ScanResultModelFromJson(json);
}

extension ScanResultModelMapper on ScanResultModel {
  ScanResultEntity toEntity() => ScanResultEntity(
        id: id,
        imagePath: imagePath,
        diseaseName: diseaseName,
        scientificName: scientificName,
        confidence: confidence,
        severity: severity,
        recommendations: recommendations,
        tip: tip,
        analyzedAt: analyzedAt,
      );
}
