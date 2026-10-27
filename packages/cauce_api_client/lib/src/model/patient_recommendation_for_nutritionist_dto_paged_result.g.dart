// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_recommendation_for_nutritionist_dto_paged_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PatientRecommendationForNutritionistDtoPagedResult
    extends PatientRecommendationForNutritionistDtoPagedResult {
  @override
  final BuiltList<PatientRecommendationForNutritionistDto>? items;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? totalCount;

  factory _$PatientRecommendationForNutritionistDtoPagedResult(
          [void Function(
                  PatientRecommendationForNutritionistDtoPagedResultBuilder)?
              updates]) =>
      (PatientRecommendationForNutritionistDtoPagedResultBuilder()
            ..update(updates))
          ._build();

  _$PatientRecommendationForNutritionistDtoPagedResult._(
      {this.items, this.page, this.pageSize, this.totalCount})
      : super._();
  @override
  PatientRecommendationForNutritionistDtoPagedResult rebuild(
          void Function(
                  PatientRecommendationForNutritionistDtoPagedResultBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PatientRecommendationForNutritionistDtoPagedResultBuilder toBuilder() =>
      PatientRecommendationForNutritionistDtoPagedResultBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PatientRecommendationForNutritionistDtoPagedResult &&
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
            r'PatientRecommendationForNutritionistDtoPagedResult')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('totalCount', totalCount))
        .toString();
  }
}

class PatientRecommendationForNutritionistDtoPagedResultBuilder
    implements
        Builder<PatientRecommendationForNutritionistDtoPagedResult,
            PatientRecommendationForNutritionistDtoPagedResultBuilder> {
  _$PatientRecommendationForNutritionistDtoPagedResult? _$v;

  ListBuilder<PatientRecommendationForNutritionistDto>? _items;
  ListBuilder<PatientRecommendationForNutritionistDto> get items =>
      _$this._items ??= ListBuilder<PatientRecommendationForNutritionistDto>();
  set items(ListBuilder<PatientRecommendationForNutritionistDto>? items) =>
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

  PatientRecommendationForNutritionistDtoPagedResultBuilder() {
    PatientRecommendationForNutritionistDtoPagedResult._defaults(this);
  }

  PatientRecommendationForNutritionistDtoPagedResultBuilder get _$this {
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
  void replace(PatientRecommendationForNutritionistDtoPagedResult other) {
    _$v = other as _$PatientRecommendationForNutritionistDtoPagedResult;
  }

  @override
  void update(
      void Function(PatientRecommendationForNutritionistDtoPagedResultBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  PatientRecommendationForNutritionistDtoPagedResult build() => _build();

  _$PatientRecommendationForNutritionistDtoPagedResult _build() {
    _$PatientRecommendationForNutritionistDtoPagedResult _$result;
    try {
      _$result = _$v ??
          _$PatientRecommendationForNutritionistDtoPagedResult._(
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
            r'PatientRecommendationForNutritionistDtoPagedResult',
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
