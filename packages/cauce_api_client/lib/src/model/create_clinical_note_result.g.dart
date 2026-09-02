// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_clinical_note_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateClinicalNoteResult extends CreateClinicalNoteResult {
  @override
  final String? noteId;

  factory _$CreateClinicalNoteResult(
          [void Function(CreateClinicalNoteResultBuilder)? updates]) =>
      (CreateClinicalNoteResultBuilder()..update(updates))._build();

  _$CreateClinicalNoteResult._({this.noteId}) : super._();
  @override
  CreateClinicalNoteResult rebuild(
          void Function(CreateClinicalNoteResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateClinicalNoteResultBuilder toBuilder() =>
      CreateClinicalNoteResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateClinicalNoteResult && noteId == other.noteId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, noteId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateClinicalNoteResult')
          ..add('noteId', noteId))
        .toString();
  }
}

class CreateClinicalNoteResultBuilder
    implements
        Builder<CreateClinicalNoteResult, CreateClinicalNoteResultBuilder> {
  _$CreateClinicalNoteResult? _$v;

  String? _noteId;
  String? get noteId => _$this._noteId;
  set noteId(String? noteId) => _$this._noteId = noteId;

  CreateClinicalNoteResultBuilder() {
    CreateClinicalNoteResult._defaults(this);
  }

  CreateClinicalNoteResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _noteId = $v.noteId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateClinicalNoteResult other) {
    _$v = other as _$CreateClinicalNoteResult;
  }

  @override
  void update(void Function(CreateClinicalNoteResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateClinicalNoteResult build() => _build();

  _$CreateClinicalNoteResult _build() {
    final _$result = _$v ??
        _$CreateClinicalNoteResult._(
          noteId: noteId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
