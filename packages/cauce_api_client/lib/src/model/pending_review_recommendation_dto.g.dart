// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_review_recommendation_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PendingReviewRecommendationDto extends PendingReviewRecommendationDto {
  @override
  final String? recommendationId;
  @override
  final String? patientId;
  @override
  final String? patientFullName;
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

  factory _$PendingReviewRecommendationDto(
          [void Function(PendingReviewRecommendationDtoBuilder)? updates]) =>
      (PendingReviewRecommendationDtoBuilder()..update(updates))._build();

  _$PendingReviewRecommendationDto._(
      {this.recommendationId,
      this.patientId,
      this.patientFullName,
      this.status,
      this.confidenceScore,
      this.itemsCount,
      this.generatedAt,
      this.expiresAt})
      : super._();
  @override
  PendingReviewRecommendationDto rebuild(
          void Function(PendingReviewRecommendationDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PendingReviewRecommendationDtoBuilder toBuilder() =>
      PendingReviewRecommendationDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PendingReviewRecommendationDto &&
        recommendationId == other.recommendationId &&
        patientId == other.patientId &&
        patientFullName == other.patientFullName &&
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
    _$hash = $jc(_$hash, patientId.hashCode);
    _$hash = $jc(_$hash, patientFullName.hashCode);
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
    return (newBuiltValueToStringHelper(r'PendingReviewRecommendationDto')
          ..add('recommendationId', recommendationId)
          ..add('patientId', patientId)
          ..add('patientFullName', patientFullName)
          ..add('status', status)
          ..add('confidenceScore', confidenceScore)
          ..add('itemsCount', itemsCount)
          ..add('generatedAt', generatedAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class PendingReviewRecommendationDtoBuilder
    implements
        Builder<PendingReviewRecommendationDto,
            PendingReviewRecommendationDtoBuilder> {
  _$PendingReviewRecommendationDto? _$v;

  String? _recommendationId;
  String? get recommendationId => _$this._recommendationId;
  set recommendationId(String? recommendationId) =>
      _$this._recommendationId = recommendationId;

  String? _patientId;
  String? get patientId => _$this._patientId;
  set patientId(String? patientId) => _$this._patientId = patientId;

  String? _patientFullName;
  String? get patientFullName => _$this._patientFullName;
  set patientFullName(String? patientFullName) =>
      _$this._patientFullName = patientFullName;

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

  PendingReviewRecommendationDtoBuilder() {
    PendingReviewRecommendationDto._defaults(this);
  }

  PendingReviewRecommendationDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recommendationId = $v.recommendationId;
      _patientId = $v.patientId;
      _patientFullName = $v.patientFullName;
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
  void replace(PendingReviewRecommendationDto other) {
    _$v = other as _$PendingReviewRecommendationDto;
  }

  @override
  void update(void Function(PendingReviewRecommendationDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PendingReviewRecommendationDto build() => _build();

  _$PendingReviewRecommendationDto _build() {
    final _$result = _$v ??
        _$PendingReviewRecommendationDto._(
          recommendationId: recommendationId,
          patientId: patientId,
          patientFullName: patientFullName,
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
