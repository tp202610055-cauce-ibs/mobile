// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_item_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MealItemRequest extends MealItemRequest {
  @override
  final String? foodId;
  @override
  final String? customFoodId;
  @override
  final double? quantity;
  @override
  final MeasurementUnit? unit;

  factory _$MealItemRequest([void Function(MealItemRequestBuilder)? updates]) =>
      (MealItemRequestBuilder()..update(updates))._build();

  _$MealItemRequest._(
      {this.foodId, this.customFoodId, this.quantity, this.unit})
      : super._();
  @override
  MealItemRequest rebuild(void Function(MealItemRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MealItemRequestBuilder toBuilder() => MealItemRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MealItemRequest &&
        foodId == other.foodId &&
        customFoodId == other.customFoodId &&
        quantity == other.quantity &&
        unit == other.unit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, foodId.hashCode);
    _$hash = $jc(_$hash, customFoodId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MealItemRequest')
          ..add('foodId', foodId)
          ..add('customFoodId', customFoodId)
          ..add('quantity', quantity)
          ..add('unit', unit))
        .toString();
  }
}

class MealItemRequestBuilder
    implements Builder<MealItemRequest, MealItemRequestBuilder> {
  _$MealItemRequest? _$v;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  String? _customFoodId;
  String? get customFoodId => _$this._customFoodId;
  set customFoodId(String? customFoodId) => _$this._customFoodId = customFoodId;

  double? _quantity;
  double? get quantity => _$this._quantity;
  set quantity(double? quantity) => _$this._quantity = quantity;

  MeasurementUnit? _unit;
  MeasurementUnit? get unit => _$this._unit;
  set unit(MeasurementUnit? unit) => _$this._unit = unit;

  MealItemRequestBuilder() {
    MealItemRequest._defaults(this);
  }

  MealItemRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodId = $v.foodId;
      _customFoodId = $v.customFoodId;
      _quantity = $v.quantity;
      _unit = $v.unit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MealItemRequest other) {
    _$v = other as _$MealItemRequest;
  }

  @override
  void update(void Function(MealItemRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MealItemRequest build() => _build();

  _$MealItemRequest _build() {
    final _$result = _$v ??
        _$MealItemRequest._(
          foodId: foodId,
          customFoodId: customFoodId,
          quantity: quantity,
          unit: unit,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
