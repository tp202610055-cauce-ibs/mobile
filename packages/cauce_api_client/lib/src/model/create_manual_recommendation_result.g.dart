// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_manual_recommendation_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateManualRecommendationResult
    extends CreateManualRecommendationResult {
  @override
  final String? recommendationId;
  @override
  final RecommendationStatus? status;

  factory _$CreateManualRecommendationResult(
          [void Function(CreateManualRecommendationResultBuilder)? updates]) =>
      (CreateManualRecommendationResultBuilder()..update(updates))._build();

  _$CreateManualRecommendationResult._({this.recommendationId, this.status})
      : super._();
  @override
  CreateManualRecommendationResult rebuild(
          void Function(CreateManualRecommendationResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateManualRecommendationResultBuilder toBuilder() =>
      CreateManualRecommendationResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateManualRecommendationResult &&
        recommendationId == other.recommendationId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recommendationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateManualRecommendationResult')
          ..add('recommendationId', recommendationId)
          ..add('status', status))
        .toString();
  }
}

class CreateManualRecommendationResultBuilder
    implements
        Builder<CreateManualRecommendationResult,
            CreateManualRecommendationResultBuilder> {
  _$CreateManualRecommendationResult? _$v;

  String? _recommendationId;
  String? get recommendationId => _$this._recommendationId;
  set recommendationId(String? recommendationId) =>
      _$this._recommendationId = recommendationId;

  RecommendationStatus? _status;
  RecommendationStatus? get status => _$this._status;
  set status(RecommendationStatus? status) => _$this._status = status;

  CreateManualRecommendationResultBuilder() {
    CreateManualRecommendationResult._defaults(this);
  }

  CreateManualRecommendationResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recommendationId = $v.recommendationId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateManualRecommendationResult other) {
    _$v = other as _$CreateManualRecommendationResult;
  }

  @override
  void update(void Function(CreateManualRecommendationResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateManualRecommendationResult build() => _build();

  _$CreateManualRecommendationResult _build() {
    final _$result = _$v ??
        _$CreateManualRecommendationResult._(
          recommendationId: recommendationId,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
