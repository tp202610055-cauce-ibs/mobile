// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_custom_food_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateCustomFoodRequest extends UpdateCustomFoodRequest {
  @override
  final String? name;
  @override
  final double? portionSizeGrams;
  @override
  final BuiltList<CustomFoodIngredientRequest>? ingredients;
  @override
  final bool? confirmedAllergens;

  factory _$UpdateCustomFoodRequest(
          [void Function(UpdateCustomFoodRequestBuilder)? updates]) =>
      (UpdateCustomFoodRequestBuilder()..update(updates))._build();

  _$UpdateCustomFoodRequest._(
      {this.name,
      this.portionSizeGrams,
      this.ingredients,
      this.confirmedAllergens})
      : super._();
  @override
  UpdateCustomFoodRequest rebuild(
          void Function(UpdateCustomFoodRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateCustomFoodRequestBuilder toBuilder() =>
      UpdateCustomFoodRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateCustomFoodRequest &&
        name == other.name &&
        portionSizeGrams == other.portionSizeGrams &&
        ingredients == other.ingredients &&
        confirmedAllergens == other.confirmedAllergens;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, portionSizeGrams.hashCode);
    _$hash = $jc(_$hash, ingredients.hashCode);
    _$hash = $jc(_$hash, confirmedAllergens.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateCustomFoodRequest')
          ..add('name', name)
          ..add('portionSizeGrams', portionSizeGrams)
          ..add('ingredients', ingredients)
          ..add('confirmedAllergens', confirmedAllergens))
        .toString();
  }
}

class UpdateCustomFoodRequestBuilder
    implements
        Builder<UpdateCustomFoodRequest, UpdateCustomFoodRequestBuilder> {
  _$UpdateCustomFoodRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  double? _portionSizeGrams;
  double? get portionSizeGrams => _$this._portionSizeGrams;
  set portionSizeGrams(double? portionSizeGrams) =>
      _$this._portionSizeGrams = portionSizeGrams;

  ListBuilder<CustomFoodIngredientRequest>? _ingredients;
  ListBuilder<CustomFoodIngredientRequest> get ingredients =>
      _$this._ingredients ??= ListBuilder<CustomFoodIngredientRequest>();
  set ingredients(ListBuilder<CustomFoodIngredientRequest>? ingredients) =>
      _$this._ingredients = ingredients;

  bool? _confirmedAllergens;
  bool? get confirmedAllergens => _$this._confirmedAllergens;
  set confirmedAllergens(bool? confirmedAllergens) =>
      _$this._confirmedAllergens = confirmedAllergens;

  UpdateCustomFoodRequestBuilder() {
    UpdateCustomFoodRequest._defaults(this);
  }

  UpdateCustomFoodRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _portionSizeGrams = $v.portionSizeGrams;
      _ingredients = $v.ingredients?.toBuilder();
      _confirmedAllergens = $v.confirmedAllergens;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateCustomFoodRequest other) {
    _$v = other as _$UpdateCustomFoodRequest;
  }

  @override
  void update(void Function(UpdateCustomFoodRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateCustomFoodRequest build() => _build();

  _$UpdateCustomFoodRequest _build() {
    _$UpdateCustomFoodRequest _$result;
    try {
      _$result = _$v ??
          _$UpdateCustomFoodRequest._(
            name: name,
            portionSizeGrams: portionSizeGrams,
            ingredients: _ingredients?.build(),
            confirmedAllergens: confirmedAllergens,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ingredients';
        _ingredients?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateCustomFoodRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
