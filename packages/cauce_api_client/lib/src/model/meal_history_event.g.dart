// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_history_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MealHistoryEvent extends MealHistoryEvent {
  @override
  final MealHistoryItem? meal;
  @override
  final String eventType;
  @override
  final DateTime? occurredAt;

  factory _$MealHistoryEvent(
          [void Function(MealHistoryEventBuilder)? updates]) =>
      (MealHistoryEventBuilder()..update(updates))._build();

  _$MealHistoryEvent._({this.meal, required this.eventType, this.occurredAt})
      : super._();
  @override
  MealHistoryEvent rebuild(void Function(MealHistoryEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MealHistoryEventBuilder toBuilder() =>
      MealHistoryEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MealHistoryEvent &&
        meal == other.meal &&
        eventType == other.eventType &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, meal.hashCode);
    _$hash = $jc(_$hash, eventType.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MealHistoryEvent')
          ..add('meal', meal)
          ..add('eventType', eventType)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class MealHistoryEventBuilder
    implements
        Builder<MealHistoryEvent, MealHistoryEventBuilder>,
        HistoryEventBuilder {
  _$MealHistoryEvent? _$v;

  MealHistoryItemBuilder? _meal;
  MealHistoryItemBuilder get meal => _$this._meal ??= MealHistoryItemBuilder();
  set meal(covariant MealHistoryItemBuilder? meal) => _$this._meal = meal;

  String? _eventType;
  String? get eventType => _$this._eventType;
  set eventType(covariant String? eventType) => _$this._eventType = eventType;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(covariant DateTime? occurredAt) =>
      _$this._occurredAt = occurredAt;

  MealHistoryEventBuilder() {
    MealHistoryEvent._defaults(this);
  }

  MealHistoryEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _meal = $v.meal?.toBuilder();
      _eventType = $v.eventType;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant MealHistoryEvent other) {
    _$v = other as _$MealHistoryEvent;
  }

  @override
  void update(void Function(MealHistoryEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MealHistoryEvent build() => _build();

  _$MealHistoryEvent _build() {
    _$MealHistoryEvent _$result;
    try {
      _$result = _$v ??
          _$MealHistoryEvent._(
            meal: _meal?.build(),
            eventType: BuiltValueNullFieldError.checkNotNull(
                eventType, r'MealHistoryEvent', 'eventType'),
            occurredAt: occurredAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'meal';
        _meal?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MealHistoryEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
