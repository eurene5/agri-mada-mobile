// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$JournalEntryEntity {
  String get id => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String get diseaseName => throw _privateConstructorUsedError;
  String get scientificName => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  ScanSeverity get severity => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of JournalEntryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JournalEntryEntityCopyWith<JournalEntryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JournalEntryEntityCopyWith<$Res> {
  factory $JournalEntryEntityCopyWith(
          JournalEntryEntity value, $Res Function(JournalEntryEntity) then) =
      _$JournalEntryEntityCopyWithImpl<$Res, JournalEntryEntity>;
  @useResult
  $Res call(
      {String id,
      String imagePath,
      String diseaseName,
      String scientificName,
      double confidence,
      ScanSeverity severity,
      List<String> recommendations,
      DateTime createdAt});
}

/// @nodoc
class _$JournalEntryEntityCopyWithImpl<$Res, $Val extends JournalEntryEntity>
    implements $JournalEntryEntityCopyWith<$Res> {
  _$JournalEntryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JournalEntryEntity
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
    Object? createdAt = null,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JournalEntryEntityImplCopyWith<$Res>
    implements $JournalEntryEntityCopyWith<$Res> {
  factory _$$JournalEntryEntityImplCopyWith(_$JournalEntryEntityImpl value,
          $Res Function(_$JournalEntryEntityImpl) then) =
      __$$JournalEntryEntityImplCopyWithImpl<$Res>;
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
      DateTime createdAt});
}

/// @nodoc
class __$$JournalEntryEntityImplCopyWithImpl<$Res>
    extends _$JournalEntryEntityCopyWithImpl<$Res, _$JournalEntryEntityImpl>
    implements _$$JournalEntryEntityImplCopyWith<$Res> {
  __$$JournalEntryEntityImplCopyWithImpl(_$JournalEntryEntityImpl _value,
      $Res Function(_$JournalEntryEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of JournalEntryEntity
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
    Object? createdAt = null,
  }) {
    return _then(_$JournalEntryEntityImpl(
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$JournalEntryEntityImpl implements _JournalEntryEntity {
  const _$JournalEntryEntityImpl(
      {required this.id,
      required this.imagePath,
      required this.diseaseName,
      required this.scientificName,
      required this.confidence,
      required this.severity,
      required final List<String> recommendations,
      required this.createdAt})
      : _recommendations = recommendations;

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
  final DateTime createdAt;

  @override
  String toString() {
    return 'JournalEntryEntity(id: $id, imagePath: $imagePath, diseaseName: $diseaseName, scientificName: $scientificName, confidence: $confidence, severity: $severity, recommendations: $recommendations, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JournalEntryEntityImpl &&
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
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

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
      createdAt);

  /// Create a copy of JournalEntryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JournalEntryEntityImplCopyWith<_$JournalEntryEntityImpl> get copyWith =>
      __$$JournalEntryEntityImplCopyWithImpl<_$JournalEntryEntityImpl>(
          this, _$identity);
}

abstract class _JournalEntryEntity implements JournalEntryEntity {
  const factory _JournalEntryEntity(
      {required final String id,
      required final String imagePath,
      required final String diseaseName,
      required final String scientificName,
      required final double confidence,
      required final ScanSeverity severity,
      required final List<String> recommendations,
      required final DateTime createdAt}) = _$JournalEntryEntityImpl;

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
  DateTime get createdAt;

  /// Create a copy of JournalEntryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JournalEntryEntityImplCopyWith<_$JournalEntryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
