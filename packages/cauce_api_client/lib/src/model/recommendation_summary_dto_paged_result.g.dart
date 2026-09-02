// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_summary_dto_paged_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationSummaryDtoPagedResult
    extends RecommendationSummaryDtoPagedResult {
  @override
  final BuiltList<RecommendationSummaryDto>? items;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? totalCount;

  factory _$RecommendationSummaryDtoPagedResult(
          [void Function(RecommendationSummaryDtoPagedResultBuilder)?
              updates]) =>
      (RecommendationSummaryDtoPagedResultBuilder()..update(updates))._build();

  _$RecommendationSummaryDtoPagedResult._(
      {this.items, this.page, this.pageSize, this.totalCount})
      : super._();
  @override
  RecommendationSummaryDtoPagedResult rebuild(
          void Function(RecommendationSummaryDtoPagedResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationSummaryDtoPagedResultBuilder toBuilder() =>
      RecommendationSummaryDtoPagedResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationSummaryDtoPagedResult &&
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
    return (newBuiltValueToStringHelper(r'RecommendationSummaryDtoPagedResult')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class RecommendationSummaryDtoPagedResultBuilder
    implements
        Builder<RecommendationSummaryDtoPagedResult,
            RecommendationSummaryDtoPagedResultBuilder> {
  _$RecommendationSummaryDtoPagedResult? _$v;

  ListBuilder<RecommendationSummaryDto>? _items;
  ListBuilder<RecommendationSummaryDto> get items =>
      _$this._items ??= ListBuilder<RecommendationSummaryDto>();
  set items(ListBuilder<RecommendationSummaryDto>? items) =>
      _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  RecommendationSummaryDtoPagedResultBuilder() {
    RecommendationSummaryDtoPagedResult._defaults(this);
  }

  RecommendationSummaryDtoPagedResultBuilder get _$this {
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
  void replace(RecommendationSummaryDtoPagedResult other) {
    _$v = other as _$RecommendationSummaryDtoPagedResult;
  }

  @override
  void update(
      void Function(RecommendationSummaryDtoPagedResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationSummaryDtoPagedResult build() => _build();

  _$RecommendationSummaryDtoPagedResult _build() {
    _$RecommendationSummaryDtoPagedResult _$result;
    try {
      _$result = _$v ??
          _$RecommendationSummaryDtoPagedResult._(
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
        throw BuiltValueNestedFieldError(r'RecommendationSummaryDtoPagedResult',
            _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
