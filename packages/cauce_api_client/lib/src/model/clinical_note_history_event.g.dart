// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_note_history_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClinicalNoteHistoryEvent extends ClinicalNoteHistoryEvent {
  @override
  final ClinicalNoteSummary? note;
  @override
  final String eventType;
  @override
  final DateTime? occurredAt;

  factory _$ClinicalNoteHistoryEvent(
          [void Function(ClinicalNoteHistoryEventBuilder)? updates]) =>
      (ClinicalNoteHistoryEventBuilder()..update(updates))._build();

  _$ClinicalNoteHistoryEvent._(
      {this.note, required this.eventType, this.occurredAt})
      : super._();
  @override
  ClinicalNoteHistoryEvent rebuild(
          void Function(ClinicalNoteHistoryEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClinicalNoteHistoryEventBuilder toBuilder() =>
      ClinicalNoteHistoryEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClinicalNoteHistoryEvent &&
        note == other.note &&
        eventType == other.eventType &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, eventType.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClinicalNoteHistoryEvent')
          ..add('note', note)
          ..add('eventType', eventType)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class ClinicalNoteHistoryEventBuilder
    implements
        Builder<ClinicalNoteHistoryEvent, ClinicalNoteHistoryEventBuilder>,
        HistoryEventBuilder {
  _$ClinicalNoteHistoryEvent? _$v;

  ClinicalNoteSummaryBuilder? _note;
  ClinicalNoteSummaryBuilder get note =>
      _$this._note ??= ClinicalNoteSummaryBuilder();
  set note(covariant ClinicalNoteSummaryBuilder? note) => _$this._note = note;

  String? _eventType;
  String? get eventType => _$this._eventType;
  set eventType(covariant String? eventType) => _$this._eventType = eventType;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(covariant DateTime? occurredAt) =>
      _$this._occurredAt = occurredAt;

  ClinicalNoteHistoryEventBuilder() {
    ClinicalNoteHistoryEvent._defaults(this);
  }

  ClinicalNoteHistoryEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _note = $v.note?.toBuilder();
      _eventType = $v.eventType;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant ClinicalNoteHistoryEvent other) {
    _$v = other as _$ClinicalNoteHistoryEvent;
  }

  @override
  void update(void Function(ClinicalNoteHistoryEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClinicalNoteHistoryEvent build() => _build();

  _$ClinicalNoteHistoryEvent _build() {
    _$ClinicalNoteHistoryEvent _$result;
    try {
      _$result = _$v ??
          _$ClinicalNoteHistoryEvent._(
            note: _note?.build(),
            eventType: BuiltValueNullFieldError.checkNotNull(
                eventType, r'ClinicalNoteHistoryEvent', 'eventType'),
            occurredAt: occurredAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'note';
        _note?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ClinicalNoteHistoryEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
