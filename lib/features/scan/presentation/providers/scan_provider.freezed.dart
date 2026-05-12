// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScanState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() capturing,
    required TResult Function(String imagePath) analyzing,
    required TResult Function(ScanResultEntity result) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? capturing,
    TResult? Function(String imagePath)? analyzing,
    TResult? Function(ScanResultEntity result)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? capturing,
    TResult Function(String imagePath)? analyzing,
    TResult Function(ScanResultEntity result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScanInitial value) initial,
    required TResult Function(ScanCapturing value) capturing,
    required TResult Function(ScanAnalyzing value) analyzing,
    required TResult Function(ScanSuccess value) success,
    required TResult Function(ScanError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScanInitial value)? initial,
    TResult? Function(ScanCapturing value)? capturing,
    TResult? Function(ScanAnalyzing value)? analyzing,
    TResult? Function(ScanSuccess value)? success,
    TResult? Function(ScanError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScanInitial value)? initial,
    TResult Function(ScanCapturing value)? capturing,
    TResult Function(ScanAnalyzing value)? analyzing,
    TResult Function(ScanSuccess value)? success,
    TResult Function(ScanError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanStateCopyWith<$Res> {
  factory $ScanStateCopyWith(ScanState value, $Res Function(ScanState) then) =
      _$ScanStateCopyWithImpl<$Res, ScanState>;
}

/// @nodoc
class _$ScanStateCopyWithImpl<$Res, $Val extends ScanState>
    implements $ScanStateCopyWith<$Res> {
  _$ScanStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ScanInitialImplCopyWith<$Res> {
  factory _$$ScanInitialImplCopyWith(
          _$ScanInitialImpl value, $Res Function(_$ScanInitialImpl) then) =
      __$$ScanInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScanInitialImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ScanInitialImpl>
    implements _$$ScanInitialImplCopyWith<$Res> {
  __$$ScanInitialImplCopyWithImpl(
      _$ScanInitialImpl _value, $Res Function(_$ScanInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ScanInitialImpl implements ScanInitial {
  const _$ScanInitialImpl();

  @override
  String toString() {
    return 'ScanState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ScanInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() capturing,
    required TResult Function(String imagePath) analyzing,
    required TResult Function(ScanResultEntity result) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? capturing,
    TResult? Function(String imagePath)? analyzing,
    TResult? Function(ScanResultEntity result)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? capturing,
    TResult Function(String imagePath)? analyzing,
    TResult Function(ScanResultEntity result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScanInitial value) initial,
    required TResult Function(ScanCapturing value) capturing,
    required TResult Function(ScanAnalyzing value) analyzing,
    required TResult Function(ScanSuccess value) success,
    required TResult Function(ScanError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScanInitial value)? initial,
    TResult? Function(ScanCapturing value)? capturing,
    TResult? Function(ScanAnalyzing value)? analyzing,
    TResult? Function(ScanSuccess value)? success,
    TResult? Function(ScanError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScanInitial value)? initial,
    TResult Function(ScanCapturing value)? capturing,
    TResult Function(ScanAnalyzing value)? analyzing,
    TResult Function(ScanSuccess value)? success,
    TResult Function(ScanError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ScanInitial implements ScanState {
  const factory ScanInitial() = _$ScanInitialImpl;
}

/// @nodoc
abstract class _$$ScanCapturingImplCopyWith<$Res> {
  factory _$$ScanCapturingImplCopyWith(
          _$ScanCapturingImpl value, $Res Function(_$ScanCapturingImpl) then) =
      __$$ScanCapturingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScanCapturingImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ScanCapturingImpl>
    implements _$$ScanCapturingImplCopyWith<$Res> {
  __$$ScanCapturingImplCopyWithImpl(
      _$ScanCapturingImpl _value, $Res Function(_$ScanCapturingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ScanCapturingImpl implements ScanCapturing {
  const _$ScanCapturingImpl();

  @override
  String toString() {
    return 'ScanState.capturing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ScanCapturingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() capturing,
    required TResult Function(String imagePath) analyzing,
    required TResult Function(ScanResultEntity result) success,
    required TResult Function(String message) error,
  }) {
    return capturing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? capturing,
    TResult? Function(String imagePath)? analyzing,
    TResult? Function(ScanResultEntity result)? success,
    TResult? Function(String message)? error,
  }) {
    return capturing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? capturing,
    TResult Function(String imagePath)? analyzing,
    TResult Function(ScanResultEntity result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (capturing != null) {
      return capturing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScanInitial value) initial,
    required TResult Function(ScanCapturing value) capturing,
    required TResult Function(ScanAnalyzing value) analyzing,
    required TResult Function(ScanSuccess value) success,
    required TResult Function(ScanError value) error,
  }) {
    return capturing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScanInitial value)? initial,
    TResult? Function(ScanCapturing value)? capturing,
    TResult? Function(ScanAnalyzing value)? analyzing,
    TResult? Function(ScanSuccess value)? success,
    TResult? Function(ScanError value)? error,
  }) {
    return capturing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScanInitial value)? initial,
    TResult Function(ScanCapturing value)? capturing,
    TResult Function(ScanAnalyzing value)? analyzing,
    TResult Function(ScanSuccess value)? success,
    TResult Function(ScanError value)? error,
    required TResult orElse(),
  }) {
    if (capturing != null) {
      return capturing(this);
    }
    return orElse();
  }
}

abstract class ScanCapturing implements ScanState {
  const factory ScanCapturing() = _$ScanCapturingImpl;
}

/// @nodoc
abstract class _$$ScanAnalyzingImplCopyWith<$Res> {
  factory _$$ScanAnalyzingImplCopyWith(
          _$ScanAnalyzingImpl value, $Res Function(_$ScanAnalyzingImpl) then) =
      __$$ScanAnalyzingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String imagePath});
}

/// @nodoc
class __$$ScanAnalyzingImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ScanAnalyzingImpl>
    implements _$$ScanAnalyzingImplCopyWith<$Res> {
  __$$ScanAnalyzingImplCopyWithImpl(
      _$ScanAnalyzingImpl _value, $Res Function(_$ScanAnalyzingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = null,
  }) {
    return _then(_$ScanAnalyzingImpl(
      null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScanAnalyzingImpl implements ScanAnalyzing {
  const _$ScanAnalyzingImpl(this.imagePath);

  @override
  final String imagePath;

  @override
  String toString() {
    return 'ScanState.analyzing(imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanAnalyzingImpl &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imagePath);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanAnalyzingImplCopyWith<_$ScanAnalyzingImpl> get copyWith =>
      __$$ScanAnalyzingImplCopyWithImpl<_$ScanAnalyzingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() capturing,
    required TResult Function(String imagePath) analyzing,
    required TResult Function(ScanResultEntity result) success,
    required TResult Function(String message) error,
  }) {
    return analyzing(imagePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? capturing,
    TResult? Function(String imagePath)? analyzing,
    TResult? Function(ScanResultEntity result)? success,
    TResult? Function(String message)? error,
  }) {
    return analyzing?.call(imagePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? capturing,
    TResult Function(String imagePath)? analyzing,
    TResult Function(ScanResultEntity result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (analyzing != null) {
      return analyzing(imagePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScanInitial value) initial,
    required TResult Function(ScanCapturing value) capturing,
    required TResult Function(ScanAnalyzing value) analyzing,
    required TResult Function(ScanSuccess value) success,
    required TResult Function(ScanError value) error,
  }) {
    return analyzing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScanInitial value)? initial,
    TResult? Function(ScanCapturing value)? capturing,
    TResult? Function(ScanAnalyzing value)? analyzing,
    TResult? Function(ScanSuccess value)? success,
    TResult? Function(ScanError value)? error,
  }) {
    return analyzing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScanInitial value)? initial,
    TResult Function(ScanCapturing value)? capturing,
    TResult Function(ScanAnalyzing value)? analyzing,
    TResult Function(ScanSuccess value)? success,
    TResult Function(ScanError value)? error,
    required TResult orElse(),
  }) {
    if (analyzing != null) {
      return analyzing(this);
    }
    return orElse();
  }
}

abstract class ScanAnalyzing implements ScanState {
  const factory ScanAnalyzing(final String imagePath) = _$ScanAnalyzingImpl;

  String get imagePath;

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanAnalyzingImplCopyWith<_$ScanAnalyzingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScanSuccessImplCopyWith<$Res> {
  factory _$$ScanSuccessImplCopyWith(
          _$ScanSuccessImpl value, $Res Function(_$ScanSuccessImpl) then) =
      __$$ScanSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ScanResultEntity result});

  $ScanResultEntityCopyWith<$Res> get result;
}

/// @nodoc
class __$$ScanSuccessImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ScanSuccessImpl>
    implements _$$ScanSuccessImplCopyWith<$Res> {
  __$$ScanSuccessImplCopyWithImpl(
      _$ScanSuccessImpl _value, $Res Function(_$ScanSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
  }) {
    return _then(_$ScanSuccessImpl(
      null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as ScanResultEntity,
    ));
  }

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScanResultEntityCopyWith<$Res> get result {
    return $ScanResultEntityCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$ScanSuccessImpl implements ScanSuccess {
  const _$ScanSuccessImpl(this.result);

  @override
  final ScanResultEntity result;

  @override
  String toString() {
    return 'ScanState.success(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanSuccessImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanSuccessImplCopyWith<_$ScanSuccessImpl> get copyWith =>
      __$$ScanSuccessImplCopyWithImpl<_$ScanSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() capturing,
    required TResult Function(String imagePath) analyzing,
    required TResult Function(ScanResultEntity result) success,
    required TResult Function(String message) error,
  }) {
    return success(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? capturing,
    TResult? Function(String imagePath)? analyzing,
    TResult? Function(ScanResultEntity result)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? capturing,
    TResult Function(String imagePath)? analyzing,
    TResult Function(ScanResultEntity result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScanInitial value) initial,
    required TResult Function(ScanCapturing value) capturing,
    required TResult Function(ScanAnalyzing value) analyzing,
    required TResult Function(ScanSuccess value) success,
    required TResult Function(ScanError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScanInitial value)? initial,
    TResult? Function(ScanCapturing value)? capturing,
    TResult? Function(ScanAnalyzing value)? analyzing,
    TResult? Function(ScanSuccess value)? success,
    TResult? Function(ScanError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScanInitial value)? initial,
    TResult Function(ScanCapturing value)? capturing,
    TResult Function(ScanAnalyzing value)? analyzing,
    TResult Function(ScanSuccess value)? success,
    TResult Function(ScanError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ScanSuccess implements ScanState {
  const factory ScanSuccess(final ScanResultEntity result) = _$ScanSuccessImpl;

  ScanResultEntity get result;

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanSuccessImplCopyWith<_$ScanSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScanErrorImplCopyWith<$Res> {
  factory _$$ScanErrorImplCopyWith(
          _$ScanErrorImpl value, $Res Function(_$ScanErrorImpl) then) =
      __$$ScanErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ScanErrorImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ScanErrorImpl>
    implements _$$ScanErrorImplCopyWith<$Res> {
  __$$ScanErrorImplCopyWithImpl(
      _$ScanErrorImpl _value, $Res Function(_$ScanErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ScanErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScanErrorImpl implements ScanError {
  const _$ScanErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ScanState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanErrorImplCopyWith<_$ScanErrorImpl> get copyWith =>
      __$$ScanErrorImplCopyWithImpl<_$ScanErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() capturing,
    required TResult Function(String imagePath) analyzing,
    required TResult Function(ScanResultEntity result) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? capturing,
    TResult? Function(String imagePath)? analyzing,
    TResult? Function(ScanResultEntity result)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? capturing,
    TResult Function(String imagePath)? analyzing,
    TResult Function(ScanResultEntity result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScanInitial value) initial,
    required TResult Function(ScanCapturing value) capturing,
    required TResult Function(ScanAnalyzing value) analyzing,
    required TResult Function(ScanSuccess value) success,
    required TResult Function(ScanError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScanInitial value)? initial,
    TResult? Function(ScanCapturing value)? capturing,
    TResult? Function(ScanAnalyzing value)? analyzing,
    TResult? Function(ScanSuccess value)? success,
    TResult? Function(ScanError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScanInitial value)? initial,
    TResult Function(ScanCapturing value)? capturing,
    TResult Function(ScanAnalyzing value)? analyzing,
    TResult Function(ScanSuccess value)? success,
    TResult Function(ScanError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ScanError implements ScanState {
  const factory ScanError(final String message) = _$ScanErrorImpl;

  String get message;

  /// Create a copy of ScanState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanErrorImplCopyWith<_$ScanErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
