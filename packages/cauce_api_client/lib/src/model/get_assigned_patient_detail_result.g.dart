// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_assigned_patient_detail_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetAssignedPatientDetailResult extends GetAssignedPatientDetailResult {
  @override
  final String? patientUserId;
  @override
  final String? fullName;
  @override
  final int? age;
  @override
  final double? bmi;
  @override
  final String? bmiCategory;
  @override
  final IbsSubtype? ibsSubtype;
  @override
  final bool? onboardingCompleted;
  @override
  final BuiltList<PatientAllergySummary>? allergies;

  factory _$GetAssignedPatientDetailResult(
          [void Function(GetAssignedPatientDetailResultBuilder)? updates]) =>
      (GetAssignedPatientDetailResultBuilder()..update(updates))._build();

  _$GetAssignedPatientDetailResult._(
      {this.patientUserId,
      this.fullName,
      this.age,
      this.bmi,
      this.bmiCategory,
      this.ibsSubtype,
      this.onboardingCompleted,
      this.allergies})
      : super._();
  @override
  GetAssignedPatientDetailResult rebuild(
          void Function(GetAssignedPatientDetailResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetAssignedPatientDetailResultBuilder toBuilder() =>
      GetAssignedPatientDetailResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAssignedPatientDetailResult &&
        patientUserId == other.patientUserId &&
        fullName == other.fullName &&
        age == other.age &&
        bmi == other.bmi &&
        bmiCategory == other.bmiCategory &&
        ibsSubtype == other.ibsSubtype &&
        onboardingCompleted == other.onboardingCompleted &&
        allergies == other.allergies;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, patientUserId.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, bmi.hashCode);
    _$hash = $jc(_$hash, bmiCategory.hashCode);
    _$hash = $jc(_$hash, ibsSubtype.hashCode);
    _$hash = $jc(_$hash, onboardingCompleted.hashCode);
    _$hash = $jc(_$hash, allergies.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetAssignedPatientDetailResult')
          ..add('patientUserId', patientUserId)
          ..add('fullName', fullName)
          ..add('age', age)
          ..add('bmi', bmi)
          ..add('bmiCategory', bmiCategory)
          ..add('ibsSubtype', ibsSubtype)
          ..add('onboardingCompleted', onboardingCompleted)
          ..add('allergies', allergies))
        .toString();
  }
}

class GetAssignedPatientDetailResultBuilder
    implements
        Builder<GetAssignedPatientDetailResult,
            GetAssignedPatientDetailResultBuilder> {
  _$GetAssignedPatientDetailResult? _$v;

  String? _patientUserId;
  String? get patientUserId => _$this._patientUserId;
  set patientUserId(String? patientUserId) =>
      _$this._patientUserId = patientUserId;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  double? _bmi;
  double? get bmi => _$this._bmi;
  set bmi(double? bmi) => _$this._bmi = bmi;

  String? _bmiCategory;
  String? get bmiCategory => _$this._bmiCategory;
  set bmiCategory(String? bmiCategory) => _$this._bmiCategory = bmiCategory;

  IbsSubtype? _ibsSubtype;
  IbsSubtype? get ibsSubtype => _$this._ibsSubtype;
  set ibsSubtype(IbsSubtype? ibsSubtype) => _$this._ibsSubtype = ibsSubtype;

  bool? _onboardingCompleted;
  bool? get onboardingCompleted => _$this._onboardingCompleted;
  set onboardingCompleted(bool? onboardingCompleted) =>
      _$this._onboardingCompleted = onboardingCompleted;

  ListBuilder<PatientAllergySummary>? _allergies;
  ListBuilder<PatientAllergySummary> get allergies =>
      _$this._allergies ??= ListBuilder<PatientAllergySummary>();
  set allergies(ListBuilder<PatientAllergySummary>? allergies) =>
      _$this._allergies = allergies;

  GetAssignedPatientDetailResultBuilder() {
    GetAssignedPatientDetailResult._defaults(this);
  }

  GetAssignedPatientDetailResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _patientUserId = $v.patientUserId;
      _fullName = $v.fullName;
      _age = $v.age;
      _bmi = $v.bmi;
      _bmiCategory = $v.bmiCategory;
      _ibsSubtype = $v.ibsSubtype;
      _onboardingCompleted = $v.onboardingCompleted;
      _allergies = $v.allergies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetAssignedPatientDetailResult other) {
    _$v = other as _$GetAssignedPatientDetailResult;
  }

  @override
  void update(void Function(GetAssignedPatientDetailResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAssignedPatientDetailResult build() => _build();

  _$GetAssignedPatientDetailResult _build() {
    _$GetAssignedPatientDetailResult _$result;
    try {
      _$result = _$v ??
          _$GetAssignedPatientDetailResult._(
            patientUserId: patientUserId,
            fullName: fullName,
            age: age,
            bmi: bmi,
            bmiCategory: bmiCategory,
            ibsSubtype: ibsSubtype,
            onboardingCompleted: onboardingCompleted,
            allergies: _allergies?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'allergies';
        _allergies?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetAssignedPatientDetailResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
