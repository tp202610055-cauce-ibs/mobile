// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_feedback_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmitFeedbackRequest extends SubmitFeedbackRequest {
  @override
  final bool? wasApplied;
  @override
  final FeedbackOutcome? outcome;
  @override
  final String? comment;

  factory _$SubmitFeedbackRequest(
          [void Function(SubmitFeedbackRequestBuilder)? updates]) =>
      (SubmitFeedbackRequestBuilder()..update(updates))._build();

  _$SubmitFeedbackRequest._({this.wasApplied, this.outcome, this.comment})
      : super._();
  @override
  SubmitFeedbackRequest rebuild(
          void Function(SubmitFeedbackRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmitFeedbackRequestBuilder toBuilder() =>
      SubmitFeedbackRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitFeedbackRequest &&
        wasApplied == other.wasApplied &&
        outcome == other.outcome &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, wasApplied.hashCode);
    _$hash = $jc(_$hash, outcome.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmitFeedbackRequest')
          ..add('wasApplied', wasApplied)
          ..add('outcome', outcome)
          ..add('comment', comment))
        .toString();
  }
}

class SubmitFeedbackRequestBuilder
    implements Builder<SubmitFeedbackRequest, SubmitFeedbackRequestBuilder> {
  _$SubmitFeedbackRequest? _$v;

  bool? _wasApplied;
  bool? get wasApplied => _$this._wasApplied;
  set wasApplied(bool? wasApplied) => _$this._wasApplied = wasApplied;

  FeedbackOutcome? _outcome;
  FeedbackOutcome? get outcome => _$this._outcome;
  set outcome(FeedbackOutcome? outcome) => _$this._outcome = outcome;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  SubmitFeedbackRequestBuilder() {
    SubmitFeedbackRequest._defaults(this);
  }

  SubmitFeedbackRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _wasApplied = $v.wasApplied;
      _outcome = $v.outcome;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmitFeedbackRequest other) {
    _$v = other as _$SubmitFeedbackRequest;
  }

  @override
  void update(void Function(SubmitFeedbackRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitFeedbackRequest build() => _build();

  _$SubmitFeedbackRequest _build() {
    final _$result = _$v ??
        _$SubmitFeedbackRequest._(
          wasApplied: wasApplied,
          outcome: outcome,
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
