//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/symptom_history_item.dart';
import 'package:cauce_api_client/src/model/meal_history_item.dart';
import 'package:cauce_api_client/src/model/clinical_note_history_event.dart';
import 'package:cauce_api_client/src/model/symptom_history_event.dart';
import 'package:cauce_api_client/src/model/meal_history_event.dart';
import 'package:cauce_api_client/src/model/clinical_note_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'api_v1_history_get200_response_inner.g.dart';

/// ApiV1HistoryGet200ResponseInner
///
/// Properties:
/// * [eventType] 
/// * [occurredAt] 
/// * [meal] 
/// * [symptom] 
/// * [note] 
@BuiltValue()
abstract class ApiV1HistoryGet200ResponseInner implements Built<ApiV1HistoryGet200ResponseInner, ApiV1HistoryGet200ResponseInnerBuilder> {
  /// One Of [ClinicalNoteHistoryEvent], [MealHistoryEvent], [SymptomHistoryEvent]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'eventType';

  static const Map<String, Type> discriminatorMapping = {
    r'clinical_note': ClinicalNoteHistoryEvent,
    r'meal': MealHistoryEvent,
    r'symptom': SymptomHistoryEvent,
    r'ClinicalNoteHistoryEvent': ClinicalNoteHistoryEvent,
    r'MealHistoryEvent': MealHistoryEvent,
    r'SymptomHistoryEvent': SymptomHistoryEvent,
  };

  ApiV1HistoryGet200ResponseInner._();

  factory ApiV1HistoryGet200ResponseInner([void updates(ApiV1HistoryGet200ResponseInnerBuilder b)]) = _$ApiV1HistoryGet200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiV1HistoryGet200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiV1HistoryGet200ResponseInner> get serializer => _$ApiV1HistoryGet200ResponseInnerSerializer();
}

extension ApiV1HistoryGet200ResponseInnerDiscriminatorExt on ApiV1HistoryGet200ResponseInner {
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
        if (this is ClinicalNoteHistoryEvent) {
            return r'ClinicalNoteHistoryEvent';
        }
        if (this is MealHistoryEvent) {
            return r'MealHistoryEvent';
        }
        if (this is SymptomHistoryEvent) {
            return r'SymptomHistoryEvent';
        }
        return null;
    }
}
extension ApiV1HistoryGet200ResponseInnerBuilderDiscriminatorExt on ApiV1HistoryGet200ResponseInnerBuilder {
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
        if (this is ClinicalNoteHistoryEventBuilder) {
            return r'ClinicalNoteHistoryEvent';
        }
        if (this is MealHistoryEventBuilder) {
            return r'MealHistoryEvent';
        }
        if (this is SymptomHistoryEventBuilder) {
            return r'SymptomHistoryEvent';
        }
        return null;
    }
}

class _$ApiV1HistoryGet200ResponseInnerSerializer implements PrimitiveSerializer<ApiV1HistoryGet200ResponseInner> {
  @override
  final Iterable<Type> types = const [ApiV1HistoryGet200ResponseInner, _$ApiV1HistoryGet200ResponseInner];

  @override
  final String wireName = r'ApiV1HistoryGet200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiV1HistoryGet200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiV1HistoryGet200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  ApiV1HistoryGet200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiV1HistoryGet200ResponseInnerBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(ApiV1HistoryGet200ResponseInner.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [ClinicalNoteHistoryEvent, MealHistoryEvent, SymptomHistoryEvent, ClinicalNoteHistoryEvent, MealHistoryEvent, SymptomHistoryEvent, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'clinical_note':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(ClinicalNoteHistoryEvent),
        ) as ClinicalNoteHistoryEvent;
        oneOfType = ClinicalNoteHistoryEvent;
        break;
      case r'meal':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(MealHistoryEvent),
        ) as MealHistoryEvent;
        oneOfType = MealHistoryEvent;
        break;
      case r'symptom':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(SymptomHistoryEvent),
        ) as SymptomHistoryEvent;
        oneOfType = SymptomHistoryEvent;
        break;
      case r'ClinicalNoteHistoryEvent':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(ClinicalNoteHistoryEvent),
        ) as ClinicalNoteHistoryEvent;
        oneOfType = ClinicalNoteHistoryEvent;
        break;
      case r'MealHistoryEvent':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(MealHistoryEvent),
        ) as MealHistoryEvent;
        oneOfType = MealHistoryEvent;
        break;
      case r'SymptomHistoryEvent':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(SymptomHistoryEvent),
        ) as SymptomHistoryEvent;
        oneOfType = SymptomHistoryEvent;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

