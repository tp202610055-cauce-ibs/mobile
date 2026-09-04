//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/meal_item_request.dart';
import 'package:cauce_api_client/src/model/meal_time.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meal_batch_item.g.dart';

/// MealBatchItem
///
/// Properties:
/// * [clientGuid] 
/// * [mealTime] 
/// * [consumedAt] 
/// * [clientCreatedAt] 
/// * [items] 
@BuiltValue()
abstract class MealBatchItem implements Built<MealBatchItem, MealBatchItemBuilder> {
  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'mealTime')
  MealTime? get mealTime;
  // enum mealTimeEnum {  Breakfast,  Lunch,  Dinner,  Snack,  };

  @BuiltValueField(wireName: r'consumedAt')
  DateTime? get consumedAt;

  @BuiltValueField(wireName: r'clientCreatedAt')
  DateTime? get clientCreatedAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<MealItemRequest>? get items;

  MealBatchItem._();

  factory MealBatchItem([void updates(MealBatchItemBuilder b)]) = _$MealBatchItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MealBatchItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MealBatchItem> get serializer => _$MealBatchItemSerializer();
}

class _$MealBatchItemSerializer implements PrimitiveSerializer<MealBatchItem> {
  @override
  final Iterable<Type> types = const [MealBatchItem, _$MealBatchItem];

  @override
  final String wireName = r'MealBatchItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MealBatchItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clientGuid != null) {
      yield r'clientGuid';
      yield serializers.serialize(
        object.clientGuid,
        specifiedType: const FullType(String),
      );
    }
    if (object.mealTime != null) {
      yield r'mealTime';
      yield serializers.serialize(
        object.mealTime,
        specifiedType: const FullType(MealTime),
      );
    }
    if (object.consumedAt != null) {
      yield r'consumedAt';
      yield serializers.serialize(
        object.consumedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.clientCreatedAt != null) {
      yield r'clientCreatedAt';
      yield serializers.serialize(
        object.clientCreatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(MealItemRequest)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MealBatchItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MealBatchItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clientGuid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientGuid = valueDes;
          break;
        case r'mealTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MealTime),
          ) as MealTime;
          result.mealTime = valueDes;
          break;
        case r'consumedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.consumedAt = valueDes;
          break;
        case r'clientCreatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.clientCreatedAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(MealItemRequest)]),
          ) as BuiltList<MealItemRequest>?;
          if (valueDes == null) continue;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MealBatchItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MealBatchItemBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

