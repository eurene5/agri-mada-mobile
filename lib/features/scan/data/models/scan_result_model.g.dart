// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanResultModelImpl _$$ScanResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScanResultModelImpl(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      diseaseName: json['diseaseName'] as String,
      scientificName: json['scientificName'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      severity: $enumDecode(_$ScanSeverityEnumMap, json['severity']),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tip: json['tip'] as String,
      analyzedAt: DateTime.parse(json['analyzedAt'] as String),
    );

Map<String, dynamic> _$$ScanResultModelImplToJson(
        _$ScanResultModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'diseaseName': instance.diseaseName,
      'scientificName': instance.scientificName,
      'confidence': instance.confidence,
      'severity': _$ScanSeverityEnumMap[instance.severity]!,
      'recommendations': instance.recommendations,
      'tip': instance.tip,
      'analyzedAt': instance.analyzedAt.toIso8601String(),
    };

const _$ScanSeverityEnumMap = {
  ScanSeverity.low: 'low',
  ScanSeverity.medium: 'medium',
  ScanSeverity.high: 'high',
};
