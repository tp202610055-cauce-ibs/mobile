// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_history_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MealHistoryItem extends MealHistoryItem {
  @override
  final String? mealId;
  @override
  final String? clientGuid;
  @override
  final MealTime? mealTime;
  @override
  final DateTime? consumedAt;
  @override
  final DateTime? clientCreatedAt;
  @override
  final SyncStatus? syncStatus;
  @override
  final BuiltList<MealItemSummary>? items;
  @override
  final FodmapLevel? aggregatedFodmap;

  factory _$MealHistoryItem([void Function(MealHistoryItemBuilder)? updates]) =>
      (MealHistoryItemBuilder()..update(updates))._build();

  _$MealHistoryItem._(
      {this.mealId,
      this.clientGuid,
      this.mealTime,
      this.consumedAt,
      this.clientCreatedAt,
      this.syncStatus,
      this.items,
      this.aggregatedFodmap})
      : super._();
  @override
  MealHistoryItem rebuild(void Function(MealHistoryItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MealHistoryItemBuilder toBuilder() => MealHistoryItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MealHistoryItem &&
        mealId == other.mealId &&
        clientGuid == other.clientGuid &&
        mealTime == other.mealTime &&
        consumedAt == other.consumedAt &&
        clientCreatedAt == other.clientCreatedAt &&
        syncStatus == other.syncStatus &&
        items == other.items &&
        aggregatedFodmap == other.aggregatedFodmap;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mealId.hashCode);
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, mealTime.hashCode);
    _$hash = $jc(_$hash, consumedAt.hashCode);
    _$hash = $jc(_$hash, clientCreatedAt.hashCode);
    _$hash = $jc(_$hash, syncStatus.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, aggregatedFodmap.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MealHistoryItem')
          ..add('mealId', mealId)
          ..add('clientGuid', clientGuid)
          ..add('mealTime', mealTime)
          ..add('consumedAt', consumedAt)
          ..add('clientCreatedAt', clientCreatedAt)
          ..add('syncStatus', syncStatus)
          ..add('items', items)
          ..add('aggregatedFodmap', aggregatedFodmap))
        .toString();
  }
}

class MealHistoryItemBuilder
    implements Builder<MealHistoryItem, MealHistoryItemBuilder> {
  _$MealHistoryItem? _$v;

  String? _mealId;
  String? get mealId => _$this._mealId;
  set mealId(String? mealId) => _$this._mealId = mealId;

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

  SyncStatus? _syncStatus;
  SyncStatus? get syncStatus => _$this._syncStatus;
  set syncStatus(SyncStatus? syncStatus) => _$this._syncStatus = syncStatus;

  ListBuilder<MealItemSummary>? _items;
  ListBuilder<MealItemSummary> get items =>
      _$this._items ??= ListBuilder<MealItemSummary>();
  set items(ListBuilder<MealItemSummary>? items) => _$this._items = items;

  FodmapLevel? _aggregatedFodmap;
  FodmapLevel? get aggregatedFodmap => _$this._aggregatedFodmap;
  set aggregatedFodmap(FodmapLevel? aggregatedFodmap) =>
      _$this._aggregatedFodmap = aggregatedFodmap;

  MealHistoryItemBuilder() {
    MealHistoryItem._defaults(this);
  }

  MealHistoryItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mealId = $v.mealId;
      _clientGuid = $v.clientGuid;
      _mealTime = $v.mealTime;
      _consumedAt = $v.consumedAt;
      _clientCreatedAt = $v.clientCreatedAt;
      _syncStatus = $v.syncStatus;
      _items = $v.items?.toBuilder();
      _aggregatedFodmap = $v.aggregatedFodmap;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MealHistoryItem other) {
    _$v = other as _$MealHistoryItem;
  }

  @override
  void update(void Function(MealHistoryItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MealHistoryItem build() => _build();

  _$MealHistoryItem _build() {
    _$MealHistoryItem _$result;
    try {
      _$result = _$v ??
          _$MealHistoryItem._(
            mealId: mealId,
            clientGuid: clientGuid,
            mealTime: mealTime,
            consumedAt: consumedAt,
            clientCreatedAt: clientCreatedAt,
            syncStatus: syncStatus,
            items: _items?.build(),
            aggregatedFodmap: aggregatedFodmap,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MealHistoryItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
