//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/meal_history_item.dart';
import 'package:cauce_api_client/src/model/history_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meal_history_event.g.dart';

/// MealHistoryEvent
///
/// Properties:
/// * [eventType] 
/// * [occurredAt] 
/// * [meal] 
@BuiltValue()
abstract class MealHistoryEvent implements HistoryEvent, Built<MealHistoryEvent, MealHistoryEventBuilder> {
  @BuiltValueField(wireName: r'meal')
  MealHistoryItem? get meal;

  MealHistoryEvent._();

  factory MealHistoryEvent([void updates(MealHistoryEventBuilder b)]) = _$MealHistoryEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MealHistoryEventBuilder b) => b..eventType=b.discriminatorValue;

  @BuiltValueSerializer(custom: true)
  static Serializer<MealHistoryEvent> get serializer => _$MealHistoryEventSerializer();
}

class _$MealHistoryEventSerializer implements PrimitiveSerializer<MealHistoryEvent> {
  @override
  final Iterable<Type> types = const [MealHistoryEvent, _$MealHistoryEvent];

  @override
  final String wireName = r'MealHistoryEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MealHistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.meal != null) {
      yield r'meal';
      yield serializers.serialize(
        object.meal,
        specifiedType: const FullType(MealHistoryItem),
      );
    }
    if (object.occurredAt != null) {
      yield r'occurredAt';
      yield serializers.serialize(
        object.occurredAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'eventType';
    yield serializers.serialize(
      object.eventType,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MealHistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MealHistoryEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'meal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MealHistoryItem),
          ) as MealHistoryItem;
          result.meal.replace(valueDes);
          break;
        case r'occurredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        case r'eventType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.eventType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MealHistoryEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MealHistoryEventBuilder();
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

