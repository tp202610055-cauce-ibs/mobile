// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_history_item_paged_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MealHistoryItemPagedResult extends MealHistoryItemPagedResult {
  @override
  final BuiltList<MealHistoryItem>? items;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? totalCount;

  factory _$MealHistoryItemPagedResult(
          [void Function(MealHistoryItemPagedResultBuilder)? updates]) =>
      (MealHistoryItemPagedResultBuilder()..update(updates))._build();

  _$MealHistoryItemPagedResult._(
      {this.items, this.page, this.pageSize, this.totalCount})
      : super._();
  @override
  MealHistoryItemPagedResult rebuild(
          void Function(MealHistoryItemPagedResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MealHistoryItemPagedResultBuilder toBuilder() =>
      MealHistoryItemPagedResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MealHistoryItemPagedResult &&
        items == other.items &&
        page == other.page &&
        pageSize == other.pageSize &&
        totalCount == other.totalCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MealHistoryItemPagedResult')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class MealHistoryItemPagedResultBuilder
    implements
        Builder<MealHistoryItemPagedResult, MealHistoryItemPagedResultBuilder> {
  _$MealHistoryItemPagedResult? _$v;

  ListBuilder<MealHistoryItem>? _items;
  ListBuilder<MealHistoryItem> get items =>
      _$this._items ??= ListBuilder<MealHistoryItem>();
  set items(ListBuilder<MealHistoryItem>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  MealHistoryItemPagedResultBuilder() {
    MealHistoryItemPagedResult._defaults(this);
  }

  MealHistoryItemPagedResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _page = $v.page;
      _pageSize = $v.pageSize;
      _totalCount = $v.totalCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MealHistoryItemPagedResult other) {
    _$v = other as _$MealHistoryItemPagedResult;
  }

  @override
  void update(void Function(MealHistoryItemPagedResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MealHistoryItemPagedResult build() => _build();

  _$MealHistoryItemPagedResult _build() {
    _$MealHistoryItemPagedResult _$result;
    try {
      _$result = _$v ??
          _$MealHistoryItemPagedResult._(
            items: _items?.build(),
            page: page,
            pageSize: pageSize,
            totalCount: totalCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MealHistoryItemPagedResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
