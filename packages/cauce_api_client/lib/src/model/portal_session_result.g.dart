// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portal_session_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortalSessionResult extends PortalSessionResult {
  @override
  final String? accessToken;
  @override
  final int? expiresIn;
  @override
  final String? tokenType;
  @override
  final AuthenticatedUser? user;

  factory _$PortalSessionResult(
          [void Function(PortalSessionResultBuilder)? updates]) =>
      (PortalSessionResultBuilder()..update(updates))._build();

  _$PortalSessionResult._(
      {this.accessToken, this.expiresIn, this.tokenType, this.user})
      : super._();
  @override
  PortalSessionResult rebuild(
          void Function(PortalSessionResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortalSessionResultBuilder toBuilder() =>
      PortalSessionResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortalSessionResult &&
        accessToken == other.accessToken &&
        expiresIn == other.expiresIn &&
        tokenType == other.tokenType &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortalSessionResult')
          ..add('accessToken', accessToken)
          ..add('expiresIn', expiresIn)
          ..add('tokenType', tokenType)
          ..add('user', user))
        .toString();
  }
}

class PortalSessionResultBuilder
    implements Builder<PortalSessionResult, PortalSessionResultBuilder> {
  _$PortalSessionResult? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _tokenType;
  String? get tokenType => _$this._tokenType;
  set tokenType(String? tokenType) => _$this._tokenType = tokenType;

  AuthenticatedUserBuilder? _user;
  AuthenticatedUserBuilder get user =>
      _$this._user ??= AuthenticatedUserBuilder();
  set user(AuthenticatedUserBuilder? user) => _$this._user = user;

  PortalSessionResultBuilder() {
    PortalSessionResult._defaults(this);
  }

  PortalSessionResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _expiresIn = $v.expiresIn;
      _tokenType = $v.tokenType;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortalSessionResult other) {
    _$v = other as _$PortalSessionResult;
  }

  @override
  void update(void Function(PortalSessionResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortalSessionResult build() => _build();

  _$PortalSessionResult _build() {
    _$PortalSessionResult _$result;
    try {
      _$result = _$v ??
          _$PortalSessionResult._(
            accessToken: accessToken,
            expiresIn: expiresIn,
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
            r'PortalSessionResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
