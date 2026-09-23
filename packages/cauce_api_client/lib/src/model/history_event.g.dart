// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class HistoryEventBuilder {
  void replace(HistoryEvent other);
  void update(void Function(HistoryEventBuilder) updates);
  String? get eventType;
  set eventType(String? eventType);

  DateTime? get occurredAt;
  set occurredAt(DateTime? occurredAt);
}

class _$$HistoryEvent extends $HistoryEvent {
  @override
  final String eventType;
  @override
  final DateTime? occurredAt;

  factory _$$HistoryEvent([void Function($HistoryEventBuilder)? updates]) =>
      ($HistoryEventBuilder()..update(updates))._build();

  _$$HistoryEvent._({required this.eventType, this.occurredAt}) : super._();
  @override
  $HistoryEvent rebuild(void Function($HistoryEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $HistoryEventBuilder toBuilder() => $HistoryEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $HistoryEvent &&
        eventType == other.eventType &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, eventType.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$HistoryEvent')
          ..add('eventType', eventType)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class $HistoryEventBuilder
    implements
        Builder<$HistoryEvent, $HistoryEventBuilder>,
        HistoryEventBuilder {
  _$$HistoryEvent? _$v;

  String? _eventType;
  String? get eventType => _$this._eventType;
  set eventType(covariant String? eventType) => _$this._eventType = eventType;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(covariant DateTime? occurredAt) =>
      _$this._occurredAt = occurredAt;

  $HistoryEventBuilder() {
    $HistoryEvent._defaults(this);
  }

  $HistoryEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _eventType = $v.eventType;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $HistoryEvent other) {
    _$v = other as _$$HistoryEvent;
  }

  @override
  void update(void Function($HistoryEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $HistoryEvent build() => _build();

  _$$HistoryEvent _build() {
    final _$result = _$v ??
        _$$HistoryEvent._(
          eventType: BuiltValueNullFieldError.checkNotNull(
              eventType, r'$HistoryEvent', 'eventType'),
          occurredAt: occurredAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
