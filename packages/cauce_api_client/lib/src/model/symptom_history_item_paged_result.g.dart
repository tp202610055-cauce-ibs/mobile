// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_history_item_paged_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SymptomHistoryItemPagedResult extends SymptomHistoryItemPagedResult {
  @override
  final BuiltList<SymptomHistoryItem>? items;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? totalCount;

  factory _$SymptomHistoryItemPagedResult(
          [void Function(SymptomHistoryItemPagedResultBuilder)? updates]) =>
      (SymptomHistoryItemPagedResultBuilder()..update(updates))._build();

  _$SymptomHistoryItemPagedResult._(
      {this.items, this.page, this.pageSize, this.totalCount})
      : super._();
  @override
  SymptomHistoryItemPagedResult rebuild(
          void Function(SymptomHistoryItemPagedResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SymptomHistoryItemPagedResultBuilder toBuilder() =>
      SymptomHistoryItemPagedResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SymptomHistoryItemPagedResult &&
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
    return (newBuiltValueToStringHelper(r'SymptomHistoryItemPagedResult')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class SymptomHistoryItemPagedResultBuilder
    implements
        Builder<SymptomHistoryItemPagedResult,
            SymptomHistoryItemPagedResultBuilder> {
  _$SymptomHistoryItemPagedResult? _$v;

  ListBuilder<SymptomHistoryItem>? _items;
  ListBuilder<SymptomHistoryItem> get items =>
      _$this._items ??= ListBuilder<SymptomHistoryItem>();
  set items(ListBuilder<SymptomHistoryItem>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  SymptomHistoryItemPagedResultBuilder() {
    SymptomHistoryItemPagedResult._defaults(this);
  }

  SymptomHistoryItemPagedResultBuilder get _$this {
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
  void replace(SymptomHistoryItemPagedResult other) {
    _$v = other as _$SymptomHistoryItemPagedResult;
  }

  @override
  void update(void Function(SymptomHistoryItemPagedResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SymptomHistoryItemPagedResult build() => _build();

  _$SymptomHistoryItemPagedResult _build() {
    _$SymptomHistoryItemPagedResult _$result;
    try {
      _$result = _$v ??
          _$SymptomHistoryItemPagedResult._(
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
            r'SymptomHistoryItemPagedResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
