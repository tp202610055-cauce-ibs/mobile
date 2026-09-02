// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_note_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClinicalNoteSummary extends ClinicalNoteSummary {
  @override
  final String? noteId;
  @override
  final String? mealId;
  @override
  final String? symptomId;
  @override
  final String? content;
  @override
  final DateTime? createdAt;

  factory _$ClinicalNoteSummary(
          [void Function(ClinicalNoteSummaryBuilder)? updates]) =>
      (ClinicalNoteSummaryBuilder()..update(updates))._build();

  _$ClinicalNoteSummary._(
      {this.noteId, this.mealId, this.symptomId, this.content, this.createdAt})
      : super._();
  @override
  ClinicalNoteSummary rebuild(
          void Function(ClinicalNoteSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClinicalNoteSummaryBuilder toBuilder() =>
      ClinicalNoteSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClinicalNoteSummary &&
        noteId == other.noteId &&
        mealId == other.mealId &&
        symptomId == other.symptomId &&
        content == other.content &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, noteId.hashCode);
    _$hash = $jc(_$hash, mealId.hashCode);
    _$hash = $jc(_$hash, symptomId.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClinicalNoteSummary')
          ..add('noteId', noteId)
          ..add('mealId', mealId)
          ..add('symptomId', symptomId)
          ..add('content', content)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ClinicalNoteSummaryBuilder
    implements Builder<ClinicalNoteSummary, ClinicalNoteSummaryBuilder> {
  _$ClinicalNoteSummary? _$v;

  String? _noteId;
  String? get noteId => _$this._noteId;
  set noteId(String? noteId) => _$this._noteId = noteId;

  String? _mealId;
  String? get mealId => _$this._mealId;
  set mealId(String? mealId) => _$this._mealId = mealId;

  String? _symptomId;
  String? get symptomId => _$this._symptomId;
  set symptomId(String? symptomId) => _$this._symptomId = symptomId;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ClinicalNoteSummaryBuilder() {
    ClinicalNoteSummary._defaults(this);
  }

  ClinicalNoteSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _noteId = $v.noteId;
      _mealId = $v.mealId;
      _symptomId = $v.symptomId;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClinicalNoteSummary other) {
    _$v = other as _$ClinicalNoteSummary;
  }

  @override
  void update(void Function(ClinicalNoteSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClinicalNoteSummary build() => _build();

  _$ClinicalNoteSummary _build() {
    final _$result = _$v ??
        _$ClinicalNoteSummary._(
          noteId: noteId,
          mealId: mealId,
          symptomId: symptomId,
          content: content,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
