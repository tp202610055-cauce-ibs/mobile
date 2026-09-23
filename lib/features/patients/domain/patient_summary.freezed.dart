// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatientSummary {
  String get fullName => throw _privateConstructorUsedError;
  IbsSubtypeOption? get ibsSubtype => throw _privateConstructorUsedError;
  DateTime? get pilotStartDate => throw _privateConstructorUsedError;
  String? get nutritionistName => throw _privateConstructorUsedError;
  int? get ibsSssBaseline => throw _privateConstructorUsedError;
  int? get ibsSssLatest => throw _privateConstructorUsedError;

  /// Diferencia entre el ultimo puntaje y la linea base.
  ///
  /// **Negativo es mejoria**, igual que `deltaFromBaseline` del cuestionario
  /// periodico: el backend lo calcula como `latest - baseline`
  /// (`IbsSssAssessment.CompareTotalScoreTo`). El mockup describe el signo
  /// al reves; manda el backend.
  int? get cumulativeChange => throw _privateConstructorUsedError;

  /// Si el cambio alcanza el MCID de 50 puntos.
  ///
  /// **Lo calcula el backend** (`IsClinicallySignificantImprovement`) y el
  /// cliente no lo re-deriva. Hasta este bloque el umbral estaba escrito
  /// tambien en el movil porque el contrato no lo exponia; ahora si.
  bool get significantClinicalResponse => throw _privateConstructorUsedError;

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientSummaryCopyWith<PatientSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientSummaryCopyWith<$Res> {
  factory $PatientSummaryCopyWith(
          PatientSummary value, $Res Function(PatientSummary) then) =
      _$PatientSummaryCopyWithImpl<$Res, PatientSummary>;
  @useResult
  $Res call(
      {String fullName,
      IbsSubtypeOption? ibsSubtype,
      DateTime? pilotStartDate,
      String? nutritionistName,
      int? ibsSssBaseline,
      int? ibsSssLatest,
      int? cumulativeChange,
      bool significantClinicalResponse});
}

/// @nodoc
class _$PatientSummaryCopyWithImpl<$Res, $Val extends PatientSummary>
    implements $PatientSummaryCopyWith<$Res> {
  _$PatientSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? ibsSubtype = freezed,
    Object? pilotStartDate = freezed,
    Object? nutritionistName = freezed,
    Object? ibsSssBaseline = freezed,
    Object? ibsSssLatest = freezed,
    Object? cumulativeChange = freezed,
    Object? significantClinicalResponse = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      ibsSubtype: freezed == ibsSubtype
          ? _value.ibsSubtype
          : ibsSubtype // ignore: cast_nullable_to_non_nullable
              as IbsSubtypeOption?,
      pilotStartDate: freezed == pilotStartDate
          ? _value.pilotStartDate
          : pilotStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nutritionistName: freezed == nutritionistName
          ? _value.nutritionistName
          : nutritionistName // ignore: cast_nullable_to_non_nullable
              as String?,
      ibsSssBaseline: freezed == ibsSssBaseline
          ? _value.ibsSssBaseline
          : ibsSssBaseline // ignore: cast_nullable_to_non_nullable
              as int?,
      ibsSssLatest: freezed == ibsSssLatest
          ? _value.ibsSssLatest
          : ibsSssLatest // ignore: cast_nullable_to_non_nullable
              as int?,
      cumulativeChange: freezed == cumulativeChange
          ? _value.cumulativeChange
          : cumulativeChange // ignore: cast_nullable_to_non_nullable
              as int?,
      significantClinicalResponse: null == significantClinicalResponse
          ? _value.significantClinicalResponse
          : significantClinicalResponse // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientSummaryImplCopyWith<$Res>
    implements $PatientSummaryCopyWith<$Res> {
  factory _$$PatientSummaryImplCopyWith(_$PatientSummaryImpl value,
          $Res Function(_$PatientSummaryImpl) then) =
      __$$PatientSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      IbsSubtypeOption? ibsSubtype,
      DateTime? pilotStartDate,
      String? nutritionistName,
      int? ibsSssBaseline,
      int? ibsSssLatest,
      int? cumulativeChange,
      bool significantClinicalResponse});
}

/// @nodoc
class __$$PatientSummaryImplCopyWithImpl<$Res>
    extends _$PatientSummaryCopyWithImpl<$Res, _$PatientSummaryImpl>
    implements _$$PatientSummaryImplCopyWith<$Res> {
  __$$PatientSummaryImplCopyWithImpl(
      _$PatientSummaryImpl _value, $Res Function(_$PatientSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? ibsSubtype = freezed,
    Object? pilotStartDate = freezed,
    Object? nutritionistName = freezed,
    Object? ibsSssBaseline = freezed,
    Object? ibsSssLatest = freezed,
    Object? cumulativeChange = freezed,
    Object? significantClinicalResponse = null,
  }) {
    return _then(_$PatientSummaryImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      ibsSubtype: freezed == ibsSubtype
          ? _value.ibsSubtype
          : ibsSubtype // ignore: cast_nullable_to_non_nullable
              as IbsSubtypeOption?,
      pilotStartDate: freezed == pilotStartDate
          ? _value.pilotStartDate
          : pilotStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nutritionistName: freezed == nutritionistName
          ? _value.nutritionistName
          : nutritionistName // ignore: cast_nullable_to_non_nullable
              as String?,
      ibsSssBaseline: freezed == ibsSssBaseline
          ? _value.ibsSssBaseline
          : ibsSssBaseline // ignore: cast_nullable_to_non_nullable
              as int?,
      ibsSssLatest: freezed == ibsSssLatest
          ? _value.ibsSssLatest
          : ibsSssLatest // ignore: cast_nullable_to_non_nullable
              as int?,
      cumulativeChange: freezed == cumulativeChange
          ? _value.cumulativeChange
          : cumulativeChange // ignore: cast_nullable_to_non_nullable
              as int?,
      significantClinicalResponse: null == significantClinicalResponse
          ? _value.significantClinicalResponse
          : significantClinicalResponse // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PatientSummaryImpl extends _PatientSummary {
  const _$PatientSummaryImpl(
      {required this.fullName,
      this.ibsSubtype,
      this.pilotStartDate,
      this.nutritionistName,
      this.ibsSssBaseline,
      this.ibsSssLatest,
      this.cumulativeChange,
      this.significantClinicalResponse = false})
      : super._();

  @override
  final String fullName;
  @override
  final IbsSubtypeOption? ibsSubtype;
  @override
  final DateTime? pilotStartDate;
  @override
  final String? nutritionistName;
  @override
  final int? ibsSssBaseline;
  @override
  final int? ibsSssLatest;

  /// Diferencia entre el ultimo puntaje y la linea base.
  ///
  /// **Negativo es mejoria**, igual que `deltaFromBaseline` del cuestionario
  /// periodico: el backend lo calcula como `latest - baseline`
  /// (`IbsSssAssessment.CompareTotalScoreTo`). El mockup describe el signo
  /// al reves; manda el backend.
  @override
  final int? cumulativeChange;

  /// Si el cambio alcanza el MCID de 50 puntos.
  ///
  /// **Lo calcula el backend** (`IsClinicallySignificantImprovement`) y el
  /// cliente no lo re-deriva. Hasta este bloque el umbral estaba escrito
  /// tambien en el movil porque el contrato no lo exponia; ahora si.
  @override
  @JsonKey()
  final bool significantClinicalResponse;

  @override
  String toString() {
    return 'PatientSummary(fullName: $fullName, ibsSubtype: $ibsSubtype, pilotStartDate: $pilotStartDate, nutritionistName: $nutritionistName, ibsSssBaseline: $ibsSssBaseline, ibsSssLatest: $ibsSssLatest, cumulativeChange: $cumulativeChange, significantClinicalResponse: $significantClinicalResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientSummaryImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.ibsSubtype, ibsSubtype) ||
                other.ibsSubtype == ibsSubtype) &&
            (identical(other.pilotStartDate, pilotStartDate) ||
                other.pilotStartDate == pilotStartDate) &&
            (identical(other.nutritionistName, nutritionistName) ||
                other.nutritionistName == nutritionistName) &&
            (identical(other.ibsSssBaseline, ibsSssBaseline) ||
                other.ibsSssBaseline == ibsSssBaseline) &&
            (identical(other.ibsSssLatest, ibsSssLatest) ||
                other.ibsSssLatest == ibsSssLatest) &&
            (identical(other.cumulativeChange, cumulativeChange) ||
                other.cumulativeChange == cumulativeChange) &&
            (identical(other.significantClinicalResponse,
                    significantClinicalResponse) ||
                other.significantClinicalResponse ==
                    significantClinicalResponse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fullName,
      ibsSubtype,
      pilotStartDate,
      nutritionistName,
      ibsSssBaseline,
      ibsSssLatest,
      cumulativeChange,
      significantClinicalResponse);

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientSummaryImplCopyWith<_$PatientSummaryImpl> get copyWith =>
      __$$PatientSummaryImplCopyWithImpl<_$PatientSummaryImpl>(
          this, _$identity);
}

abstract class _PatientSummary extends PatientSummary {
  const factory _PatientSummary(
      {required final String fullName,
      final IbsSubtypeOption? ibsSubtype,
      final DateTime? pilotStartDate,
      final String? nutritionistName,
      final int? ibsSssBaseline,
      final int? ibsSssLatest,
      final int? cumulativeChange,
      final bool significantClinicalResponse}) = _$PatientSummaryImpl;
  const _PatientSummary._() : super._();

  @override
  String get fullName;
  @override
  IbsSubtypeOption? get ibsSubtype;
  @override
  DateTime? get pilotStartDate;
  @override
  String? get nutritionistName;
  @override
  int? get ibsSssBaseline;
  @override
  int? get ibsSssLatest;

  /// Diferencia entre el ultimo puntaje y la linea base.
  ///
  /// **Negativo es mejoria**, igual que `deltaFromBaseline` del cuestionario
  /// periodico: el backend lo calcula como `latest - baseline`
  /// (`IbsSssAssessment.CompareTotalScoreTo`). El mockup describe el signo
  /// al reves; manda el backend.
  @override
  int? get cumulativeChange;

  /// Si el cambio alcanza el MCID de 50 puntos.
  ///
  /// **Lo calcula el backend** (`IsClinicallySignificantImprovement`) y el
  /// cliente no lo re-deriva. Hasta este bloque el umbral estaba escrito
  /// tambien en el movil porque el contrato no lo exponia; ahora si.
  @override
  bool get significantClinicalResponse;

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientSummaryImplCopyWith<_$PatientSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
