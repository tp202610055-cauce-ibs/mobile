// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_recovery_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PasswordRecoveryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? sent,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PasswordRecoveryIdle value) idle,
    required TResult Function(PasswordRecoverySubmitting value) submitting,
    required TResult Function(PasswordRecoverySent value) sent,
    required TResult Function(PasswordRecoveryFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordRecoveryIdle value)? idle,
    TResult? Function(PasswordRecoverySubmitting value)? submitting,
    TResult? Function(PasswordRecoverySent value)? sent,
    TResult? Function(PasswordRecoveryFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordRecoveryIdle value)? idle,
    TResult Function(PasswordRecoverySubmitting value)? submitting,
    TResult Function(PasswordRecoverySent value)? sent,
    TResult Function(PasswordRecoveryFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordRecoveryStateCopyWith<$Res> {
  factory $PasswordRecoveryStateCopyWith(PasswordRecoveryState value,
          $Res Function(PasswordRecoveryState) then) =
      _$PasswordRecoveryStateCopyWithImpl<$Res, PasswordRecoveryState>;
}

/// @nodoc
class _$PasswordRecoveryStateCopyWithImpl<$Res,
        $Val extends PasswordRecoveryState>
    implements $PasswordRecoveryStateCopyWith<$Res> {
  _$PasswordRecoveryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PasswordRecoveryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PasswordRecoveryIdleImplCopyWith<$Res> {
  factory _$$PasswordRecoveryIdleImplCopyWith(_$PasswordRecoveryIdleImpl value,
          $Res Function(_$PasswordRecoveryIdleImpl) then) =
      __$$PasswordRecoveryIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PasswordRecoveryIdleImplCopyWithImpl<$Res>
    extends _$PasswordRecoveryStateCopyWithImpl<$Res,
        _$PasswordRecoveryIdleImpl>
    implements _$$PasswordRecoveryIdleImplCopyWith<$Res> {
  __$$PasswordRecoveryIdleImplCopyWithImpl(_$PasswordRecoveryIdleImpl _value,
      $Res Function(_$PasswordRecoveryIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of PasswordRecoveryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PasswordRecoveryIdleImpl extends PasswordRecoveryIdle {
  const _$PasswordRecoveryIdleImpl() : super._();

  @override
  String toString() {
    return 'PasswordRecoveryState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordRecoveryIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? sent,
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
    required TResult Function(PasswordRecoveryIdle value) idle,
    required TResult Function(PasswordRecoverySubmitting value) submitting,
    required TResult Function(PasswordRecoverySent value) sent,
    required TResult Function(PasswordRecoveryFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordRecoveryIdle value)? idle,
    TResult? Function(PasswordRecoverySubmitting value)? submitting,
    TResult? Function(PasswordRecoverySent value)? sent,
    TResult? Function(PasswordRecoveryFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordRecoveryIdle value)? idle,
    TResult Function(PasswordRecoverySubmitting value)? submitting,
    TResult Function(PasswordRecoverySent value)? sent,
    TResult Function(PasswordRecoveryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class PasswordRecoveryIdle extends PasswordRecoveryState {
  const factory PasswordRecoveryIdle() = _$PasswordRecoveryIdleImpl;
  const PasswordRecoveryIdle._() : super._();
}

/// @nodoc
abstract class _$$PasswordRecoverySubmittingImplCopyWith<$Res> {
  factory _$$PasswordRecoverySubmittingImplCopyWith(
          _$PasswordRecoverySubmittingImpl value,
          $Res Function(_$PasswordRecoverySubmittingImpl) then) =
      __$$PasswordRecoverySubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PasswordRecoverySubmittingImplCopyWithImpl<$Res>
    extends _$PasswordRecoveryStateCopyWithImpl<$Res,
        _$PasswordRecoverySubmittingImpl>
    implements _$$PasswordRecoverySubmittingImplCopyWith<$Res> {
  __$$PasswordRecoverySubmittingImplCopyWithImpl(
      _$PasswordRecoverySubmittingImpl _value,
      $Res Function(_$PasswordRecoverySubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PasswordRecoveryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PasswordRecoverySubmittingImpl extends PasswordRecoverySubmitting {
  const _$PasswordRecoverySubmittingImpl() : super._();

  @override
  String toString() {
    return 'PasswordRecoveryState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordRecoverySubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? sent,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PasswordRecoveryIdle value) idle,
    required TResult Function(PasswordRecoverySubmitting value) submitting,
    required TResult Function(PasswordRecoverySent value) sent,
    required TResult Function(PasswordRecoveryFailure value) failure,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordRecoveryIdle value)? idle,
    TResult? Function(PasswordRecoverySubmitting value)? submitting,
    TResult? Function(PasswordRecoverySent value)? sent,
    TResult? Function(PasswordRecoveryFailure value)? failure,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordRecoveryIdle value)? idle,
    TResult Function(PasswordRecoverySubmitting value)? submitting,
    TResult Function(PasswordRecoverySent value)? sent,
    TResult Function(PasswordRecoveryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class PasswordRecoverySubmitting extends PasswordRecoveryState {
  const factory PasswordRecoverySubmitting() = _$PasswordRecoverySubmittingImpl;
  const PasswordRecoverySubmitting._() : super._();
}

/// @nodoc
abstract class _$$PasswordRecoverySentImplCopyWith<$Res> {
  factory _$$PasswordRecoverySentImplCopyWith(_$PasswordRecoverySentImpl value,
          $Res Function(_$PasswordRecoverySentImpl) then) =
      __$$PasswordRecoverySentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PasswordRecoverySentImplCopyWithImpl<$Res>
    extends _$PasswordRecoveryStateCopyWithImpl<$Res,
        _$PasswordRecoverySentImpl>
    implements _$$PasswordRecoverySentImplCopyWith<$Res> {
  __$$PasswordRecoverySentImplCopyWithImpl(_$PasswordRecoverySentImpl _value,
      $Res Function(_$PasswordRecoverySentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PasswordRecoveryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PasswordRecoverySentImpl extends PasswordRecoverySent {
  const _$PasswordRecoverySentImpl() : super._();

  @override
  String toString() {
    return 'PasswordRecoveryState.sent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordRecoverySentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return sent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return sent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? sent,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PasswordRecoveryIdle value) idle,
    required TResult Function(PasswordRecoverySubmitting value) submitting,
    required TResult Function(PasswordRecoverySent value) sent,
    required TResult Function(PasswordRecoveryFailure value) failure,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordRecoveryIdle value)? idle,
    TResult? Function(PasswordRecoverySubmitting value)? submitting,
    TResult? Function(PasswordRecoverySent value)? sent,
    TResult? Function(PasswordRecoveryFailure value)? failure,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordRecoveryIdle value)? idle,
    TResult Function(PasswordRecoverySubmitting value)? submitting,
    TResult Function(PasswordRecoverySent value)? sent,
    TResult Function(PasswordRecoveryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }
}

abstract class PasswordRecoverySent extends PasswordRecoveryState {
  const factory PasswordRecoverySent() = _$PasswordRecoverySentImpl;
  const PasswordRecoverySent._() : super._();
}

/// @nodoc
abstract class _$$PasswordRecoveryFailureImplCopyWith<$Res> {
  factory _$$PasswordRecoveryFailureImplCopyWith(
          _$PasswordRecoveryFailureImpl value,
          $Res Function(_$PasswordRecoveryFailureImpl) then) =
      __$$PasswordRecoveryFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CauceApiError error});

  $CauceApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$PasswordRecoveryFailureImplCopyWithImpl<$Res>
    extends _$PasswordRecoveryStateCopyWithImpl<$Res,
        _$PasswordRecoveryFailureImpl>
    implements _$$PasswordRecoveryFailureImplCopyWith<$Res> {
  __$$PasswordRecoveryFailureImplCopyWithImpl(
      _$PasswordRecoveryFailureImpl _value,
      $Res Function(_$PasswordRecoveryFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of PasswordRecoveryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$PasswordRecoveryFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError,
    ));
  }

  /// Create a copy of PasswordRecoveryState
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

class _$PasswordRecoveryFailureImpl extends PasswordRecoveryFailure {
  const _$PasswordRecoveryFailureImpl(this.error) : super._();

  @override
  final CauceApiError error;

  @override
  String toString() {
    return 'PasswordRecoveryState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordRecoveryFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of PasswordRecoveryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordRecoveryFailureImplCopyWith<_$PasswordRecoveryFailureImpl>
      get copyWith => __$$PasswordRecoveryFailureImplCopyWithImpl<
          _$PasswordRecoveryFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? sent,
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
    required TResult Function(PasswordRecoveryIdle value) idle,
    required TResult Function(PasswordRecoverySubmitting value) submitting,
    required TResult Function(PasswordRecoverySent value) sent,
    required TResult Function(PasswordRecoveryFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordRecoveryIdle value)? idle,
    TResult? Function(PasswordRecoverySubmitting value)? submitting,
    TResult? Function(PasswordRecoverySent value)? sent,
    TResult? Function(PasswordRecoveryFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordRecoveryIdle value)? idle,
    TResult Function(PasswordRecoverySubmitting value)? submitting,
    TResult Function(PasswordRecoverySent value)? sent,
    TResult Function(PasswordRecoveryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class PasswordRecoveryFailure extends PasswordRecoveryState {
  const factory PasswordRecoveryFailure(final CauceApiError error) =
      _$PasswordRecoveryFailureImpl;
  const PasswordRecoveryFailure._() : super._();

  CauceApiError get error;

  /// Create a copy of PasswordRecoveryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordRecoveryFailureImplCopyWith<_$PasswordRecoveryFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
