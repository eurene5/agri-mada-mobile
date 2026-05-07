// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$JournalState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<JournalEntryEntity> entries) loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<JournalEntryEntity> entries)? loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<JournalEntryEntity> entries)? loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JournalInitial value) initial,
    required TResult Function(JournalLoading value) loading,
    required TResult Function(JournalLoaded value) loaded,
    required TResult Function(JournalEmpty value) empty,
    required TResult Function(JournalError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(JournalInitial value)? initial,
    TResult? Function(JournalLoading value)? loading,
    TResult? Function(JournalLoaded value)? loaded,
    TResult? Function(JournalEmpty value)? empty,
    TResult? Function(JournalError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JournalInitial value)? initial,
    TResult Function(JournalLoading value)? loading,
    TResult Function(JournalLoaded value)? loaded,
    TResult Function(JournalEmpty value)? empty,
    TResult Function(JournalError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JournalStateCopyWith<$Res> {
  factory $JournalStateCopyWith(
          JournalState value, $Res Function(JournalState) then) =
      _$JournalStateCopyWithImpl<$Res, JournalState>;
}

/// @nodoc
class _$JournalStateCopyWithImpl<$Res, $Val extends JournalState>
    implements $JournalStateCopyWith<$Res> {
  _$JournalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$JournalInitialImplCopyWith<$Res> {
  factory _$$JournalInitialImplCopyWith(_$JournalInitialImpl value,
          $Res Function(_$JournalInitialImpl) then) =
      __$$JournalInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$JournalInitialImplCopyWithImpl<$Res>
    extends _$JournalStateCopyWithImpl<$Res, _$JournalInitialImpl>
    implements _$$JournalInitialImplCopyWith<$Res> {
  __$$JournalInitialImplCopyWithImpl(
      _$JournalInitialImpl _value, $Res Function(_$JournalInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$JournalInitialImpl implements JournalInitial {
  const _$JournalInitialImpl();

  @override
  String toString() {
    return 'JournalState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$JournalInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<JournalEntryEntity> entries) loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<JournalEntryEntity> entries)? loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<JournalEntryEntity> entries)? loaded,
    TResult Function()? empty,
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
    required TResult Function(JournalInitial value) initial,
    required TResult Function(JournalLoading value) loading,
    required TResult Function(JournalLoaded value) loaded,
    required TResult Function(JournalEmpty value) empty,
    required TResult Function(JournalError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(JournalInitial value)? initial,
    TResult? Function(JournalLoading value)? loading,
    TResult? Function(JournalLoaded value)? loaded,
    TResult? Function(JournalEmpty value)? empty,
    TResult? Function(JournalError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JournalInitial value)? initial,
    TResult Function(JournalLoading value)? loading,
    TResult Function(JournalLoaded value)? loaded,
    TResult Function(JournalEmpty value)? empty,
    TResult Function(JournalError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class JournalInitial implements JournalState {
  const factory JournalInitial() = _$JournalInitialImpl;
}

/// @nodoc
abstract class _$$JournalLoadingImplCopyWith<$Res> {
  factory _$$JournalLoadingImplCopyWith(_$JournalLoadingImpl value,
          $Res Function(_$JournalLoadingImpl) then) =
      __$$JournalLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$JournalLoadingImplCopyWithImpl<$Res>
    extends _$JournalStateCopyWithImpl<$Res, _$JournalLoadingImpl>
    implements _$$JournalLoadingImplCopyWith<$Res> {
  __$$JournalLoadingImplCopyWithImpl(
      _$JournalLoadingImpl _value, $Res Function(_$JournalLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$JournalLoadingImpl implements JournalLoading {
  const _$JournalLoadingImpl();

  @override
  String toString() {
    return 'JournalState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$JournalLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<JournalEntryEntity> entries) loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<JournalEntryEntity> entries)? loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<JournalEntryEntity> entries)? loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JournalInitial value) initial,
    required TResult Function(JournalLoading value) loading,
    required TResult Function(JournalLoaded value) loaded,
    required TResult Function(JournalEmpty value) empty,
    required TResult Function(JournalError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(JournalInitial value)? initial,
    TResult? Function(JournalLoading value)? loading,
    TResult? Function(JournalLoaded value)? loaded,
    TResult? Function(JournalEmpty value)? empty,
    TResult? Function(JournalError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JournalInitial value)? initial,
    TResult Function(JournalLoading value)? loading,
    TResult Function(JournalLoaded value)? loaded,
    TResult Function(JournalEmpty value)? empty,
    TResult Function(JournalError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class JournalLoading implements JournalState {
  const factory JournalLoading() = _$JournalLoadingImpl;
}

/// @nodoc
abstract class _$$JournalLoadedImplCopyWith<$Res> {
  factory _$$JournalLoadedImplCopyWith(
          _$JournalLoadedImpl value, $Res Function(_$JournalLoadedImpl) then) =
      __$$JournalLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<JournalEntryEntity> entries});
}

/// @nodoc
class __$$JournalLoadedImplCopyWithImpl<$Res>
    extends _$JournalStateCopyWithImpl<$Res, _$JournalLoadedImpl>
    implements _$$JournalLoadedImplCopyWith<$Res> {
  __$$JournalLoadedImplCopyWithImpl(
      _$JournalLoadedImpl _value, $Res Function(_$JournalLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
  }) {
    return _then(_$JournalLoadedImpl(
      null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<JournalEntryEntity>,
    ));
  }
}

/// @nodoc

class _$JournalLoadedImpl implements JournalLoaded {
  const _$JournalLoadedImpl(final List<JournalEntryEntity> entries)
      : _entries = entries;

  final List<JournalEntryEntity> _entries;
  @override
  List<JournalEntryEntity> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString() {
    return 'JournalState.loaded(entries: $entries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JournalLoadedImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_entries));

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JournalLoadedImplCopyWith<_$JournalLoadedImpl> get copyWith =>
      __$$JournalLoadedImplCopyWithImpl<_$JournalLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<JournalEntryEntity> entries) loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return loaded(entries);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<JournalEntryEntity> entries)? loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(entries);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<JournalEntryEntity> entries)? loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(entries);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JournalInitial value) initial,
    required TResult Function(JournalLoading value) loading,
    required TResult Function(JournalLoaded value) loaded,
    required TResult Function(JournalEmpty value) empty,
    required TResult Function(JournalError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(JournalInitial value)? initial,
    TResult? Function(JournalLoading value)? loading,
    TResult? Function(JournalLoaded value)? loaded,
    TResult? Function(JournalEmpty value)? empty,
    TResult? Function(JournalError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JournalInitial value)? initial,
    TResult Function(JournalLoading value)? loading,
    TResult Function(JournalLoaded value)? loaded,
    TResult Function(JournalEmpty value)? empty,
    TResult Function(JournalError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class JournalLoaded implements JournalState {
  const factory JournalLoaded(final List<JournalEntryEntity> entries) =
      _$JournalLoadedImpl;

  List<JournalEntryEntity> get entries;

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JournalLoadedImplCopyWith<_$JournalLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JournalEmptyImplCopyWith<$Res> {
  factory _$$JournalEmptyImplCopyWith(
          _$JournalEmptyImpl value, $Res Function(_$JournalEmptyImpl) then) =
      __$$JournalEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$JournalEmptyImplCopyWithImpl<$Res>
    extends _$JournalStateCopyWithImpl<$Res, _$JournalEmptyImpl>
    implements _$$JournalEmptyImplCopyWith<$Res> {
  __$$JournalEmptyImplCopyWithImpl(
      _$JournalEmptyImpl _value, $Res Function(_$JournalEmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$JournalEmptyImpl implements JournalEmpty {
  const _$JournalEmptyImpl();

  @override
  String toString() {
    return 'JournalState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$JournalEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<JournalEntryEntity> entries) loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<JournalEntryEntity> entries)? loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<JournalEntryEntity> entries)? loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(JournalInitial value) initial,
    required TResult Function(JournalLoading value) loading,
    required TResult Function(JournalLoaded value) loaded,
    required TResult Function(JournalEmpty value) empty,
    required TResult Function(JournalError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(JournalInitial value)? initial,
    TResult? Function(JournalLoading value)? loading,
    TResult? Function(JournalLoaded value)? loaded,
    TResult? Function(JournalEmpty value)? empty,
    TResult? Function(JournalError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JournalInitial value)? initial,
    TResult Function(JournalLoading value)? loading,
    TResult Function(JournalLoaded value)? loaded,
    TResult Function(JournalEmpty value)? empty,
    TResult Function(JournalError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class JournalEmpty implements JournalState {
  const factory JournalEmpty() = _$JournalEmptyImpl;
}

/// @nodoc
abstract class _$$JournalErrorImplCopyWith<$Res> {
  factory _$$JournalErrorImplCopyWith(
          _$JournalErrorImpl value, $Res Function(_$JournalErrorImpl) then) =
      __$$JournalErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$JournalErrorImplCopyWithImpl<$Res>
    extends _$JournalStateCopyWithImpl<$Res, _$JournalErrorImpl>
    implements _$$JournalErrorImplCopyWith<$Res> {
  __$$JournalErrorImplCopyWithImpl(
      _$JournalErrorImpl _value, $Res Function(_$JournalErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$JournalErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$JournalErrorImpl implements JournalError {
  const _$JournalErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'JournalState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JournalErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JournalErrorImplCopyWith<_$JournalErrorImpl> get copyWith =>
      __$$JournalErrorImplCopyWithImpl<_$JournalErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<JournalEntryEntity> entries) loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<JournalEntryEntity> entries)? loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<JournalEntryEntity> entries)? loaded,
    TResult Function()? empty,
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
    required TResult Function(JournalInitial value) initial,
    required TResult Function(JournalLoading value) loading,
    required TResult Function(JournalLoaded value) loaded,
    required TResult Function(JournalEmpty value) empty,
    required TResult Function(JournalError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(JournalInitial value)? initial,
    TResult? Function(JournalLoading value)? loading,
    TResult? Function(JournalLoaded value)? loaded,
    TResult? Function(JournalEmpty value)? empty,
    TResult? Function(JournalError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(JournalInitial value)? initial,
    TResult Function(JournalLoading value)? loading,
    TResult Function(JournalLoaded value)? loaded,
    TResult Function(JournalEmpty value)? empty,
    TResult Function(JournalError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class JournalError implements JournalState {
  const factory JournalError(final String message) = _$JournalErrorImpl;

  String get message;

  /// Create a copy of JournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JournalErrorImplCopyWith<_$JournalErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
