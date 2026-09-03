// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(CauceApiError error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(CauceApiError error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginIdle value) idle,
    required TResult Function(LoginSubmitting value) submitting,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginIdle value)? idle,
    TResult? Function(LoginSubmitting value)? submitting,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginIdle value)? idle,
    TResult Function(LoginSubmitting value)? submitting,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginIdleImplCopyWith<$Res> {
  factory _$$LoginIdleImplCopyWith(
          _$LoginIdleImpl value, $Res Function(_$LoginIdleImpl) then) =
      __$$LoginIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginIdleImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginIdleImpl>
    implements _$$LoginIdleImplCopyWith<$Res> {
  __$$LoginIdleImplCopyWithImpl(
      _$LoginIdleImpl _value, $Res Function(_$LoginIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginIdleImpl extends LoginIdle {
  const _$LoginIdleImpl() : super._();

  @override
  String toString() {
    return 'LoginState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(CauceApiError error) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(LoginIdle value) idle,
    required TResult Function(LoginSubmitting value) submitting,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginIdle value)? idle,
    TResult? Function(LoginSubmitting value)? submitting,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginIdle value)? idle,
    TResult Function(LoginSubmitting value)? submitting,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class LoginIdle extends LoginState {
  const factory LoginIdle() = _$LoginIdleImpl;
  const LoginIdle._() : super._();
}

/// @nodoc
abstract class _$$LoginSubmittingImplCopyWith<$Res> {
  factory _$$LoginSubmittingImplCopyWith(_$LoginSubmittingImpl value,
          $Res Function(_$LoginSubmittingImpl) then) =
      __$$LoginSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSubmittingImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginSubmittingImpl>
    implements _$$LoginSubmittingImplCopyWith<$Res> {
  __$$LoginSubmittingImplCopyWithImpl(
      _$LoginSubmittingImpl _value, $Res Function(_$LoginSubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginSubmittingImpl extends LoginSubmitting {
  const _$LoginSubmittingImpl() : super._();

  @override
  String toString() {
    return 'LoginState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginSubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(CauceApiError error) failure,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(LoginIdle value) idle,
    required TResult Function(LoginSubmitting value) submitting,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginFailure value) failure,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginIdle value)? idle,
    TResult? Function(LoginSubmitting value)? submitting,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginFailure value)? failure,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginIdle value)? idle,
    TResult Function(LoginSubmitting value)? submitting,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class LoginSubmitting extends LoginState {
  const factory LoginSubmitting() = _$LoginSubmittingImpl;
  const LoginSubmitting._() : super._();
}

/// @nodoc
abstract class _$$LoginSuccessImplCopyWith<$Res> {
  factory _$$LoginSuccessImplCopyWith(
          _$LoginSuccessImpl value, $Res Function(_$LoginSuccessImpl) then) =
      __$$LoginSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSuccessImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginSuccessImpl>
    implements _$$LoginSuccessImplCopyWith<$Res> {
  __$$LoginSuccessImplCopyWithImpl(
      _$LoginSuccessImpl _value, $Res Function(_$LoginSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginSuccessImpl extends LoginSuccess {
  const _$LoginSuccessImpl() : super._();

  @override
  String toString() {
    return 'LoginState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(CauceApiError error) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginIdle value) idle,
    required TResult Function(LoginSubmitting value) submitting,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginIdle value)? idle,
    TResult? Function(LoginSubmitting value)? submitting,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginIdle value)? idle,
    TResult Function(LoginSubmitting value)? submitting,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class LoginSuccess extends LoginState {
  const factory LoginSuccess() = _$LoginSuccessImpl;
  const LoginSuccess._() : super._();
}

/// @nodoc
abstract class _$$LoginFailureImplCopyWith<$Res> {
  factory _$$LoginFailureImplCopyWith(
          _$LoginFailureImpl value, $Res Function(_$LoginFailureImpl) then) =
      __$$LoginFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CauceApiError error});

  $CauceApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$LoginFailureImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginFailureImpl>
    implements _$$LoginFailureImplCopyWith<$Res> {
  __$$LoginFailureImplCopyWithImpl(
      _$LoginFailureImpl _value, $Res Function(_$LoginFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$LoginFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError,
    ));
  }

  /// Create a copy of LoginState
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

class _$LoginFailureImpl extends LoginFailure {
  const _$LoginFailureImpl(this.error) : super._();

  @override
  final CauceApiError error;

  @override
  String toString() {
    return 'LoginState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFailureImplCopyWith<_$LoginFailureImpl> get copyWith =>
      __$$LoginFailureImplCopyWithImpl<_$LoginFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(CauceApiError error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(LoginIdle value) idle,
    required TResult Function(LoginSubmitting value) submitting,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginIdle value)? idle,
    TResult? Function(LoginSubmitting value)? submitting,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginIdle value)? idle,
    TResult Function(LoginSubmitting value)? submitting,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class LoginFailure extends LoginState {
  const factory LoginFailure(final CauceApiError error) = _$LoginFailureImpl;
  const LoginFailure._() : super._();

  CauceApiError get error;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginFailureImplCopyWith<_$LoginFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
