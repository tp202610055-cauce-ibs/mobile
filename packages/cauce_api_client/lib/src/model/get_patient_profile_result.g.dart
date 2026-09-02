// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_patient_profile_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetPatientProfileResult extends GetPatientProfileResult {
  @override
  final String? profileId;
  @override
  final String? userId;
  @override
  final Date? dateOfBirth;
  @override
  final BiologicalSex? biologicalSex;
  @override
  final double? weightKg;
  @override
  final double? heightCm;
  @override
  final double? bmi;
  @override
  final String? bmiCategory;
  @override
  final int? age;
  @override
  final IbsSubtype? ibsSubtype;
  @override
  final Date? diagnosisDate;
  @override
  final String? medications;
  @override
  final bool? onboardingCompleted;
  @override
  final BuiltList<PatientAllergySummary>? allergies;
  @override
  final NutritionistAssignmentSummary? assignedNutritionist;

  factory _$GetPatientProfileResult(
          [void Function(GetPatientProfileResultBuilder)? updates]) =>
      (GetPatientProfileResultBuilder()..update(updates))._build();

  _$GetPatientProfileResult._(
      {this.profileId,
      this.userId,
      this.dateOfBirth,
      this.biologicalSex,
      this.weightKg,
      this.heightCm,
      this.bmi,
      this.bmiCategory,
      this.age,
      this.ibsSubtype,
      this.diagnosisDate,
      this.medications,
      this.onboardingCompleted,
      this.allergies,
      this.assignedNutritionist})
      : super._();
  @override
  GetPatientProfileResult rebuild(
          void Function(GetPatientProfileResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetPatientProfileResultBuilder toBuilder() =>
      GetPatientProfileResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetPatientProfileResult &&
        profileId == other.profileId &&
        userId == other.userId &&
        dateOfBirth == other.dateOfBirth &&
        biologicalSex == other.biologicalSex &&
        weightKg == other.weightKg &&
        heightCm == other.heightCm &&
        bmi == other.bmi &&
        bmiCategory == other.bmiCategory &&
        age == other.age &&
        ibsSubtype == other.ibsSubtype &&
        diagnosisDate == other.diagnosisDate &&
        medications == other.medications &&
        onboardingCompleted == other.onboardingCompleted &&
        allergies == other.allergies &&
        assignedNutritionist == other.assignedNutritionist;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, profileId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, dateOfBirth.hashCode);
    _$hash = $jc(_$hash, biologicalSex.hashCode);
    _$hash = $jc(_$hash, weightKg.hashCode);
    _$hash = $jc(_$hash, heightCm.hashCode);
    _$hash = $jc(_$hash, bmi.hashCode);
    _$hash = $jc(_$hash, bmiCategory.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, ibsSubtype.hashCode);
    _$hash = $jc(_$hash, diagnosisDate.hashCode);
    _$hash = $jc(_$hash, medications.hashCode);
    _$hash = $jc(_$hash, onboardingCompleted.hashCode);
    _$hash = $jc(_$hash, allergies.hashCode);
    _$hash = $jc(_$hash, assignedNutritionist.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetPatientProfileResult')
          ..add('profileId', profileId)
          ..add('userId', userId)
          ..add('dateOfBirth', dateOfBirth)
          ..add('biologicalSex', biologicalSex)
          ..add('weightKg', weightKg)
          ..add('heightCm', heightCm)
          ..add('bmi', bmi)
          ..add('bmiCategory', bmiCategory)
          ..add('age', age)
          ..add('ibsSubtype', ibsSubtype)
          ..add('diagnosisDate', diagnosisDate)
          ..add('medications', medications)
          ..add('onboardingCompleted', onboardingCompleted)
          ..add('allergies', allergies)
          ..add('assignedNutritionist', assignedNutritionist))
        .toString();
  }
}

class GetPatientProfileResultBuilder
    implements
        Builder<GetPatientProfileResult, GetPatientProfileResultBuilder> {
  _$GetPatientProfileResult? _$v;

  String? _profileId;
  String? get profileId => _$this._profileId;
  set profileId(String? profileId) => _$this._profileId = profileId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  Date? _dateOfBirth;
  Date? get dateOfBirth => _$this._dateOfBirth;
  set dateOfBirth(Date? dateOfBirth) => _$this._dateOfBirth = dateOfBirth;

  BiologicalSex? _biologicalSex;
  BiologicalSex? get biologicalSex => _$this._biologicalSex;
  set biologicalSex(BiologicalSex? biologicalSex) =>
      _$this._biologicalSex = biologicalSex;

  double? _weightKg;
  double? get weightKg => _$this._weightKg;
  set weightKg(double? weightKg) => _$this._weightKg = weightKg;

  double? _heightCm;
  double? get heightCm => _$this._heightCm;
  set heightCm(double? heightCm) => _$this._heightCm = heightCm;

  double? _bmi;
  double? get bmi => _$this._bmi;
  set bmi(double? bmi) => _$this._bmi = bmi;

  String? _bmiCategory;
  String? get bmiCategory => _$this._bmiCategory;
  set bmiCategory(String? bmiCategory) => _$this._bmiCategory = bmiCategory;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  IbsSubtype? _ibsSubtype;
  IbsSubtype? get ibsSubtype => _$this._ibsSubtype;
  set ibsSubtype(IbsSubtype? ibsSubtype) => _$this._ibsSubtype = ibsSubtype;

  Date? _diagnosisDate;
  Date? get diagnosisDate => _$this._diagnosisDate;
  set diagnosisDate(Date? diagnosisDate) =>
      _$this._diagnosisDate = diagnosisDate;

  String? _medications;
  String? get medications => _$this._medications;
  set medications(String? medications) => _$this._medications = medications;

  bool? _onboardingCompleted;
  bool? get onboardingCompleted => _$this._onboardingCompleted;
  set onboardingCompleted(bool? onboardingCompleted) =>
      _$this._onboardingCompleted = onboardingCompleted;

  ListBuilder<PatientAllergySummary>? _allergies;
  ListBuilder<PatientAllergySummary> get allergies =>
      _$this._allergies ??= ListBuilder<PatientAllergySummary>();
  set allergies(ListBuilder<PatientAllergySummary>? allergies) =>
      _$this._allergies = allergies;

  NutritionistAssignmentSummaryBuilder? _assignedNutritionist;
  NutritionistAssignmentSummaryBuilder get assignedNutritionist =>
      _$this._assignedNutritionist ??= NutritionistAssignmentSummaryBuilder();
  set assignedNutritionist(
          NutritionistAssignmentSummaryBuilder? assignedNutritionist) =>
      _$this._assignedNutritionist = assignedNutritionist;

  GetPatientProfileResultBuilder() {
    GetPatientProfileResult._defaults(this);
  }

  GetPatientProfileResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _profileId = $v.profileId;
      _userId = $v.userId;
      _dateOfBirth = $v.dateOfBirth;
      _biologicalSex = $v.biologicalSex;
      _weightKg = $v.weightKg;
      _heightCm = $v.heightCm;
      _bmi = $v.bmi;
      _bmiCategory = $v.bmiCategory;
      _age = $v.age;
      _ibsSubtype = $v.ibsSubtype;
      _diagnosisDate = $v.diagnosisDate;
      _medications = $v.medications;
      _onboardingCompleted = $v.onboardingCompleted;
      _allergies = $v.allergies?.toBuilder();
      _assignedNutritionist = $v.assignedNutritionist?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetPatientProfileResult other) {
    _$v = other as _$GetPatientProfileResult;
  }

  @override
  void update(void Function(GetPatientProfileResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetPatientProfileResult build() => _build();

  _$GetPatientProfileResult _build() {
    _$GetPatientProfileResult _$result;
    try {
      _$result = _$v ??
          _$GetPatientProfileResult._(
            profileId: profileId,
            userId: userId,
            dateOfBirth: dateOfBirth,
            biologicalSex: biologicalSex,
            weightKg: weightKg,
            heightCm: heightCm,
            bmi: bmi,
            bmiCategory: bmiCategory,
            age: age,
            ibsSubtype: ibsSubtype,
            diagnosisDate: diagnosisDate,
            medications: medications,
            onboardingCompleted: onboardingCompleted,
            allergies: _allergies?.build(),
            assignedNutritionist: _assignedNutritionist?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'allergies';
        _allergies?.build();
        _$failedField = 'assignedNutritionist';
        _assignedNutritionist?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetPatientProfileResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
