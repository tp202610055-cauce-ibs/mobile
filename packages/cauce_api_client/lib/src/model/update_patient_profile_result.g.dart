// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_patient_profile_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePatientProfileResult extends UpdatePatientProfileResult {
  @override
  final double? bmi;
  @override
  final String? bmiCategory;
  @override
  final int? age;

  factory _$UpdatePatientProfileResult(
          [void Function(UpdatePatientProfileResultBuilder)? updates]) =>
      (UpdatePatientProfileResultBuilder()..update(updates))._build();

  _$UpdatePatientProfileResult._({this.bmi, this.bmiCategory, this.age})
      : super._();
  @override
  UpdatePatientProfileResult rebuild(
          void Function(UpdatePatientProfileResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePatientProfileResultBuilder toBuilder() =>
      UpdatePatientProfileResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePatientProfileResult &&
        bmi == other.bmi &&
        bmiCategory == other.bmiCategory &&
        age == other.age;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bmi.hashCode);
    _$hash = $jc(_$hash, bmiCategory.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePatientProfileResult')
          ..add('bmi', bmi)
          ..add('bmiCategory', bmiCategory)
          ..add('age', age))
        .toString();
  }
}

class UpdatePatientProfileResultBuilder
    implements
        Builder<UpdatePatientProfileResult, UpdatePatientProfileResultBuilder> {
  _$UpdatePatientProfileResult? _$v;

  double? _bmi;
  double? get bmi => _$this._bmi;
  set bmi(double? bmi) => _$this._bmi = bmi;

  String? _bmiCategory;
  String? get bmiCategory => _$this._bmiCategory;
  set bmiCategory(String? bmiCategory) => _$this._bmiCategory = bmiCategory;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  UpdatePatientProfileResultBuilder() {
    UpdatePatientProfileResult._defaults(this);
  }

  UpdatePatientProfileResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bmi = $v.bmi;
      _bmiCategory = $v.bmiCategory;
      _age = $v.age;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePatientProfileResult other) {
    _$v = other as _$UpdatePatientProfileResult;
  }

  @override
  void update(void Function(UpdatePatientProfileResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePatientProfileResult build() => _build();

  _$UpdatePatientProfileResult _build() {
    final _$result = _$v ??
        _$UpdatePatientProfileResult._(
          bmi: bmi,
          bmiCategory: bmiCategory,
          age: age,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
