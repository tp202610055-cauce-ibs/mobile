// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_summary_paged_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FoodItemSummaryPagedResult extends FoodItemSummaryPagedResult {
  @override
  final BuiltList<FoodItemSummary>? items;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? totalCount;

  factory _$FoodItemSummaryPagedResult(
          [void Function(FoodItemSummaryPagedResultBuilder)? updates]) =>
      (FoodItemSummaryPagedResultBuilder()..update(updates))._build();

  _$FoodItemSummaryPagedResult._(
      {this.items, this.page, this.pageSize, this.totalCount})
      : super._();
  @override
  FoodItemSummaryPagedResult rebuild(
          void Function(FoodItemSummaryPagedResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FoodItemSummaryPagedResultBuilder toBuilder() =>
      FoodItemSummaryPagedResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FoodItemSummaryPagedResult &&
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
    return (newBuiltValueToStringHelper(r'FoodItemSummaryPagedResult')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class FoodItemSummaryPagedResultBuilder
    implements
        Builder<FoodItemSummaryPagedResult, FoodItemSummaryPagedResultBuilder> {
  _$FoodItemSummaryPagedResult? _$v;

  ListBuilder<FoodItemSummary>? _items;
  ListBuilder<FoodItemSummary> get items =>
      _$this._items ??= ListBuilder<FoodItemSummary>();
  set items(ListBuilder<FoodItemSummary>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  FoodItemSummaryPagedResultBuilder() {
    FoodItemSummaryPagedResult._defaults(this);
  }

  FoodItemSummaryPagedResultBuilder get _$this {
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
  void replace(FoodItemSummaryPagedResult other) {
    _$v = other as _$FoodItemSummaryPagedResult;
  }

  @override
  void update(void Function(FoodItemSummaryPagedResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FoodItemSummaryPagedResult build() => _build();

  _$FoodItemSummaryPagedResult _build() {
    _$FoodItemSummaryPagedResult _$result;
    try {
      _$result = _$v ??
          _$FoodItemSummaryPagedResult._(
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
            r'FoodItemSummaryPagedResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
