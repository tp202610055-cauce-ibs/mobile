// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_term_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GlossaryTermDto extends GlossaryTermDto {
  @override
  final String? term;
  @override
  final String? definition;
  @override
  final GlossaryCategory? category;

  factory _$GlossaryTermDto([void Function(GlossaryTermDtoBuilder)? updates]) =>
      (GlossaryTermDtoBuilder()..update(updates))._build();

  _$GlossaryTermDto._({this.term, this.definition, this.category}) : super._();
  @override
  GlossaryTermDto rebuild(void Function(GlossaryTermDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlossaryTermDtoBuilder toBuilder() => GlossaryTermDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlossaryTermDto &&
        term == other.term &&
        definition == other.definition &&
        category == other.category;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, term.hashCode);
    _$hash = $jc(_$hash, definition.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GlossaryTermDto')
          ..add('term', term)
          ..add('definition', definition)
          ..add('category', category))
        .toString();
  }
}

class GlossaryTermDtoBuilder
    implements Builder<GlossaryTermDto, GlossaryTermDtoBuilder> {
  _$GlossaryTermDto? _$v;

  String? _term;
  String? get term => _$this._term;
  set term(String? term) => _$this._term = term;

  String? _definition;
  String? get definition => _$this._definition;
  set definition(String? definition) => _$this._definition = definition;

  GlossaryCategory? _category;
  GlossaryCategory? get category => _$this._category;
  set category(GlossaryCategory? category) => _$this._category = category;

  GlossaryTermDtoBuilder() {
    GlossaryTermDto._defaults(this);
  }

  GlossaryTermDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _term = $v.term;
      _definition = $v.definition;
      _category = $v.category;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlossaryTermDto other) {
    _$v = other as _$GlossaryTermDto;
  }

  @override
  void update(void Function(GlossaryTermDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GlossaryTermDto build() => _build();

  _$GlossaryTermDto _build() {
    final _$result = _$v ??
        _$GlossaryTermDto._(
          term: term,
          definition: definition,
          category: category,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
