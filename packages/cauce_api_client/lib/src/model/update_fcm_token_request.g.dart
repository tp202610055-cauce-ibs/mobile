// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_fcm_token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateFcmTokenRequest extends UpdateFcmTokenRequest {
  @override
  final String? fcmToken;

  factory _$UpdateFcmTokenRequest(
          [void Function(UpdateFcmTokenRequestBuilder)? updates]) =>
      (UpdateFcmTokenRequestBuilder()..update(updates))._build();

  _$UpdateFcmTokenRequest._({this.fcmToken}) : super._();
  @override
  UpdateFcmTokenRequest rebuild(
          void Function(UpdateFcmTokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateFcmTokenRequestBuilder toBuilder() =>
      UpdateFcmTokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateFcmTokenRequest && fcmToken == other.fcmToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fcmToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateFcmTokenRequest')
          ..add('fcmToken', fcmToken))
        .toString();
  }
}

class UpdateFcmTokenRequestBuilder
    implements Builder<UpdateFcmTokenRequest, UpdateFcmTokenRequestBuilder> {
  _$UpdateFcmTokenRequest? _$v;

  String? _fcmToken;
  String? get fcmToken => _$this._fcmToken;
  set fcmToken(String? fcmToken) => _$this._fcmToken = fcmToken;

  UpdateFcmTokenRequestBuilder() {
    UpdateFcmTokenRequest._defaults(this);
  }

  UpdateFcmTokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fcmToken = $v.fcmToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateFcmTokenRequest other) {
    _$v = other as _$UpdateFcmTokenRequest;
  }

  @override
  void update(void Function(UpdateFcmTokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateFcmTokenRequest build() => _build();

  _$UpdateFcmTokenRequest _build() {
    final _$result = _$v ??
        _$UpdateFcmTokenRequest._(
          fcmToken: fcmToken,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
