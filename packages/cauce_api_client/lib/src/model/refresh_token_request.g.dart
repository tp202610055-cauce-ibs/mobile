// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RefreshTokenRequest extends RefreshTokenRequest {
  @override
  final String? refreshToken;
  @override
  final String? clientId;

  factory _$RefreshTokenRequest(
          [void Function(RefreshTokenRequestBuilder)? updates]) =>
      (RefreshTokenRequestBuilder()..update(updates))._build();

  _$RefreshTokenRequest._({this.refreshToken, this.clientId}) : super._();
  @override
  RefreshTokenRequest rebuild(
          void Function(RefreshTokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RefreshTokenRequestBuilder toBuilder() =>
      RefreshTokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RefreshTokenRequest &&
        refreshToken == other.refreshToken &&
        clientId == other.clientId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RefreshTokenRequest')
          ..add('refreshToken', refreshToken)
          ..add('clientId', clientId))
        .toString();
  }
}

class RefreshTokenRequestBuilder
    implements Builder<RefreshTokenRequest, RefreshTokenRequestBuilder> {
  _$RefreshTokenRequest? _$v;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  RefreshTokenRequestBuilder() {
    RefreshTokenRequest._defaults(this);
  }

  RefreshTokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshToken = $v.refreshToken;
      _clientId = $v.clientId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RefreshTokenRequest other) {
    _$v = other as _$RefreshTokenRequest;
  }

  @override
  void update(void Function(RefreshTokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RefreshTokenRequest build() => _build();

  _$RefreshTokenRequest _build() {
    final _$result = _$v ??
        _$RefreshTokenRequest._(
          refreshToken: refreshToken,
          clientId: clientId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
