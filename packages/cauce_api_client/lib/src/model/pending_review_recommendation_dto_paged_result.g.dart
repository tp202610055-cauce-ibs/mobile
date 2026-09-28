// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_review_recommendation_dto_paged_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PendingReviewRecommendationDtoPagedResult
    extends PendingReviewRecommendationDtoPagedResult {
  @override
  final BuiltList<PendingReviewRecommendationDto>? items;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? totalCount;

  factory _$PendingReviewRecommendationDtoPagedResult(
          [void Function(PendingReviewRecommendationDtoPagedResultBuilder)?
              updates]) =>
      (PendingReviewRecommendationDtoPagedResultBuilder()..update(updates))
          ._build();

  _$PendingReviewRecommendationDtoPagedResult._(
      {this.items, this.page, this.pageSize, this.totalCount})
      : super._();
  @override
  PendingReviewRecommendationDtoPagedResult rebuild(
          void Function(PendingReviewRecommendationDtoPagedResultBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PendingReviewRecommendationDtoPagedResultBuilder toBuilder() =>
      PendingReviewRecommendationDtoPagedResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PendingReviewRecommendationDtoPagedResult &&
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
    return (newBuiltValueToStringHelper(
            r'PendingReviewRecommendationDtoPagedResult')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class PendingReviewRecommendationDtoPagedResultBuilder
    implements
        Builder<PendingReviewRecommendationDtoPagedResult,
            PendingReviewRecommendationDtoPagedResultBuilder> {
  _$PendingReviewRecommendationDtoPagedResult? _$v;

  ListBuilder<PendingReviewRecommendationDto>? _items;
  ListBuilder<PendingReviewRecommendationDto> get items =>
      _$this._items ??= ListBuilder<PendingReviewRecommendationDto>();
  set items(ListBuilder<PendingReviewRecommendationDto>? items) =>
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

  PendingReviewRecommendationDtoPagedResultBuilder() {
    PendingReviewRecommendationDtoPagedResult._defaults(this);
  }

  PendingReviewRecommendationDtoPagedResultBuilder get _$this {
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
  void replace(PendingReviewRecommendationDtoPagedResult other) {
    _$v = other as _$PendingReviewRecommendationDtoPagedResult;
  }

  @override
  void update(
      void Function(PendingReviewRecommendationDtoPagedResultBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  PendingReviewRecommendationDtoPagedResult build() => _build();

  _$PendingReviewRecommendationDtoPagedResult _build() {
    _$PendingReviewRecommendationDtoPagedResult _$result;
    try {
      _$result = _$v ??
          _$PendingReviewRecommendationDtoPagedResult._(
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
            r'PendingReviewRecommendationDtoPagedResult',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
