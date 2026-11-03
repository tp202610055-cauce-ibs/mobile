// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_glossary_term_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RequestGlossaryTermRequest extends RequestGlossaryTermRequest {
  @override
  final String? term;

  factory _$RequestGlossaryTermRequest(
          [void Function(RequestGlossaryTermRequestBuilder)? updates]) =>
      (RequestGlossaryTermRequestBuilder()..update(updates))._build();

  _$RequestGlossaryTermRequest._({this.term}) : super._();
  @override
  RequestGlossaryTermRequest rebuild(
          void Function(RequestGlossaryTermRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RequestGlossaryTermRequestBuilder toBuilder() =>
      RequestGlossaryTermRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestGlossaryTermRequest && term == other.term;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, term.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RequestGlossaryTermRequest')
          ..add('term', term))
        .toString();
  }
}

class RequestGlossaryTermRequestBuilder
    implements
        Builder<RequestGlossaryTermRequest, RequestGlossaryTermRequestBuilder> {
  _$RequestGlossaryTermRequest? _$v;

  String? _term;
  String? get term => _$this._term;
  set term(String? term) => _$this._term = term;

  RequestGlossaryTermRequestBuilder() {
    RequestGlossaryTermRequest._defaults(this);
  }

  RequestGlossaryTermRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _term = $v.term;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestGlossaryTermRequest other) {
    _$v = other as _$RequestGlossaryTermRequest;
  }

  @override
  void update(void Function(RequestGlossaryTermRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestGlossaryTermRequest build() => _build();

  _$RequestGlossaryTermRequest _build() {
    final _$result = _$v ??
        _$RequestGlossaryTermRequest._(
          term: term,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
