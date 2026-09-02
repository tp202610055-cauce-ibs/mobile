// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_recommendation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ArchiveRecommendationRequest extends ArchiveRecommendationRequest {
  @override
  final ArchiveReason? reason;

  factory _$ArchiveRecommendationRequest(
          [void Function(ArchiveRecommendationRequestBuilder)? updates]) =>
      (ArchiveRecommendationRequestBuilder()..update(updates))._build();

  _$ArchiveRecommendationRequest._({this.reason}) : super._();
  @override
  ArchiveRecommendationRequest rebuild(
          void Function(ArchiveRecommendationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArchiveRecommendationRequestBuilder toBuilder() =>
      ArchiveRecommendationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArchiveRecommendationRequest && reason == other.reason;
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
    return (newBuiltValueToStringHelper(r'ArchiveRecommendationRequest')
          ..add('reason', reason))
        .toString();
  }
}

class ArchiveRecommendationRequestBuilder
    implements
        Builder<ArchiveRecommendationRequest,
            ArchiveRecommendationRequestBuilder> {
  _$ArchiveRecommendationRequest? _$v;

  ArchiveReason? _reason;
  ArchiveReason? get reason => _$this._reason;
  set reason(ArchiveReason? reason) => _$this._reason = reason;

  ArchiveRecommendationRequestBuilder() {
    ArchiveRecommendationRequest._defaults(this);
  }

  ArchiveRecommendationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArchiveRecommendationRequest other) {
    _$v = other as _$ArchiveRecommendationRequest;
  }

  @override
  void update(void Function(ArchiveRecommendationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ArchiveRecommendationRequest build() => _build();

  _$ArchiveRecommendationRequest _build() {
    final _$result = _$v ??
        _$ArchiveRecommendationRequest._(
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
