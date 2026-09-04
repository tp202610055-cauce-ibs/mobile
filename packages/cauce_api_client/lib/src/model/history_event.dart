//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'history_event.g.dart';

/// HistoryEvent
///
/// Properties:
/// * [occurredAt] 
@BuiltValue()
abstract class HistoryEvent implements Built<HistoryEvent, HistoryEventBuilder> {
  @BuiltValueField(wireName: r'occurredAt')
  DateTime? get occurredAt;

  HistoryEvent._();

  factory HistoryEvent([void updates(HistoryEventBuilder b)]) = _$HistoryEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HistoryEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HistoryEvent> get serializer => _$HistoryEventSerializer();
}

class _$HistoryEventSerializer implements PrimitiveSerializer<HistoryEvent> {
  @override
  final Iterable<Type> types = const [HistoryEvent, _$HistoryEvent];

  @override
  final String wireName = r'HistoryEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HistoryEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
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
  HistoryEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HistoryEventBuilder();
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

