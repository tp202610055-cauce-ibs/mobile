// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_feedback_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationFeedbackDto extends RecommendationFeedbackDto {
  @override
  final String? feedbackId;
  @override
  final bool? wasApplied;
  @override
  final FeedbackOutcome? outcome;
  @override
  final String? comment;
  @override
  final DateTime? submittedAt;

  factory _$RecommendationFeedbackDto(
          [void Function(RecommendationFeedbackDtoBuilder)? updates]) =>
      (RecommendationFeedbackDtoBuilder()..update(updates))._build();

  _$RecommendationFeedbackDto._(
      {this.feedbackId,
      this.wasApplied,
      this.outcome,
      this.comment,
      this.submittedAt})
      : super._();
  @override
  RecommendationFeedbackDto rebuild(
          void Function(RecommendationFeedbackDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationFeedbackDtoBuilder toBuilder() =>
      RecommendationFeedbackDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationFeedbackDto &&
        feedbackId == other.feedbackId &&
        wasApplied == other.wasApplied &&
        outcome == other.outcome &&
        comment == other.comment &&
        submittedAt == other.submittedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, feedbackId.hashCode);
    _$hash = $jc(_$hash, wasApplied.hashCode);
    _$hash = $jc(_$hash, outcome.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecommendationFeedbackDto')
          ..add('feedbackId', feedbackId)
          ..add('wasApplied', wasApplied)
          ..add('outcome', outcome)
          ..add('comment', comment)
          ..add('submittedAt', submittedAt))
        .toString();
  }
}

class RecommendationFeedbackDtoBuilder
    implements
        Builder<RecommendationFeedbackDto, RecommendationFeedbackDtoBuilder> {
  _$RecommendationFeedbackDto? _$v;

  String? _feedbackId;
  String? get feedbackId => _$this._feedbackId;
  set feedbackId(String? feedbackId) => _$this._feedbackId = feedbackId;

  bool? _wasApplied;
  bool? get wasApplied => _$this._wasApplied;
  set wasApplied(bool? wasApplied) => _$this._wasApplied = wasApplied;

  FeedbackOutcome? _outcome;
  FeedbackOutcome? get outcome => _$this._outcome;
  set outcome(FeedbackOutcome? outcome) => _$this._outcome = outcome;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  RecommendationFeedbackDtoBuilder() {
    RecommendationFeedbackDto._defaults(this);
  }

  RecommendationFeedbackDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _feedbackId = $v.feedbackId;
      _wasApplied = $v.wasApplied;
      _outcome = $v.outcome;
      _comment = $v.comment;
      _submittedAt = $v.submittedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecommendationFeedbackDto other) {
    _$v = other as _$RecommendationFeedbackDto;
  }

  @override
  void update(void Function(RecommendationFeedbackDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationFeedbackDto build() => _build();

  _$RecommendationFeedbackDto _build() {
    final _$result = _$v ??
        _$RecommendationFeedbackDto._(
          feedbackId: feedbackId,
          wasApplied: wasApplied,
          outcome: outcome,
          comment: comment,
          submittedAt: submittedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
