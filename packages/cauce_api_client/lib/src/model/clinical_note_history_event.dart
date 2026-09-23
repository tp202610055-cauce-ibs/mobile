//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/clinical_note_summary.dart';
import 'package:cauce_api_client/src/model/history_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'clinical_note_history_event.g.dart';

/// ClinicalNoteHistoryEvent
///
/// Properties:
/// * [eventType] 
/// * [occurredAt] 
/// * [note] 
@BuiltValue()
abstract class ClinicalNoteHistoryEvent implements HistoryEvent, Built<ClinicalNoteHistoryEvent, ClinicalNoteHistoryEventBuilder> {
  @BuiltValueField(wireName: r'note')
  ClinicalNoteSummary? get note;

  ClinicalNoteHistoryEvent._();

  factory ClinicalNoteHistoryEvent([void updates(ClinicalNoteHistoryEventBuilder b)]) = _$ClinicalNoteHistoryEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClinicalNoteHistoryEventBuilder b) => b..eventType=b.discriminatorValue;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClinicalNoteHistoryEvent> get serializer => _$ClinicalNoteHistoryEventSerializer();
}

class _$ClinicalNoteHistoryEventSerializer implements PrimitiveSerializer<ClinicalNoteHistoryEvent> {
  @override
  final Iterable<Type> types = const [ClinicalNoteHistoryEvent, _$ClinicalNoteHistoryEvent];

  @override
  final String wireName = r'ClinicalNoteHistoryEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClinicalNoteHistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(ClinicalNoteSummary),
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
    ClinicalNoteHistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ClinicalNoteHistoryEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ClinicalNoteSummary),
          ) as ClinicalNoteSummary;
          result.note.replace(valueDes);
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
  ClinicalNoteHistoryEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClinicalNoteHistoryEventBuilder();
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

