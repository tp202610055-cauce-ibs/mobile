// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'periodic_assessment_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PeriodicAssessmentState {
  IbsSssAnswers get answers => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Resultado del envio. **Solo existe despues de enviar** (CA04).
  IbsSssResult? get result => throw _privateConstructorUsedError;

  /// Serie de evolucion, para el grafico de CA03.
  List<IbsSssEvolutionPoint> get evolution =>
      throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of PeriodicAssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeriodicAssessmentStateCopyWith<PeriodicAssessmentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeriodicAssessmentStateCopyWith<$Res> {
  factory $PeriodicAssessmentStateCopyWith(PeriodicAssessmentState value,
          $Res Function(PeriodicAssessmentState) then) =
      _$PeriodicAssessmentStateCopyWithImpl<$Res, PeriodicAssessmentState>;
  @useResult
  $Res call(
      {IbsSssAnswers answers,
      bool submitting,
      bool loading,
      IbsSssResult? result,
      List<IbsSssEvolutionPoint> evolution,
      CauceApiError? error});

  $IbsSssAnswersCopyWith<$Res> get answers;
  $IbsSssResultCopyWith<$Res>? get result;
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$PeriodicAssessmentStateCopyWithImpl<$Res,
        $Val extends PeriodicAssessmentState>
    implements $PeriodicAssessmentStateCopyWith<$Res> {
  _$PeriodicAssessmentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeriodicAssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answers = null,
    Object? submitting = null,
    Object? loading = null,
    Object? result = freezed,
    Object? evolution = null,
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
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as IbsSssResult?,
      evolution: null == evolution
          ? _value.evolution
          : evolution // ignore: cast_nullable_to_non_nullable
              as List<IbsSssEvolutionPoint>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of PeriodicAssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IbsSssAnswersCopyWith<$Res> get answers {
    return $IbsSssAnswersCopyWith<$Res>(_value.answers, (value) {
      return _then(_value.copyWith(answers: value) as $Val);
    });
  }

  /// Create a copy of PeriodicAssessmentState
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

  /// Create a copy of PeriodicAssessmentState
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
abstract class _$$PeriodicAssessmentStateImplCopyWith<$Res>
    implements $PeriodicAssessmentStateCopyWith<$Res> {
  factory _$$PeriodicAssessmentStateImplCopyWith(
          _$PeriodicAssessmentStateImpl value,
          $Res Function(_$PeriodicAssessmentStateImpl) then) =
      __$$PeriodicAssessmentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IbsSssAnswers answers,
      bool submitting,
      bool loading,
      IbsSssResult? result,
      List<IbsSssEvolutionPoint> evolution,
      CauceApiError? error});

  @override
  $IbsSssAnswersCopyWith<$Res> get answers;
  @override
  $IbsSssResultCopyWith<$Res>? get result;
  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$PeriodicAssessmentStateImplCopyWithImpl<$Res>
    extends _$PeriodicAssessmentStateCopyWithImpl<$Res,
        _$PeriodicAssessmentStateImpl>
    implements _$$PeriodicAssessmentStateImplCopyWith<$Res> {
  __$$PeriodicAssessmentStateImplCopyWithImpl(
      _$PeriodicAssessmentStateImpl _value,
      $Res Function(_$PeriodicAssessmentStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeriodicAssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answers = null,
    Object? submitting = null,
    Object? loading = null,
    Object? result = freezed,
    Object? evolution = null,
    Object? error = freezed,
  }) {
    return _then(_$PeriodicAssessmentStateImpl(
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as IbsSssAnswers,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as IbsSssResult?,
      evolution: null == evolution
          ? _value._evolution
          : evolution // ignore: cast_nullable_to_non_nullable
              as List<IbsSssEvolutionPoint>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$PeriodicAssessmentStateImpl extends _PeriodicAssessmentState {
  const _$PeriodicAssessmentStateImpl(
      {this.answers = const IbsSssAnswers(),
      this.submitting = false,
      this.loading = false,
      this.result,
      final List<IbsSssEvolutionPoint> evolution =
          const <IbsSssEvolutionPoint>[],
      this.error})
      : _evolution = evolution,
        super._();

  @override
  @JsonKey()
  final IbsSssAnswers answers;
  @override
  @JsonKey()
  final bool submitting;
  @override
  @JsonKey()
  final bool loading;

  /// Resultado del envio. **Solo existe despues de enviar** (CA04).
  @override
  final IbsSssResult? result;

  /// Serie de evolucion, para el grafico de CA03.
  final List<IbsSssEvolutionPoint> _evolution;

  /// Serie de evolucion, para el grafico de CA03.
  @override
  @JsonKey()
  List<IbsSssEvolutionPoint> get evolution {
    if (_evolution is EqualUnmodifiableListView) return _evolution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evolution);
  }

  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'PeriodicAssessmentState(answers: $answers, submitting: $submitting, loading: $loading, result: $result, evolution: $evolution, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeriodicAssessmentStateImpl &&
            (identical(other.answers, answers) || other.answers == answers) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.result, result) || other.result == result) &&
            const DeepCollectionEquality()
                .equals(other._evolution, _evolution) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, answers, submitting, loading,
      result, const DeepCollectionEquality().hash(_evolution), error);

  /// Create a copy of PeriodicAssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeriodicAssessmentStateImplCopyWith<_$PeriodicAssessmentStateImpl>
      get copyWith => __$$PeriodicAssessmentStateImplCopyWithImpl<
          _$PeriodicAssessmentStateImpl>(this, _$identity);
}

abstract class _PeriodicAssessmentState extends PeriodicAssessmentState {
  const factory _PeriodicAssessmentState(
      {final IbsSssAnswers answers,
      final bool submitting,
      final bool loading,
      final IbsSssResult? result,
      final List<IbsSssEvolutionPoint> evolution,
      final CauceApiError? error}) = _$PeriodicAssessmentStateImpl;
  const _PeriodicAssessmentState._() : super._();

  @override
  IbsSssAnswers get answers;
  @override
  bool get submitting;
  @override
  bool get loading;

  /// Resultado del envio. **Solo existe despues de enviar** (CA04).
  @override
  IbsSssResult? get result;

  /// Serie de evolucion, para el grafico de CA03.
  @override
  List<IbsSssEvolutionPoint> get evolution;
  @override
  CauceApiError? get error;

  /// Create a copy of PeriodicAssessmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeriodicAssessmentStateImplCopyWith<_$PeriodicAssessmentStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
