// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_patient_profile_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePatientProfileRequest extends CreatePatientProfileRequest {
  @override
  final Date? dateOfBirth;
  @override
  final BiologicalSex? biologicalSex;
  @override
  final double? weightKg;
  @override
  final double? heightCm;
  @override
  final IbsSubtype? ibsSubtype;
  @override
  final Date? diagnosisDate;
  @override
  final String? medications;

  factory _$CreatePatientProfileRequest(
          [void Function(CreatePatientProfileRequestBuilder)? updates]) =>
      (CreatePatientProfileRequestBuilder()..update(updates))._build();

  _$CreatePatientProfileRequest._(
      {this.dateOfBirth,
      this.biologicalSex,
      this.weightKg,
      this.heightCm,
      this.ibsSubtype,
      this.diagnosisDate,
      this.medications})
      : super._();
  @override
  CreatePatientProfileRequest rebuild(
          void Function(CreatePatientProfileRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePatientProfileRequestBuilder toBuilder() =>
      CreatePatientProfileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePatientProfileRequest &&
        dateOfBirth == other.dateOfBirth &&
        biologicalSex == other.biologicalSex &&
        weightKg == other.weightKg &&
        heightCm == other.heightCm &&
        ibsSubtype == other.ibsSubtype &&
        diagnosisDate == other.diagnosisDate &&
        medications == other.medications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dateOfBirth.hashCode);
    _$hash = $jc(_$hash, biologicalSex.hashCode);
    _$hash = $jc(_$hash, weightKg.hashCode);
    _$hash = $jc(_$hash, heightCm.hashCode);
    _$hash = $jc(_$hash, ibsSubtype.hashCode);
    _$hash = $jc(_$hash, diagnosisDate.hashCode);
    _$hash = $jc(_$hash, medications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePatientProfileRequest')
          ..add('dateOfBirth', dateOfBirth)
          ..add('biologicalSex', biologicalSex)
          ..add('weightKg', weightKg)
          ..add('heightCm', heightCm)
          ..add('ibsSubtype', ibsSubtype)
          ..add('diagnosisDate', diagnosisDate)
          ..add('medications', medications))
        .toString();
  }
}

class CreatePatientProfileRequestBuilder
    implements
        Builder<CreatePatientProfileRequest,
            CreatePatientProfileRequestBuilder> {
  _$CreatePatientProfileRequest? _$v;

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

  CreatePatientProfileRequestBuilder() {
    CreatePatientProfileRequest._defaults(this);
  }

  CreatePatientProfileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dateOfBirth = $v.dateOfBirth;
      _biologicalSex = $v.biologicalSex;
      _weightKg = $v.weightKg;
      _heightCm = $v.heightCm;
      _ibsSubtype = $v.ibsSubtype;
      _diagnosisDate = $v.diagnosisDate;
      _medications = $v.medications;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePatientProfileRequest other) {
    _$v = other as _$CreatePatientProfileRequest;
  }

  @override
  void update(void Function(CreatePatientProfileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePatientProfileRequest build() => _build();

  _$CreatePatientProfileRequest _build() {
    final _$result = _$v ??
        _$CreatePatientProfileRequest._(
          dateOfBirth: dateOfBirth,
          biologicalSex: biologicalSex,
          weightKg: weightKg,
          heightCm: heightCm,
          ibsSubtype: ibsSubtype,
          diagnosisDate: diagnosisDate,
          medications: medications,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
