// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_verification_email_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResendVerificationEmailRequest extends ResendVerificationEmailRequest {
  @override
  final String? email;

  factory _$ResendVerificationEmailRequest(
          [void Function(ResendVerificationEmailRequestBuilder)? updates]) =>
      (ResendVerificationEmailRequestBuilder()..update(updates))._build();

  _$ResendVerificationEmailRequest._({this.email}) : super._();
  @override
  ResendVerificationEmailRequest rebuild(
          void Function(ResendVerificationEmailRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResendVerificationEmailRequestBuilder toBuilder() =>
      ResendVerificationEmailRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResendVerificationEmailRequest && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResendVerificationEmailRequest')
          ..add('email', email))
        .toString();
  }
}

class ResendVerificationEmailRequestBuilder
    implements
        Builder<ResendVerificationEmailRequest,
            ResendVerificationEmailRequestBuilder> {
  _$ResendVerificationEmailRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  ResendVerificationEmailRequestBuilder() {
    ResendVerificationEmailRequest._defaults(this);
  }

  ResendVerificationEmailRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResendVerificationEmailRequest other) {
    _$v = other as _$ResendVerificationEmailRequest;
  }

  @override
  void update(void Function(ResendVerificationEmailRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResendVerificationEmailRequest build() => _build();

  _$ResendVerificationEmailRequest _build() {
    final _$result = _$v ??
        _$ResendVerificationEmailRequest._(
          email: email,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
