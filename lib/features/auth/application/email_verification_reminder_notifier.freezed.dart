// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_reminder_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmailVerificationReminderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hidden,
    required TResult Function(String email, bool checking, bool stillPending,
            CauceApiError? error)
        visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? hidden,
    TResult? Function(String email, bool checking, bool stillPending,
            CauceApiError? error)?
        visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function(String email, bool checking, bool stillPending,
            CauceApiError? error)?
        visible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailVerificationReminderHidden value) hidden,
    required TResult Function(EmailVerificationReminderVisible value) visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailVerificationReminderHidden value)? hidden,
    TResult? Function(EmailVerificationReminderVisible value)? visible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailVerificationReminderHidden value)? hidden,
    TResult Function(EmailVerificationReminderVisible value)? visible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationReminderStateCopyWith<$Res> {
  factory $EmailVerificationReminderStateCopyWith(
          EmailVerificationReminderState value,
          $Res Function(EmailVerificationReminderState) then) =
      _$EmailVerificationReminderStateCopyWithImpl<$Res,
          EmailVerificationReminderState>;
}

/// @nodoc
class _$EmailVerificationReminderStateCopyWithImpl<$Res,
        $Val extends EmailVerificationReminderState>
    implements $EmailVerificationReminderStateCopyWith<$Res> {
  _$EmailVerificationReminderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailVerificationReminderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EmailVerificationReminderHiddenImplCopyWith<$Res> {
  factory _$$EmailVerificationReminderHiddenImplCopyWith(
          _$EmailVerificationReminderHiddenImpl value,
          $Res Function(_$EmailVerificationReminderHiddenImpl) then) =
      __$$EmailVerificationReminderHiddenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmailVerificationReminderHiddenImplCopyWithImpl<$Res>
    extends _$EmailVerificationReminderStateCopyWithImpl<$Res,
        _$EmailVerificationReminderHiddenImpl>
    implements _$$EmailVerificationReminderHiddenImplCopyWith<$Res> {
  __$$EmailVerificationReminderHiddenImplCopyWithImpl(
      _$EmailVerificationReminderHiddenImpl _value,
      $Res Function(_$EmailVerificationReminderHiddenImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailVerificationReminderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmailVerificationReminderHiddenImpl
    implements EmailVerificationReminderHidden {
  const _$EmailVerificationReminderHiddenImpl();

  @override
  String toString() {
    return 'EmailVerificationReminderState.hidden()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationReminderHiddenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hidden,
    required TResult Function(String email, bool checking, bool stillPending,
            CauceApiError? error)
        visible,
  }) {
    return hidden();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? hidden,
    TResult? Function(String email, bool checking, bool stillPending,
            CauceApiError? error)?
        visible,
  }) {
    return hidden?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function(String email, bool checking, bool stillPending,
            CauceApiError? error)?
        visible,
    required TResult orElse(),
  }) {
    if (hidden != null) {
      return hidden();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailVerificationReminderHidden value) hidden,
    required TResult Function(EmailVerificationReminderVisible value) visible,
  }) {
    return hidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailVerificationReminderHidden value)? hidden,
    TResult? Function(EmailVerificationReminderVisible value)? visible,
  }) {
    return hidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailVerificationReminderHidden value)? hidden,
    TResult Function(EmailVerificationReminderVisible value)? visible,
    required TResult orElse(),
  }) {
    if (hidden != null) {
      return hidden(this);
    }
    return orElse();
  }
}

abstract class EmailVerificationReminderHidden
    implements EmailVerificationReminderState {
  const factory EmailVerificationReminderHidden() =
      _$EmailVerificationReminderHiddenImpl;
}

/// @nodoc
abstract class _$$EmailVerificationReminderVisibleImplCopyWith<$Res> {
  factory _$$EmailVerificationReminderVisibleImplCopyWith(
          _$EmailVerificationReminderVisibleImpl value,
          $Res Function(_$EmailVerificationReminderVisibleImpl) then) =
      __$$EmailVerificationReminderVisibleImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String email, bool checking, bool stillPending, CauceApiError? error});

  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$EmailVerificationReminderVisibleImplCopyWithImpl<$Res>
    extends _$EmailVerificationReminderStateCopyWithImpl<$Res,
        _$EmailVerificationReminderVisibleImpl>
    implements _$$EmailVerificationReminderVisibleImplCopyWith<$Res> {
  __$$EmailVerificationReminderVisibleImplCopyWithImpl(
      _$EmailVerificationReminderVisibleImpl _value,
      $Res Function(_$EmailVerificationReminderVisibleImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailVerificationReminderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? checking = null,
    Object? stillPending = null,
    Object? error = freezed,
  }) {
    return _then(_$EmailVerificationReminderVisibleImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      checking: null == checking
          ? _value.checking
          : checking // ignore: cast_nullable_to_non_nullable
              as bool,
      stillPending: null == stillPending
          ? _value.stillPending
          : stillPending // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }

  /// Create a copy of EmailVerificationReminderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CauceApiErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $CauceApiErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$EmailVerificationReminderVisibleImpl
    implements EmailVerificationReminderVisible {
  const _$EmailVerificationReminderVisibleImpl(
      {required this.email,
      this.checking = false,
      this.stillPending = false,
      this.error});

  @override
  final String email;
  @override
  @JsonKey()
  final bool checking;
  @override
  @JsonKey()
  final bool stillPending;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'EmailVerificationReminderState.visible(email: $email, checking: $checking, stillPending: $stillPending, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationReminderVisibleImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.checking, checking) ||
                other.checking == checking) &&
            (identical(other.stillPending, stillPending) ||
                other.stillPending == stillPending) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, checking, stillPending, error);

  /// Create a copy of EmailVerificationReminderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailVerificationReminderVisibleImplCopyWith<
          _$EmailVerificationReminderVisibleImpl>
      get copyWith => __$$EmailVerificationReminderVisibleImplCopyWithImpl<
          _$EmailVerificationReminderVisibleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hidden,
    required TResult Function(String email, bool checking, bool stillPending,
            CauceApiError? error)
        visible,
  }) {
    return visible(email, checking, stillPending, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? hidden,
    TResult? Function(String email, bool checking, bool stillPending,
            CauceApiError? error)?
        visible,
  }) {
    return visible?.call(email, checking, stillPending, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hidden,
    TResult Function(String email, bool checking, bool stillPending,
            CauceApiError? error)?
        visible,
    required TResult orElse(),
  }) {
    if (visible != null) {
      return visible(email, checking, stillPending, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailVerificationReminderHidden value) hidden,
    required TResult Function(EmailVerificationReminderVisible value) visible,
  }) {
    return visible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailVerificationReminderHidden value)? hidden,
    TResult? Function(EmailVerificationReminderVisible value)? visible,
  }) {
    return visible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailVerificationReminderHidden value)? hidden,
    TResult Function(EmailVerificationReminderVisible value)? visible,
    required TResult orElse(),
  }) {
    if (visible != null) {
      return visible(this);
    }
    return orElse();
  }
}

abstract class EmailVerificationReminderVisible
    implements EmailVerificationReminderState {
  const factory EmailVerificationReminderVisible(
      {required final String email,
      final bool checking,
      final bool stillPending,
      final CauceApiError? error}) = _$EmailVerificationReminderVisibleImpl;

  String get email;
  bool get checking;
  bool get stillPending;
  CauceApiError? get error;

  /// Create a copy of EmailVerificationReminderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailVerificationReminderVisibleImplCopyWith<
          _$EmailVerificationReminderVisibleImpl>
      get copyWith => throw _privateConstructorUsedError;
}
