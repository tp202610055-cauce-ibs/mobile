// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declare_patient_allergy_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeclarePatientAllergyResult extends DeclarePatientAllergyResult {
  @override
  final String? patientAllergyId;

  factory _$DeclarePatientAllergyResult(
          [void Function(DeclarePatientAllergyResultBuilder)? updates]) =>
      (DeclarePatientAllergyResultBuilder()..update(updates))._build();

  _$DeclarePatientAllergyResult._({this.patientAllergyId}) : super._();
  @override
  DeclarePatientAllergyResult rebuild(
          void Function(DeclarePatientAllergyResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeclarePatientAllergyResultBuilder toBuilder() =>
      DeclarePatientAllergyResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeclarePatientAllergyResult &&
        patientAllergyId == other.patientAllergyId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, patientAllergyId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeclarePatientAllergyResult')
          ..add('patientAllergyId', patientAllergyId))
        .toString();
  }
}

class DeclarePatientAllergyResultBuilder
    implements
        Builder<DeclarePatientAllergyResult,
            DeclarePatientAllergyResultBuilder> {
  _$DeclarePatientAllergyResult? _$v;

  String? _patientAllergyId;
  String? get patientAllergyId => _$this._patientAllergyId;
  set patientAllergyId(String? patientAllergyId) =>
      _$this._patientAllergyId = patientAllergyId;

  DeclarePatientAllergyResultBuilder() {
    DeclarePatientAllergyResult._defaults(this);
  }

  DeclarePatientAllergyResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _patientAllergyId = $v.patientAllergyId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeclarePatientAllergyResult other) {
    _$v = other as _$DeclarePatientAllergyResult;
  }

  @override
  void update(void Function(DeclarePatientAllergyResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeclarePatientAllergyResult build() => _build();

  _$DeclarePatientAllergyResult _build() {
    final _$result = _$v ??
        _$DeclarePatientAllergyResult._(
          patientAllergyId: patientAllergyId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
