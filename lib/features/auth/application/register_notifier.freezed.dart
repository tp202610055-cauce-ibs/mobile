// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegisterState {
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
    required TResult Function(RegisterIdle value) idle,
    required TResult Function(RegisterSubmitting value) submitting,
    required TResult Function(RegisterSuccess value) success,
    required TResult Function(RegisterFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterIdle value)? idle,
    TResult? Function(RegisterSubmitting value)? submitting,
    TResult? Function(RegisterSuccess value)? success,
    TResult? Function(RegisterFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterIdle value)? idle,
    TResult Function(RegisterSubmitting value)? submitting,
    TResult Function(RegisterSuccess value)? success,
    TResult Function(RegisterFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res, RegisterState>;
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res, $Val extends RegisterState>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RegisterIdleImplCopyWith<$Res> {
  factory _$$RegisterIdleImplCopyWith(
          _$RegisterIdleImpl value, $Res Function(_$RegisterIdleImpl) then) =
      __$$RegisterIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterIdleImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterIdleImpl>
    implements _$$RegisterIdleImplCopyWith<$Res> {
  __$$RegisterIdleImplCopyWithImpl(
      _$RegisterIdleImpl _value, $Res Function(_$RegisterIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterIdleImpl extends RegisterIdle {
  const _$RegisterIdleImpl() : super._();

  @override
  String toString() {
    return 'RegisterState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterIdleImpl);
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
    required TResult Function(RegisterIdle value) idle,
    required TResult Function(RegisterSubmitting value) submitting,
    required TResult Function(RegisterSuccess value) success,
    required TResult Function(RegisterFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterIdle value)? idle,
    TResult? Function(RegisterSubmitting value)? submitting,
    TResult? Function(RegisterSuccess value)? success,
    TResult? Function(RegisterFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterIdle value)? idle,
    TResult Function(RegisterSubmitting value)? submitting,
    TResult Function(RegisterSuccess value)? success,
    TResult Function(RegisterFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class RegisterIdle extends RegisterState {
  const factory RegisterIdle() = _$RegisterIdleImpl;
  const RegisterIdle._() : super._();
}

/// @nodoc
abstract class _$$RegisterSubmittingImplCopyWith<$Res> {
  factory _$$RegisterSubmittingImplCopyWith(_$RegisterSubmittingImpl value,
          $Res Function(_$RegisterSubmittingImpl) then) =
      __$$RegisterSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterSubmittingImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterSubmittingImpl>
    implements _$$RegisterSubmittingImplCopyWith<$Res> {
  __$$RegisterSubmittingImplCopyWithImpl(_$RegisterSubmittingImpl _value,
      $Res Function(_$RegisterSubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterSubmittingImpl extends RegisterSubmitting {
  const _$RegisterSubmittingImpl() : super._();

  @override
  String toString() {
    return 'RegisterState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterSubmittingImpl);
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
    required TResult Function(RegisterIdle value) idle,
    required TResult Function(RegisterSubmitting value) submitting,
    required TResult Function(RegisterSuccess value) success,
    required TResult Function(RegisterFailure value) failure,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterIdle value)? idle,
    TResult? Function(RegisterSubmitting value)? submitting,
    TResult? Function(RegisterSuccess value)? success,
    TResult? Function(RegisterFailure value)? failure,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterIdle value)? idle,
    TResult Function(RegisterSubmitting value)? submitting,
    TResult Function(RegisterSuccess value)? success,
    TResult Function(RegisterFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class RegisterSubmitting extends RegisterState {
  const factory RegisterSubmitting() = _$RegisterSubmittingImpl;
  const RegisterSubmitting._() : super._();
}

/// @nodoc
abstract class _$$RegisterSuccessImplCopyWith<$Res> {
  factory _$$RegisterSuccessImplCopyWith(_$RegisterSuccessImpl value,
          $Res Function(_$RegisterSuccessImpl) then) =
      __$$RegisterSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterSuccessImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterSuccessImpl>
    implements _$$RegisterSuccessImplCopyWith<$Res> {
  __$$RegisterSuccessImplCopyWithImpl(
      _$RegisterSuccessImpl _value, $Res Function(_$RegisterSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterSuccessImpl extends RegisterSuccess {
  const _$RegisterSuccessImpl() : super._();

  @override
  String toString() {
    return 'RegisterState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterSuccessImpl);
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
    required TResult Function(RegisterIdle value) idle,
    required TResult Function(RegisterSubmitting value) submitting,
    required TResult Function(RegisterSuccess value) success,
    required TResult Function(RegisterFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterIdle value)? idle,
    TResult? Function(RegisterSubmitting value)? submitting,
    TResult? Function(RegisterSuccess value)? success,
    TResult? Function(RegisterFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterIdle value)? idle,
    TResult Function(RegisterSubmitting value)? submitting,
    TResult Function(RegisterSuccess value)? success,
    TResult Function(RegisterFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RegisterSuccess extends RegisterState {
  const factory RegisterSuccess() = _$RegisterSuccessImpl;
  const RegisterSuccess._() : super._();
}

/// @nodoc
abstract class _$$RegisterFailureImplCopyWith<$Res> {
  factory _$$RegisterFailureImplCopyWith(_$RegisterFailureImpl value,
          $Res Function(_$RegisterFailureImpl) then) =
      __$$RegisterFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CauceApiError error});

  $CauceApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$RegisterFailureImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterFailureImpl>
    implements _$$RegisterFailureImplCopyWith<$Res> {
  __$$RegisterFailureImplCopyWithImpl(
      _$RegisterFailureImpl _value, $Res Function(_$RegisterFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$RegisterFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError,
    ));
  }

  /// Create a copy of RegisterState
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

class _$RegisterFailureImpl extends RegisterFailure {
  const _$RegisterFailureImpl(this.error) : super._();

  @override
  final CauceApiError error;

  @override
  String toString() {
    return 'RegisterState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterFailureImplCopyWith<_$RegisterFailureImpl> get copyWith =>
      __$$RegisterFailureImplCopyWithImpl<_$RegisterFailureImpl>(
          this, _$identity);

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
    required TResult Function(RegisterIdle value) idle,
    required TResult Function(RegisterSubmitting value) submitting,
    required TResult Function(RegisterSuccess value) success,
    required TResult Function(RegisterFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterIdle value)? idle,
    TResult? Function(RegisterSubmitting value)? submitting,
    TResult? Function(RegisterSuccess value)? success,
    TResult? Function(RegisterFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterIdle value)? idle,
    TResult Function(RegisterSubmitting value)? submitting,
    TResult Function(RegisterSuccess value)? success,
    TResult Function(RegisterFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class RegisterFailure extends RegisterState {
  const factory RegisterFailure(final CauceApiError error) =
      _$RegisterFailureImpl;
  const RegisterFailure._() : super._();

  CauceApiError get error;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterFailureImplCopyWith<_$RegisterFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
