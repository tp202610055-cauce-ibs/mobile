// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_patient_profile_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePatientProfileResult extends CreatePatientProfileResult {
  @override
  final String? profileId;
  @override
  final double? bmi;
  @override
  final String? bmiCategory;
  @override
  final int? age;
  @override
  final bool? nutritionistAssigned;
  @override
  final String? nutritionistAssignmentId;

  factory _$CreatePatientProfileResult(
          [void Function(CreatePatientProfileResultBuilder)? updates]) =>
      (CreatePatientProfileResultBuilder()..update(updates))._build();

  _$CreatePatientProfileResult._(
      {this.profileId,
      this.bmi,
      this.bmiCategory,
      this.age,
      this.nutritionistAssigned,
      this.nutritionistAssignmentId})
      : super._();
  @override
  CreatePatientProfileResult rebuild(
          void Function(CreatePatientProfileResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePatientProfileResultBuilder toBuilder() =>
      CreatePatientProfileResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePatientProfileResult &&
        profileId == other.profileId &&
        bmi == other.bmi &&
        bmiCategory == other.bmiCategory &&
        age == other.age &&
        nutritionistAssigned == other.nutritionistAssigned &&
        nutritionistAssignmentId == other.nutritionistAssignmentId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, profileId.hashCode);
    _$hash = $jc(_$hash, bmi.hashCode);
    _$hash = $jc(_$hash, bmiCategory.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, nutritionistAssigned.hashCode);
    _$hash = $jc(_$hash, nutritionistAssignmentId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePatientProfileResult')
          ..add('profileId', profileId)
          ..add('bmi', bmi)
          ..add('bmiCategory', bmiCategory)
          ..add('age', age)
          ..add('nutritionistAssigned', nutritionistAssigned)
          ..add('nutritionistAssignmentId', nutritionistAssignmentId))
        .toString();
  }
}

class CreatePatientProfileResultBuilder
    implements
        Builder<CreatePatientProfileResult, CreatePatientProfileResultBuilder> {
  _$CreatePatientProfileResult? _$v;

  String? _profileId;
  String? get profileId => _$this._profileId;
  set profileId(String? profileId) => _$this._profileId = profileId;

  double? _bmi;
  double? get bmi => _$this._bmi;
  set bmi(double? bmi) => _$this._bmi = bmi;

  String? _bmiCategory;
  String? get bmiCategory => _$this._bmiCategory;
  set bmiCategory(String? bmiCategory) => _$this._bmiCategory = bmiCategory;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  bool? _nutritionistAssigned;
  bool? get nutritionistAssigned => _$this._nutritionistAssigned;
  set nutritionistAssigned(bool? nutritionistAssigned) =>
      _$this._nutritionistAssigned = nutritionistAssigned;

  String? _nutritionistAssignmentId;
  String? get nutritionistAssignmentId => _$this._nutritionistAssignmentId;
  set nutritionistAssignmentId(String? nutritionistAssignmentId) =>
      _$this._nutritionistAssignmentId = nutritionistAssignmentId;

  CreatePatientProfileResultBuilder() {
    CreatePatientProfileResult._defaults(this);
  }

  CreatePatientProfileResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _profileId = $v.profileId;
      _bmi = $v.bmi;
      _bmiCategory = $v.bmiCategory;
      _age = $v.age;
      _nutritionistAssigned = $v.nutritionistAssigned;
      _nutritionistAssignmentId = $v.nutritionistAssignmentId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePatientProfileResult other) {
    _$v = other as _$CreatePatientProfileResult;
  }

  @override
  void update(void Function(CreatePatientProfileResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePatientProfileResult build() => _build();

  _$CreatePatientProfileResult _build() {
    final _$result = _$v ??
        _$CreatePatientProfileResult._(
          profileId: profileId,
          bmi: bmi,
          bmiCategory: bmiCategory,
          age: age,
          nutritionistAssigned: nutritionistAssigned,
          nutritionistAssignmentId: nutritionistAssignmentId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
