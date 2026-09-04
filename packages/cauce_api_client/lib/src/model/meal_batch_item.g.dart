// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_batch_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MealBatchItem extends MealBatchItem {
  @override
  final String? clientGuid;
  @override
  final MealTime? mealTime;
  @override
  final DateTime? consumedAt;
  @override
  final DateTime? clientCreatedAt;
  @override
  final BuiltList<MealItemRequest>? items;

  factory _$MealBatchItem([void Function(MealBatchItemBuilder)? updates]) =>
      (MealBatchItemBuilder()..update(updates))._build();

  _$MealBatchItem._(
      {this.clientGuid,
      this.mealTime,
      this.consumedAt,
      this.clientCreatedAt,
      this.items})
      : super._();
  @override
  MealBatchItem rebuild(void Function(MealBatchItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MealBatchItemBuilder toBuilder() => MealBatchItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MealBatchItem &&
        clientGuid == other.clientGuid &&
        mealTime == other.mealTime &&
        consumedAt == other.consumedAt &&
        clientCreatedAt == other.clientCreatedAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, mealTime.hashCode);
    _$hash = $jc(_$hash, consumedAt.hashCode);
    _$hash = $jc(_$hash, clientCreatedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MealBatchItem')
          ..add('clientGuid', clientGuid)
          ..add('mealTime', mealTime)
          ..add('consumedAt', consumedAt)
          ..add('clientCreatedAt', clientCreatedAt)
          ..add('items', items))
        .toString();
  }
}

class MealBatchItemBuilder
    implements Builder<MealBatchItem, MealBatchItemBuilder> {
  _$MealBatchItem? _$v;

  String? _clientGuid;
  String? get clientGuid => _$this._clientGuid;
  set clientGuid(String? clientGuid) => _$this._clientGuid = clientGuid;

  MealTime? _mealTime;
  MealTime? get mealTime => _$this._mealTime;
  set mealTime(MealTime? mealTime) => _$this._mealTime = mealTime;

  DateTime? _consumedAt;
  DateTime? get consumedAt => _$this._consumedAt;
  set consumedAt(DateTime? consumedAt) => _$this._consumedAt = consumedAt;

  DateTime? _clientCreatedAt;
  DateTime? get clientCreatedAt => _$this._clientCreatedAt;
  set clientCreatedAt(DateTime? clientCreatedAt) =>
      _$this._clientCreatedAt = clientCreatedAt;

  ListBuilder<MealItemRequest>? _items;
  ListBuilder<MealItemRequest> get items =>
      _$this._items ??= ListBuilder<MealItemRequest>();
  set items(ListBuilder<MealItemRequest>? items) => _$this._items = items;

  MealBatchItemBuilder() {
    MealBatchItem._defaults(this);
  }

  MealBatchItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientGuid = $v.clientGuid;
      _mealTime = $v.mealTime;
      _consumedAt = $v.consumedAt;
      _clientCreatedAt = $v.clientCreatedAt;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MealBatchItem other) {
    _$v = other as _$MealBatchItem;
  }

  @override
  void update(void Function(MealBatchItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MealBatchItem build() => _build();

  _$MealBatchItem _build() {
    _$MealBatchItem _$result;
    try {
      _$result = _$v ??
          _$MealBatchItem._(
            clientGuid: clientGuid,
            mealTime: mealTime,
            consumedAt: consumedAt,
            clientCreatedAt: clientCreatedAt,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MealBatchItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
