// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ibs_sss_baseline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IbsSssBaselineAnswers {
  Map<IbsSssDimension, int> get values => throw _privateConstructorUsedError;

  /// Create a copy of IbsSssBaselineAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IbsSssBaselineAnswersCopyWith<IbsSssBaselineAnswers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IbsSssBaselineAnswersCopyWith<$Res> {
  factory $IbsSssBaselineAnswersCopyWith(IbsSssBaselineAnswers value,
          $Res Function(IbsSssBaselineAnswers) then) =
      _$IbsSssBaselineAnswersCopyWithImpl<$Res, IbsSssBaselineAnswers>;
  @useResult
  $Res call({Map<IbsSssDimension, int> values});
}

/// @nodoc
class _$IbsSssBaselineAnswersCopyWithImpl<$Res,
        $Val extends IbsSssBaselineAnswers>
    implements $IbsSssBaselineAnswersCopyWith<$Res> {
  _$IbsSssBaselineAnswersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IbsSssBaselineAnswers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_value.copyWith(
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<IbsSssDimension, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IbsSssBaselineAnswersImplCopyWith<$Res>
    implements $IbsSssBaselineAnswersCopyWith<$Res> {
  factory _$$IbsSssBaselineAnswersImplCopyWith(
          _$IbsSssBaselineAnswersImpl value,
          $Res Function(_$IbsSssBaselineAnswersImpl) then) =
      __$$IbsSssBaselineAnswersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<IbsSssDimension, int> values});
}

/// @nodoc
class __$$IbsSssBaselineAnswersImplCopyWithImpl<$Res>
    extends _$IbsSssBaselineAnswersCopyWithImpl<$Res,
        _$IbsSssBaselineAnswersImpl>
    implements _$$IbsSssBaselineAnswersImplCopyWith<$Res> {
  __$$IbsSssBaselineAnswersImplCopyWithImpl(_$IbsSssBaselineAnswersImpl _value,
      $Res Function(_$IbsSssBaselineAnswersImpl) _then)
      : super(_value, _then);

  /// Create a copy of IbsSssBaselineAnswers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$IbsSssBaselineAnswersImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<IbsSssDimension, int>,
    ));
  }
}

/// @nodoc

class _$IbsSssBaselineAnswersImpl extends _IbsSssBaselineAnswers {
  const _$IbsSssBaselineAnswersImpl(
      {final Map<IbsSssDimension, int> values = const <IbsSssDimension, int>{}})
      : _values = values,
        super._();

  final Map<IbsSssDimension, int> _values;
  @override
  @JsonKey()
  Map<IbsSssDimension, int> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  @override
  String toString() {
    return 'IbsSssBaselineAnswers(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IbsSssBaselineAnswersImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  /// Create a copy of IbsSssBaselineAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IbsSssBaselineAnswersImplCopyWith<_$IbsSssBaselineAnswersImpl>
      get copyWith => __$$IbsSssBaselineAnswersImplCopyWithImpl<
          _$IbsSssBaselineAnswersImpl>(this, _$identity);
}

abstract class _IbsSssBaselineAnswers extends IbsSssBaselineAnswers {
  const factory _IbsSssBaselineAnswers(
      {final Map<IbsSssDimension, int> values}) = _$IbsSssBaselineAnswersImpl;
  const _IbsSssBaselineAnswers._() : super._();

  @override
  Map<IbsSssDimension, int> get values;

  /// Create a copy of IbsSssBaselineAnswers
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IbsSssBaselineAnswersImplCopyWith<_$IbsSssBaselineAnswersImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IbsSssBaselineResult {
  String get assessmentId => throw _privateConstructorUsedError;

  /// Suma de las cinco dimensiones, de 0 a 500. La calcula el servidor.
  int get totalScore => throw _privateConstructorUsedError;

  /// `true` si esta evaluacion cerro el onboarding del paciente.
  bool get triggeredOnboardingCompletion => throw _privateConstructorUsedError;
  IbsSssSeverity? get severity => throw _privateConstructorUsedError;

  /// Fecha de la proxima evaluacion periodica, a catorce dias. La agenda el
  /// backend y la consume US12, fuera del alcance de este bloque.
  DateTime? get nextAssessmentDate => throw _privateConstructorUsedError;

  /// Create a copy of IbsSssBaselineResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IbsSssBaselineResultCopyWith<IbsSssBaselineResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IbsSssBaselineResultCopyWith<$Res> {
  factory $IbsSssBaselineResultCopyWith(IbsSssBaselineResult value,
          $Res Function(IbsSssBaselineResult) then) =
      _$IbsSssBaselineResultCopyWithImpl<$Res, IbsSssBaselineResult>;
  @useResult
  $Res call(
      {String assessmentId,
      int totalScore,
      bool triggeredOnboardingCompletion,
      IbsSssSeverity? severity,
      DateTime? nextAssessmentDate});
}

/// @nodoc
class _$IbsSssBaselineResultCopyWithImpl<$Res,
        $Val extends IbsSssBaselineResult>
    implements $IbsSssBaselineResultCopyWith<$Res> {
  _$IbsSssBaselineResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IbsSssBaselineResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? totalScore = null,
    Object? triggeredOnboardingCompletion = null,
    Object? severity = freezed,
    Object? nextAssessmentDate = freezed,
  }) {
    return _then(_value.copyWith(
      assessmentId: null == assessmentId
          ? _value.assessmentId
          : assessmentId // ignore: cast_nullable_to_non_nullable
              as String,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      triggeredOnboardingCompletion: null == triggeredOnboardingCompletion
          ? _value.triggeredOnboardingCompletion
          : triggeredOnboardingCompletion // ignore: cast_nullable_to_non_nullable
              as bool,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as IbsSssSeverity?,
      nextAssessmentDate: freezed == nextAssessmentDate
          ? _value.nextAssessmentDate
          : nextAssessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IbsSssBaselineResultImplCopyWith<$Res>
    implements $IbsSssBaselineResultCopyWith<$Res> {
  factory _$$IbsSssBaselineResultImplCopyWith(_$IbsSssBaselineResultImpl value,
          $Res Function(_$IbsSssBaselineResultImpl) then) =
      __$$IbsSssBaselineResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String assessmentId,
      int totalScore,
      bool triggeredOnboardingCompletion,
      IbsSssSeverity? severity,
      DateTime? nextAssessmentDate});
}

/// @nodoc
class __$$IbsSssBaselineResultImplCopyWithImpl<$Res>
    extends _$IbsSssBaselineResultCopyWithImpl<$Res, _$IbsSssBaselineResultImpl>
    implements _$$IbsSssBaselineResultImplCopyWith<$Res> {
  __$$IbsSssBaselineResultImplCopyWithImpl(_$IbsSssBaselineResultImpl _value,
      $Res Function(_$IbsSssBaselineResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of IbsSssBaselineResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? totalScore = null,
    Object? triggeredOnboardingCompletion = null,
    Object? severity = freezed,
    Object? nextAssessmentDate = freezed,
  }) {
    return _then(_$IbsSssBaselineResultImpl(
      assessmentId: null == assessmentId
          ? _value.assessmentId
          : assessmentId // ignore: cast_nullable_to_non_nullable
              as String,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      triggeredOnboardingCompletion: null == triggeredOnboardingCompletion
          ? _value.triggeredOnboardingCompletion
          : triggeredOnboardingCompletion // ignore: cast_nullable_to_non_nullable
              as bool,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as IbsSssSeverity?,
      nextAssessmentDate: freezed == nextAssessmentDate
          ? _value.nextAssessmentDate
          : nextAssessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$IbsSssBaselineResultImpl extends _IbsSssBaselineResult {
  const _$IbsSssBaselineResultImpl(
      {required this.assessmentId,
      required this.totalScore,
      required this.triggeredOnboardingCompletion,
      this.severity,
      this.nextAssessmentDate})
      : super._();

  @override
  final String assessmentId;

  /// Suma de las cinco dimensiones, de 0 a 500. La calcula el servidor.
  @override
  final int totalScore;

  /// `true` si esta evaluacion cerro el onboarding del paciente.
  @override
  final bool triggeredOnboardingCompletion;
  @override
  final IbsSssSeverity? severity;

  /// Fecha de la proxima evaluacion periodica, a catorce dias. La agenda el
  /// backend y la consume US12, fuera del alcance de este bloque.
  @override
  final DateTime? nextAssessmentDate;

  @override
  String toString() {
    return 'IbsSssBaselineResult(assessmentId: $assessmentId, totalScore: $totalScore, triggeredOnboardingCompletion: $triggeredOnboardingCompletion, severity: $severity, nextAssessmentDate: $nextAssessmentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IbsSssBaselineResultImpl &&
            (identical(other.assessmentId, assessmentId) ||
                other.assessmentId == assessmentId) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.triggeredOnboardingCompletion,
                    triggeredOnboardingCompletion) ||
                other.triggeredOnboardingCompletion ==
                    triggeredOnboardingCompletion) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.nextAssessmentDate, nextAssessmentDate) ||
                other.nextAssessmentDate == nextAssessmentDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assessmentId, totalScore,
      triggeredOnboardingCompletion, severity, nextAssessmentDate);

  /// Create a copy of IbsSssBaselineResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IbsSssBaselineResultImplCopyWith<_$IbsSssBaselineResultImpl>
      get copyWith =>
          __$$IbsSssBaselineResultImplCopyWithImpl<_$IbsSssBaselineResultImpl>(
              this, _$identity);
}

abstract class _IbsSssBaselineResult extends IbsSssBaselineResult {
  const factory _IbsSssBaselineResult(
      {required final String assessmentId,
      required final int totalScore,
      required final bool triggeredOnboardingCompletion,
      final IbsSssSeverity? severity,
      final DateTime? nextAssessmentDate}) = _$IbsSssBaselineResultImpl;
  const _IbsSssBaselineResult._() : super._();

  @override
  String get assessmentId;

  /// Suma de las cinco dimensiones, de 0 a 500. La calcula el servidor.
  @override
  int get totalScore;

  /// `true` si esta evaluacion cerro el onboarding del paciente.
  @override
  bool get triggeredOnboardingCompletion;
  @override
  IbsSssSeverity? get severity;

  /// Fecha de la proxima evaluacion periodica, a catorce dias. La agenda el
  /// backend y la consume US12, fuera del alcance de este bloque.
  @override
  DateTime? get nextAssessmentDate;

  /// Create a copy of IbsSssBaselineResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IbsSssBaselineResultImplCopyWith<_$IbsSssBaselineResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
