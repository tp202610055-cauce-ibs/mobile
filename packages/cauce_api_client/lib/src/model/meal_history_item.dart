//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/meal_item_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/fodmap_level.dart';
import 'package:cauce_api_client/src/model/meal_time.dart';
import 'package:cauce_api_client/src/model/sync_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meal_history_item.g.dart';

/// MealHistoryItem
///
/// Properties:
/// * [mealId] 
/// * [clientGuid] 
/// * [mealTime] 
/// * [consumedAt] 
/// * [clientCreatedAt] 
/// * [syncStatus] 
/// * [items] 
/// * [aggregatedFodmap] 
@BuiltValue()
abstract class MealHistoryItem implements Built<MealHistoryItem, MealHistoryItemBuilder> {
  @BuiltValueField(wireName: r'mealId')
  String? get mealId;

  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'mealTime')
  MealTime? get mealTime;
  // enum mealTimeEnum {  Breakfast,  Lunch,  Dinner,  Snack,  };

  @BuiltValueField(wireName: r'consumedAt')
  DateTime? get consumedAt;

  @BuiltValueField(wireName: r'clientCreatedAt')
  DateTime? get clientCreatedAt;

  @BuiltValueField(wireName: r'syncStatus')
  SyncStatus? get syncStatus;
  // enum syncStatusEnum {  SyncPending,  SyncCompleted,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<MealItemSummary>? get items;

  @BuiltValueField(wireName: r'aggregatedFodmap')
  FodmapLevel? get aggregatedFodmap;
  // enum aggregatedFodmapEnum {  Low,  Moderate,  High,  };

  MealHistoryItem._();

  factory MealHistoryItem([void updates(MealHistoryItemBuilder b)]) = _$MealHistoryItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MealHistoryItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MealHistoryItem> get serializer => _$MealHistoryItemSerializer();
}

class _$MealHistoryItemSerializer implements PrimitiveSerializer<MealHistoryItem> {
  @override
  final Iterable<Type> types = const [MealHistoryItem, _$MealHistoryItem];

  @override
  final String wireName = r'MealHistoryItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MealHistoryItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.mealId != null) {
      yield r'mealId';
      yield serializers.serialize(
        object.mealId,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.syncStatus != null) {
      yield r'syncStatus';
      yield serializers.serialize(
        object.syncStatus,
        specifiedType: const FullType(SyncStatus),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(MealItemSummary)]),
      );
    }
    if (object.aggregatedFodmap != null) {
      yield r'aggregatedFodmap';
      yield serializers.serialize(
        object.aggregatedFodmap,
        specifiedType: const FullType(FodmapLevel),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MealHistoryItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MealHistoryItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mealId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mealId = valueDes;
          break;
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
        case r'syncStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SyncStatus),
          ) as SyncStatus;
          result.syncStatus = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(MealItemSummary)]),
          ) as BuiltList<MealItemSummary>?;
          if (valueDes == null) continue;
          result.items.replace(valueDes);
          break;
        case r'aggregatedFodmap':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FodmapLevel),
          ) as FodmapLevel;
          result.aggregatedFodmap = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MealHistoryItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MealHistoryItemBuilder();
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

