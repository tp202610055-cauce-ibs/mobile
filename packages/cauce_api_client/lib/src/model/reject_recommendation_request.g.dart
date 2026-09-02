// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_recommendation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RejectRecommendationRequest extends RejectRecommendationRequest {
  @override
  final String? reason;

  factory _$RejectRecommendationRequest(
          [void Function(RejectRecommendationRequestBuilder)? updates]) =>
      (RejectRecommendationRequestBuilder()..update(updates))._build();

  _$RejectRecommendationRequest._({this.reason}) : super._();
  @override
  RejectRecommendationRequest rebuild(
          void Function(RejectRecommendationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RejectRecommendationRequestBuilder toBuilder() =>
      RejectRecommendationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RejectRecommendationRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RejectRecommendationRequest')
          ..add('reason', reason))
        .toString();
  }
}

class RejectRecommendationRequestBuilder
    implements
        Builder<RejectRecommendationRequest,
            RejectRecommendationRequestBuilder> {
  _$RejectRecommendationRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  RejectRecommendationRequestBuilder() {
    RejectRecommendationRequest._defaults(this);
  }

  RejectRecommendationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RejectRecommendationRequest other) {
    _$v = other as _$RejectRecommendationRequest;
  }

  @override
  void update(void Function(RejectRecommendationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RejectRecommendationRequest build() => _build();

  _$RejectRecommendationRequest _build() {
    final _$result = _$v ??
        _$RejectRecommendationRequest._(
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
