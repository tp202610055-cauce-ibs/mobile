// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_history_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SymptomHistoryEvent extends SymptomHistoryEvent {
  @override
  final SymptomHistoryItem? symptom;
  @override
  final String eventType;
  @override
  final DateTime? occurredAt;

  factory _$SymptomHistoryEvent(
          [void Function(SymptomHistoryEventBuilder)? updates]) =>
      (SymptomHistoryEventBuilder()..update(updates))._build();

  _$SymptomHistoryEvent._(
      {this.symptom, required this.eventType, this.occurredAt})
      : super._();
  @override
  SymptomHistoryEvent rebuild(
          void Function(SymptomHistoryEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SymptomHistoryEventBuilder toBuilder() =>
      SymptomHistoryEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SymptomHistoryEvent &&
        symptom == other.symptom &&
        eventType == other.eventType &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symptom.hashCode);
    _$hash = $jc(_$hash, eventType.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SymptomHistoryEvent')
          ..add('symptom', symptom)
          ..add('eventType', eventType)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class SymptomHistoryEventBuilder
    implements
        Builder<SymptomHistoryEvent, SymptomHistoryEventBuilder>,
        HistoryEventBuilder {
  _$SymptomHistoryEvent? _$v;

  SymptomHistoryItemBuilder? _symptom;
  SymptomHistoryItemBuilder get symptom =>
      _$this._symptom ??= SymptomHistoryItemBuilder();
  set symptom(covariant SymptomHistoryItemBuilder? symptom) =>
      _$this._symptom = symptom;

  String? _eventType;
  String? get eventType => _$this._eventType;
  set eventType(covariant String? eventType) => _$this._eventType = eventType;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(covariant DateTime? occurredAt) =>
      _$this._occurredAt = occurredAt;

  SymptomHistoryEventBuilder() {
    SymptomHistoryEvent._defaults(this);
  }

  SymptomHistoryEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symptom = $v.symptom?.toBuilder();
      _eventType = $v.eventType;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SymptomHistoryEvent other) {
    _$v = other as _$SymptomHistoryEvent;
  }

  @override
  void update(void Function(SymptomHistoryEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SymptomHistoryEvent build() => _build();

  _$SymptomHistoryEvent _build() {
    _$SymptomHistoryEvent _$result;
    try {
      _$result = _$v ??
          _$SymptomHistoryEvent._(
            symptom: _symptom?.build(),
            eventType: BuiltValueNullFieldError.checkNotNull(
                eventType, r'SymptomHistoryEvent', 'eventType'),
            occurredAt: occurredAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'symptom';
        _symptom?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SymptomHistoryEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
