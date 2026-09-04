// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_patient_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterPatientRequest extends RegisterPatientRequest {
  @override
  final String? email;
  @override
  final String? fullName;
  @override
  final String? password;
  @override
  final String? consentDocumentVersion;
  @override
  final String? consentTextHash;
  @override
  final String? invitationCode;

  factory _$RegisterPatientRequest(
          [void Function(RegisterPatientRequestBuilder)? updates]) =>
      (RegisterPatientRequestBuilder()..update(updates))._build();

  _$RegisterPatientRequest._(
      {this.email,
      this.fullName,
      this.password,
      this.consentDocumentVersion,
      this.consentTextHash,
      this.invitationCode})
      : super._();
  @override
  RegisterPatientRequest rebuild(
          void Function(RegisterPatientRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterPatientRequestBuilder toBuilder() =>
      RegisterPatientRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterPatientRequest &&
        email == other.email &&
        fullName == other.fullName &&
        password == other.password &&
        consentDocumentVersion == other.consentDocumentVersion &&
        consentTextHash == other.consentTextHash &&
        invitationCode == other.invitationCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, consentDocumentVersion.hashCode);
    _$hash = $jc(_$hash, consentTextHash.hashCode);
    _$hash = $jc(_$hash, invitationCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterPatientRequest')
          ..add('email', email)
          ..add('fullName', fullName)
          ..add('password', password)
          ..add('consentDocumentVersion', consentDocumentVersion)
          ..add('consentTextHash', consentTextHash)
          ..add('invitationCode', invitationCode))
        .toString();
  }
}

class RegisterPatientRequestBuilder
    implements Builder<RegisterPatientRequest, RegisterPatientRequestBuilder> {
  _$RegisterPatientRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _consentDocumentVersion;
  String? get consentDocumentVersion => _$this._consentDocumentVersion;
  set consentDocumentVersion(String? consentDocumentVersion) =>
      _$this._consentDocumentVersion = consentDocumentVersion;

  String? _consentTextHash;
  String? get consentTextHash => _$this._consentTextHash;
  set consentTextHash(String? consentTextHash) =>
      _$this._consentTextHash = consentTextHash;

  String? _invitationCode;
  String? get invitationCode => _$this._invitationCode;
  set invitationCode(String? invitationCode) =>
      _$this._invitationCode = invitationCode;

  RegisterPatientRequestBuilder() {
    RegisterPatientRequest._defaults(this);
  }

  RegisterPatientRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _fullName = $v.fullName;
      _password = $v.password;
      _consentDocumentVersion = $v.consentDocumentVersion;
      _consentTextHash = $v.consentTextHash;
      _invitationCode = $v.invitationCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterPatientRequest other) {
    _$v = other as _$RegisterPatientRequest;
  }

  @override
  void update(void Function(RegisterPatientRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterPatientRequest build() => _build();

  _$RegisterPatientRequest _build() {
    final _$result = _$v ??
        _$RegisterPatientRequest._(
          email: email,
          fullName: fullName,
          password: password,
          consentDocumentVersion: consentDocumentVersion,
          consentTextHash: consentTextHash,
          invitationCode: invitationCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
