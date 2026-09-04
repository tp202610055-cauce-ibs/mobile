// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_password_reset_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmPasswordResetRequest extends ConfirmPasswordResetRequest {
  @override
  final String? token;
  @override
  final String? newPassword;

  factory _$ConfirmPasswordResetRequest(
          [void Function(ConfirmPasswordResetRequestBuilder)? updates]) =>
      (ConfirmPasswordResetRequestBuilder()..update(updates))._build();

  _$ConfirmPasswordResetRequest._({this.token, this.newPassword}) : super._();
  @override
  ConfirmPasswordResetRequest rebuild(
          void Function(ConfirmPasswordResetRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfirmPasswordResetRequestBuilder toBuilder() =>
      ConfirmPasswordResetRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmPasswordResetRequest &&
        token == other.token &&
        newPassword == other.newPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfirmPasswordResetRequest')
          ..add('token', token)
          ..add('newPassword', newPassword))
        .toString();
  }
}

class ConfirmPasswordResetRequestBuilder
    implements
        Builder<ConfirmPasswordResetRequest,
            ConfirmPasswordResetRequestBuilder> {
  _$ConfirmPasswordResetRequest? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  ConfirmPasswordResetRequestBuilder() {
    ConfirmPasswordResetRequest._defaults(this);
  }

  ConfirmPasswordResetRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _newPassword = $v.newPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmPasswordResetRequest other) {
    _$v = other as _$ConfirmPasswordResetRequest;
  }

  @override
  void update(void Function(ConfirmPasswordResetRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmPasswordResetRequest build() => _build();

  _$ConfirmPasswordResetRequest _build() {
    final _$result = _$v ??
        _$ConfirmPasswordResetRequest._(
          token: token,
          newPassword: newPassword,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
