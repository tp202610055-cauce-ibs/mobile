// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_food_ingredient_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CustomFoodIngredientRequest extends CustomFoodIngredientRequest {
  @override
  final String? foodId;
  @override
  final double? proportionGrams;

  factory _$CustomFoodIngredientRequest(
          [void Function(CustomFoodIngredientRequestBuilder)? updates]) =>
      (CustomFoodIngredientRequestBuilder()..update(updates))._build();

  _$CustomFoodIngredientRequest._({this.foodId, this.proportionGrams})
      : super._();
  @override
  CustomFoodIngredientRequest rebuild(
          void Function(CustomFoodIngredientRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomFoodIngredientRequestBuilder toBuilder() =>
      CustomFoodIngredientRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomFoodIngredientRequest &&
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
    return (newBuiltValueToStringHelper(r'CustomFoodIngredientRequest')
          ..add('foodId', foodId)
          ..add('proportionGrams', proportionGrams))
        .toString();
  }
}

class CustomFoodIngredientRequestBuilder
    implements
        Builder<CustomFoodIngredientRequest,
            CustomFoodIngredientRequestBuilder> {
  _$CustomFoodIngredientRequest? _$v;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  double? _proportionGrams;
  double? get proportionGrams => _$this._proportionGrams;
  set proportionGrams(double? proportionGrams) =>
      _$this._proportionGrams = proportionGrams;

  CustomFoodIngredientRequestBuilder() {
    CustomFoodIngredientRequest._defaults(this);
  }

  CustomFoodIngredientRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodId = $v.foodId;
      _proportionGrams = $v.proportionGrams;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomFoodIngredientRequest other) {
    _$v = other as _$CustomFoodIngredientRequest;
  }

  @override
  void update(void Function(CustomFoodIngredientRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CustomFoodIngredientRequest build() => _build();

  _$CustomFoodIngredientRequest _build() {
    final _$result = _$v ??
        _$CustomFoodIngredientRequest._(
          foodId: foodId,
          proportionGrams: proportionGrams,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
