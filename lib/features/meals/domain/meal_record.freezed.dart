// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreatedMeal {
  String get mealId => throw _privateConstructorUsedError;

  /// Carga FODMAP agregada de la comida, que calcula el servidor.
  ///
  /// La regla de hoy es el maximo nivel entre los ingredientes con peso; el
  /// backend deja anotado que se refinara con umbrales de carga acumulada de
  /// Monash cuando esten los datos. El cliente no la recalcula.
  FodmapLoad? get aggregatedFodmap => throw _privateConstructorUsedError;

  /// `true` si el servidor reconocio un `client_guid` ya registrado y
  /// respondio 200 en vez de 201.
  bool get wasReplay => throw _privateConstructorUsedError;

  /// Create a copy of CreatedMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatedMealCopyWith<CreatedMeal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedMealCopyWith<$Res> {
  factory $CreatedMealCopyWith(
          CreatedMeal value, $Res Function(CreatedMeal) then) =
      _$CreatedMealCopyWithImpl<$Res, CreatedMeal>;
  @useResult
  $Res call({String mealId, FodmapLoad? aggregatedFodmap, bool wasReplay});
}

/// @nodoc
class _$CreatedMealCopyWithImpl<$Res, $Val extends CreatedMeal>
    implements $CreatedMealCopyWith<$Res> {
  _$CreatedMealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatedMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? aggregatedFodmap = freezed,
    Object? wasReplay = null,
  }) {
    return _then(_value.copyWith(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      wasReplay: null == wasReplay
          ? _value.wasReplay
          : wasReplay // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatedMealImplCopyWith<$Res>
    implements $CreatedMealCopyWith<$Res> {
  factory _$$CreatedMealImplCopyWith(
          _$CreatedMealImpl value, $Res Function(_$CreatedMealImpl) then) =
      __$$CreatedMealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mealId, FodmapLoad? aggregatedFodmap, bool wasReplay});
}

/// @nodoc
class __$$CreatedMealImplCopyWithImpl<$Res>
    extends _$CreatedMealCopyWithImpl<$Res, _$CreatedMealImpl>
    implements _$$CreatedMealImplCopyWith<$Res> {
  __$$CreatedMealImplCopyWithImpl(
      _$CreatedMealImpl _value, $Res Function(_$CreatedMealImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatedMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? aggregatedFodmap = freezed,
    Object? wasReplay = null,
  }) {
    return _then(_$CreatedMealImpl(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      wasReplay: null == wasReplay
          ? _value.wasReplay
          : wasReplay // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreatedMealImpl extends _CreatedMeal {
  const _$CreatedMealImpl(
      {required this.mealId, this.aggregatedFodmap, this.wasReplay = false})
      : super._();

  @override
  final String mealId;

  /// Carga FODMAP agregada de la comida, que calcula el servidor.
  ///
  /// La regla de hoy es el maximo nivel entre los ingredientes con peso; el
  /// backend deja anotado que se refinara con umbrales de carga acumulada de
  /// Monash cuando esten los datos. El cliente no la recalcula.
  @override
  final FodmapLoad? aggregatedFodmap;

  /// `true` si el servidor reconocio un `client_guid` ya registrado y
  /// respondio 200 en vez de 201.
  @override
  @JsonKey()
  final bool wasReplay;

  @override
  String toString() {
    return 'CreatedMeal(mealId: $mealId, aggregatedFodmap: $aggregatedFodmap, wasReplay: $wasReplay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedMealImpl &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.aggregatedFodmap, aggregatedFodmap) ||
                other.aggregatedFodmap == aggregatedFodmap) &&
            (identical(other.wasReplay, wasReplay) ||
                other.wasReplay == wasReplay));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, mealId, aggregatedFodmap, wasReplay);

  /// Create a copy of CreatedMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedMealImplCopyWith<_$CreatedMealImpl> get copyWith =>
      __$$CreatedMealImplCopyWithImpl<_$CreatedMealImpl>(this, _$identity);
}

abstract class _CreatedMeal extends CreatedMeal {
  const factory _CreatedMeal(
      {required final String mealId,
      final FodmapLoad? aggregatedFodmap,
      final bool wasReplay}) = _$CreatedMealImpl;
  const _CreatedMeal._() : super._();

  @override
  String get mealId;

  /// Carga FODMAP agregada de la comida, que calcula el servidor.
  ///
  /// La regla de hoy es el maximo nivel entre los ingredientes con peso; el
  /// backend deja anotado que se refinara con umbrales de carga acumulada de
  /// Monash cuando esten los datos. El cliente no la recalcula.
  @override
  FodmapLoad? get aggregatedFodmap;

  /// `true` si el servidor reconocio un `client_guid` ya registrado y
  /// respondio 200 en vez de 201.
  @override
  bool get wasReplay;

  /// Create a copy of CreatedMeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedMealImplCopyWith<_$CreatedMealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MealRecordItem {
  double get quantity => throw _privateConstructorUsedError;
  String? get foodId => throw _privateConstructorUsedError;
  String? get customFoodId => throw _privateConstructorUsedError;
  MeasurementUnitOption? get unit => throw _privateConstructorUsedError;

  /// Create a copy of MealRecordItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealRecordItemCopyWith<MealRecordItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealRecordItemCopyWith<$Res> {
  factory $MealRecordItemCopyWith(
          MealRecordItem value, $Res Function(MealRecordItem) then) =
      _$MealRecordItemCopyWithImpl<$Res, MealRecordItem>;
  @useResult
  $Res call(
      {double quantity,
      String? foodId,
      String? customFoodId,
      MeasurementUnitOption? unit});
}

/// @nodoc
class _$MealRecordItemCopyWithImpl<$Res, $Val extends MealRecordItem>
    implements $MealRecordItemCopyWith<$Res> {
  _$MealRecordItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealRecordItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? foodId = freezed,
    Object? customFoodId = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      foodId: freezed == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as String?,
      customFoodId: freezed == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitOption?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealRecordItemImplCopyWith<$Res>
    implements $MealRecordItemCopyWith<$Res> {
  factory _$$MealRecordItemImplCopyWith(_$MealRecordItemImpl value,
          $Res Function(_$MealRecordItemImpl) then) =
      __$$MealRecordItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double quantity,
      String? foodId,
      String? customFoodId,
      MeasurementUnitOption? unit});
}

/// @nodoc
class __$$MealRecordItemImplCopyWithImpl<$Res>
    extends _$MealRecordItemCopyWithImpl<$Res, _$MealRecordItemImpl>
    implements _$$MealRecordItemImplCopyWith<$Res> {
  __$$MealRecordItemImplCopyWithImpl(
      _$MealRecordItemImpl _value, $Res Function(_$MealRecordItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRecordItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? foodId = freezed,
    Object? customFoodId = freezed,
    Object? unit = freezed,
  }) {
    return _then(_$MealRecordItemImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      foodId: freezed == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as String?,
      customFoodId: freezed == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitOption?,
    ));
  }
}

/// @nodoc

class _$MealRecordItemImpl extends _MealRecordItem {
  const _$MealRecordItemImpl(
      {required this.quantity, this.foodId, this.customFoodId, this.unit})
      : super._();

  @override
  final double quantity;
  @override
  final String? foodId;
  @override
  final String? customFoodId;
  @override
  final MeasurementUnitOption? unit;

  @override
  String toString() {
    return 'MealRecordItem(quantity: $quantity, foodId: $foodId, customFoodId: $customFoodId, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealRecordItemImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.customFoodId, customFoodId) ||
                other.customFoodId == customFoodId) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, quantity, foodId, customFoodId, unit);

  /// Create a copy of MealRecordItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealRecordItemImplCopyWith<_$MealRecordItemImpl> get copyWith =>
      __$$MealRecordItemImplCopyWithImpl<_$MealRecordItemImpl>(
          this, _$identity);
}

abstract class _MealRecordItem extends MealRecordItem {
  const factory _MealRecordItem(
      {required final double quantity,
      final String? foodId,
      final String? customFoodId,
      final MeasurementUnitOption? unit}) = _$MealRecordItemImpl;
  const _MealRecordItem._() : super._();

  @override
  double get quantity;
  @override
  String? get foodId;
  @override
  String? get customFoodId;
  @override
  MeasurementUnitOption? get unit;

  /// Create a copy of MealRecordItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealRecordItemImplCopyWith<_$MealRecordItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MealRecord {
  String get mealId => throw _privateConstructorUsedError;
  DateTime get consumedAt => throw _privateConstructorUsedError;
  String? get clientGuid => throw _privateConstructorUsedError;
  MealTimeOption? get mealTime => throw _privateConstructorUsedError;
  FodmapLoad? get aggregatedFodmap => throw _privateConstructorUsedError;
  List<MealRecordItem> get items => throw _privateConstructorUsedError;

  /// Create a copy of MealRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealRecordCopyWith<MealRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealRecordCopyWith<$Res> {
  factory $MealRecordCopyWith(
          MealRecord value, $Res Function(MealRecord) then) =
      _$MealRecordCopyWithImpl<$Res, MealRecord>;
  @useResult
  $Res call(
      {String mealId,
      DateTime consumedAt,
      String? clientGuid,
      MealTimeOption? mealTime,
      FodmapLoad? aggregatedFodmap,
      List<MealRecordItem> items});
}

/// @nodoc
class _$MealRecordCopyWithImpl<$Res, $Val extends MealRecord>
    implements $MealRecordCopyWith<$Res> {
  _$MealRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? consumedAt = null,
    Object? clientGuid = freezed,
    Object? mealTime = freezed,
    Object? aggregatedFodmap = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      consumedAt: null == consumedAt
          ? _value.consumedAt
          : consumedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clientGuid: freezed == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String?,
      mealTime: freezed == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MealRecordItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealRecordImplCopyWith<$Res>
    implements $MealRecordCopyWith<$Res> {
  factory _$$MealRecordImplCopyWith(
          _$MealRecordImpl value, $Res Function(_$MealRecordImpl) then) =
      __$$MealRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mealId,
      DateTime consumedAt,
      String? clientGuid,
      MealTimeOption? mealTime,
      FodmapLoad? aggregatedFodmap,
      List<MealRecordItem> items});
}

/// @nodoc
class __$$MealRecordImplCopyWithImpl<$Res>
    extends _$MealRecordCopyWithImpl<$Res, _$MealRecordImpl>
    implements _$$MealRecordImplCopyWith<$Res> {
  __$$MealRecordImplCopyWithImpl(
      _$MealRecordImpl _value, $Res Function(_$MealRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? consumedAt = null,
    Object? clientGuid = freezed,
    Object? mealTime = freezed,
    Object? aggregatedFodmap = freezed,
    Object? items = null,
  }) {
    return _then(_$MealRecordImpl(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      consumedAt: null == consumedAt
          ? _value.consumedAt
          : consumedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      clientGuid: freezed == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String?,
      mealTime: freezed == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MealRecordItem>,
    ));
  }
}

/// @nodoc

class _$MealRecordImpl extends _MealRecord {
  const _$MealRecordImpl(
      {required this.mealId,
      required this.consumedAt,
      this.clientGuid,
      this.mealTime,
      this.aggregatedFodmap,
      final List<MealRecordItem> items = const <MealRecordItem>[]})
      : _items = items,
        super._();

  @override
  final String mealId;
  @override
  final DateTime consumedAt;
  @override
  final String? clientGuid;
  @override
  final MealTimeOption? mealTime;
  @override
  final FodmapLoad? aggregatedFodmap;
  final List<MealRecordItem> _items;
  @override
  @JsonKey()
  List<MealRecordItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'MealRecord(mealId: $mealId, consumedAt: $consumedAt, clientGuid: $clientGuid, mealTime: $mealTime, aggregatedFodmap: $aggregatedFodmap, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealRecordImpl &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.consumedAt, consumedAt) ||
                other.consumedAt == consumedAt) &&
            (identical(other.clientGuid, clientGuid) ||
                other.clientGuid == clientGuid) &&
            (identical(other.mealTime, mealTime) ||
                other.mealTime == mealTime) &&
            (identical(other.aggregatedFodmap, aggregatedFodmap) ||
                other.aggregatedFodmap == aggregatedFodmap) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mealId, consumedAt, clientGuid,
      mealTime, aggregatedFodmap, const DeepCollectionEquality().hash(_items));

  /// Create a copy of MealRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealRecordImplCopyWith<_$MealRecordImpl> get copyWith =>
      __$$MealRecordImplCopyWithImpl<_$MealRecordImpl>(this, _$identity);
}

abstract class _MealRecord extends MealRecord {
  const factory _MealRecord(
      {required final String mealId,
      required final DateTime consumedAt,
      final String? clientGuid,
      final MealTimeOption? mealTime,
      final FodmapLoad? aggregatedFodmap,
      final List<MealRecordItem> items}) = _$MealRecordImpl;
  const _MealRecord._() : super._();

  @override
  String get mealId;
  @override
  DateTime get consumedAt;
  @override
  String? get clientGuid;
  @override
  MealTimeOption? get mealTime;
  @override
  FodmapLoad? get aggregatedFodmap;
  @override
  List<MealRecordItem> get items;

  /// Create a copy of MealRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealRecordImplCopyWith<_$MealRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MealHistoryPage {
  List<MealRecord> get items => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  /// Create a copy of MealHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealHistoryPageCopyWith<MealHistoryPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealHistoryPageCopyWith<$Res> {
  factory $MealHistoryPageCopyWith(
          MealHistoryPage value, $Res Function(MealHistoryPage) then) =
      _$MealHistoryPageCopyWithImpl<$Res, MealHistoryPage>;
  @useResult
  $Res call({List<MealRecord> items, int page, int pageSize, int totalCount});
}

/// @nodoc
class _$MealHistoryPageCopyWithImpl<$Res, $Val extends MealHistoryPage>
    implements $MealHistoryPageCopyWith<$Res> {
  _$MealHistoryPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalCount = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MealRecord>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealHistoryPageImplCopyWith<$Res>
    implements $MealHistoryPageCopyWith<$Res> {
  factory _$$MealHistoryPageImplCopyWith(_$MealHistoryPageImpl value,
          $Res Function(_$MealHistoryPageImpl) then) =
      __$$MealHistoryPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MealRecord> items, int page, int pageSize, int totalCount});
}

/// @nodoc
class __$$MealHistoryPageImplCopyWithImpl<$Res>
    extends _$MealHistoryPageCopyWithImpl<$Res, _$MealHistoryPageImpl>
    implements _$$MealHistoryPageImplCopyWith<$Res> {
  __$$MealHistoryPageImplCopyWithImpl(
      _$MealHistoryPageImpl _value, $Res Function(_$MealHistoryPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalCount = null,
  }) {
    return _then(_$MealHistoryPageImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<MealRecord>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MealHistoryPageImpl extends _MealHistoryPage {
  const _$MealHistoryPageImpl(
      {final List<MealRecord> items = const <MealRecord>[],
      this.page = 1,
      this.pageSize = 50,
      this.totalCount = 0})
      : _items = items,
        super._();

  final List<MealRecord> _items;
  @override
  @JsonKey()
  List<MealRecord> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final int totalCount;

  @override
  String toString() {
    return 'MealHistoryPage(items: $items, page: $page, pageSize: $pageSize, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealHistoryPageImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), page, pageSize, totalCount);

  /// Create a copy of MealHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealHistoryPageImplCopyWith<_$MealHistoryPageImpl> get copyWith =>
      __$$MealHistoryPageImplCopyWithImpl<_$MealHistoryPageImpl>(
          this, _$identity);
}

abstract class _MealHistoryPage extends MealHistoryPage {
  const factory _MealHistoryPage(
      {final List<MealRecord> items,
      final int page,
      final int pageSize,
      final int totalCount}) = _$MealHistoryPageImpl;
  const _MealHistoryPage._() : super._();

  @override
  List<MealRecord> get items;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get totalCount;

  /// Create a copy of MealHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealHistoryPageImplCopyWith<_$MealHistoryPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
