// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_custom_food_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateCustomFoodRequest extends CreateCustomFoodRequest {
  @override
  final String? name;
  @override
  final double? portionSizeGrams;
  @override
  final BuiltList<CustomFoodIngredientRequest>? ingredients;
  @override
  final bool? confirmedAllergens;

  factory _$CreateCustomFoodRequest(
          [void Function(CreateCustomFoodRequestBuilder)? updates]) =>
      (CreateCustomFoodRequestBuilder()..update(updates))._build();

  _$CreateCustomFoodRequest._(
      {this.name,
      this.portionSizeGrams,
      this.ingredients,
      this.confirmedAllergens})
      : super._();
  @override
  CreateCustomFoodRequest rebuild(
          void Function(CreateCustomFoodRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateCustomFoodRequestBuilder toBuilder() =>
      CreateCustomFoodRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCustomFoodRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateCustomFoodRequest')
          ..add('name', name)
          ..add('portionSizeGrams', portionSizeGrams)
          ..add('ingredients', ingredients)
          ..add('confirmedAllergens', confirmedAllergens))
        .toString();
  }
}

class CreateCustomFoodRequestBuilder
    implements
        Builder<CreateCustomFoodRequest, CreateCustomFoodRequestBuilder> {
  _$CreateCustomFoodRequest? _$v;

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

  CreateCustomFoodRequestBuilder() {
    CreateCustomFoodRequest._defaults(this);
  }

  CreateCustomFoodRequestBuilder get _$this {
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
  void replace(CreateCustomFoodRequest other) {
    _$v = other as _$CreateCustomFoodRequest;
  }

  @override
  void update(void Function(CreateCustomFoodRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCustomFoodRequest build() => _build();

  _$CreateCustomFoodRequest _build() {
    _$CreateCustomFoodRequest _$result;
    try {
      _$result = _$v ??
          _$CreateCustomFoodRequest._(
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
            r'CreateCustomFoodRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
