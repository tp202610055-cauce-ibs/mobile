// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GlossaryResult extends GlossaryResult {
  @override
  final BuiltList<GlossaryTermDto>? terms;
  @override
  final String? contentStatus;

  factory _$GlossaryResult([void Function(GlossaryResultBuilder)? updates]) =>
      (GlossaryResultBuilder()..update(updates))._build();

  _$GlossaryResult._({this.terms, this.contentStatus}) : super._();
  @override
  GlossaryResult rebuild(void Function(GlossaryResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlossaryResultBuilder toBuilder() => GlossaryResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlossaryResult &&
        terms == other.terms &&
        contentStatus == other.contentStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, terms.hashCode);
    _$hash = $jc(_$hash, contentStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GlossaryResult')
          ..add('terms', terms)
          ..add('contentStatus', contentStatus))
        .toString();
  }
}

class GlossaryResultBuilder
    implements Builder<GlossaryResult, GlossaryResultBuilder> {
  _$GlossaryResult? _$v;

  ListBuilder<GlossaryTermDto>? _terms;
  ListBuilder<GlossaryTermDto> get terms =>
      _$this._terms ??= ListBuilder<GlossaryTermDto>();
  set terms(ListBuilder<GlossaryTermDto>? terms) => _$this._terms = terms;

  String? _contentStatus;
  String? get contentStatus => _$this._contentStatus;
  set contentStatus(String? contentStatus) =>
      _$this._contentStatus = contentStatus;

  GlossaryResultBuilder() {
    GlossaryResult._defaults(this);
  }

  GlossaryResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _terms = $v.terms?.toBuilder();
      _contentStatus = $v.contentStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlossaryResult other) {
    _$v = other as _$GlossaryResult;
  }

  @override
  void update(void Function(GlossaryResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GlossaryResult build() => _build();

  _$GlossaryResult _build() {
    _$GlossaryResult _$result;
    try {
      _$result = _$v ??
          _$GlossaryResult._(
            terms: _terms?.build(),
            contentStatus: contentStatus,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'terms';
        _terms?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GlossaryResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
