// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FoodItemDetail extends FoodItemDetail {
  @override
  final String? foodId;
  @override
  final String? name;
  @override
  final String? category;
  @override
  final double? caloriesPer100g;
  @override
  final double? proteinGPer100g;
  @override
  final double? carbsGPer100g;
  @override
  final double? fatGPer100g;
  @override
  final double? fiberGPer100g;
  @override
  final FodmapLevel? fodmapLevel;
  @override
  final String? fodmapTags;
  @override
  final bool? isPeruvian;
  @override
  final bool? isActive;

  factory _$FoodItemDetail([void Function(FoodItemDetailBuilder)? updates]) =>
      (FoodItemDetailBuilder()..update(updates))._build();

  _$FoodItemDetail._(
      {this.foodId,
      this.name,
      this.category,
      this.caloriesPer100g,
      this.proteinGPer100g,
      this.carbsGPer100g,
      this.fatGPer100g,
      this.fiberGPer100g,
      this.fodmapLevel,
      this.fodmapTags,
      this.isPeruvian,
      this.isActive})
      : super._();
  @override
  FoodItemDetail rebuild(void Function(FoodItemDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FoodItemDetailBuilder toBuilder() => FoodItemDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FoodItemDetail &&
        foodId == other.foodId &&
        name == other.name &&
        category == other.category &&
        caloriesPer100g == other.caloriesPer100g &&
        proteinGPer100g == other.proteinGPer100g &&
        carbsGPer100g == other.carbsGPer100g &&
        fatGPer100g == other.fatGPer100g &&
        fiberGPer100g == other.fiberGPer100g &&
        fodmapLevel == other.fodmapLevel &&
        fodmapTags == other.fodmapTags &&
        isPeruvian == other.isPeruvian &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, foodId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, caloriesPer100g.hashCode);
    _$hash = $jc(_$hash, proteinGPer100g.hashCode);
    _$hash = $jc(_$hash, carbsGPer100g.hashCode);
    _$hash = $jc(_$hash, fatGPer100g.hashCode);
    _$hash = $jc(_$hash, fiberGPer100g.hashCode);
    _$hash = $jc(_$hash, fodmapLevel.hashCode);
    _$hash = $jc(_$hash, fodmapTags.hashCode);
    _$hash = $jc(_$hash, isPeruvian.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FoodItemDetail')
          ..add('foodId', foodId)
          ..add('name', name)
          ..add('category', category)
          ..add('caloriesPer100g', caloriesPer100g)
          ..add('proteinGPer100g', proteinGPer100g)
          ..add('carbsGPer100g', carbsGPer100g)
          ..add('fatGPer100g', fatGPer100g)
          ..add('fiberGPer100g', fiberGPer100g)
          ..add('fodmapLevel', fodmapLevel)
          ..add('fodmapTags', fodmapTags)
          ..add('isPeruvian', isPeruvian)
          ..add('isActive', isActive))
        .toString();
  }
}

class FoodItemDetailBuilder
    implements Builder<FoodItemDetail, FoodItemDetailBuilder> {
  _$FoodItemDetail? _$v;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  double? _caloriesPer100g;
  double? get caloriesPer100g => _$this._caloriesPer100g;
  set caloriesPer100g(double? caloriesPer100g) =>
      _$this._caloriesPer100g = caloriesPer100g;

  double? _proteinGPer100g;
  double? get proteinGPer100g => _$this._proteinGPer100g;
  set proteinGPer100g(double? proteinGPer100g) =>
      _$this._proteinGPer100g = proteinGPer100g;

  double? _carbsGPer100g;
  double? get carbsGPer100g => _$this._carbsGPer100g;
  set carbsGPer100g(double? carbsGPer100g) =>
      _$this._carbsGPer100g = carbsGPer100g;

  double? _fatGPer100g;
  double? get fatGPer100g => _$this._fatGPer100g;
  set fatGPer100g(double? fatGPer100g) => _$this._fatGPer100g = fatGPer100g;

  double? _fiberGPer100g;
  double? get fiberGPer100g => _$this._fiberGPer100g;
  set fiberGPer100g(double? fiberGPer100g) =>
      _$this._fiberGPer100g = fiberGPer100g;

  FodmapLevel? _fodmapLevel;
  FodmapLevel? get fodmapLevel => _$this._fodmapLevel;
  set fodmapLevel(FodmapLevel? fodmapLevel) =>
      _$this._fodmapLevel = fodmapLevel;

  String? _fodmapTags;
  String? get fodmapTags => _$this._fodmapTags;
  set fodmapTags(String? fodmapTags) => _$this._fodmapTags = fodmapTags;

  bool? _isPeruvian;
  bool? get isPeruvian => _$this._isPeruvian;
  set isPeruvian(bool? isPeruvian) => _$this._isPeruvian = isPeruvian;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FoodItemDetailBuilder() {
    FoodItemDetail._defaults(this);
  }

  FoodItemDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodId = $v.foodId;
      _name = $v.name;
      _category = $v.category;
      _caloriesPer100g = $v.caloriesPer100g;
      _proteinGPer100g = $v.proteinGPer100g;
      _carbsGPer100g = $v.carbsGPer100g;
      _fatGPer100g = $v.fatGPer100g;
      _fiberGPer100g = $v.fiberGPer100g;
      _fodmapLevel = $v.fodmapLevel;
      _fodmapTags = $v.fodmapTags;
      _isPeruvian = $v.isPeruvian;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FoodItemDetail other) {
    _$v = other as _$FoodItemDetail;
  }

  @override
  void update(void Function(FoodItemDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FoodItemDetail build() => _build();

  _$FoodItemDetail _build() {
    final _$result = _$v ??
        _$FoodItemDetail._(
          foodId: foodId,
          name: name,
          category: category,
          caloriesPer100g: caloriesPer100g,
          proteinGPer100g: proteinGPer100g,
          carbsGPer100g: carbsGPer100g,
          fatGPer100g: fatGPer100g,
          fiberGPer100g: fiberGPer100g,
          fodmapLevel: fodmapLevel,
          fodmapTags: fodmapTags,
          isPeruvian: isPeruvian,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
