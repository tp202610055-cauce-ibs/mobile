// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_clinical_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MyProfileClinicalInfo extends MyProfileClinicalInfo {
  @override
  final IbsSubtype? ibsSubtype;
  @override
  final Date? diagnosisDate;
  @override
  final int? age;

  factory _$MyProfileClinicalInfo(
          [void Function(MyProfileClinicalInfoBuilder)? updates]) =>
      (MyProfileClinicalInfoBuilder()..update(updates))._build();

  _$MyProfileClinicalInfo._({this.ibsSubtype, this.diagnosisDate, this.age})
      : super._();
  @override
  MyProfileClinicalInfo rebuild(
          void Function(MyProfileClinicalInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyProfileClinicalInfoBuilder toBuilder() =>
      MyProfileClinicalInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyProfileClinicalInfo &&
        ibsSubtype == other.ibsSubtype &&
        diagnosisDate == other.diagnosisDate &&
        age == other.age;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ibsSubtype.hashCode);
    _$hash = $jc(_$hash, diagnosisDate.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MyProfileClinicalInfo')
          ..add('ibsSubtype', ibsSubtype)
          ..add('diagnosisDate', diagnosisDate)
          ..add('age', age))
        .toString();
  }
}

class MyProfileClinicalInfoBuilder
    implements Builder<MyProfileClinicalInfo, MyProfileClinicalInfoBuilder> {
  _$MyProfileClinicalInfo? _$v;

  IbsSubtype? _ibsSubtype;
  IbsSubtype? get ibsSubtype => _$this._ibsSubtype;
  set ibsSubtype(IbsSubtype? ibsSubtype) => _$this._ibsSubtype = ibsSubtype;

  Date? _diagnosisDate;
  Date? get diagnosisDate => _$this._diagnosisDate;
  set diagnosisDate(Date? diagnosisDate) =>
      _$this._diagnosisDate = diagnosisDate;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  MyProfileClinicalInfoBuilder() {
    MyProfileClinicalInfo._defaults(this);
  }

  MyProfileClinicalInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ibsSubtype = $v.ibsSubtype;
      _diagnosisDate = $v.diagnosisDate;
      _age = $v.age;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyProfileClinicalInfo other) {
    _$v = other as _$MyProfileClinicalInfo;
  }

  @override
  void update(void Function(MyProfileClinicalInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MyProfileClinicalInfo build() => _build();

  _$MyProfileClinicalInfo _build() {
    final _$result = _$v ??
        _$MyProfileClinicalInfo._(
          ibsSubtype: ibsSubtype,
          diagnosisDate: diagnosisDate,
          age: age,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
