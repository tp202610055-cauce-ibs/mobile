//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/nutritionist_alert_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'nutritionist_alert_dto.g.dart';

/// NutritionistAlertDto
///
/// Properties:
/// * [id] 
/// * [type] 
/// * [patientId] 
/// * [patientName] 
/// * [patientCode] 
/// * [message] 
/// * [occurredAt] 
/// * [isRead] 
/// * [readAt] 
@BuiltValue()
abstract class NutritionistAlertDto implements Built<NutritionistAlertDto, NutritionistAlertDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'type')
  NutritionistAlertType? get type;
  // enum typeEnum {  PatientLinked,  PatientSubtypeChanged,  };

  @BuiltValueField(wireName: r'patientId')
  String? get patientId;

  @BuiltValueField(wireName: r'patientName')
  String? get patientName;

  @BuiltValueField(wireName: r'patientCode')
  String? get patientCode;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'occurredAt')
  DateTime? get occurredAt;

  @BuiltValueField(wireName: r'isRead')
  bool? get isRead;

  @BuiltValueField(wireName: r'readAt')
  DateTime? get readAt;

  NutritionistAlertDto._();

  factory NutritionistAlertDto([void updates(NutritionistAlertDtoBuilder b)]) = _$NutritionistAlertDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NutritionistAlertDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NutritionistAlertDto> get serializer => _$NutritionistAlertDtoSerializer();
}

class _$NutritionistAlertDtoSerializer implements PrimitiveSerializer<NutritionistAlertDto> {
  @override
  final Iterable<Type> types = const [NutritionistAlertDto, _$NutritionistAlertDto];

  @override
  final String wireName = r'NutritionistAlertDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NutritionistAlertDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(NutritionistAlertType),
      );
    }
    if (object.patientId != null) {
      yield r'patientId';
      yield serializers.serialize(
        object.patientId,
        specifiedType: const FullType(String),
      );
    }
    if (object.patientName != null) {
      yield r'patientName';
      yield serializers.serialize(
        object.patientName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.patientCode != null) {
      yield r'patientCode';
      yield serializers.serialize(
        object.patientCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.occurredAt != null) {
      yield r'occurredAt';
      yield serializers.serialize(
        object.occurredAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.isRead != null) {
      yield r'isRead';
      yield serializers.serialize(
        object.isRead,
        specifiedType: const FullType(bool),
      );
    }
    if (object.readAt != null) {
      yield r'readAt';
      yield serializers.serialize(
        object.readAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NutritionistAlertDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NutritionistAlertDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NutritionistAlertType),
          ) as NutritionistAlertType;
          result.type = valueDes;
          break;
        case r'patientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.patientId = valueDes;
          break;
        case r'patientName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.patientName = valueDes;
          break;
        case r'patientCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.patientCode = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.message = valueDes;
          break;
        case r'occurredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        case r'isRead':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isRead = valueDes;
          break;
        case r'readAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.readAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NutritionistAlertDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NutritionistAlertDtoBuilder();
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

