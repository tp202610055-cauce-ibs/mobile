// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portal_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortalLoginRequest extends PortalLoginRequest {
  @override
  final String? email;
  @override
  final String? password;

  factory _$PortalLoginRequest(
          [void Function(PortalLoginRequestBuilder)? updates]) =>
      (PortalLoginRequestBuilder()..update(updates))._build();

  _$PortalLoginRequest._({this.email, this.password}) : super._();
  @override
  PortalLoginRequest rebuild(
          void Function(PortalLoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortalLoginRequestBuilder toBuilder() =>
      PortalLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortalLoginRequest &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortalLoginRequest')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class PortalLoginRequestBuilder
    implements Builder<PortalLoginRequest, PortalLoginRequestBuilder> {
  _$PortalLoginRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  PortalLoginRequestBuilder() {
    PortalLoginRequest._defaults(this);
  }

  PortalLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortalLoginRequest other) {
    _$v = other as _$PortalLoginRequest;
  }

  @override
  void update(void Function(PortalLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortalLoginRequest build() => _build();

  _$PortalLoginRequest _build() {
    final _$result = _$v ??
        _$PortalLoginRequest._(
          email: email,
          password: password,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
