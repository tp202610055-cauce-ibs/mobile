// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_password_reset_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ValidatePasswordResetRequest extends ValidatePasswordResetRequest {
  @override
  final String? token;

  factory _$ValidatePasswordResetRequest(
          [void Function(ValidatePasswordResetRequestBuilder)? updates]) =>
      (ValidatePasswordResetRequestBuilder()..update(updates))._build();

  _$ValidatePasswordResetRequest._({this.token}) : super._();
  @override
  ValidatePasswordResetRequest rebuild(
          void Function(ValidatePasswordResetRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ValidatePasswordResetRequestBuilder toBuilder() =>
      ValidatePasswordResetRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ValidatePasswordResetRequest && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ValidatePasswordResetRequest')
          ..add('token', token))
        .toString();
  }
}

class ValidatePasswordResetRequestBuilder
    implements
        Builder<ValidatePasswordResetRequest,
            ValidatePasswordResetRequestBuilder> {
  _$ValidatePasswordResetRequest? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  ValidatePasswordResetRequestBuilder() {
    ValidatePasswordResetRequest._defaults(this);
  }

  ValidatePasswordResetRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ValidatePasswordResetRequest other) {
    _$v = other as _$ValidatePasswordResetRequest;
  }

  @override
  void update(void Function(ValidatePasswordResetRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ValidatePasswordResetRequest build() => _build();

  _$ValidatePasswordResetRequest _build() {
    final _$result = _$v ??
        _$ValidatePasswordResetRequest._(
          token: token,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
