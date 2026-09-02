// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FoodItemSummary extends FoodItemSummary {
  @override
  final String? foodId;
  @override
  final String? name;
  @override
  final String? category;
  @override
  final FodmapLevel? fodmapLevel;
  @override
  final bool? isPeruvian;

  factory _$FoodItemSummary([void Function(FoodItemSummaryBuilder)? updates]) =>
      (FoodItemSummaryBuilder()..update(updates))._build();

  _$FoodItemSummary._(
      {this.foodId,
      this.name,
      this.category,
      this.fodmapLevel,
      this.isPeruvian})
      : super._();
  @override
  FoodItemSummary rebuild(void Function(FoodItemSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FoodItemSummaryBuilder toBuilder() => FoodItemSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FoodItemSummary &&
        foodId == other.foodId &&
        name == other.name &&
        category == other.category &&
        fodmapLevel == other.fodmapLevel &&
        isPeruvian == other.isPeruvian;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, foodId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, fodmapLevel.hashCode);
    _$hash = $jc(_$hash, isPeruvian.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FoodItemSummary')
          ..add('foodId', foodId)
          ..add('name', name)
          ..add('category', category)
          ..add('fodmapLevel', fodmapLevel)
          ..add('isPeruvian', isPeruvian))
        .toString();
  }
}

class FoodItemSummaryBuilder
    implements Builder<FoodItemSummary, FoodItemSummaryBuilder> {
  _$FoodItemSummary? _$v;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  FodmapLevel? _fodmapLevel;
  FodmapLevel? get fodmapLevel => _$this._fodmapLevel;
  set fodmapLevel(FodmapLevel? fodmapLevel) =>
      _$this._fodmapLevel = fodmapLevel;

  bool? _isPeruvian;
  bool? get isPeruvian => _$this._isPeruvian;
  set isPeruvian(bool? isPeruvian) => _$this._isPeruvian = isPeruvian;

  FoodItemSummaryBuilder() {
    FoodItemSummary._defaults(this);
  }

  FoodItemSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodId = $v.foodId;
      _name = $v.name;
      _category = $v.category;
      _fodmapLevel = $v.fodmapLevel;
      _isPeruvian = $v.isPeruvian;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FoodItemSummary other) {
    _$v = other as _$FoodItemSummary;
  }

  @override
  void update(void Function(FoodItemSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FoodItemSummary build() => _build();

  _$FoodItemSummary _build() {
    final _$result = _$v ??
        _$FoodItemSummary._(
          foodId: foodId,
          name: name,
          category: category,
          fodmapLevel: fodmapLevel,
          isPeruvian: isPeruvian,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
