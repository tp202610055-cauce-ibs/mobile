// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MealItemDraft {
  double get quantity => throw _privateConstructorUsedError;
  MeasurementUnitOption get unit => throw _privateConstructorUsedError;

  /// Alimento del catalogo, con lo que se sepa de el.
  FoodItem? get food => throw _privateConstructorUsedError;

  /// Plato personalizado ya creado en el servidor.
  String? get customFoodId => throw _privateConstructorUsedError;

  /// Nombre del plato personalizado, solo para mostrarlo.
  String? get customFoodName => throw _privateConstructorUsedError;

  /// Create a copy of MealItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealItemDraftCopyWith<MealItemDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealItemDraftCopyWith<$Res> {
  factory $MealItemDraftCopyWith(
          MealItemDraft value, $Res Function(MealItemDraft) then) =
      _$MealItemDraftCopyWithImpl<$Res, MealItemDraft>;
  @useResult
  $Res call(
      {double quantity,
      MeasurementUnitOption unit,
      FoodItem? food,
      String? customFoodId,
      String? customFoodName});

  $FoodItemCopyWith<$Res>? get food;
}

/// @nodoc
class _$MealItemDraftCopyWithImpl<$Res, $Val extends MealItemDraft>
    implements $MealItemDraftCopyWith<$Res> {
  _$MealItemDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? unit = null,
    Object? food = freezed,
    Object? customFoodId = freezed,
    Object? customFoodName = freezed,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitOption,
      food: freezed == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as FoodItem?,
      customFoodId: freezed == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String?,
      customFoodName: freezed == customFoodName
          ? _value.customFoodName
          : customFoodName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MealItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodItemCopyWith<$Res>? get food {
    if (_value.food == null) {
      return null;
    }

    return $FoodItemCopyWith<$Res>(_value.food!, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealItemDraftImplCopyWith<$Res>
    implements $MealItemDraftCopyWith<$Res> {
  factory _$$MealItemDraftImplCopyWith(
          _$MealItemDraftImpl value, $Res Function(_$MealItemDraftImpl) then) =
      __$$MealItemDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double quantity,
      MeasurementUnitOption unit,
      FoodItem? food,
      String? customFoodId,
      String? customFoodName});

  @override
  $FoodItemCopyWith<$Res>? get food;
}

/// @nodoc
class __$$MealItemDraftImplCopyWithImpl<$Res>
    extends _$MealItemDraftCopyWithImpl<$Res, _$MealItemDraftImpl>
    implements _$$MealItemDraftImplCopyWith<$Res> {
  __$$MealItemDraftImplCopyWithImpl(
      _$MealItemDraftImpl _value, $Res Function(_$MealItemDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? unit = null,
    Object? food = freezed,
    Object? customFoodId = freezed,
    Object? customFoodName = freezed,
  }) {
    return _then(_$MealItemDraftImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitOption,
      food: freezed == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as FoodItem?,
      customFoodId: freezed == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String?,
      customFoodName: freezed == customFoodName
          ? _value.customFoodName
          : customFoodName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MealItemDraftImpl extends _MealItemDraft {
  const _$MealItemDraftImpl(
      {required this.quantity,
      required this.unit,
      this.food,
      this.customFoodId,
      this.customFoodName})
      : super._();

  @override
  final double quantity;
  @override
  final MeasurementUnitOption unit;

  /// Alimento del catalogo, con lo que se sepa de el.
  @override
  final FoodItem? food;

  /// Plato personalizado ya creado en el servidor.
  @override
  final String? customFoodId;

  /// Nombre del plato personalizado, solo para mostrarlo.
  @override
  final String? customFoodName;

  @override
  String toString() {
    return 'MealItemDraft(quantity: $quantity, unit: $unit, food: $food, customFoodId: $customFoodId, customFoodName: $customFoodName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealItemDraftImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.customFoodId, customFoodId) ||
                other.customFoodId == customFoodId) &&
            (identical(other.customFoodName, customFoodName) ||
                other.customFoodName == customFoodName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, quantity, unit, food, customFoodId, customFoodName);

  /// Create a copy of MealItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealItemDraftImplCopyWith<_$MealItemDraftImpl> get copyWith =>
      __$$MealItemDraftImplCopyWithImpl<_$MealItemDraftImpl>(this, _$identity);
}

abstract class _MealItemDraft extends MealItemDraft {
  const factory _MealItemDraft(
      {required final double quantity,
      required final MeasurementUnitOption unit,
      final FoodItem? food,
      final String? customFoodId,
      final String? customFoodName}) = _$MealItemDraftImpl;
  const _MealItemDraft._() : super._();

  @override
  double get quantity;
  @override
  MeasurementUnitOption get unit;

  /// Alimento del catalogo, con lo que se sepa de el.
  @override
  FoodItem? get food;

  /// Plato personalizado ya creado en el servidor.
  @override
  String? get customFoodId;

  /// Nombre del plato personalizado, solo para mostrarlo.
  @override
  String? get customFoodName;

  /// Create a copy of MealItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealItemDraftImplCopyWith<_$MealItemDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MealDraft {
  MealTimeOption? get mealTime => throw _privateConstructorUsedError;
  DateTime? get consumedAt => throw _privateConstructorUsedError;
  List<MealItemDraft> get items => throw _privateConstructorUsedError;

  /// Create a copy of MealDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealDraftCopyWith<MealDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealDraftCopyWith<$Res> {
  factory $MealDraftCopyWith(MealDraft value, $Res Function(MealDraft) then) =
      _$MealDraftCopyWithImpl<$Res, MealDraft>;
  @useResult
  $Res call(
      {MealTimeOption? mealTime,
      DateTime? consumedAt,
      List<MealItemDraft> items});
}

/// @nodoc
class _$MealDraftCopyWithImpl<$Res, $Val extends MealDraft>
    implements $MealDraftCopyWith<$Res> {
  _$MealDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealTime = freezed,
    Object? consumedAt = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      mealTime: freezed == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      consumedAt: freezed == consumedAt
          ? _value.consumedAt
          : consumedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MealItemDraft>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealDraftImplCopyWith<$Res>
    implements $MealDraftCopyWith<$Res> {
  factory _$$MealDraftImplCopyWith(
          _$MealDraftImpl value, $Res Function(_$MealDraftImpl) then) =
      __$$MealDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MealTimeOption? mealTime,
      DateTime? consumedAt,
      List<MealItemDraft> items});
}

/// @nodoc
class __$$MealDraftImplCopyWithImpl<$Res>
    extends _$MealDraftCopyWithImpl<$Res, _$MealDraftImpl>
    implements _$$MealDraftImplCopyWith<$Res> {
  __$$MealDraftImplCopyWithImpl(
      _$MealDraftImpl _value, $Res Function(_$MealDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealTime = freezed,
    Object? consumedAt = freezed,
    Object? items = null,
  }) {
    return _then(_$MealDraftImpl(
      mealTime: freezed == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      consumedAt: freezed == consumedAt
          ? _value.consumedAt
          : consumedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MealItemDraft>,
    ));
  }
}

/// @nodoc

class _$MealDraftImpl extends _MealDraft {
  const _$MealDraftImpl(
      {this.mealTime,
      this.consumedAt,
      final List<MealItemDraft> items = const <MealItemDraft>[]})
      : _items = items,
        super._();

  @override
  final MealTimeOption? mealTime;
  @override
  final DateTime? consumedAt;
  final List<MealItemDraft> _items;
  @override
  @JsonKey()
  List<MealItemDraft> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'MealDraft(mealTime: $mealTime, consumedAt: $consumedAt, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealDraftImpl &&
            (identical(other.mealTime, mealTime) ||
                other.mealTime == mealTime) &&
            (identical(other.consumedAt, consumedAt) ||
                other.consumedAt == consumedAt) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mealTime, consumedAt,
      const DeepCollectionEquality().hash(_items));

  /// Create a copy of MealDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealDraftImplCopyWith<_$MealDraftImpl> get copyWith =>
      __$$MealDraftImplCopyWithImpl<_$MealDraftImpl>(this, _$identity);
}

abstract class _MealDraft extends MealDraft {
  const factory _MealDraft(
      {final MealTimeOption? mealTime,
      final DateTime? consumedAt,
      final List<MealItemDraft> items}) = _$MealDraftImpl;
  const _MealDraft._() : super._();

  @override
  MealTimeOption? get mealTime;
  @override
  DateTime? get consumedAt;
  @override
  List<MealItemDraft> get items;

  /// Create a copy of MealDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealDraftImplCopyWith<_$MealDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
