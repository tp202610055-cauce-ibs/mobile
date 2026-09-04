// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HistoryEvent extends HistoryEvent {
  @override
  final DateTime? occurredAt;

  factory _$HistoryEvent([void Function(HistoryEventBuilder)? updates]) =>
      (HistoryEventBuilder()..update(updates))._build();

  _$HistoryEvent._({this.occurredAt}) : super._();
  @override
  HistoryEvent rebuild(void Function(HistoryEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HistoryEventBuilder toBuilder() => HistoryEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistoryEvent && occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HistoryEvent')
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class HistoryEventBuilder
    implements Builder<HistoryEvent, HistoryEventBuilder> {
  _$HistoryEvent? _$v;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  HistoryEventBuilder() {
    HistoryEvent._defaults(this);
  }

  HistoryEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HistoryEvent other) {
    _$v = other as _$HistoryEvent;
  }

  @override
  void update(void Function(HistoryEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HistoryEvent build() => _build();

  _$HistoryEvent _build() {
    final _$result = _$v ??
        _$HistoryEvent._(
          occurredAt: occurredAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
