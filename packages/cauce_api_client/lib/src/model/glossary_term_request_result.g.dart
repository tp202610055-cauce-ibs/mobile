// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_term_request_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GlossaryTermRequestResult extends GlossaryTermRequestResult {
  @override
  final String? id;
  @override
  final String? term;
  @override
  final GlossaryTermRequestStatus? status;
  @override
  final DateTime? requestedAt;

  factory _$GlossaryTermRequestResult(
          [void Function(GlossaryTermRequestResultBuilder)? updates]) =>
      (GlossaryTermRequestResultBuilder()..update(updates))._build();

  _$GlossaryTermRequestResult._(
      {this.id, this.term, this.status, this.requestedAt})
      : super._();
  @override
  GlossaryTermRequestResult rebuild(
          void Function(GlossaryTermRequestResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlossaryTermRequestResultBuilder toBuilder() =>
      GlossaryTermRequestResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlossaryTermRequestResult &&
        id == other.id &&
        term == other.term &&
        status == other.status &&
        requestedAt == other.requestedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, term.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GlossaryTermRequestResult')
          ..add('id', id)
          ..add('term', term)
          ..add('status', status)
          ..add('requestedAt', requestedAt))
        .toString();
  }
}

class GlossaryTermRequestResultBuilder
    implements
        Builder<GlossaryTermRequestResult, GlossaryTermRequestResultBuilder> {
  _$GlossaryTermRequestResult? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _term;
  String? get term => _$this._term;
  set term(String? term) => _$this._term = term;

  GlossaryTermRequestStatus? _status;
  GlossaryTermRequestStatus? get status => _$this._status;
  set status(GlossaryTermRequestStatus? status) => _$this._status = status;

  DateTime? _requestedAt;
  DateTime? get requestedAt => _$this._requestedAt;
  set requestedAt(DateTime? requestedAt) => _$this._requestedAt = requestedAt;

  GlossaryTermRequestResultBuilder() {
    GlossaryTermRequestResult._defaults(this);
  }

  GlossaryTermRequestResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _term = $v.term;
      _status = $v.status;
      _requestedAt = $v.requestedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlossaryTermRequestResult other) {
    _$v = other as _$GlossaryTermRequestResult;
  }

  @override
  void update(void Function(GlossaryTermRequestResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GlossaryTermRequestResult build() => _build();

  _$GlossaryTermRequestResult _build() {
    final _$result = _$v ??
        _$GlossaryTermRequestResult._(
          id: id,
          term: term,
          status: status,
          requestedAt: requestedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
