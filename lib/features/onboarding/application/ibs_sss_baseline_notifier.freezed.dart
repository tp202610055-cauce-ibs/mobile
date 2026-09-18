// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ibs_sss_baseline_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IbsSssBaselineState {
  IbsSssAnswers get answers => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;

  /// Resultado devuelto por el servidor, disponible recien tras el envio.
  IbsSssResult? get result => throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IbsSssBaselineStateCopyWith<IbsSssBaselineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IbsSssBaselineStateCopyWith<$Res> {
  factory $IbsSssBaselineStateCopyWith(
          IbsSssBaselineState value, $Res Function(IbsSssBaselineState) then) =
      _$IbsSssBaselineStateCopyWithImpl<$Res, IbsSssBaselineState>;
  @useResult
  $Res call(
      {IbsSssAnswers answers,
      bool submitting,
      IbsSssResult? result,
      CauceApiError? error});

  $IbsSssAnswersCopyWith<$Res> get answers;
  $IbsSssResultCopyWith<$Res>? get result;
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$IbsSssBaselineStateCopyWithImpl<$Res, $Val extends IbsSssBaselineState>
    implements $IbsSssBaselineStateCopyWith<$Res> {
  _$IbsSssBaselineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answers = null,
    Object? submitting = null,
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as IbsSssAnswers,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as IbsSssResult?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IbsSssAnswersCopyWith<$Res> get answers {
    return $IbsSssAnswersCopyWith<$Res>(_value.answers, (value) {
      return _then(_value.copyWith(answers: value) as $Val);
    });
  }

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IbsSssResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $IbsSssResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CauceApiErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $CauceApiErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IbsSssBaselineStateImplCopyWith<$Res>
    implements $IbsSssBaselineStateCopyWith<$Res> {
  factory _$$IbsSssBaselineStateImplCopyWith(_$IbsSssBaselineStateImpl value,
          $Res Function(_$IbsSssBaselineStateImpl) then) =
      __$$IbsSssBaselineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IbsSssAnswers answers,
      bool submitting,
      IbsSssResult? result,
      CauceApiError? error});

  @override
  $IbsSssAnswersCopyWith<$Res> get answers;
  @override
  $IbsSssResultCopyWith<$Res>? get result;
  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$IbsSssBaselineStateImplCopyWithImpl<$Res>
    extends _$IbsSssBaselineStateCopyWithImpl<$Res, _$IbsSssBaselineStateImpl>
    implements _$$IbsSssBaselineStateImplCopyWith<$Res> {
  __$$IbsSssBaselineStateImplCopyWithImpl(_$IbsSssBaselineStateImpl _value,
      $Res Function(_$IbsSssBaselineStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answers = null,
    Object? submitting = null,
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_$IbsSssBaselineStateImpl(
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as IbsSssAnswers,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as IbsSssResult?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$IbsSssBaselineStateImpl extends _IbsSssBaselineState {
  const _$IbsSssBaselineStateImpl(
      {this.answers = const IbsSssAnswers(),
      this.submitting = false,
      this.result,
      this.error})
      : super._();

  @override
  @JsonKey()
  final IbsSssAnswers answers;
  @override
  @JsonKey()
  final bool submitting;

  /// Resultado devuelto por el servidor, disponible recien tras el envio.
  @override
  final IbsSssResult? result;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'IbsSssBaselineState(answers: $answers, submitting: $submitting, result: $result, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IbsSssBaselineStateImpl &&
            (identical(other.answers, answers) || other.answers == answers) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, answers, submitting, result, error);

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IbsSssBaselineStateImplCopyWith<_$IbsSssBaselineStateImpl> get copyWith =>
      __$$IbsSssBaselineStateImplCopyWithImpl<_$IbsSssBaselineStateImpl>(
          this, _$identity);
}

abstract class _IbsSssBaselineState extends IbsSssBaselineState {
  const factory _IbsSssBaselineState(
      {final IbsSssAnswers answers,
      final bool submitting,
      final IbsSssResult? result,
      final CauceApiError? error}) = _$IbsSssBaselineStateImpl;
  const _IbsSssBaselineState._() : super._();

  @override
  IbsSssAnswers get answers;
  @override
  bool get submitting;

  /// Resultado devuelto por el servidor, disponible recien tras el envio.
  @override
  IbsSssResult? get result;
  @override
  CauceApiError? get error;

  /// Create a copy of IbsSssBaselineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IbsSssBaselineStateImplCopyWith<_$IbsSssBaselineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
