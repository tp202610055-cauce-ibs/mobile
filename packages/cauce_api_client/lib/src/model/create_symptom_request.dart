//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/symptom_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_symptom_request.g.dart';

/// Cuerpo de la petición de registro de un síntoma. El Cauce.Api.Contracts.ClinicalRegistry.CreateSymptomRequest.ClientGuid puede  omitirse en el cuerpo y enviarse en el encabezado `Idempotency-Key`.
///
/// Properties:
/// * [clientGuid] - Identificador del dispositivo (UUID v4), opcional si viaja en el encabezado.
/// * [symptomType] 
/// * [intensity] - Intensidad (1–100).
/// * [occurredAt] - Momento de ocurrencia.
/// * [clientCreatedAt] - Momento de creación en el dispositivo.
@BuiltValue()
abstract class CreateSymptomRequest implements Built<CreateSymptomRequest, CreateSymptomRequestBuilder> {
  /// Identificador del dispositivo (UUID v4), opcional si viaja en el encabezado.
  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'symptomType')
  SymptomType? get symptomType;
  // enum symptomTypeEnum {  AbdominalPain,  Bloating,  Flatulence,  Diarrhea,  Constipation,  Other,  Nausea,  Reflux,  Urgency,  };

  /// Intensidad (1–100).
  @BuiltValueField(wireName: r'intensity')
  int? get intensity;

  /// Momento de ocurrencia.
  @BuiltValueField(wireName: r'occurredAt')
  DateTime? get occurredAt;

  /// Momento de creación en el dispositivo.
  @BuiltValueField(wireName: r'clientCreatedAt')
  DateTime? get clientCreatedAt;

  CreateSymptomRequest._();

  factory CreateSymptomRequest([void updates(CreateSymptomRequestBuilder b)]) = _$CreateSymptomRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSymptomRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSymptomRequest> get serializer => _$CreateSymptomRequestSerializer();
}

class _$CreateSymptomRequestSerializer implements PrimitiveSerializer<CreateSymptomRequest> {
  @override
  final Iterable<Type> types = const [CreateSymptomRequest, _$CreateSymptomRequest];

  @override
  final String wireName = r'CreateSymptomRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSymptomRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clientGuid != null) {
      yield r'clientGuid';
      yield serializers.serialize(
        object.clientGuid,
        specifiedType: const FullType.nullable(String),
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
    CreateSymptomRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateSymptomRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clientGuid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  CreateSymptomRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSymptomRequestBuilder();
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

