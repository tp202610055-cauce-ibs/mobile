// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ibs_sss_assessment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IbsSssAnswers {
  Map<IbsSssDimension, int> get values => throw _privateConstructorUsedError;

  /// Create a copy of IbsSssAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IbsSssAnswersCopyWith<IbsSssAnswers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IbsSssAnswersCopyWith<$Res> {
  factory $IbsSssAnswersCopyWith(
          IbsSssAnswers value, $Res Function(IbsSssAnswers) then) =
      _$IbsSssAnswersCopyWithImpl<$Res, IbsSssAnswers>;
  @useResult
  $Res call({Map<IbsSssDimension, int> values});
}

/// @nodoc
class _$IbsSssAnswersCopyWithImpl<$Res, $Val extends IbsSssAnswers>
    implements $IbsSssAnswersCopyWith<$Res> {
  _$IbsSssAnswersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IbsSssAnswers
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
abstract class _$$IbsSssAnswersImplCopyWith<$Res>
    implements $IbsSssAnswersCopyWith<$Res> {
  factory _$$IbsSssAnswersImplCopyWith(
          _$IbsSssAnswersImpl value, $Res Function(_$IbsSssAnswersImpl) then) =
      __$$IbsSssAnswersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<IbsSssDimension, int> values});
}

/// @nodoc
class __$$IbsSssAnswersImplCopyWithImpl<$Res>
    extends _$IbsSssAnswersCopyWithImpl<$Res, _$IbsSssAnswersImpl>
    implements _$$IbsSssAnswersImplCopyWith<$Res> {
  __$$IbsSssAnswersImplCopyWithImpl(
      _$IbsSssAnswersImpl _value, $Res Function(_$IbsSssAnswersImpl) _then)
      : super(_value, _then);

  /// Create a copy of IbsSssAnswers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$IbsSssAnswersImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<IbsSssDimension, int>,
    ));
  }
}

/// @nodoc

class _$IbsSssAnswersImpl extends _IbsSssAnswers {
  const _$IbsSssAnswersImpl(
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
    return 'IbsSssAnswers(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IbsSssAnswersImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  /// Create a copy of IbsSssAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IbsSssAnswersImplCopyWith<_$IbsSssAnswersImpl> get copyWith =>
      __$$IbsSssAnswersImplCopyWithImpl<_$IbsSssAnswersImpl>(this, _$identity);
}

abstract class _IbsSssAnswers extends IbsSssAnswers {
  const factory _IbsSssAnswers({final Map<IbsSssDimension, int> values}) =
      _$IbsSssAnswersImpl;
  const _IbsSssAnswers._() : super._();

  @override
  Map<IbsSssDimension, int> get values;

  /// Create a copy of IbsSssAnswers
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IbsSssAnswersImplCopyWith<_$IbsSssAnswersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IbsSssResult {
  String get assessmentId => throw _privateConstructorUsedError;

  /// Suma de las cinco dimensiones, de 0 a 500. La calcula el servidor.
  int get totalScore => throw _privateConstructorUsedError;

  /// `true` si esta evaluacion cerro el onboarding del paciente.
  bool get triggeredOnboardingCompletion => throw _privateConstructorUsedError;
  IbsSssSeverity? get severity => throw _privateConstructorUsedError;

  /// Fecha de la proxima evaluacion periodica, a catorce dias. La agenda el
  /// backend y la consume US12, fuera del alcance de este bloque.
  DateTime? get nextAssessmentDate => throw _privateConstructorUsedError;

  /// Create a copy of IbsSssResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IbsSssResultCopyWith<IbsSssResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IbsSssResultCopyWith<$Res> {
  factory $IbsSssResultCopyWith(
          IbsSssResult value, $Res Function(IbsSssResult) then) =
      _$IbsSssResultCopyWithImpl<$Res, IbsSssResult>;
  @useResult
  $Res call(
      {String assessmentId,
      int totalScore,
      bool triggeredOnboardingCompletion,
      IbsSssSeverity? severity,
      DateTime? nextAssessmentDate});
}

/// @nodoc
class _$IbsSssResultCopyWithImpl<$Res, $Val extends IbsSssResult>
    implements $IbsSssResultCopyWith<$Res> {
  _$IbsSssResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IbsSssResult
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
abstract class _$$IbsSssResultImplCopyWith<$Res>
    implements $IbsSssResultCopyWith<$Res> {
  factory _$$IbsSssResultImplCopyWith(
          _$IbsSssResultImpl value, $Res Function(_$IbsSssResultImpl) then) =
      __$$IbsSssResultImplCopyWithImpl<$Res>;
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
class __$$IbsSssResultImplCopyWithImpl<$Res>
    extends _$IbsSssResultCopyWithImpl<$Res, _$IbsSssResultImpl>
    implements _$$IbsSssResultImplCopyWith<$Res> {
  __$$IbsSssResultImplCopyWithImpl(
      _$IbsSssResultImpl _value, $Res Function(_$IbsSssResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of IbsSssResult
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
    return _then(_$IbsSssResultImpl(
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

class _$IbsSssResultImpl extends _IbsSssResult {
  const _$IbsSssResultImpl(
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
    return 'IbsSssResult(assessmentId: $assessmentId, totalScore: $totalScore, triggeredOnboardingCompletion: $triggeredOnboardingCompletion, severity: $severity, nextAssessmentDate: $nextAssessmentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IbsSssResultImpl &&
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

  /// Create a copy of IbsSssResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IbsSssResultImplCopyWith<_$IbsSssResultImpl> get copyWith =>
      __$$IbsSssResultImplCopyWithImpl<_$IbsSssResultImpl>(this, _$identity);
}

abstract class _IbsSssResult extends IbsSssResult {
  const factory _IbsSssResult(
      {required final String assessmentId,
      required final int totalScore,
      required final bool triggeredOnboardingCompletion,
      final IbsSssSeverity? severity,
      final DateTime? nextAssessmentDate}) = _$IbsSssResultImpl;
  const _IbsSssResult._() : super._();

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

  /// Create a copy of IbsSssResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IbsSssResultImplCopyWith<_$IbsSssResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IbsSssAssessmentSummaryData {
  String get assessmentId => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  IbsSssAssessmentType get assessmentType => throw _privateConstructorUsedError;
  int get cycleNumber => throw _privateConstructorUsedError;
  IbsSssSeverity? get severity => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Vencimiento del proximo ciclo, a catorce dias. Lo agenda el backend.
  DateTime? get nextAssessmentDate => throw _privateConstructorUsedError;

  /// Create a copy of IbsSssAssessmentSummaryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IbsSssAssessmentSummaryDataCopyWith<IbsSssAssessmentSummaryData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IbsSssAssessmentSummaryDataCopyWith<$Res> {
  factory $IbsSssAssessmentSummaryDataCopyWith(
          IbsSssAssessmentSummaryData value,
          $Res Function(IbsSssAssessmentSummaryData) then) =
      _$IbsSssAssessmentSummaryDataCopyWithImpl<$Res,
          IbsSssAssessmentSummaryData>;
  @useResult
  $Res call(
      {String assessmentId,
      int totalScore,
      IbsSssAssessmentType assessmentType,
      int cycleNumber,
      IbsSssSeverity? severity,
      DateTime? completedAt,
      DateTime? nextAssessmentDate});
}

/// @nodoc
class _$IbsSssAssessmentSummaryDataCopyWithImpl<$Res,
        $Val extends IbsSssAssessmentSummaryData>
    implements $IbsSssAssessmentSummaryDataCopyWith<$Res> {
  _$IbsSssAssessmentSummaryDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IbsSssAssessmentSummaryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? totalScore = null,
    Object? assessmentType = null,
    Object? cycleNumber = null,
    Object? severity = freezed,
    Object? completedAt = freezed,
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
      assessmentType: null == assessmentType
          ? _value.assessmentType
          : assessmentType // ignore: cast_nullable_to_non_nullable
              as IbsSssAssessmentType,
      cycleNumber: null == cycleNumber
          ? _value.cycleNumber
          : cycleNumber // ignore: cast_nullable_to_non_nullable
              as int,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as IbsSssSeverity?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextAssessmentDate: freezed == nextAssessmentDate
          ? _value.nextAssessmentDate
          : nextAssessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IbsSssAssessmentSummaryDataImplCopyWith<$Res>
    implements $IbsSssAssessmentSummaryDataCopyWith<$Res> {
  factory _$$IbsSssAssessmentSummaryDataImplCopyWith(
          _$IbsSssAssessmentSummaryDataImpl value,
          $Res Function(_$IbsSssAssessmentSummaryDataImpl) then) =
      __$$IbsSssAssessmentSummaryDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String assessmentId,
      int totalScore,
      IbsSssAssessmentType assessmentType,
      int cycleNumber,
      IbsSssSeverity? severity,
      DateTime? completedAt,
      DateTime? nextAssessmentDate});
}

/// @nodoc
class __$$IbsSssAssessmentSummaryDataImplCopyWithImpl<$Res>
    extends _$IbsSssAssessmentSummaryDataCopyWithImpl<$Res,
        _$IbsSssAssessmentSummaryDataImpl>
    implements _$$IbsSssAssessmentSummaryDataImplCopyWith<$Res> {
  __$$IbsSssAssessmentSummaryDataImplCopyWithImpl(
      _$IbsSssAssessmentSummaryDataImpl _value,
      $Res Function(_$IbsSssAssessmentSummaryDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of IbsSssAssessmentSummaryData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? totalScore = null,
    Object? assessmentType = null,
    Object? cycleNumber = null,
    Object? severity = freezed,
    Object? completedAt = freezed,
    Object? nextAssessmentDate = freezed,
  }) {
    return _then(_$IbsSssAssessmentSummaryDataImpl(
      assessmentId: null == assessmentId
          ? _value.assessmentId
          : assessmentId // ignore: cast_nullable_to_non_nullable
              as String,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      assessmentType: null == assessmentType
          ? _value.assessmentType
          : assessmentType // ignore: cast_nullable_to_non_nullable
              as IbsSssAssessmentType,
      cycleNumber: null == cycleNumber
          ? _value.cycleNumber
          : cycleNumber // ignore: cast_nullable_to_non_nullable
              as int,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as IbsSssSeverity?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextAssessmentDate: freezed == nextAssessmentDate
          ? _value.nextAssessmentDate
          : nextAssessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$IbsSssAssessmentSummaryDataImpl extends _IbsSssAssessmentSummaryData {
  const _$IbsSssAssessmentSummaryDataImpl(
      {required this.assessmentId,
      required this.totalScore,
      required this.assessmentType,
      this.cycleNumber = 0,
      this.severity,
      this.completedAt,
      this.nextAssessmentDate})
      : super._();

  @override
  final String assessmentId;
  @override
  final int totalScore;
  @override
  final IbsSssAssessmentType assessmentType;
  @override
  @JsonKey()
  final int cycleNumber;
  @override
  final IbsSssSeverity? severity;
  @override
  final DateTime? completedAt;

  /// Vencimiento del proximo ciclo, a catorce dias. Lo agenda el backend.
  @override
  final DateTime? nextAssessmentDate;

  @override
  String toString() {
    return 'IbsSssAssessmentSummaryData(assessmentId: $assessmentId, totalScore: $totalScore, assessmentType: $assessmentType, cycleNumber: $cycleNumber, severity: $severity, completedAt: $completedAt, nextAssessmentDate: $nextAssessmentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IbsSssAssessmentSummaryDataImpl &&
            (identical(other.assessmentId, assessmentId) ||
                other.assessmentId == assessmentId) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.assessmentType, assessmentType) ||
                other.assessmentType == assessmentType) &&
            (identical(other.cycleNumber, cycleNumber) ||
                other.cycleNumber == cycleNumber) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.nextAssessmentDate, nextAssessmentDate) ||
                other.nextAssessmentDate == nextAssessmentDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assessmentId, totalScore,
      assessmentType, cycleNumber, severity, completedAt, nextAssessmentDate);

  /// Create a copy of IbsSssAssessmentSummaryData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IbsSssAssessmentSummaryDataImplCopyWith<_$IbsSssAssessmentSummaryDataImpl>
      get copyWith => __$$IbsSssAssessmentSummaryDataImplCopyWithImpl<
          _$IbsSssAssessmentSummaryDataImpl>(this, _$identity);
}

abstract class _IbsSssAssessmentSummaryData
    extends IbsSssAssessmentSummaryData {
  const factory _IbsSssAssessmentSummaryData(
      {required final String assessmentId,
      required final int totalScore,
      required final IbsSssAssessmentType assessmentType,
      final int cycleNumber,
      final IbsSssSeverity? severity,
      final DateTime? completedAt,
      final DateTime? nextAssessmentDate}) = _$IbsSssAssessmentSummaryDataImpl;
  const _IbsSssAssessmentSummaryData._() : super._();

  @override
  String get assessmentId;
  @override
  int get totalScore;
  @override
  IbsSssAssessmentType get assessmentType;
  @override
  int get cycleNumber;
  @override
  IbsSssSeverity? get severity;
  @override
  DateTime? get completedAt;

  /// Vencimiento del proximo ciclo, a catorce dias. Lo agenda el backend.
  @override
  DateTime? get nextAssessmentDate;

  /// Create a copy of IbsSssAssessmentSummaryData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IbsSssAssessmentSummaryDataImplCopyWith<_$IbsSssAssessmentSummaryDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IbsSssEvolutionPoint {
  String get assessmentId => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  IbsSssAssessmentType get assessmentType => throw _privateConstructorUsedError;
  int get cycleNumber => throw _privateConstructorUsedError;
  IbsSssSeverity? get severity => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Diferencia contra la linea base.
  ///
  /// **Negativo significa mejoria**: el backend lo calcula como
  /// `TotalScore - baseline.TotalScore` (`IbsSssAssessment.CompareTotalScoreTo`,
  /// con su test `CompareTotalScoreTo_Improvement_ReturnsNegative` asertando
  /// `-50`). Llega `null` para la propia linea base y cuando no hay ninguna.
  int? get deltaFromBaseline => throw _privateConstructorUsedError;

  /// Create a copy of IbsSssEvolutionPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IbsSssEvolutionPointCopyWith<IbsSssEvolutionPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IbsSssEvolutionPointCopyWith<$Res> {
  factory $IbsSssEvolutionPointCopyWith(IbsSssEvolutionPoint value,
          $Res Function(IbsSssEvolutionPoint) then) =
      _$IbsSssEvolutionPointCopyWithImpl<$Res, IbsSssEvolutionPoint>;
  @useResult
  $Res call(
      {String assessmentId,
      int totalScore,
      IbsSssAssessmentType assessmentType,
      int cycleNumber,
      IbsSssSeverity? severity,
      DateTime? completedAt,
      int? deltaFromBaseline});
}

/// @nodoc
class _$IbsSssEvolutionPointCopyWithImpl<$Res,
        $Val extends IbsSssEvolutionPoint>
    implements $IbsSssEvolutionPointCopyWith<$Res> {
  _$IbsSssEvolutionPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IbsSssEvolutionPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? totalScore = null,
    Object? assessmentType = null,
    Object? cycleNumber = null,
    Object? severity = freezed,
    Object? completedAt = freezed,
    Object? deltaFromBaseline = freezed,
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
      assessmentType: null == assessmentType
          ? _value.assessmentType
          : assessmentType // ignore: cast_nullable_to_non_nullable
              as IbsSssAssessmentType,
      cycleNumber: null == cycleNumber
          ? _value.cycleNumber
          : cycleNumber // ignore: cast_nullable_to_non_nullable
              as int,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as IbsSssSeverity?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deltaFromBaseline: freezed == deltaFromBaseline
          ? _value.deltaFromBaseline
          : deltaFromBaseline // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IbsSssEvolutionPointImplCopyWith<$Res>
    implements $IbsSssEvolutionPointCopyWith<$Res> {
  factory _$$IbsSssEvolutionPointImplCopyWith(_$IbsSssEvolutionPointImpl value,
          $Res Function(_$IbsSssEvolutionPointImpl) then) =
      __$$IbsSssEvolutionPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String assessmentId,
      int totalScore,
      IbsSssAssessmentType assessmentType,
      int cycleNumber,
      IbsSssSeverity? severity,
      DateTime? completedAt,
      int? deltaFromBaseline});
}

/// @nodoc
class __$$IbsSssEvolutionPointImplCopyWithImpl<$Res>
    extends _$IbsSssEvolutionPointCopyWithImpl<$Res, _$IbsSssEvolutionPointImpl>
    implements _$$IbsSssEvolutionPointImplCopyWith<$Res> {
  __$$IbsSssEvolutionPointImplCopyWithImpl(_$IbsSssEvolutionPointImpl _value,
      $Res Function(_$IbsSssEvolutionPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of IbsSssEvolutionPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? totalScore = null,
    Object? assessmentType = null,
    Object? cycleNumber = null,
    Object? severity = freezed,
    Object? completedAt = freezed,
    Object? deltaFromBaseline = freezed,
  }) {
    return _then(_$IbsSssEvolutionPointImpl(
      assessmentId: null == assessmentId
          ? _value.assessmentId
          : assessmentId // ignore: cast_nullable_to_non_nullable
              as String,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      assessmentType: null == assessmentType
          ? _value.assessmentType
          : assessmentType // ignore: cast_nullable_to_non_nullable
              as IbsSssAssessmentType,
      cycleNumber: null == cycleNumber
          ? _value.cycleNumber
          : cycleNumber // ignore: cast_nullable_to_non_nullable
              as int,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as IbsSssSeverity?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deltaFromBaseline: freezed == deltaFromBaseline
          ? _value.deltaFromBaseline
          : deltaFromBaseline // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$IbsSssEvolutionPointImpl extends _IbsSssEvolutionPoint {
  const _$IbsSssEvolutionPointImpl(
      {required this.assessmentId,
      required this.totalScore,
      required this.assessmentType,
      this.cycleNumber = 0,
      this.severity,
      this.completedAt,
      this.deltaFromBaseline})
      : super._();

  @override
  final String assessmentId;
  @override
  final int totalScore;
  @override
  final IbsSssAssessmentType assessmentType;
  @override
  @JsonKey()
  final int cycleNumber;
  @override
  final IbsSssSeverity? severity;
  @override
  final DateTime? completedAt;

  /// Diferencia contra la linea base.
  ///
  /// **Negativo significa mejoria**: el backend lo calcula como
  /// `TotalScore - baseline.TotalScore` (`IbsSssAssessment.CompareTotalScoreTo`,
  /// con su test `CompareTotalScoreTo_Improvement_ReturnsNegative` asertando
  /// `-50`). Llega `null` para la propia linea base y cuando no hay ninguna.
  @override
  final int? deltaFromBaseline;

  @override
  String toString() {
    return 'IbsSssEvolutionPoint(assessmentId: $assessmentId, totalScore: $totalScore, assessmentType: $assessmentType, cycleNumber: $cycleNumber, severity: $severity, completedAt: $completedAt, deltaFromBaseline: $deltaFromBaseline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IbsSssEvolutionPointImpl &&
            (identical(other.assessmentId, assessmentId) ||
                other.assessmentId == assessmentId) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.assessmentType, assessmentType) ||
                other.assessmentType == assessmentType) &&
            (identical(other.cycleNumber, cycleNumber) ||
                other.cycleNumber == cycleNumber) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.deltaFromBaseline, deltaFromBaseline) ||
                other.deltaFromBaseline == deltaFromBaseline));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assessmentId, totalScore,
      assessmentType, cycleNumber, severity, completedAt, deltaFromBaseline);

  /// Create a copy of IbsSssEvolutionPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IbsSssEvolutionPointImplCopyWith<_$IbsSssEvolutionPointImpl>
      get copyWith =>
          __$$IbsSssEvolutionPointImplCopyWithImpl<_$IbsSssEvolutionPointImpl>(
              this, _$identity);
}

abstract class _IbsSssEvolutionPoint extends IbsSssEvolutionPoint {
  const factory _IbsSssEvolutionPoint(
      {required final String assessmentId,
      required final int totalScore,
      required final IbsSssAssessmentType assessmentType,
      final int cycleNumber,
      final IbsSssSeverity? severity,
      final DateTime? completedAt,
      final int? deltaFromBaseline}) = _$IbsSssEvolutionPointImpl;
  const _IbsSssEvolutionPoint._() : super._();

  @override
  String get assessmentId;
  @override
  int get totalScore;
  @override
  IbsSssAssessmentType get assessmentType;
  @override
  int get cycleNumber;
  @override
  IbsSssSeverity? get severity;
  @override
  DateTime? get completedAt;

  /// Diferencia contra la linea base.
  ///
  /// **Negativo significa mejoria**: el backend lo calcula como
  /// `TotalScore - baseline.TotalScore` (`IbsSssAssessment.CompareTotalScoreTo`,
  /// con su test `CompareTotalScoreTo_Improvement_ReturnsNegative` asertando
  /// `-50`). Llega `null` para la propia linea base y cuando no hay ninguna.
  @override
  int? get deltaFromBaseline;

  /// Create a copy of IbsSssEvolutionPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IbsSssEvolutionPointImplCopyWith<_$IbsSssEvolutionPointImpl>
      get copyWith => throw _privateConstructorUsedError;
}
