// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_patient_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MyProfilePatientInfo extends MyProfilePatientInfo {
  @override
  final String? fullName;
  @override
  final String? maskedEmail;

  factory _$MyProfilePatientInfo(
          [void Function(MyProfilePatientInfoBuilder)? updates]) =>
      (MyProfilePatientInfoBuilder()..update(updates))._build();

  _$MyProfilePatientInfo._({this.fullName, this.maskedEmail}) : super._();
  @override
  MyProfilePatientInfo rebuild(
          void Function(MyProfilePatientInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyProfilePatientInfoBuilder toBuilder() =>
      MyProfilePatientInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyProfilePatientInfo &&
        fullName == other.fullName &&
        maskedEmail == other.maskedEmail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, maskedEmail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MyProfilePatientInfo')
          ..add('fullName', fullName)
          ..add('maskedEmail', maskedEmail))
        .toString();
  }
}

class MyProfilePatientInfoBuilder
    implements Builder<MyProfilePatientInfo, MyProfilePatientInfoBuilder> {
  _$MyProfilePatientInfo? _$v;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _maskedEmail;
  String? get maskedEmail => _$this._maskedEmail;
  set maskedEmail(String? maskedEmail) => _$this._maskedEmail = maskedEmail;

  MyProfilePatientInfoBuilder() {
    MyProfilePatientInfo._defaults(this);
  }

  MyProfilePatientInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fullName = $v.fullName;
      _maskedEmail = $v.maskedEmail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyProfilePatientInfo other) {
    _$v = other as _$MyProfilePatientInfo;
  }

  @override
  void update(void Function(MyProfilePatientInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MyProfilePatientInfo build() => _build();

  _$MyProfilePatientInfo _build() {
    final _$result = _$v ??
        _$MyProfilePatientInfo._(
          fullName: fullName,
          maskedEmail: maskedEmail,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
