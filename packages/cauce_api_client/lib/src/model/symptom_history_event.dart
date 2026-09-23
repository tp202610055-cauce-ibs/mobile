//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/symptom_history_item.dart';
import 'package:cauce_api_client/src/model/history_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'symptom_history_event.g.dart';

/// SymptomHistoryEvent
///
/// Properties:
/// * [eventType] 
/// * [occurredAt] 
/// * [symptom] 
@BuiltValue()
abstract class SymptomHistoryEvent implements HistoryEvent, Built<SymptomHistoryEvent, SymptomHistoryEventBuilder> {
  @BuiltValueField(wireName: r'symptom')
  SymptomHistoryItem? get symptom;

  SymptomHistoryEvent._();

  factory SymptomHistoryEvent([void updates(SymptomHistoryEventBuilder b)]) = _$SymptomHistoryEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SymptomHistoryEventBuilder b) => b..eventType=b.discriminatorValue;

  @BuiltValueSerializer(custom: true)
  static Serializer<SymptomHistoryEvent> get serializer => _$SymptomHistoryEventSerializer();
}

class _$SymptomHistoryEventSerializer implements PrimitiveSerializer<SymptomHistoryEvent> {
  @override
  final Iterable<Type> types = const [SymptomHistoryEvent, _$SymptomHistoryEvent];

  @override
  final String wireName = r'SymptomHistoryEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SymptomHistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.symptom != null) {
      yield r'symptom';
      yield serializers.serialize(
        object.symptom,
        specifiedType: const FullType(SymptomHistoryItem),
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
    SymptomHistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SymptomHistoryEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symptom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SymptomHistoryItem),
          ) as SymptomHistoryItem;
          result.symptom.replace(valueDes);
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
  SymptomHistoryEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SymptomHistoryEventBuilder();
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

