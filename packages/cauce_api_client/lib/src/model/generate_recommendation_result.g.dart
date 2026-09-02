// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_recommendation_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateRecommendationResult extends GenerateRecommendationResult {
  @override
  final String? recommendationId;
  @override
  final RecommendationStatus? status;
  @override
  final bool? requiresReview;
  @override
  final DateTime? generatedAt;
  @override
  final DateTime? expiresAt;

  factory _$GenerateRecommendationResult(
          [void Function(GenerateRecommendationResultBuilder)? updates]) =>
      (GenerateRecommendationResultBuilder()..update(updates))._build();

  _$GenerateRecommendationResult._(
      {this.recommendationId,
      this.status,
      this.requiresReview,
      this.generatedAt,
      this.expiresAt})
      : super._();
  @override
  GenerateRecommendationResult rebuild(
          void Function(GenerateRecommendationResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerateRecommendationResultBuilder toBuilder() =>
      GenerateRecommendationResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateRecommendationResult &&
        recommendationId == other.recommendationId &&
        status == other.status &&
        requiresReview == other.requiresReview &&
        generatedAt == other.generatedAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recommendationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, requiresReview.hashCode);
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerateRecommendationResult')
          ..add('recommendationId', recommendationId)
          ..add('status', status)
          ..add('requiresReview', requiresReview)
          ..add('generatedAt', generatedAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class GenerateRecommendationResultBuilder
    implements
        Builder<GenerateRecommendationResult,
            GenerateRecommendationResultBuilder> {
  _$GenerateRecommendationResult? _$v;

  String? _recommendationId;
  String? get recommendationId => _$this._recommendationId;
  set recommendationId(String? recommendationId) =>
      _$this._recommendationId = recommendationId;

  RecommendationStatus? _status;
  RecommendationStatus? get status => _$this._status;
  set status(RecommendationStatus? status) => _$this._status = status;

  bool? _requiresReview;
  bool? get requiresReview => _$this._requiresReview;
  set requiresReview(bool? requiresReview) =>
      _$this._requiresReview = requiresReview;

  DateTime? _generatedAt;
  DateTime? get generatedAt => _$this._generatedAt;
  set generatedAt(DateTime? generatedAt) => _$this._generatedAt = generatedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  GenerateRecommendationResultBuilder() {
    GenerateRecommendationResult._defaults(this);
  }

  GenerateRecommendationResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recommendationId = $v.recommendationId;
      _status = $v.status;
      _requiresReview = $v.requiresReview;
      _generatedAt = $v.generatedAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateRecommendationResult other) {
    _$v = other as _$GenerateRecommendationResult;
  }

  @override
  void update(void Function(GenerateRecommendationResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateRecommendationResult build() => _build();

  _$GenerateRecommendationResult _build() {
    final _$result = _$v ??
        _$GenerateRecommendationResult._(
          recommendationId: recommendationId,
          status: status,
          requiresReview: requiresReview,
          generatedAt: generatedAt,
          expiresAt: expiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
