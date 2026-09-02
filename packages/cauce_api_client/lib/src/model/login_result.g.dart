// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginResult extends LoginResult {
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final int? expiresIn;
  @override
  final int? refreshExpiresIn;
  @override
  final String? tokenType;
  @override
  final AuthenticatedUser? user;

  factory _$LoginResult([void Function(LoginResultBuilder)? updates]) =>
      (LoginResultBuilder()..update(updates))._build();

  _$LoginResult._(
      {this.accessToken,
      this.refreshToken,
      this.expiresIn,
      this.refreshExpiresIn,
      this.tokenType,
      this.user})
      : super._();
  @override
  LoginResult rebuild(void Function(LoginResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResultBuilder toBuilder() => LoginResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginResult &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        expiresIn == other.expiresIn &&
        refreshExpiresIn == other.refreshExpiresIn &&
        tokenType == other.tokenType &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, refreshExpiresIn.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginResult')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('expiresIn', expiresIn)
          ..add('refreshExpiresIn', refreshExpiresIn)
          ..add('tokenType', tokenType)
          ..add('user', user))
        .toString();
  }
}

class LoginResultBuilder implements Builder<LoginResult, LoginResultBuilder> {
  _$LoginResult? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  int? _refreshExpiresIn;
  int? get refreshExpiresIn => _$this._refreshExpiresIn;
  set refreshExpiresIn(int? refreshExpiresIn) =>
      _$this._refreshExpiresIn = refreshExpiresIn;

  String? _tokenType;
  String? get tokenType => _$this._tokenType;
  set tokenType(String? tokenType) => _$this._tokenType = tokenType;

  AuthenticatedUserBuilder? _user;
  AuthenticatedUserBuilder get user =>
      _$this._user ??= AuthenticatedUserBuilder();
  set user(AuthenticatedUserBuilder? user) => _$this._user = user;

  LoginResultBuilder() {
    LoginResult._defaults(this);
  }

  LoginResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _expiresIn = $v.expiresIn;
      _refreshExpiresIn = $v.refreshExpiresIn;
      _tokenType = $v.tokenType;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResult other) {
    _$v = other as _$LoginResult;
  }

  @override
  void update(void Function(LoginResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginResult build() => _build();

  _$LoginResult _build() {
    _$LoginResult _$result;
    try {
      _$result = _$v ??
          _$LoginResult._(
            accessToken: accessToken,
            refreshToken: refreshToken,
            expiresIn: expiresIn,
            refreshExpiresIn: refreshExpiresIn,
            tokenType: tokenType,
            user: _user?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'LoginResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
