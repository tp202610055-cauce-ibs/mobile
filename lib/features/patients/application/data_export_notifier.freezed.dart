// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_export_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DataExportState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() requesting,
    required TResult Function(DateTime expiresAt) opened,
    required TResult Function(DateTime expiresAt) notOpened,
    required TResult Function(CauceApiError error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? requesting,
    TResult? Function(DateTime expiresAt)? opened,
    TResult? Function(DateTime expiresAt)? notOpened,
    TResult? Function(CauceApiError error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? requesting,
    TResult Function(DateTime expiresAt)? opened,
    TResult Function(DateTime expiresAt)? notOpened,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataExportIdle value) idle,
    required TResult Function(DataExportRequesting value) requesting,
    required TResult Function(DataExportOpened value) opened,
    required TResult Function(DataExportNotOpened value) notOpened,
    required TResult Function(DataExportFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataExportIdle value)? idle,
    TResult? Function(DataExportRequesting value)? requesting,
    TResult? Function(DataExportOpened value)? opened,
    TResult? Function(DataExportNotOpened value)? notOpened,
    TResult? Function(DataExportFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataExportIdle value)? idle,
    TResult Function(DataExportRequesting value)? requesting,
    TResult Function(DataExportOpened value)? opened,
    TResult Function(DataExportNotOpened value)? notOpened,
    TResult Function(DataExportFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataExportStateCopyWith<$Res> {
  factory $DataExportStateCopyWith(
          DataExportState value, $Res Function(DataExportState) then) =
      _$DataExportStateCopyWithImpl<$Res, DataExportState>;
}

/// @nodoc
class _$DataExportStateCopyWithImpl<$Res, $Val extends DataExportState>
    implements $DataExportStateCopyWith<$Res> {
  _$DataExportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DataExportIdleImplCopyWith<$Res> {
  factory _$$DataExportIdleImplCopyWith(_$DataExportIdleImpl value,
          $Res Function(_$DataExportIdleImpl) then) =
      __$$DataExportIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DataExportIdleImplCopyWithImpl<$Res>
    extends _$DataExportStateCopyWithImpl<$Res, _$DataExportIdleImpl>
    implements _$$DataExportIdleImplCopyWith<$Res> {
  __$$DataExportIdleImplCopyWithImpl(
      _$DataExportIdleImpl _value, $Res Function(_$DataExportIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DataExportIdleImpl extends DataExportIdle {
  const _$DataExportIdleImpl() : super._();

  @override
  String toString() {
    return 'DataExportState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DataExportIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() requesting,
    required TResult Function(DateTime expiresAt) opened,
    required TResult Function(DateTime expiresAt) notOpened,
    required TResult Function(CauceApiError error) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? requesting,
    TResult? Function(DateTime expiresAt)? opened,
    TResult? Function(DateTime expiresAt)? notOpened,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? requesting,
    TResult Function(DateTime expiresAt)? opened,
    TResult Function(DateTime expiresAt)? notOpened,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataExportIdle value) idle,
    required TResult Function(DataExportRequesting value) requesting,
    required TResult Function(DataExportOpened value) opened,
    required TResult Function(DataExportNotOpened value) notOpened,
    required TResult Function(DataExportFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataExportIdle value)? idle,
    TResult? Function(DataExportRequesting value)? requesting,
    TResult? Function(DataExportOpened value)? opened,
    TResult? Function(DataExportNotOpened value)? notOpened,
    TResult? Function(DataExportFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataExportIdle value)? idle,
    TResult Function(DataExportRequesting value)? requesting,
    TResult Function(DataExportOpened value)? opened,
    TResult Function(DataExportNotOpened value)? notOpened,
    TResult Function(DataExportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class DataExportIdle extends DataExportState {
  const factory DataExportIdle() = _$DataExportIdleImpl;
  const DataExportIdle._() : super._();
}

/// @nodoc
abstract class _$$DataExportRequestingImplCopyWith<$Res> {
  factory _$$DataExportRequestingImplCopyWith(_$DataExportRequestingImpl value,
          $Res Function(_$DataExportRequestingImpl) then) =
      __$$DataExportRequestingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DataExportRequestingImplCopyWithImpl<$Res>
    extends _$DataExportStateCopyWithImpl<$Res, _$DataExportRequestingImpl>
    implements _$$DataExportRequestingImplCopyWith<$Res> {
  __$$DataExportRequestingImplCopyWithImpl(_$DataExportRequestingImpl _value,
      $Res Function(_$DataExportRequestingImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DataExportRequestingImpl extends DataExportRequesting {
  const _$DataExportRequestingImpl() : super._();

  @override
  String toString() {
    return 'DataExportState.requesting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataExportRequestingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() requesting,
    required TResult Function(DateTime expiresAt) opened,
    required TResult Function(DateTime expiresAt) notOpened,
    required TResult Function(CauceApiError error) failure,
  }) {
    return requesting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? requesting,
    TResult? Function(DateTime expiresAt)? opened,
    TResult? Function(DateTime expiresAt)? notOpened,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return requesting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? requesting,
    TResult Function(DateTime expiresAt)? opened,
    TResult Function(DateTime expiresAt)? notOpened,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (requesting != null) {
      return requesting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataExportIdle value) idle,
    required TResult Function(DataExportRequesting value) requesting,
    required TResult Function(DataExportOpened value) opened,
    required TResult Function(DataExportNotOpened value) notOpened,
    required TResult Function(DataExportFailure value) failure,
  }) {
    return requesting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataExportIdle value)? idle,
    TResult? Function(DataExportRequesting value)? requesting,
    TResult? Function(DataExportOpened value)? opened,
    TResult? Function(DataExportNotOpened value)? notOpened,
    TResult? Function(DataExportFailure value)? failure,
  }) {
    return requesting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataExportIdle value)? idle,
    TResult Function(DataExportRequesting value)? requesting,
    TResult Function(DataExportOpened value)? opened,
    TResult Function(DataExportNotOpened value)? notOpened,
    TResult Function(DataExportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (requesting != null) {
      return requesting(this);
    }
    return orElse();
  }
}

abstract class DataExportRequesting extends DataExportState {
  const factory DataExportRequesting() = _$DataExportRequestingImpl;
  const DataExportRequesting._() : super._();
}

/// @nodoc
abstract class _$$DataExportOpenedImplCopyWith<$Res> {
  factory _$$DataExportOpenedImplCopyWith(_$DataExportOpenedImpl value,
          $Res Function(_$DataExportOpenedImpl) then) =
      __$$DataExportOpenedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime expiresAt});
}

/// @nodoc
class __$$DataExportOpenedImplCopyWithImpl<$Res>
    extends _$DataExportStateCopyWithImpl<$Res, _$DataExportOpenedImpl>
    implements _$$DataExportOpenedImplCopyWith<$Res> {
  __$$DataExportOpenedImplCopyWithImpl(_$DataExportOpenedImpl _value,
      $Res Function(_$DataExportOpenedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expiresAt = null,
  }) {
    return _then(_$DataExportOpenedImpl(
      null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DataExportOpenedImpl extends DataExportOpened {
  const _$DataExportOpenedImpl(this.expiresAt) : super._();

  @override
  final DateTime expiresAt;

  @override
  String toString() {
    return 'DataExportState.opened(expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataExportOpenedImpl &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expiresAt);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataExportOpenedImplCopyWith<_$DataExportOpenedImpl> get copyWith =>
      __$$DataExportOpenedImplCopyWithImpl<_$DataExportOpenedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() requesting,
    required TResult Function(DateTime expiresAt) opened,
    required TResult Function(DateTime expiresAt) notOpened,
    required TResult Function(CauceApiError error) failure,
  }) {
    return opened(expiresAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? requesting,
    TResult? Function(DateTime expiresAt)? opened,
    TResult? Function(DateTime expiresAt)? notOpened,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return opened?.call(expiresAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? requesting,
    TResult Function(DateTime expiresAt)? opened,
    TResult Function(DateTime expiresAt)? notOpened,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (opened != null) {
      return opened(expiresAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataExportIdle value) idle,
    required TResult Function(DataExportRequesting value) requesting,
    required TResult Function(DataExportOpened value) opened,
    required TResult Function(DataExportNotOpened value) notOpened,
    required TResult Function(DataExportFailure value) failure,
  }) {
    return opened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataExportIdle value)? idle,
    TResult? Function(DataExportRequesting value)? requesting,
    TResult? Function(DataExportOpened value)? opened,
    TResult? Function(DataExportNotOpened value)? notOpened,
    TResult? Function(DataExportFailure value)? failure,
  }) {
    return opened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataExportIdle value)? idle,
    TResult Function(DataExportRequesting value)? requesting,
    TResult Function(DataExportOpened value)? opened,
    TResult Function(DataExportNotOpened value)? notOpened,
    TResult Function(DataExportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (opened != null) {
      return opened(this);
    }
    return orElse();
  }
}

abstract class DataExportOpened extends DataExportState {
  const factory DataExportOpened(final DateTime expiresAt) =
      _$DataExportOpenedImpl;
  const DataExportOpened._() : super._();

  DateTime get expiresAt;

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataExportOpenedImplCopyWith<_$DataExportOpenedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataExportNotOpenedImplCopyWith<$Res> {
  factory _$$DataExportNotOpenedImplCopyWith(_$DataExportNotOpenedImpl value,
          $Res Function(_$DataExportNotOpenedImpl) then) =
      __$$DataExportNotOpenedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime expiresAt});
}

/// @nodoc
class __$$DataExportNotOpenedImplCopyWithImpl<$Res>
    extends _$DataExportStateCopyWithImpl<$Res, _$DataExportNotOpenedImpl>
    implements _$$DataExportNotOpenedImplCopyWith<$Res> {
  __$$DataExportNotOpenedImplCopyWithImpl(_$DataExportNotOpenedImpl _value,
      $Res Function(_$DataExportNotOpenedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expiresAt = null,
  }) {
    return _then(_$DataExportNotOpenedImpl(
      null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DataExportNotOpenedImpl extends DataExportNotOpened {
  const _$DataExportNotOpenedImpl(this.expiresAt) : super._();

  @override
  final DateTime expiresAt;

  @override
  String toString() {
    return 'DataExportState.notOpened(expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataExportNotOpenedImpl &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expiresAt);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataExportNotOpenedImplCopyWith<_$DataExportNotOpenedImpl> get copyWith =>
      __$$DataExportNotOpenedImplCopyWithImpl<_$DataExportNotOpenedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() requesting,
    required TResult Function(DateTime expiresAt) opened,
    required TResult Function(DateTime expiresAt) notOpened,
    required TResult Function(CauceApiError error) failure,
  }) {
    return notOpened(expiresAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? requesting,
    TResult? Function(DateTime expiresAt)? opened,
    TResult? Function(DateTime expiresAt)? notOpened,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return notOpened?.call(expiresAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? requesting,
    TResult Function(DateTime expiresAt)? opened,
    TResult Function(DateTime expiresAt)? notOpened,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (notOpened != null) {
      return notOpened(expiresAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataExportIdle value) idle,
    required TResult Function(DataExportRequesting value) requesting,
    required TResult Function(DataExportOpened value) opened,
    required TResult Function(DataExportNotOpened value) notOpened,
    required TResult Function(DataExportFailure value) failure,
  }) {
    return notOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataExportIdle value)? idle,
    TResult? Function(DataExportRequesting value)? requesting,
    TResult? Function(DataExportOpened value)? opened,
    TResult? Function(DataExportNotOpened value)? notOpened,
    TResult? Function(DataExportFailure value)? failure,
  }) {
    return notOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataExportIdle value)? idle,
    TResult Function(DataExportRequesting value)? requesting,
    TResult Function(DataExportOpened value)? opened,
    TResult Function(DataExportNotOpened value)? notOpened,
    TResult Function(DataExportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (notOpened != null) {
      return notOpened(this);
    }
    return orElse();
  }
}

abstract class DataExportNotOpened extends DataExportState {
  const factory DataExportNotOpened(final DateTime expiresAt) =
      _$DataExportNotOpenedImpl;
  const DataExportNotOpened._() : super._();

  DateTime get expiresAt;

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataExportNotOpenedImplCopyWith<_$DataExportNotOpenedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataExportFailureImplCopyWith<$Res> {
  factory _$$DataExportFailureImplCopyWith(_$DataExportFailureImpl value,
          $Res Function(_$DataExportFailureImpl) then) =
      __$$DataExportFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CauceApiError error});

  $CauceApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$DataExportFailureImplCopyWithImpl<$Res>
    extends _$DataExportStateCopyWithImpl<$Res, _$DataExportFailureImpl>
    implements _$$DataExportFailureImplCopyWith<$Res> {
  __$$DataExportFailureImplCopyWithImpl(_$DataExportFailureImpl _value,
      $Res Function(_$DataExportFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$DataExportFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError,
    ));
  }

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CauceApiErrorCopyWith<$Res> get error {
    return $CauceApiErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$DataExportFailureImpl extends DataExportFailure {
  const _$DataExportFailureImpl(this.error) : super._();

  @override
  final CauceApiError error;

  @override
  String toString() {
    return 'DataExportState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataExportFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataExportFailureImplCopyWith<_$DataExportFailureImpl> get copyWith =>
      __$$DataExportFailureImplCopyWithImpl<_$DataExportFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() requesting,
    required TResult Function(DateTime expiresAt) opened,
    required TResult Function(DateTime expiresAt) notOpened,
    required TResult Function(CauceApiError error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? requesting,
    TResult? Function(DateTime expiresAt)? opened,
    TResult? Function(DateTime expiresAt)? notOpened,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? requesting,
    TResult Function(DateTime expiresAt)? opened,
    TResult Function(DateTime expiresAt)? notOpened,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataExportIdle value) idle,
    required TResult Function(DataExportRequesting value) requesting,
    required TResult Function(DataExportOpened value) opened,
    required TResult Function(DataExportNotOpened value) notOpened,
    required TResult Function(DataExportFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataExportIdle value)? idle,
    TResult? Function(DataExportRequesting value)? requesting,
    TResult? Function(DataExportOpened value)? opened,
    TResult? Function(DataExportNotOpened value)? notOpened,
    TResult? Function(DataExportFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataExportIdle value)? idle,
    TResult Function(DataExportRequesting value)? requesting,
    TResult Function(DataExportOpened value)? opened,
    TResult Function(DataExportNotOpened value)? notOpened,
    TResult Function(DataExportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class DataExportFailure extends DataExportState {
  const factory DataExportFailure(final CauceApiError error) =
      _$DataExportFailureImpl;
  const DataExportFailure._() : super._();

  CauceApiError get error;

  /// Create a copy of DataExportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataExportFailureImplCopyWith<_$DataExportFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
