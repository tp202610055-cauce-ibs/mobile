// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_food_ingredient_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CustomFoodIngredientSummary extends CustomFoodIngredientSummary {
  @override
  final String? foodId;
  @override
  final double? proportionGrams;

  factory _$CustomFoodIngredientSummary(
          [void Function(CustomFoodIngredientSummaryBuilder)? updates]) =>
      (CustomFoodIngredientSummaryBuilder()..update(updates))._build();

  _$CustomFoodIngredientSummary._({this.foodId, this.proportionGrams})
      : super._();
  @override
  CustomFoodIngredientSummary rebuild(
          void Function(CustomFoodIngredientSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomFoodIngredientSummaryBuilder toBuilder() =>
      CustomFoodIngredientSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomFoodIngredientSummary &&
        foodId == other.foodId &&
        proportionGrams == other.proportionGrams;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, foodId.hashCode);
    _$hash = $jc(_$hash, proportionGrams.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CustomFoodIngredientSummary')
          ..add('foodId', foodId)
          ..add('proportionGrams', proportionGrams))
        .toString();
  }
}

class CustomFoodIngredientSummaryBuilder
    implements
        Builder<CustomFoodIngredientSummary,
            CustomFoodIngredientSummaryBuilder> {
  _$CustomFoodIngredientSummary? _$v;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  double? _proportionGrams;
  double? get proportionGrams => _$this._proportionGrams;
  set proportionGrams(double? proportionGrams) =>
      _$this._proportionGrams = proportionGrams;

  CustomFoodIngredientSummaryBuilder() {
    CustomFoodIngredientSummary._defaults(this);
  }

  CustomFoodIngredientSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodId = $v.foodId;
      _proportionGrams = $v.proportionGrams;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomFoodIngredientSummary other) {
    _$v = other as _$CustomFoodIngredientSummary;
  }

  @override
  void update(void Function(CustomFoodIngredientSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CustomFoodIngredientSummary build() => _build();

  _$CustomFoodIngredientSummary _build() {
    final _$result = _$v ??
        _$CustomFoodIngredientSummary._(
          foodId: foodId,
          proportionGrams: proportionGrams,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
