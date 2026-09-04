// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_summary_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationSummaryDto extends RecommendationSummaryDto {
  @override
  final String? recommendationId;
  @override
  final RecommendationStatus? status;
  @override
  final double? confidenceScore;
  @override
  final int? itemsCount;
  @override
  final DateTime? generatedAt;
  @override
  final DateTime? expiresAt;

  factory _$RecommendationSummaryDto(
          [void Function(RecommendationSummaryDtoBuilder)? updates]) =>
      (RecommendationSummaryDtoBuilder()..update(updates))._build();

  _$RecommendationSummaryDto._(
      {this.recommendationId,
      this.status,
      this.confidenceScore,
      this.itemsCount,
      this.generatedAt,
      this.expiresAt})
      : super._();
  @override
  RecommendationSummaryDto rebuild(
          void Function(RecommendationSummaryDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationSummaryDtoBuilder toBuilder() =>
      RecommendationSummaryDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationSummaryDto &&
        recommendationId == other.recommendationId &&
        status == other.status &&
        confidenceScore == other.confidenceScore &&
        itemsCount == other.itemsCount &&
        generatedAt == other.generatedAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recommendationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, confidenceScore.hashCode);
    _$hash = $jc(_$hash, itemsCount.hashCode);
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecommendationSummaryDto')
          ..add('recommendationId', recommendationId)
          ..add('status', status)
          ..add('confidenceScore', confidenceScore)
          ..add('itemsCount', itemsCount)
          ..add('generatedAt', generatedAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class RecommendationSummaryDtoBuilder
    implements
        Builder<RecommendationSummaryDto, RecommendationSummaryDtoBuilder> {
  _$RecommendationSummaryDto? _$v;

  String? _recommendationId;
  String? get recommendationId => _$this._recommendationId;
  set recommendationId(String? recommendationId) =>
      _$this._recommendationId = recommendationId;

  RecommendationStatus? _status;
  RecommendationStatus? get status => _$this._status;
  set status(RecommendationStatus? status) => _$this._status = status;

  double? _confidenceScore;
  double? get confidenceScore => _$this._confidenceScore;
  set confidenceScore(double? confidenceScore) =>
      _$this._confidenceScore = confidenceScore;

  int? _itemsCount;
  int? get itemsCount => _$this._itemsCount;
  set itemsCount(int? itemsCount) => _$this._itemsCount = itemsCount;

  DateTime? _generatedAt;
  DateTime? get generatedAt => _$this._generatedAt;
  set generatedAt(DateTime? generatedAt) => _$this._generatedAt = generatedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  RecommendationSummaryDtoBuilder() {
    RecommendationSummaryDto._defaults(this);
  }

  RecommendationSummaryDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recommendationId = $v.recommendationId;
      _status = $v.status;
      _confidenceScore = $v.confidenceScore;
      _itemsCount = $v.itemsCount;
      _generatedAt = $v.generatedAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecommendationSummaryDto other) {
    _$v = other as _$RecommendationSummaryDto;
  }

  @override
  void update(void Function(RecommendationSummaryDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationSummaryDto build() => _build();

  _$RecommendationSummaryDto _build() {
    final _$result = _$v ??
        _$RecommendationSummaryDto._(
          recommendationId: recommendationId,
          status: status,
          confidenceScore: confidenceScore,
          itemsCount: itemsCount,
          generatedAt: generatedAt,
          expiresAt: expiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
