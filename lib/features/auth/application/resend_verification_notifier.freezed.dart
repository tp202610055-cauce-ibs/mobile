// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resend_verification_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResendVerificationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? sending,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? sending,
    TResult Function()? sent,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResendVerificationIdle value) idle,
    required TResult Function(ResendVerificationSending value) sending,
    required TResult Function(ResendVerificationSent value) sent,
    required TResult Function(ResendVerificationFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResendVerificationIdle value)? idle,
    TResult? Function(ResendVerificationSending value)? sending,
    TResult? Function(ResendVerificationSent value)? sent,
    TResult? Function(ResendVerificationFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResendVerificationIdle value)? idle,
    TResult Function(ResendVerificationSending value)? sending,
    TResult Function(ResendVerificationSent value)? sent,
    TResult Function(ResendVerificationFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResendVerificationStateCopyWith<$Res> {
  factory $ResendVerificationStateCopyWith(ResendVerificationState value,
          $Res Function(ResendVerificationState) then) =
      _$ResendVerificationStateCopyWithImpl<$Res, ResendVerificationState>;
}

/// @nodoc
class _$ResendVerificationStateCopyWithImpl<$Res,
        $Val extends ResendVerificationState>
    implements $ResendVerificationStateCopyWith<$Res> {
  _$ResendVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResendVerificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ResendVerificationIdleImplCopyWith<$Res> {
  factory _$$ResendVerificationIdleImplCopyWith(
          _$ResendVerificationIdleImpl value,
          $Res Function(_$ResendVerificationIdleImpl) then) =
      __$$ResendVerificationIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendVerificationIdleImplCopyWithImpl<$Res>
    extends _$ResendVerificationStateCopyWithImpl<$Res,
        _$ResendVerificationIdleImpl>
    implements _$$ResendVerificationIdleImplCopyWith<$Res> {
  __$$ResendVerificationIdleImplCopyWithImpl(
      _$ResendVerificationIdleImpl _value,
      $Res Function(_$ResendVerificationIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResendVerificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResendVerificationIdleImpl extends ResendVerificationIdle {
  const _$ResendVerificationIdleImpl() : super._();

  @override
  String toString() {
    return 'ResendVerificationState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendVerificationIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? sending,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? sending,
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
    required TResult Function(ResendVerificationIdle value) idle,
    required TResult Function(ResendVerificationSending value) sending,
    required TResult Function(ResendVerificationSent value) sent,
    required TResult Function(ResendVerificationFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResendVerificationIdle value)? idle,
    TResult? Function(ResendVerificationSending value)? sending,
    TResult? Function(ResendVerificationSent value)? sent,
    TResult? Function(ResendVerificationFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResendVerificationIdle value)? idle,
    TResult Function(ResendVerificationSending value)? sending,
    TResult Function(ResendVerificationSent value)? sent,
    TResult Function(ResendVerificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class ResendVerificationIdle extends ResendVerificationState {
  const factory ResendVerificationIdle() = _$ResendVerificationIdleImpl;
  const ResendVerificationIdle._() : super._();
}

/// @nodoc
abstract class _$$ResendVerificationSendingImplCopyWith<$Res> {
  factory _$$ResendVerificationSendingImplCopyWith(
          _$ResendVerificationSendingImpl value,
          $Res Function(_$ResendVerificationSendingImpl) then) =
      __$$ResendVerificationSendingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendVerificationSendingImplCopyWithImpl<$Res>
    extends _$ResendVerificationStateCopyWithImpl<$Res,
        _$ResendVerificationSendingImpl>
    implements _$$ResendVerificationSendingImplCopyWith<$Res> {
  __$$ResendVerificationSendingImplCopyWithImpl(
      _$ResendVerificationSendingImpl _value,
      $Res Function(_$ResendVerificationSendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResendVerificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResendVerificationSendingImpl extends ResendVerificationSending {
  const _$ResendVerificationSendingImpl() : super._();

  @override
  String toString() {
    return 'ResendVerificationState.sending()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendVerificationSendingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return sending();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? sending,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return sending?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? sending,
    TResult Function()? sent,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResendVerificationIdle value) idle,
    required TResult Function(ResendVerificationSending value) sending,
    required TResult Function(ResendVerificationSent value) sent,
    required TResult Function(ResendVerificationFailure value) failure,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResendVerificationIdle value)? idle,
    TResult? Function(ResendVerificationSending value)? sending,
    TResult? Function(ResendVerificationSent value)? sent,
    TResult? Function(ResendVerificationFailure value)? failure,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResendVerificationIdle value)? idle,
    TResult Function(ResendVerificationSending value)? sending,
    TResult Function(ResendVerificationSent value)? sent,
    TResult Function(ResendVerificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class ResendVerificationSending extends ResendVerificationState {
  const factory ResendVerificationSending() = _$ResendVerificationSendingImpl;
  const ResendVerificationSending._() : super._();
}

/// @nodoc
abstract class _$$ResendVerificationSentImplCopyWith<$Res> {
  factory _$$ResendVerificationSentImplCopyWith(
          _$ResendVerificationSentImpl value,
          $Res Function(_$ResendVerificationSentImpl) then) =
      __$$ResendVerificationSentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendVerificationSentImplCopyWithImpl<$Res>
    extends _$ResendVerificationStateCopyWithImpl<$Res,
        _$ResendVerificationSentImpl>
    implements _$$ResendVerificationSentImplCopyWith<$Res> {
  __$$ResendVerificationSentImplCopyWithImpl(
      _$ResendVerificationSentImpl _value,
      $Res Function(_$ResendVerificationSentImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResendVerificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResendVerificationSentImpl extends ResendVerificationSent {
  const _$ResendVerificationSentImpl() : super._();

  @override
  String toString() {
    return 'ResendVerificationState.sent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendVerificationSentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return sent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? sending,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return sent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? sending,
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
    required TResult Function(ResendVerificationIdle value) idle,
    required TResult Function(ResendVerificationSending value) sending,
    required TResult Function(ResendVerificationSent value) sent,
    required TResult Function(ResendVerificationFailure value) failure,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResendVerificationIdle value)? idle,
    TResult? Function(ResendVerificationSending value)? sending,
    TResult? Function(ResendVerificationSent value)? sent,
    TResult? Function(ResendVerificationFailure value)? failure,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResendVerificationIdle value)? idle,
    TResult Function(ResendVerificationSending value)? sending,
    TResult Function(ResendVerificationSent value)? sent,
    TResult Function(ResendVerificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }
}

abstract class ResendVerificationSent extends ResendVerificationState {
  const factory ResendVerificationSent() = _$ResendVerificationSentImpl;
  const ResendVerificationSent._() : super._();
}

/// @nodoc
abstract class _$$ResendVerificationFailureImplCopyWith<$Res> {
  factory _$$ResendVerificationFailureImplCopyWith(
          _$ResendVerificationFailureImpl value,
          $Res Function(_$ResendVerificationFailureImpl) then) =
      __$$ResendVerificationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CauceApiError error});

  $CauceApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$ResendVerificationFailureImplCopyWithImpl<$Res>
    extends _$ResendVerificationStateCopyWithImpl<$Res,
        _$ResendVerificationFailureImpl>
    implements _$$ResendVerificationFailureImplCopyWith<$Res> {
  __$$ResendVerificationFailureImplCopyWithImpl(
      _$ResendVerificationFailureImpl _value,
      $Res Function(_$ResendVerificationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResendVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ResendVerificationFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError,
    ));
  }

  /// Create a copy of ResendVerificationState
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

class _$ResendVerificationFailureImpl extends ResendVerificationFailure {
  const _$ResendVerificationFailureImpl(this.error) : super._();

  @override
  final CauceApiError error;

  @override
  String toString() {
    return 'ResendVerificationState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendVerificationFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ResendVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendVerificationFailureImplCopyWith<_$ResendVerificationFailureImpl>
      get copyWith => __$$ResendVerificationFailureImplCopyWithImpl<
          _$ResendVerificationFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(CauceApiError error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? sending,
    TResult? Function()? sent,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? sending,
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
    required TResult Function(ResendVerificationIdle value) idle,
    required TResult Function(ResendVerificationSending value) sending,
    required TResult Function(ResendVerificationSent value) sent,
    required TResult Function(ResendVerificationFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResendVerificationIdle value)? idle,
    TResult? Function(ResendVerificationSending value)? sending,
    TResult? Function(ResendVerificationSent value)? sent,
    TResult? Function(ResendVerificationFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResendVerificationIdle value)? idle,
    TResult Function(ResendVerificationSending value)? sending,
    TResult Function(ResendVerificationSent value)? sent,
    TResult Function(ResendVerificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ResendVerificationFailure extends ResendVerificationState {
  const factory ResendVerificationFailure(final CauceApiError error) =
      _$ResendVerificationFailureImpl;
  const ResendVerificationFailure._() : super._();

  CauceApiError get error;

  /// Create a copy of ResendVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResendVerificationFailureImplCopyWith<_$ResendVerificationFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
