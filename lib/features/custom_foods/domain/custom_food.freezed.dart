// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomFoodIngredientDraft {
  FoodItem get food => throw _privateConstructorUsedError;

  /// Gramos que aporta este ingrediente al plato.
  double get proportionGrams => throw _privateConstructorUsedError;

  /// Create a copy of CustomFoodIngredientDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFoodIngredientDraftCopyWith<CustomFoodIngredientDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFoodIngredientDraftCopyWith<$Res> {
  factory $CustomFoodIngredientDraftCopyWith(CustomFoodIngredientDraft value,
          $Res Function(CustomFoodIngredientDraft) then) =
      _$CustomFoodIngredientDraftCopyWithImpl<$Res, CustomFoodIngredientDraft>;
  @useResult
  $Res call({FoodItem food, double proportionGrams});

  $FoodItemCopyWith<$Res> get food;
}

/// @nodoc
class _$CustomFoodIngredientDraftCopyWithImpl<$Res,
        $Val extends CustomFoodIngredientDraft>
    implements $CustomFoodIngredientDraftCopyWith<$Res> {
  _$CustomFoodIngredientDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFoodIngredientDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? food = null,
    Object? proportionGrams = null,
  }) {
    return _then(_value.copyWith(
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as FoodItem,
      proportionGrams: null == proportionGrams
          ? _value.proportionGrams
          : proportionGrams // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of CustomFoodIngredientDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodItemCopyWith<$Res> get food {
    return $FoodItemCopyWith<$Res>(_value.food, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomFoodIngredientDraftImplCopyWith<$Res>
    implements $CustomFoodIngredientDraftCopyWith<$Res> {
  factory _$$CustomFoodIngredientDraftImplCopyWith(
          _$CustomFoodIngredientDraftImpl value,
          $Res Function(_$CustomFoodIngredientDraftImpl) then) =
      __$$CustomFoodIngredientDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FoodItem food, double proportionGrams});

  @override
  $FoodItemCopyWith<$Res> get food;
}

/// @nodoc
class __$$CustomFoodIngredientDraftImplCopyWithImpl<$Res>
    extends _$CustomFoodIngredientDraftCopyWithImpl<$Res,
        _$CustomFoodIngredientDraftImpl>
    implements _$$CustomFoodIngredientDraftImplCopyWith<$Res> {
  __$$CustomFoodIngredientDraftImplCopyWithImpl(
      _$CustomFoodIngredientDraftImpl _value,
      $Res Function(_$CustomFoodIngredientDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFoodIngredientDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? food = null,
    Object? proportionGrams = null,
  }) {
    return _then(_$CustomFoodIngredientDraftImpl(
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as FoodItem,
      proportionGrams: null == proportionGrams
          ? _value.proportionGrams
          : proportionGrams // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CustomFoodIngredientDraftImpl extends _CustomFoodIngredientDraft {
  const _$CustomFoodIngredientDraftImpl(
      {required this.food, required this.proportionGrams})
      : super._();

  @override
  final FoodItem food;

  /// Gramos que aporta este ingrediente al plato.
  @override
  final double proportionGrams;

  @override
  String toString() {
    return 'CustomFoodIngredientDraft(food: $food, proportionGrams: $proportionGrams)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodIngredientDraftImpl &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.proportionGrams, proportionGrams) ||
                other.proportionGrams == proportionGrams));
  }

  @override
  int get hashCode => Object.hash(runtimeType, food, proportionGrams);

  /// Create a copy of CustomFoodIngredientDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFoodIngredientDraftImplCopyWith<_$CustomFoodIngredientDraftImpl>
      get copyWith => __$$CustomFoodIngredientDraftImplCopyWithImpl<
          _$CustomFoodIngredientDraftImpl>(this, _$identity);
}

abstract class _CustomFoodIngredientDraft extends CustomFoodIngredientDraft {
  const factory _CustomFoodIngredientDraft(
      {required final FoodItem food,
      required final double proportionGrams}) = _$CustomFoodIngredientDraftImpl;
  const _CustomFoodIngredientDraft._() : super._();

  @override
  FoodItem get food;

  /// Gramos que aporta este ingrediente al plato.
  @override
  double get proportionGrams;

  /// Create a copy of CustomFoodIngredientDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFoodIngredientDraftImplCopyWith<_$CustomFoodIngredientDraftImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NutritionEstimate {
  double get caloriesPer100g => throw _privateConstructorUsedError;
  double get proteinGPer100g => throw _privateConstructorUsedError;
  double get carbsGPer100g => throw _privateConstructorUsedError;
  double get fatGPer100g => throw _privateConstructorUsedError;
  double get fiberGPer100g => throw _privateConstructorUsedError;

  /// Carga FODMAP del plato: el maximo de sus ingredientes.
  FodmapLoad? get fodmapLevel => throw _privateConstructorUsedError;

  /// `true` si algun ingrediente no tenia composicion conocida.
  ///
  /// Pasa cuando el detalle no se pudo traer, tipicamente sin conexion. La
  /// estimacion sale igual con lo que hay, y decirlo evita presentar como
  /// completo un calculo que le falta la mitad.
  bool get isPartial => throw _privateConstructorUsedError;

  /// Create a copy of NutritionEstimate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionEstimateCopyWith<NutritionEstimate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionEstimateCopyWith<$Res> {
  factory $NutritionEstimateCopyWith(
          NutritionEstimate value, $Res Function(NutritionEstimate) then) =
      _$NutritionEstimateCopyWithImpl<$Res, NutritionEstimate>;
  @useResult
  $Res call(
      {double caloriesPer100g,
      double proteinGPer100g,
      double carbsGPer100g,
      double fatGPer100g,
      double fiberGPer100g,
      FodmapLoad? fodmapLevel,
      bool isPartial});
}

/// @nodoc
class _$NutritionEstimateCopyWithImpl<$Res, $Val extends NutritionEstimate>
    implements $NutritionEstimateCopyWith<$Res> {
  _$NutritionEstimateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionEstimate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caloriesPer100g = null,
    Object? proteinGPer100g = null,
    Object? carbsGPer100g = null,
    Object? fatGPer100g = null,
    Object? fiberGPer100g = null,
    Object? fodmapLevel = freezed,
    Object? isPartial = null,
  }) {
    return _then(_value.copyWith(
      caloriesPer100g: null == caloriesPer100g
          ? _value.caloriesPer100g
          : caloriesPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      proteinGPer100g: null == proteinGPer100g
          ? _value.proteinGPer100g
          : proteinGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      carbsGPer100g: null == carbsGPer100g
          ? _value.carbsGPer100g
          : carbsGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      fatGPer100g: null == fatGPer100g
          ? _value.fatGPer100g
          : fatGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      fiberGPer100g: null == fiberGPer100g
          ? _value.fiberGPer100g
          : fiberGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      fodmapLevel: freezed == fodmapLevel
          ? _value.fodmapLevel
          : fodmapLevel // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      isPartial: null == isPartial
          ? _value.isPartial
          : isPartial // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionEstimateImplCopyWith<$Res>
    implements $NutritionEstimateCopyWith<$Res> {
  factory _$$NutritionEstimateImplCopyWith(_$NutritionEstimateImpl value,
          $Res Function(_$NutritionEstimateImpl) then) =
      __$$NutritionEstimateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double caloriesPer100g,
      double proteinGPer100g,
      double carbsGPer100g,
      double fatGPer100g,
      double fiberGPer100g,
      FodmapLoad? fodmapLevel,
      bool isPartial});
}

/// @nodoc
class __$$NutritionEstimateImplCopyWithImpl<$Res>
    extends _$NutritionEstimateCopyWithImpl<$Res, _$NutritionEstimateImpl>
    implements _$$NutritionEstimateImplCopyWith<$Res> {
  __$$NutritionEstimateImplCopyWithImpl(_$NutritionEstimateImpl _value,
      $Res Function(_$NutritionEstimateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionEstimate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caloriesPer100g = null,
    Object? proteinGPer100g = null,
    Object? carbsGPer100g = null,
    Object? fatGPer100g = null,
    Object? fiberGPer100g = null,
    Object? fodmapLevel = freezed,
    Object? isPartial = null,
  }) {
    return _then(_$NutritionEstimateImpl(
      caloriesPer100g: null == caloriesPer100g
          ? _value.caloriesPer100g
          : caloriesPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      proteinGPer100g: null == proteinGPer100g
          ? _value.proteinGPer100g
          : proteinGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      carbsGPer100g: null == carbsGPer100g
          ? _value.carbsGPer100g
          : carbsGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      fatGPer100g: null == fatGPer100g
          ? _value.fatGPer100g
          : fatGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      fiberGPer100g: null == fiberGPer100g
          ? _value.fiberGPer100g
          : fiberGPer100g // ignore: cast_nullable_to_non_nullable
              as double,
      fodmapLevel: freezed == fodmapLevel
          ? _value.fodmapLevel
          : fodmapLevel // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      isPartial: null == isPartial
          ? _value.isPartial
          : isPartial // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NutritionEstimateImpl extends _NutritionEstimate {
  const _$NutritionEstimateImpl(
      {required this.caloriesPer100g,
      required this.proteinGPer100g,
      required this.carbsGPer100g,
      required this.fatGPer100g,
      required this.fiberGPer100g,
      this.fodmapLevel,
      this.isPartial = false})
      : super._();

  @override
  final double caloriesPer100g;
  @override
  final double proteinGPer100g;
  @override
  final double carbsGPer100g;
  @override
  final double fatGPer100g;
  @override
  final double fiberGPer100g;

  /// Carga FODMAP del plato: el maximo de sus ingredientes.
  @override
  final FodmapLoad? fodmapLevel;

  /// `true` si algun ingrediente no tenia composicion conocida.
  ///
  /// Pasa cuando el detalle no se pudo traer, tipicamente sin conexion. La
  /// estimacion sale igual con lo que hay, y decirlo evita presentar como
  /// completo un calculo que le falta la mitad.
  @override
  @JsonKey()
  final bool isPartial;

  @override
  String toString() {
    return 'NutritionEstimate(caloriesPer100g: $caloriesPer100g, proteinGPer100g: $proteinGPer100g, carbsGPer100g: $carbsGPer100g, fatGPer100g: $fatGPer100g, fiberGPer100g: $fiberGPer100g, fodmapLevel: $fodmapLevel, isPartial: $isPartial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionEstimateImpl &&
            (identical(other.caloriesPer100g, caloriesPer100g) ||
                other.caloriesPer100g == caloriesPer100g) &&
            (identical(other.proteinGPer100g, proteinGPer100g) ||
                other.proteinGPer100g == proteinGPer100g) &&
            (identical(other.carbsGPer100g, carbsGPer100g) ||
                other.carbsGPer100g == carbsGPer100g) &&
            (identical(other.fatGPer100g, fatGPer100g) ||
                other.fatGPer100g == fatGPer100g) &&
            (identical(other.fiberGPer100g, fiberGPer100g) ||
                other.fiberGPer100g == fiberGPer100g) &&
            (identical(other.fodmapLevel, fodmapLevel) ||
                other.fodmapLevel == fodmapLevel) &&
            (identical(other.isPartial, isPartial) ||
                other.isPartial == isPartial));
  }

  @override
  int get hashCode => Object.hash(runtimeType, caloriesPer100g, proteinGPer100g,
      carbsGPer100g, fatGPer100g, fiberGPer100g, fodmapLevel, isPartial);

  /// Create a copy of NutritionEstimate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionEstimateImplCopyWith<_$NutritionEstimateImpl> get copyWith =>
      __$$NutritionEstimateImplCopyWithImpl<_$NutritionEstimateImpl>(
          this, _$identity);
}

abstract class _NutritionEstimate extends NutritionEstimate {
  const factory _NutritionEstimate(
      {required final double caloriesPer100g,
      required final double proteinGPer100g,
      required final double carbsGPer100g,
      required final double fatGPer100g,
      required final double fiberGPer100g,
      final FodmapLoad? fodmapLevel,
      final bool isPartial}) = _$NutritionEstimateImpl;
  const _NutritionEstimate._() : super._();

  @override
  double get caloriesPer100g;
  @override
  double get proteinGPer100g;
  @override
  double get carbsGPer100g;
  @override
  double get fatGPer100g;
  @override
  double get fiberGPer100g;

  /// Carga FODMAP del plato: el maximo de sus ingredientes.
  @override
  FodmapLoad? get fodmapLevel;

  /// `true` si algun ingrediente no tenia composicion conocida.
  ///
  /// Pasa cuando el detalle no se pudo traer, tipicamente sin conexion. La
  /// estimacion sale igual con lo que hay, y decirlo evita presentar como
  /// completo un calculo que le falta la mitad.
  @override
  bool get isPartial;

  /// Create a copy of NutritionEstimate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionEstimateImplCopyWith<_$NutritionEstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CustomFoodDraft {
  String get name => throw _privateConstructorUsedError;
  double get portionSizeGrams => throw _privateConstructorUsedError;
  List<CustomFoodIngredientDraft> get ingredients =>
      throw _privateConstructorUsedError;

  /// Create a copy of CustomFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFoodDraftCopyWith<CustomFoodDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFoodDraftCopyWith<$Res> {
  factory $CustomFoodDraftCopyWith(
          CustomFoodDraft value, $Res Function(CustomFoodDraft) then) =
      _$CustomFoodDraftCopyWithImpl<$Res, CustomFoodDraft>;
  @useResult
  $Res call(
      {String name,
      double portionSizeGrams,
      List<CustomFoodIngredientDraft> ingredients});
}

/// @nodoc
class _$CustomFoodDraftCopyWithImpl<$Res, $Val extends CustomFoodDraft>
    implements $CustomFoodDraftCopyWith<$Res> {
  _$CustomFoodDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? portionSizeGrams = null,
    Object? ingredients = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      portionSizeGrams: null == portionSizeGrams
          ? _value.portionSizeGrams
          : portionSizeGrams // ignore: cast_nullable_to_non_nullable
              as double,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodIngredientDraft>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFoodDraftImplCopyWith<$Res>
    implements $CustomFoodDraftCopyWith<$Res> {
  factory _$$CustomFoodDraftImplCopyWith(_$CustomFoodDraftImpl value,
          $Res Function(_$CustomFoodDraftImpl) then) =
      __$$CustomFoodDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double portionSizeGrams,
      List<CustomFoodIngredientDraft> ingredients});
}

/// @nodoc
class __$$CustomFoodDraftImplCopyWithImpl<$Res>
    extends _$CustomFoodDraftCopyWithImpl<$Res, _$CustomFoodDraftImpl>
    implements _$$CustomFoodDraftImplCopyWith<$Res> {
  __$$CustomFoodDraftImplCopyWithImpl(
      _$CustomFoodDraftImpl _value, $Res Function(_$CustomFoodDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? portionSizeGrams = null,
    Object? ingredients = null,
  }) {
    return _then(_$CustomFoodDraftImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      portionSizeGrams: null == portionSizeGrams
          ? _value.portionSizeGrams
          : portionSizeGrams // ignore: cast_nullable_to_non_nullable
              as double,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodIngredientDraft>,
    ));
  }
}

/// @nodoc

class _$CustomFoodDraftImpl extends _CustomFoodDraft {
  const _$CustomFoodDraftImpl(
      {this.name = '',
      this.portionSizeGrams = 0,
      final List<CustomFoodIngredientDraft> ingredients =
          const <CustomFoodIngredientDraft>[]})
      : _ingredients = ingredients,
        super._();

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double portionSizeGrams;
  final List<CustomFoodIngredientDraft> _ingredients;
  @override
  @JsonKey()
  List<CustomFoodIngredientDraft> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  String toString() {
    return 'CustomFoodDraft(name: $name, portionSizeGrams: $portionSizeGrams, ingredients: $ingredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodDraftImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.portionSizeGrams, portionSizeGrams) ||
                other.portionSizeGrams == portionSizeGrams) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, portionSizeGrams,
      const DeepCollectionEquality().hash(_ingredients));

  /// Create a copy of CustomFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFoodDraftImplCopyWith<_$CustomFoodDraftImpl> get copyWith =>
      __$$CustomFoodDraftImplCopyWithImpl<_$CustomFoodDraftImpl>(
          this, _$identity);
}

abstract class _CustomFoodDraft extends CustomFoodDraft {
  const factory _CustomFoodDraft(
          {final String name,
          final double portionSizeGrams,
          final List<CustomFoodIngredientDraft> ingredients}) =
      _$CustomFoodDraftImpl;
  const _CustomFoodDraft._() : super._();

  @override
  String get name;
  @override
  double get portionSizeGrams;
  @override
  List<CustomFoodIngredientDraft> get ingredients;

  /// Create a copy of CustomFoodDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFoodDraftImplCopyWith<_$CustomFoodDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CustomFoodRecord {
  String get customFoodId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get portionSizeGrams => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<CustomFoodIngredientRef> get ingredients =>
      throw _privateConstructorUsedError;

  /// Create a copy of CustomFoodRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFoodRecordCopyWith<CustomFoodRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFoodRecordCopyWith<$Res> {
  factory $CustomFoodRecordCopyWith(
          CustomFoodRecord value, $Res Function(CustomFoodRecord) then) =
      _$CustomFoodRecordCopyWithImpl<$Res, CustomFoodRecord>;
  @useResult
  $Res call(
      {String customFoodId,
      String name,
      double portionSizeGrams,
      DateTime? createdAt,
      List<CustomFoodIngredientRef> ingredients});
}

/// @nodoc
class _$CustomFoodRecordCopyWithImpl<$Res, $Val extends CustomFoodRecord>
    implements $CustomFoodRecordCopyWith<$Res> {
  _$CustomFoodRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFoodRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customFoodId = null,
    Object? name = null,
    Object? portionSizeGrams = null,
    Object? createdAt = freezed,
    Object? ingredients = null,
  }) {
    return _then(_value.copyWith(
      customFoodId: null == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      portionSizeGrams: null == portionSizeGrams
          ? _value.portionSizeGrams
          : portionSizeGrams // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodIngredientRef>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFoodRecordImplCopyWith<$Res>
    implements $CustomFoodRecordCopyWith<$Res> {
  factory _$$CustomFoodRecordImplCopyWith(_$CustomFoodRecordImpl value,
          $Res Function(_$CustomFoodRecordImpl) then) =
      __$$CustomFoodRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String customFoodId,
      String name,
      double portionSizeGrams,
      DateTime? createdAt,
      List<CustomFoodIngredientRef> ingredients});
}

/// @nodoc
class __$$CustomFoodRecordImplCopyWithImpl<$Res>
    extends _$CustomFoodRecordCopyWithImpl<$Res, _$CustomFoodRecordImpl>
    implements _$$CustomFoodRecordImplCopyWith<$Res> {
  __$$CustomFoodRecordImplCopyWithImpl(_$CustomFoodRecordImpl _value,
      $Res Function(_$CustomFoodRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFoodRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customFoodId = null,
    Object? name = null,
    Object? portionSizeGrams = null,
    Object? createdAt = freezed,
    Object? ingredients = null,
  }) {
    return _then(_$CustomFoodRecordImpl(
      customFoodId: null == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      portionSizeGrams: null == portionSizeGrams
          ? _value.portionSizeGrams
          : portionSizeGrams // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodIngredientRef>,
    ));
  }
}

/// @nodoc

class _$CustomFoodRecordImpl extends _CustomFoodRecord {
  const _$CustomFoodRecordImpl(
      {required this.customFoodId,
      required this.name,
      required this.portionSizeGrams,
      this.createdAt,
      final List<CustomFoodIngredientRef> ingredients =
          const <CustomFoodIngredientRef>[]})
      : _ingredients = ingredients,
        super._();

  @override
  final String customFoodId;
  @override
  final String name;
  @override
  final double portionSizeGrams;
  @override
  final DateTime? createdAt;
  final List<CustomFoodIngredientRef> _ingredients;
  @override
  @JsonKey()
  List<CustomFoodIngredientRef> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  String toString() {
    return 'CustomFoodRecord(customFoodId: $customFoodId, name: $name, portionSizeGrams: $portionSizeGrams, createdAt: $createdAt, ingredients: $ingredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodRecordImpl &&
            (identical(other.customFoodId, customFoodId) ||
                other.customFoodId == customFoodId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.portionSizeGrams, portionSizeGrams) ||
                other.portionSizeGrams == portionSizeGrams) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      customFoodId,
      name,
      portionSizeGrams,
      createdAt,
      const DeepCollectionEquality().hash(_ingredients));

  /// Create a copy of CustomFoodRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFoodRecordImplCopyWith<_$CustomFoodRecordImpl> get copyWith =>
      __$$CustomFoodRecordImplCopyWithImpl<_$CustomFoodRecordImpl>(
          this, _$identity);
}

abstract class _CustomFoodRecord extends CustomFoodRecord {
  const factory _CustomFoodRecord(
          {required final String customFoodId,
          required final String name,
          required final double portionSizeGrams,
          final DateTime? createdAt,
          final List<CustomFoodIngredientRef> ingredients}) =
      _$CustomFoodRecordImpl;
  const _CustomFoodRecord._() : super._();

  @override
  String get customFoodId;
  @override
  String get name;
  @override
  double get portionSizeGrams;
  @override
  DateTime? get createdAt;
  @override
  List<CustomFoodIngredientRef> get ingredients;

  /// Create a copy of CustomFoodRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFoodRecordImplCopyWith<_$CustomFoodRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CustomFoodIngredientRef {
  String get foodId => throw _privateConstructorUsedError;
  double get proportionGrams => throw _privateConstructorUsedError;

  /// Create a copy of CustomFoodIngredientRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFoodIngredientRefCopyWith<CustomFoodIngredientRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFoodIngredientRefCopyWith<$Res> {
  factory $CustomFoodIngredientRefCopyWith(CustomFoodIngredientRef value,
          $Res Function(CustomFoodIngredientRef) then) =
      _$CustomFoodIngredientRefCopyWithImpl<$Res, CustomFoodIngredientRef>;
  @useResult
  $Res call({String foodId, double proportionGrams});
}

/// @nodoc
class _$CustomFoodIngredientRefCopyWithImpl<$Res,
        $Val extends CustomFoodIngredientRef>
    implements $CustomFoodIngredientRefCopyWith<$Res> {
  _$CustomFoodIngredientRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFoodIngredientRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? proportionGrams = null,
  }) {
    return _then(_value.copyWith(
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as String,
      proportionGrams: null == proportionGrams
          ? _value.proportionGrams
          : proportionGrams // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFoodIngredientRefImplCopyWith<$Res>
    implements $CustomFoodIngredientRefCopyWith<$Res> {
  factory _$$CustomFoodIngredientRefImplCopyWith(
          _$CustomFoodIngredientRefImpl value,
          $Res Function(_$CustomFoodIngredientRefImpl) then) =
      __$$CustomFoodIngredientRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String foodId, double proportionGrams});
}

/// @nodoc
class __$$CustomFoodIngredientRefImplCopyWithImpl<$Res>
    extends _$CustomFoodIngredientRefCopyWithImpl<$Res,
        _$CustomFoodIngredientRefImpl>
    implements _$$CustomFoodIngredientRefImplCopyWith<$Res> {
  __$$CustomFoodIngredientRefImplCopyWithImpl(
      _$CustomFoodIngredientRefImpl _value,
      $Res Function(_$CustomFoodIngredientRefImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFoodIngredientRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? proportionGrams = null,
  }) {
    return _then(_$CustomFoodIngredientRefImpl(
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as String,
      proportionGrams: null == proportionGrams
          ? _value.proportionGrams
          : proportionGrams // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CustomFoodIngredientRefImpl extends _CustomFoodIngredientRef {
  const _$CustomFoodIngredientRefImpl(
      {required this.foodId, required this.proportionGrams})
      : super._();

  @override
  final String foodId;
  @override
  final double proportionGrams;

  @override
  String toString() {
    return 'CustomFoodIngredientRef(foodId: $foodId, proportionGrams: $proportionGrams)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodIngredientRefImpl &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.proportionGrams, proportionGrams) ||
                other.proportionGrams == proportionGrams));
  }

  @override
  int get hashCode => Object.hash(runtimeType, foodId, proportionGrams);

  /// Create a copy of CustomFoodIngredientRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFoodIngredientRefImplCopyWith<_$CustomFoodIngredientRefImpl>
      get copyWith => __$$CustomFoodIngredientRefImplCopyWithImpl<
          _$CustomFoodIngredientRefImpl>(this, _$identity);
}

abstract class _CustomFoodIngredientRef extends CustomFoodIngredientRef {
  const factory _CustomFoodIngredientRef(
      {required final String foodId,
      required final double proportionGrams}) = _$CustomFoodIngredientRefImpl;
  const _CustomFoodIngredientRef._() : super._();

  @override
  String get foodId;
  @override
  double get proportionGrams;

  /// Create a copy of CustomFoodIngredientRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFoodIngredientRefImplCopyWith<_$CustomFoodIngredientRefImpl>
      get copyWith => throw _privateConstructorUsedError;
}
