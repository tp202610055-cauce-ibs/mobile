// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_allergen_check_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FoodAllergenCheckResult extends FoodAllergenCheckResult {
  @override
  final String? foodId;
  @override
  final String? foodName;
  @override
  final bool? hasAllergenConflict;
  @override
  final BuiltList<String>? allergens;

  factory _$FoodAllergenCheckResult(
          [void Function(FoodAllergenCheckResultBuilder)? updates]) =>
      (FoodAllergenCheckResultBuilder()..update(updates))._build();

  _$FoodAllergenCheckResult._(
      {this.foodId, this.foodName, this.hasAllergenConflict, this.allergens})
      : super._();
  @override
  FoodAllergenCheckResult rebuild(
          void Function(FoodAllergenCheckResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FoodAllergenCheckResultBuilder toBuilder() =>
      FoodAllergenCheckResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FoodAllergenCheckResult &&
        foodId == other.foodId &&
        foodName == other.foodName &&
        hasAllergenConflict == other.hasAllergenConflict &&
        allergens == other.allergens;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, foodId.hashCode);
    _$hash = $jc(_$hash, foodName.hashCode);
    _$hash = $jc(_$hash, hasAllergenConflict.hashCode);
    _$hash = $jc(_$hash, allergens.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FoodAllergenCheckResult')
          ..add('foodId', foodId)
          ..add('foodName', foodName)
          ..add('hasAllergenConflict', hasAllergenConflict)
          ..add('allergens', allergens))
        .toString();
  }
}

class FoodAllergenCheckResultBuilder
    implements
        Builder<FoodAllergenCheckResult, FoodAllergenCheckResultBuilder> {
  _$FoodAllergenCheckResult? _$v;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  String? _foodName;
  String? get foodName => _$this._foodName;
  set foodName(String? foodName) => _$this._foodName = foodName;

  bool? _hasAllergenConflict;
  bool? get hasAllergenConflict => _$this._hasAllergenConflict;
  set hasAllergenConflict(bool? hasAllergenConflict) =>
      _$this._hasAllergenConflict = hasAllergenConflict;

  ListBuilder<String>? _allergens;
  ListBuilder<String> get allergens =>
      _$this._allergens ??= ListBuilder<String>();
  set allergens(ListBuilder<String>? allergens) =>
      _$this._allergens = allergens;

  FoodAllergenCheckResultBuilder() {
    FoodAllergenCheckResult._defaults(this);
  }

  FoodAllergenCheckResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodId = $v.foodId;
      _foodName = $v.foodName;
      _hasAllergenConflict = $v.hasAllergenConflict;
      _allergens = $v.allergens?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FoodAllergenCheckResult other) {
    _$v = other as _$FoodAllergenCheckResult;
  }

  @override
  void update(void Function(FoodAllergenCheckResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FoodAllergenCheckResult build() => _build();

  _$FoodAllergenCheckResult _build() {
    _$FoodAllergenCheckResult _$result;
    try {
      _$result = _$v ??
          _$FoodAllergenCheckResult._(
            foodId: foodId,
            foodName: foodName,
            hasAllergenConflict: hasAllergenConflict,
            allergens: _allergens?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'allergens';
        _allergens?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FoodAllergenCheckResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
