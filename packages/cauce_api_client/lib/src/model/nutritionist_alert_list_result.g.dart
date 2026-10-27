// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_alert_list_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NutritionistAlertListResult extends NutritionistAlertListResult {
  @override
  final BuiltList<NutritionistAlertDto>? items;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? totalCount;
  @override
  final int? unreadCount;

  factory _$NutritionistAlertListResult(
          [void Function(NutritionistAlertListResultBuilder)? updates]) =>
      (NutritionistAlertListResultBuilder()..update(updates))._build();

  _$NutritionistAlertListResult._(
      {this.items, this.page, this.pageSize, this.totalCount, this.unreadCount})
      : super._();
  @override
  NutritionistAlertListResult rebuild(
          void Function(NutritionistAlertListResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NutritionistAlertListResultBuilder toBuilder() =>
      NutritionistAlertListResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NutritionistAlertListResult &&
        items == other.items &&
        page == other.page &&
        pageSize == other.pageSize &&
        totalCount == other.totalCount &&
        unreadCount == other.unreadCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NutritionistAlertListResult')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('totalCount', totalCount)
          ..add('unreadCount', unreadCount))
        .toString();
  }
}

class NutritionistAlertListResultBuilder
    implements
        Builder<NutritionistAlertListResult,
            NutritionistAlertListResultBuilder> {
  _$NutritionistAlertListResult? _$v;

  ListBuilder<NutritionistAlertDto>? _items;
  ListBuilder<NutritionistAlertDto> get items =>
      _$this._items ??= ListBuilder<NutritionistAlertDto>();
  set items(ListBuilder<NutritionistAlertDto>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  NutritionistAlertListResultBuilder() {
    NutritionistAlertListResult._defaults(this);
  }

  NutritionistAlertListResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _page = $v.page;
      _pageSize = $v.pageSize;
      _totalCount = $v.totalCount;
      _unreadCount = $v.unreadCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NutritionistAlertListResult other) {
    _$v = other as _$NutritionistAlertListResult;
  }

  @override
  void update(void Function(NutritionistAlertListResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NutritionistAlertListResult build() => _build();

  _$NutritionistAlertListResult _build() {
    _$NutritionistAlertListResult _$result;
    try {
      _$result = _$v ??
          _$NutritionistAlertListResult._(
            items: _items?.build(),
            page: page,
            pageSize: pageSize,
            totalCount: totalCount,
            unreadCount: unreadCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'NutritionistAlertListResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
