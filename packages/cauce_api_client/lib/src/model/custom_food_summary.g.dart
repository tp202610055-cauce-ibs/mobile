// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_food_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CustomFoodSummary extends CustomFoodSummary {
  @override
  final String? customFoodId;
  @override
  final String? name;
  @override
  final double? portionSizeGrams;
  @override
  final DateTime? createdAt;
  @override
  final BuiltList<CustomFoodIngredientSummary>? ingredients;

  factory _$CustomFoodSummary(
          [void Function(CustomFoodSummaryBuilder)? updates]) =>
      (CustomFoodSummaryBuilder()..update(updates))._build();

  _$CustomFoodSummary._(
      {this.customFoodId,
      this.name,
      this.portionSizeGrams,
      this.createdAt,
      this.ingredients})
      : super._();
  @override
  CustomFoodSummary rebuild(void Function(CustomFoodSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomFoodSummaryBuilder toBuilder() =>
      CustomFoodSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomFoodSummary &&
        customFoodId == other.customFoodId &&
        name == other.name &&
        portionSizeGrams == other.portionSizeGrams &&
        createdAt == other.createdAt &&
        ingredients == other.ingredients;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, customFoodId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, portionSizeGrams.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, ingredients.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CustomFoodSummary')
          ..add('customFoodId', customFoodId)
          ..add('name', name)
          ..add('portionSizeGrams', portionSizeGrams)
          ..add('createdAt', createdAt)
          ..add('ingredients', ingredients))
        .toString();
  }
}

class CustomFoodSummaryBuilder
    implements Builder<CustomFoodSummary, CustomFoodSummaryBuilder> {
  _$CustomFoodSummary? _$v;

  String? _customFoodId;
  String? get customFoodId => _$this._customFoodId;
  set customFoodId(String? customFoodId) => _$this._customFoodId = customFoodId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  double? _portionSizeGrams;
  double? get portionSizeGrams => _$this._portionSizeGrams;
  set portionSizeGrams(double? portionSizeGrams) =>
      _$this._portionSizeGrams = portionSizeGrams;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ListBuilder<CustomFoodIngredientSummary>? _ingredients;
  ListBuilder<CustomFoodIngredientSummary> get ingredients =>
      _$this._ingredients ??= ListBuilder<CustomFoodIngredientSummary>();
  set ingredients(ListBuilder<CustomFoodIngredientSummary>? ingredients) =>
      _$this._ingredients = ingredients;

  CustomFoodSummaryBuilder() {
    CustomFoodSummary._defaults(this);
  }

  CustomFoodSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _customFoodId = $v.customFoodId;
      _name = $v.name;
      _portionSizeGrams = $v.portionSizeGrams;
      _createdAt = $v.createdAt;
      _ingredients = $v.ingredients?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomFoodSummary other) {
    _$v = other as _$CustomFoodSummary;
  }

  @override
  void update(void Function(CustomFoodSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CustomFoodSummary build() => _build();

  _$CustomFoodSummary _build() {
    _$CustomFoodSummary _$result;
    try {
      _$result = _$v ??
          _$CustomFoodSummary._(
            customFoodId: customFoodId,
            name: name,
            portionSizeGrams: portionSizeGrams,
            createdAt: createdAt,
            ingredients: _ingredients?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ingredients';
        _ingredients?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CustomFoodSummary', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
