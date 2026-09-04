// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_allergy_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PatientAllergySummary extends PatientAllergySummary {
  @override
  final String? patientAllergyId;
  @override
  final String? allergyId;
  @override
  final String? allergyName;
  @override
  final AllergyType? allergyType;
  @override
  final AllergySeverity? severity;
  @override
  final String? notes;
  @override
  final DateTime? declaredAt;

  factory _$PatientAllergySummary(
          [void Function(PatientAllergySummaryBuilder)? updates]) =>
      (PatientAllergySummaryBuilder()..update(updates))._build();

  _$PatientAllergySummary._(
      {this.patientAllergyId,
      this.allergyId,
      this.allergyName,
      this.allergyType,
      this.severity,
      this.notes,
      this.declaredAt})
      : super._();
  @override
  PatientAllergySummary rebuild(
          void Function(PatientAllergySummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PatientAllergySummaryBuilder toBuilder() =>
      PatientAllergySummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PatientAllergySummary &&
        patientAllergyId == other.patientAllergyId &&
        allergyId == other.allergyId &&
        allergyName == other.allergyName &&
        allergyType == other.allergyType &&
        severity == other.severity &&
        notes == other.notes &&
        declaredAt == other.declaredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, patientAllergyId.hashCode);
    _$hash = $jc(_$hash, allergyId.hashCode);
    _$hash = $jc(_$hash, allergyName.hashCode);
    _$hash = $jc(_$hash, allergyType.hashCode);
    _$hash = $jc(_$hash, severity.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, declaredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PatientAllergySummary')
          ..add('patientAllergyId', patientAllergyId)
          ..add('allergyId', allergyId)
          ..add('allergyName', allergyName)
          ..add('allergyType', allergyType)
          ..add('severity', severity)
          ..add('notes', notes)
          ..add('declaredAt', declaredAt))
        .toString();
  }
}

class PatientAllergySummaryBuilder
    implements Builder<PatientAllergySummary, PatientAllergySummaryBuilder> {
  _$PatientAllergySummary? _$v;

  String? _patientAllergyId;
  String? get patientAllergyId => _$this._patientAllergyId;
  set patientAllergyId(String? patientAllergyId) =>
      _$this._patientAllergyId = patientAllergyId;

  String? _allergyId;
  String? get allergyId => _$this._allergyId;
  set allergyId(String? allergyId) => _$this._allergyId = allergyId;

  String? _allergyName;
  String? get allergyName => _$this._allergyName;
  set allergyName(String? allergyName) => _$this._allergyName = allergyName;

  AllergyType? _allergyType;
  AllergyType? get allergyType => _$this._allergyType;
  set allergyType(AllergyType? allergyType) =>
      _$this._allergyType = allergyType;

  AllergySeverity? _severity;
  AllergySeverity? get severity => _$this._severity;
  set severity(AllergySeverity? severity) => _$this._severity = severity;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  DateTime? _declaredAt;
  DateTime? get declaredAt => _$this._declaredAt;
  set declaredAt(DateTime? declaredAt) => _$this._declaredAt = declaredAt;

  PatientAllergySummaryBuilder() {
    PatientAllergySummary._defaults(this);
  }

  PatientAllergySummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _patientAllergyId = $v.patientAllergyId;
      _allergyId = $v.allergyId;
      _allergyName = $v.allergyName;
      _allergyType = $v.allergyType;
      _severity = $v.severity;
      _notes = $v.notes;
      _declaredAt = $v.declaredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PatientAllergySummary other) {
    _$v = other as _$PatientAllergySummary;
  }

  @override
  void update(void Function(PatientAllergySummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PatientAllergySummary build() => _build();

  _$PatientAllergySummary _build() {
    final _$result = _$v ??
        _$PatientAllergySummary._(
          patientAllergyId: patientAllergyId,
          allergyId: allergyId,
          allergyName: allergyName,
          allergyType: allergyType,
          severity: severity,
          notes: notes,
          declaredAt: declaredAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
