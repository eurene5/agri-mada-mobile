// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScanResultModel _$ScanResultModelFromJson(Map<String, dynamic> json) {
  return _ScanResultModel.fromJson(json);
}

/// @nodoc
mixin _$ScanResultModel {
  String get id => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String get diseaseName => throw _privateConstructorUsedError;
  String get scientificName => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  ScanSeverity get severity => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  String get tip => throw _privateConstructorUsedError;
  DateTime get analyzedAt => throw _privateConstructorUsedError;

  /// Serializes this ScanResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanResultModelCopyWith<ScanResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanResultModelCopyWith<$Res> {
  factory $ScanResultModelCopyWith(
          ScanResultModel value, $Res Function(ScanResultModel) then) =
      _$ScanResultModelCopyWithImpl<$Res, ScanResultModel>;
  @useResult
  $Res call(
      {String id,
      String imagePath,
      String diseaseName,
      String scientificName,
      double confidence,
      ScanSeverity severity,
      List<String> recommendations,
      String tip,
      DateTime analyzedAt});
}

/// @nodoc
class _$ScanResultModelCopyWithImpl<$Res, $Val extends ScanResultModel>
    implements $ScanResultModelCopyWith<$Res> {
  _$ScanResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? diseaseName = null,
    Object? scientificName = null,
    Object? confidence = null,
    Object? severity = null,
    Object? recommendations = null,
    Object? tip = null,
    Object? analyzedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      diseaseName: null == diseaseName
          ? _value.diseaseName
          : diseaseName // ignore: cast_nullable_to_non_nullable
              as String,
      scientificName: null == scientificName
          ? _value.scientificName
          : scientificName // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ScanSeverity,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tip: null == tip
          ? _value.tip
          : tip // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScanResultModelImplCopyWith<$Res>
    implements $ScanResultModelCopyWith<$Res> {
  factory _$$ScanResultModelImplCopyWith(_$ScanResultModelImpl value,
          $Res Function(_$ScanResultModelImpl) then) =
      __$$ScanResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String imagePath,
      String diseaseName,
      String scientificName,
      double confidence,
      ScanSeverity severity,
      List<String> recommendations,
      String tip,
      DateTime analyzedAt});
}

/// @nodoc
class __$$ScanResultModelImplCopyWithImpl<$Res>
    extends _$ScanResultModelCopyWithImpl<$Res, _$ScanResultModelImpl>
    implements _$$ScanResultModelImplCopyWith<$Res> {
  __$$ScanResultModelImplCopyWithImpl(
      _$ScanResultModelImpl _value, $Res Function(_$ScanResultModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? diseaseName = null,
    Object? scientificName = null,
    Object? confidence = null,
    Object? severity = null,
    Object? recommendations = null,
    Object? tip = null,
    Object? analyzedAt = null,
  }) {
    return _then(_$ScanResultModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      diseaseName: null == diseaseName
          ? _value.diseaseName
          : diseaseName // ignore: cast_nullable_to_non_nullable
              as String,
      scientificName: null == scientificName
          ? _value.scientificName
          : scientificName // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ScanSeverity,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tip: null == tip
          ? _value.tip
          : tip // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanResultModelImpl implements _ScanResultModel {
  const _$ScanResultModelImpl(
      {required this.id,
      required this.imagePath,
      required this.diseaseName,
      required this.scientificName,
      required this.confidence,
      required this.severity,
      required final List<String> recommendations,
      required this.tip,
      required this.analyzedAt})
      : _recommendations = recommendations;

  factory _$ScanResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanResultModelImplFromJson(json);

  @override
  final String id;
  @override
  final String imagePath;
  @override
  final String diseaseName;
  @override
  final String scientificName;
  @override
  final double confidence;
  @override
  final ScanSeverity severity;
  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final String tip;
  @override
  final DateTime analyzedAt;

  @override
  String toString() {
    return 'ScanResultModel(id: $id, imagePath: $imagePath, diseaseName: $diseaseName, scientificName: $scientificName, confidence: $confidence, severity: $severity, recommendations: $recommendations, tip: $tip, analyzedAt: $analyzedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanResultModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.diseaseName, diseaseName) ||
                other.diseaseName == diseaseName) &&
            (identical(other.scientificName, scientificName) ||
                other.scientificName == scientificName) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.tip, tip) || other.tip == tip) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      imagePath,
      diseaseName,
      scientificName,
      confidence,
      severity,
      const DeepCollectionEquality().hash(_recommendations),
      tip,
      analyzedAt);

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanResultModelImplCopyWith<_$ScanResultModelImpl> get copyWith =>
      __$$ScanResultModelImplCopyWithImpl<_$ScanResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanResultModelImplToJson(
      this,
    );
  }
}

abstract class _ScanResultModel implements ScanResultModel {
  const factory _ScanResultModel(
      {required final String id,
      required final String imagePath,
      required final String diseaseName,
      required final String scientificName,
      required final double confidence,
      required final ScanSeverity severity,
      required final List<String> recommendations,
      required final String tip,
      required final DateTime analyzedAt}) = _$ScanResultModelImpl;

  factory _ScanResultModel.fromJson(Map<String, dynamic> json) =
      _$ScanResultModelImpl.fromJson;

  @override
  String get id;
  @override
  String get imagePath;
  @override
  String get diseaseName;
  @override
  String get scientificName;
  @override
  double get confidence;
  @override
  ScanSeverity get severity;
  @override
  List<String> get recommendations;
  @override
  String get tip;
  @override
  DateTime get analyzedAt;

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanResultModelImplCopyWith<_$ScanResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
