// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_summary_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MyProfileSummaryResult extends MyProfileSummaryResult {
  @override
  final MyProfilePatientInfo? patient;
  @override
  final MyProfileClinicalInfo? clinical;
  @override
  final Date? pilotStartDate;
  @override
  final NutritionistAssignmentSummary? assignedNutritionist;
  @override
  final int? ibsSssBaseline;
  @override
  final int? ibsSssLatest;
  @override
  final int? cumulativeChange;
  @override
  final bool? significantClinicalResponse;

  factory _$MyProfileSummaryResult(
          [void Function(MyProfileSummaryResultBuilder)? updates]) =>
      (MyProfileSummaryResultBuilder()..update(updates))._build();

  _$MyProfileSummaryResult._(
      {this.patient,
      this.clinical,
      this.pilotStartDate,
      this.assignedNutritionist,
      this.ibsSssBaseline,
      this.ibsSssLatest,
      this.cumulativeChange,
      this.significantClinicalResponse})
      : super._();
  @override
  MyProfileSummaryResult rebuild(
          void Function(MyProfileSummaryResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyProfileSummaryResultBuilder toBuilder() =>
      MyProfileSummaryResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyProfileSummaryResult &&
        patient == other.patient &&
        clinical == other.clinical &&
        pilotStartDate == other.pilotStartDate &&
        assignedNutritionist == other.assignedNutritionist &&
        ibsSssBaseline == other.ibsSssBaseline &&
        ibsSssLatest == other.ibsSssLatest &&
        cumulativeChange == other.cumulativeChange &&
        significantClinicalResponse == other.significantClinicalResponse;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, patient.hashCode);
    _$hash = $jc(_$hash, clinical.hashCode);
    _$hash = $jc(_$hash, pilotStartDate.hashCode);
    _$hash = $jc(_$hash, assignedNutritionist.hashCode);
    _$hash = $jc(_$hash, ibsSssBaseline.hashCode);
    _$hash = $jc(_$hash, ibsSssLatest.hashCode);
    _$hash = $jc(_$hash, cumulativeChange.hashCode);
    _$hash = $jc(_$hash, significantClinicalResponse.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MyProfileSummaryResult')
          ..add('patient', patient)
          ..add('clinical', clinical)
          ..add('pilotStartDate', pilotStartDate)
          ..add('assignedNutritionist', assignedNutritionist)
          ..add('ibsSssBaseline', ibsSssBaseline)
          ..add('ibsSssLatest', ibsSssLatest)
          ..add('cumulativeChange', cumulativeChange)
          ..add('significantClinicalResponse', significantClinicalResponse))
        .toString();
  }
}

class MyProfileSummaryResultBuilder
    implements Builder<MyProfileSummaryResult, MyProfileSummaryResultBuilder> {
  _$MyProfileSummaryResult? _$v;

  MyProfilePatientInfoBuilder? _patient;
  MyProfilePatientInfoBuilder get patient =>
      _$this._patient ??= MyProfilePatientInfoBuilder();
  set patient(MyProfilePatientInfoBuilder? patient) =>
      _$this._patient = patient;

  MyProfileClinicalInfoBuilder? _clinical;
  MyProfileClinicalInfoBuilder get clinical =>
      _$this._clinical ??= MyProfileClinicalInfoBuilder();
  set clinical(MyProfileClinicalInfoBuilder? clinical) =>
      _$this._clinical = clinical;

  Date? _pilotStartDate;
  Date? get pilotStartDate => _$this._pilotStartDate;
  set pilotStartDate(Date? pilotStartDate) =>
      _$this._pilotStartDate = pilotStartDate;

  NutritionistAssignmentSummaryBuilder? _assignedNutritionist;
  NutritionistAssignmentSummaryBuilder get assignedNutritionist =>
      _$this._assignedNutritionist ??= NutritionistAssignmentSummaryBuilder();
  set assignedNutritionist(
          NutritionistAssignmentSummaryBuilder? assignedNutritionist) =>
      _$this._assignedNutritionist = assignedNutritionist;

  int? _ibsSssBaseline;
  int? get ibsSssBaseline => _$this._ibsSssBaseline;
  set ibsSssBaseline(int? ibsSssBaseline) =>
      _$this._ibsSssBaseline = ibsSssBaseline;

  int? _ibsSssLatest;
  int? get ibsSssLatest => _$this._ibsSssLatest;
  set ibsSssLatest(int? ibsSssLatest) => _$this._ibsSssLatest = ibsSssLatest;

  int? _cumulativeChange;
  int? get cumulativeChange => _$this._cumulativeChange;
  set cumulativeChange(int? cumulativeChange) =>
      _$this._cumulativeChange = cumulativeChange;

  bool? _significantClinicalResponse;
  bool? get significantClinicalResponse => _$this._significantClinicalResponse;
  set significantClinicalResponse(bool? significantClinicalResponse) =>
      _$this._significantClinicalResponse = significantClinicalResponse;

  MyProfileSummaryResultBuilder() {
    MyProfileSummaryResult._defaults(this);
  }

  MyProfileSummaryResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _patient = $v.patient?.toBuilder();
      _clinical = $v.clinical?.toBuilder();
      _pilotStartDate = $v.pilotStartDate;
      _assignedNutritionist = $v.assignedNutritionist?.toBuilder();
      _ibsSssBaseline = $v.ibsSssBaseline;
      _ibsSssLatest = $v.ibsSssLatest;
      _cumulativeChange = $v.cumulativeChange;
      _significantClinicalResponse = $v.significantClinicalResponse;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyProfileSummaryResult other) {
    _$v = other as _$MyProfileSummaryResult;
  }

  @override
  void update(void Function(MyProfileSummaryResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MyProfileSummaryResult build() => _build();

  _$MyProfileSummaryResult _build() {
    _$MyProfileSummaryResult _$result;
    try {
      _$result = _$v ??
          _$MyProfileSummaryResult._(
            patient: _patient?.build(),
            clinical: _clinical?.build(),
            pilotStartDate: pilotStartDate,
            assignedNutritionist: _assignedNutritionist?.build(),
            ibsSssBaseline: ibsSssBaseline,
            ibsSssLatest: ibsSssLatest,
            cumulativeChange: cumulativeChange,
            significantClinicalResponse: significantClinicalResponse,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'patient';
        _patient?.build();
        _$failedField = 'clinical';
        _clinical?.build();

        _$failedField = 'assignedNutritionist';
        _assignedNutritionist?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MyProfileSummaryResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
