//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/symptom_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'symptom_batch_item.g.dart';

/// SymptomBatchItem
///
/// Properties:
/// * [clientGuid] 
/// * [symptomType] 
/// * [intensity] 
/// * [occurredAt] 
/// * [clientCreatedAt] 
@BuiltValue()
abstract class SymptomBatchItem implements Built<SymptomBatchItem, SymptomBatchItemBuilder> {
  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'symptomType')
  SymptomType? get symptomType;
  // enum symptomTypeEnum {  AbdominalPain,  Bloating,  Flatulence,  Diarrhea,  Constipation,  Other,  Nausea,  Reflux,  Urgency,  };

  @BuiltValueField(wireName: r'intensity')
  int? get intensity;

  @BuiltValueField(wireName: r'occurredAt')
  DateTime? get occurredAt;

  @BuiltValueField(wireName: r'clientCreatedAt')
  DateTime? get clientCreatedAt;

  SymptomBatchItem._();

  factory SymptomBatchItem([void updates(SymptomBatchItemBuilder b)]) = _$SymptomBatchItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SymptomBatchItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SymptomBatchItem> get serializer => _$SymptomBatchItemSerializer();
}

class _$SymptomBatchItemSerializer implements PrimitiveSerializer<SymptomBatchItem> {
  @override
  final Iterable<Type> types = const [SymptomBatchItem, _$SymptomBatchItem];

  @override
  final String wireName = r'SymptomBatchItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SymptomBatchItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clientGuid != null) {
      yield r'clientGuid';
      yield serializers.serialize(
        object.clientGuid,
        specifiedType: const FullType(String),
      );
    }
    if (object.symptomType != null) {
      yield r'symptomType';
      yield serializers.serialize(
        object.symptomType,
        specifiedType: const FullType(SymptomType),
      );
    }
    if (object.intensity != null) {
      yield r'intensity';
      yield serializers.serialize(
        object.intensity,
        specifiedType: const FullType(int),
      );
    }
    if (object.occurredAt != null) {
      yield r'occurredAt';
      yield serializers.serialize(
        object.occurredAt,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SymptomBatchItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SymptomBatchItemBuilder result,
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
        case r'symptomType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SymptomType),
          ) as SymptomType;
          result.symptomType = valueDes;
          break;
        case r'intensity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.intensity = valueDes;
          break;
        case r'occurredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        case r'clientCreatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.clientCreatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SymptomBatchItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SymptomBatchItemBuilder();
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

