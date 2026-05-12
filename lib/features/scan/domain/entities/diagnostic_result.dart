import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnostic_result.freezed.dart';

@freezed
class DiagnosticResult with _$DiagnosticResult {
  const factory DiagnosticResult({
    String? id,
    @Default('Riz') String culture,
    required String maladieDetectee,
    required double confiance,
    String? imagePath,
    required DateTime createdAt,
    String? parcelleId,
    String? niveauGravite,
    @Default(<String>[]) List<String> recommandations,
  }) = _DiagnosticResult;
}
