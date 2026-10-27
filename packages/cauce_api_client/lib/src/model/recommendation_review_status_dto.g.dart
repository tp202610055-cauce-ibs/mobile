// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_review_status_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationReviewStatusDto extends RecommendationReviewStatusDto {
  @override
  final bool? hasRecommendationInReview;

  factory _$RecommendationReviewStatusDto(
          [void Function(RecommendationReviewStatusDtoBuilder)? updates]) =>
      (RecommendationReviewStatusDtoBuilder()..update(updates))._build();

  _$RecommendationReviewStatusDto._({this.hasRecommendationInReview})
      : super._();
  @override
  RecommendationReviewStatusDto rebuild(
          void Function(RecommendationReviewStatusDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationReviewStatusDtoBuilder toBuilder() =>
      RecommendationReviewStatusDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationReviewStatusDto &&
        hasRecommendationInReview == other.hasRecommendationInReview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hasRecommendationInReview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecommendationReviewStatusDto')
          ..add('hasRecommendationInReview', hasRecommendationInReview))
        .toString();
  }
}

class RecommendationReviewStatusDtoBuilder
    implements
        Builder<RecommendationReviewStatusDto,
            RecommendationReviewStatusDtoBuilder> {
  _$RecommendationReviewStatusDto? _$v;

  bool? _hasRecommendationInReview;
  bool? get hasRecommendationInReview => _$this._hasRecommendationInReview;
  set hasRecommendationInReview(bool? hasRecommendationInReview) =>
      _$this._hasRecommendationInReview = hasRecommendationInReview;

  RecommendationReviewStatusDtoBuilder() {
    RecommendationReviewStatusDto._defaults(this);
  }

  RecommendationReviewStatusDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hasRecommendationInReview = $v.hasRecommendationInReview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecommendationReviewStatusDto other) {
    _$v = other as _$RecommendationReviewStatusDto;
  }

  @override
  void update(void Function(RecommendationReviewStatusDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationReviewStatusDto build() => _build();

  _$RecommendationReviewStatusDto _build() {
    final _$result = _$v ??
        _$RecommendationReviewStatusDto._(
          hasRecommendationInReview: hasRecommendationInReview,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
