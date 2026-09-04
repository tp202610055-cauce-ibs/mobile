//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_manual_recommendation_request.g.dart';

/// Cuerpo de la petición de creación manual de una recomendación (US29).
///
/// Properties:
/// * [patientId] - Identificador del paciente destinatario.
/// * [title] - Título de la recomendación.
/// * [description] - Descripción de la recomendación.
/// * [steps] - Pasos accionables, opcional.
/// * [clinicalNote] - Nota clínica del nutricionista.
/// * [validUntil] - Fecha de vigencia, o null si no caduca.
@BuiltValue()
abstract class CreateManualRecommendationRequest implements Built<CreateManualRecommendationRequest, CreateManualRecommendationRequestBuilder> {
  /// Identificador del paciente destinatario.
  @BuiltValueField(wireName: r'patientId')
  String? get patientId;

  /// Título de la recomendación.
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// Descripción de la recomendación.
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// Pasos accionables, opcional.
  @BuiltValueField(wireName: r'steps')
  BuiltList<String>? get steps;

  /// Nota clínica del nutricionista.
  @BuiltValueField(wireName: r'clinicalNote')
  String? get clinicalNote;

  /// Fecha de vigencia, o null si no caduca.
  @BuiltValueField(wireName: r'validUntil')
  DateTime? get validUntil;

  CreateManualRecommendationRequest._();

  factory CreateManualRecommendationRequest([void updates(CreateManualRecommendationRequestBuilder b)]) = _$CreateManualRecommendationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateManualRecommendationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateManualRecommendationRequest> get serializer => _$CreateManualRecommendationRequestSerializer();
}

class _$CreateManualRecommendationRequestSerializer implements PrimitiveSerializer<CreateManualRecommendationRequest> {
  @override
  final Iterable<Type> types = const [CreateManualRecommendationRequest, _$CreateManualRecommendationRequest];

  @override
  final String wireName = r'CreateManualRecommendationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateManualRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.patientId != null) {
      yield r'patientId';
      yield serializers.serialize(
        object.patientId,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.steps != null) {
      yield r'steps';
      yield serializers.serialize(
        object.steps,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.clinicalNote != null) {
      yield r'clinicalNote';
      yield serializers.serialize(
        object.clinicalNote,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.validUntil != null) {
      yield r'validUntil';
      yield serializers.serialize(
        object.validUntil,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateManualRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateManualRecommendationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'patientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.patientId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'steps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.steps.replace(valueDes);
          break;
        case r'clinicalNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clinicalNote = valueDes;
          break;
        case r'validUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateManualRecommendationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateManualRecommendationRequestBuilder();
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

