// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_recommendation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApproveRecommendationRequest extends ApproveRecommendationRequest {
  @override
  final String? note;

  factory _$ApproveRecommendationRequest(
          [void Function(ApproveRecommendationRequestBuilder)? updates]) =>
      (ApproveRecommendationRequestBuilder()..update(updates))._build();

  _$ApproveRecommendationRequest._({this.note}) : super._();
  @override
  ApproveRecommendationRequest rebuild(
          void Function(ApproveRecommendationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApproveRecommendationRequestBuilder toBuilder() =>
      ApproveRecommendationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApproveRecommendationRequest && note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApproveRecommendationRequest')
          ..add('note', note))
        .toString();
  }
}

class ApproveRecommendationRequestBuilder
    implements
        Builder<ApproveRecommendationRequest,
            ApproveRecommendationRequestBuilder> {
  _$ApproveRecommendationRequest? _$v;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  ApproveRecommendationRequestBuilder() {
    ApproveRecommendationRequest._defaults(this);
  }

  ApproveRecommendationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApproveRecommendationRequest other) {
    _$v = other as _$ApproveRecommendationRequest;
  }

  @override
  void update(void Function(ApproveRecommendationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApproveRecommendationRequest build() => _build();

  _$ApproveRecommendationRequest _build() {
    final _$result = _$v ??
        _$ApproveRecommendationRequest._(
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
