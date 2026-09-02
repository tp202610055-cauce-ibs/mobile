// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_patient_profile_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePatientProfileRequest extends UpdatePatientProfileRequest {
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

  factory _$UpdatePatientProfileRequest(
          [void Function(UpdatePatientProfileRequestBuilder)? updates]) =>
      (UpdatePatientProfileRequestBuilder()..update(updates))._build();

  _$UpdatePatientProfileRequest._(
      {this.weightKg,
      this.heightCm,
      this.ibsSubtype,
      this.diagnosisDate,
      this.medications})
      : super._();
  @override
  UpdatePatientProfileRequest rebuild(
          void Function(UpdatePatientProfileRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePatientProfileRequestBuilder toBuilder() =>
      UpdatePatientProfileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePatientProfileRequest &&
        weightKg == other.weightKg &&
        heightCm == other.heightCm &&
        ibsSubtype == other.ibsSubtype &&
        diagnosisDate == other.diagnosisDate &&
        medications == other.medications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
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
    return (newBuiltValueToStringHelper(r'UpdatePatientProfileRequest')
          ..add('weightKg', weightKg)
          ..add('heightCm', heightCm)
          ..add('ibsSubtype', ibsSubtype)
          ..add('diagnosisDate', diagnosisDate)
          ..add('medications', medications))
        .toString();
  }
}

class UpdatePatientProfileRequestBuilder
    implements
        Builder<UpdatePatientProfileRequest,
            UpdatePatientProfileRequestBuilder> {
  _$UpdatePatientProfileRequest? _$v;

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

  UpdatePatientProfileRequestBuilder() {
    UpdatePatientProfileRequest._defaults(this);
  }

  UpdatePatientProfileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(UpdatePatientProfileRequest other) {
    _$v = other as _$UpdatePatientProfileRequest;
  }

  @override
  void update(void Function(UpdatePatientProfileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePatientProfileRequest build() => _build();

  _$UpdatePatientProfileRequest _build() {
    final _$result = _$v ??
        _$UpdatePatientProfileRequest._(
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
