// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JournalEntryModelImpl _$$JournalEntryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JournalEntryModelImpl(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      diseaseName: json['diseaseName'] as String,
      scientificName: json['scientificName'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      severity: $enumDecode(_$ScanSeverityEnumMap, json['severity']),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$JournalEntryModelImplToJson(
        _$JournalEntryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'diseaseName': instance.diseaseName,
      'scientificName': instance.scientificName,
      'confidence': instance.confidence,
      'severity': _$ScanSeverityEnumMap[instance.severity]!,
      'recommendations': instance.recommendations,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ScanSeverityEnumMap = {
  ScanSeverity.low: 'low',
  ScanSeverity.medium: 'medium',
  ScanSeverity.high: 'high',
};
