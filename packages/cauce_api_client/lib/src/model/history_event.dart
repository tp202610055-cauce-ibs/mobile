//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/clinical_note_history_event.dart';
import 'package:cauce_api_client/src/model/symptom_history_event.dart';
import 'package:cauce_api_client/src/model/meal_history_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'history_event.g.dart';

/// HistoryEvent
///
/// Properties:
/// * [eventType] 
/// * [occurredAt] 
@BuiltValue(instantiable: false)
abstract class HistoryEvent  {
  @BuiltValueField(wireName: r'eventType')
  String get eventType;

  @BuiltValueField(wireName: r'occurredAt')
  DateTime? get occurredAt;

  static const String discriminatorFieldName = r'eventType';

  static const Map<String, Type> discriminatorMapping = {
    r'clinical_note': ClinicalNoteHistoryEvent,
    r'meal': MealHistoryEvent,
    r'symptom': SymptomHistoryEvent,
  };

  @BuiltValueSerializer(custom: true)
  static Serializer<HistoryEvent> get serializer => _$HistoryEventSerializer();
}

extension HistoryEventDiscriminatorExt on HistoryEvent {
    String? get discriminatorValue {
        if (this is ClinicalNoteHistoryEvent) {
            return r'clinical_note';
        }
        if (this is MealHistoryEvent) {
            return r'meal';
        }
        if (this is SymptomHistoryEvent) {
            return r'symptom';
        }
        return null;
    }
}
extension HistoryEventBuilderDiscriminatorExt on HistoryEventBuilder {
    String? get discriminatorValue {
        if (this is ClinicalNoteHistoryEventBuilder) {
            return r'clinical_note';
        }
        if (this is MealHistoryEventBuilder) {
            return r'meal';
        }
        if (this is SymptomHistoryEventBuilder) {
            return r'symptom';
        }
        return null;
    }
}

class _$HistoryEventSerializer implements PrimitiveSerializer<HistoryEvent> {
  @override
  final Iterable<Type> types = const [HistoryEvent];

  @override
  final String wireName = r'HistoryEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'eventType';
    yield serializers.serialize(
      object.eventType,
      specifiedType: const FullType(String),
    );
    if (object.occurredAt != null) {
      yield r'occurredAt';
      yield serializers.serialize(
        object.occurredAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (object is ClinicalNoteHistoryEvent) {
      return serializers.serialize(object, specifiedType: FullType(ClinicalNoteHistoryEvent))!;
    }
    if (object is MealHistoryEvent) {
      return serializers.serialize(object, specifiedType: FullType(MealHistoryEvent))!;
    }
    if (object is SymptomHistoryEvent) {
      return serializers.serialize(object, specifiedType: FullType(SymptomHistoryEvent))!;
    }
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  HistoryEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(HistoryEvent.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    switch (discValue) {
      case r'clinical_note':
        return serializers.deserialize(serialized, specifiedType: FullType(ClinicalNoteHistoryEvent)) as ClinicalNoteHistoryEvent;
      case r'meal':
        return serializers.deserialize(serialized, specifiedType: FullType(MealHistoryEvent)) as MealHistoryEvent;
      case r'symptom':
        return serializers.deserialize(serialized, specifiedType: FullType(SymptomHistoryEvent)) as SymptomHistoryEvent;
      default:
        return serializers.deserialize(serialized, specifiedType: FullType($HistoryEvent)) as $HistoryEvent;
    }
  }
}

/// a concrete implementation of [HistoryEvent], since [HistoryEvent] is not instantiable
@BuiltValue(instantiable: true)
abstract class $HistoryEvent implements HistoryEvent, Built<$HistoryEvent, $HistoryEventBuilder> {
  $HistoryEvent._();

  factory $HistoryEvent([void Function($HistoryEventBuilder)? updates]) = _$$HistoryEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($HistoryEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$HistoryEvent> get serializer => _$$HistoryEventSerializer();
}

class _$$HistoryEventSerializer implements PrimitiveSerializer<$HistoryEvent> {
  @override
  final Iterable<Type> types = const [$HistoryEvent, _$$HistoryEvent];

  @override
  final String wireName = r'$HistoryEvent';

  @override
  Object serialize(
    Serializers serializers,
    $HistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(HistoryEvent))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HistoryEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'eventType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.eventType = valueDes;
          break;
        case r'occurredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $HistoryEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $HistoryEventBuilder();
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

