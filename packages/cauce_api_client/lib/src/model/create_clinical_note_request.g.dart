// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_clinical_note_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateClinicalNoteRequest extends CreateClinicalNoteRequest {
  @override
  final String? mealId;
  @override
  final String? symptomId;
  @override
  final String? content;

  factory _$CreateClinicalNoteRequest(
          [void Function(CreateClinicalNoteRequestBuilder)? updates]) =>
      (CreateClinicalNoteRequestBuilder()..update(updates))._build();

  _$CreateClinicalNoteRequest._({this.mealId, this.symptomId, this.content})
      : super._();
  @override
  CreateClinicalNoteRequest rebuild(
          void Function(CreateClinicalNoteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateClinicalNoteRequestBuilder toBuilder() =>
      CreateClinicalNoteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateClinicalNoteRequest &&
        mealId == other.mealId &&
        symptomId == other.symptomId &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mealId.hashCode);
    _$hash = $jc(_$hash, symptomId.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateClinicalNoteRequest')
          ..add('mealId', mealId)
          ..add('symptomId', symptomId)
          ..add('content', content))
        .toString();
  }
}

class CreateClinicalNoteRequestBuilder
    implements
        Builder<CreateClinicalNoteRequest, CreateClinicalNoteRequestBuilder> {
  _$CreateClinicalNoteRequest? _$v;

  String? _mealId;
  String? get mealId => _$this._mealId;
  set mealId(String? mealId) => _$this._mealId = mealId;

  String? _symptomId;
  String? get symptomId => _$this._symptomId;
  set symptomId(String? symptomId) => _$this._symptomId = symptomId;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  CreateClinicalNoteRequestBuilder() {
    CreateClinicalNoteRequest._defaults(this);
  }

  CreateClinicalNoteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mealId = $v.mealId;
      _symptomId = $v.symptomId;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateClinicalNoteRequest other) {
    _$v = other as _$CreateClinicalNoteRequest;
  }

  @override
  void update(void Function(CreateClinicalNoteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateClinicalNoteRequest build() => _build();

  _$CreateClinicalNoteRequest _build() {
    final _$result = _$v ??
        _$CreateClinicalNoteRequest._(
          mealId: mealId,
          symptomId: symptomId,
          content: content,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
