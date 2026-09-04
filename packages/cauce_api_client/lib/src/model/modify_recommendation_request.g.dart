// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modify_recommendation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ModifyRecommendationRequest extends ModifyRecommendationRequest {
  @override
  final String? clinicalNote;
  @override
  final BuiltList<ModifyRecommendationItemInput>? items;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final BuiltList<String>? steps;

  factory _$ModifyRecommendationRequest(
          [void Function(ModifyRecommendationRequestBuilder)? updates]) =>
      (ModifyRecommendationRequestBuilder()..update(updates))._build();

  _$ModifyRecommendationRequest._(
      {this.clinicalNote, this.items, this.title, this.description, this.steps})
      : super._();
  @override
  ModifyRecommendationRequest rebuild(
          void Function(ModifyRecommendationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModifyRecommendationRequestBuilder toBuilder() =>
      ModifyRecommendationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModifyRecommendationRequest &&
        clinicalNote == other.clinicalNote &&
        items == other.items &&
        title == other.title &&
        description == other.description &&
        steps == other.steps;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clinicalNote.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, steps.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ModifyRecommendationRequest')
          ..add('clinicalNote', clinicalNote)
          ..add('items', items)
          ..add('title', title)
          ..add('description', description)
          ..add('steps', steps))
        .toString();
  }
}

class ModifyRecommendationRequestBuilder
    implements
        Builder<ModifyRecommendationRequest,
            ModifyRecommendationRequestBuilder> {
  _$ModifyRecommendationRequest? _$v;

  String? _clinicalNote;
  String? get clinicalNote => _$this._clinicalNote;
  set clinicalNote(String? clinicalNote) => _$this._clinicalNote = clinicalNote;

  ListBuilder<ModifyRecommendationItemInput>? _items;
  ListBuilder<ModifyRecommendationItemInput> get items =>
      _$this._items ??= ListBuilder<ModifyRecommendationItemInput>();
  set items(ListBuilder<ModifyRecommendationItemInput>? items) =>
      _$this._items = items;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _steps;
  ListBuilder<String> get steps => _$this._steps ??= ListBuilder<String>();
  set steps(ListBuilder<String>? steps) => _$this._steps = steps;

  ModifyRecommendationRequestBuilder() {
    ModifyRecommendationRequest._defaults(this);
  }

  ModifyRecommendationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clinicalNote = $v.clinicalNote;
      _items = $v.items?.toBuilder();
      _title = $v.title;
      _description = $v.description;
      _steps = $v.steps?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ModifyRecommendationRequest other) {
    _$v = other as _$ModifyRecommendationRequest;
  }

  @override
  void update(void Function(ModifyRecommendationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ModifyRecommendationRequest build() => _build();

  _$ModifyRecommendationRequest _build() {
    _$ModifyRecommendationRequest _$result;
    try {
      _$result = _$v ??
          _$ModifyRecommendationRequest._(
            clinicalNote: clinicalNote,
            items: _items?.build(),
            title: title,
            description: description,
            steps: _steps?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();

        _$failedField = 'steps';
        _steps?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ModifyRecommendationRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
