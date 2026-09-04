//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_clinical_note_request.g.dart';

/// Cuerpo de la petición de creación de una nota clínica, asociada exactamente a una  comida o a un síntoma.
///
/// Properties:
/// * [mealId] - Identificador de la comida asociada, o null.
/// * [symptomId] - Identificador del síntoma asociado, o null.
/// * [content] - Contenido de la nota (1–500 caracteres).
@BuiltValue()
abstract class CreateClinicalNoteRequest implements Built<CreateClinicalNoteRequest, CreateClinicalNoteRequestBuilder> {
  /// Identificador de la comida asociada, o null.
  @BuiltValueField(wireName: r'mealId')
  String? get mealId;

  /// Identificador del síntoma asociado, o null.
  @BuiltValueField(wireName: r'symptomId')
  String? get symptomId;

  /// Contenido de la nota (1–500 caracteres).
  @BuiltValueField(wireName: r'content')
  String? get content;

  CreateClinicalNoteRequest._();

  factory CreateClinicalNoteRequest([void updates(CreateClinicalNoteRequestBuilder b)]) = _$CreateClinicalNoteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateClinicalNoteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateClinicalNoteRequest> get serializer => _$CreateClinicalNoteRequestSerializer();
}

class _$CreateClinicalNoteRequestSerializer implements PrimitiveSerializer<CreateClinicalNoteRequest> {
  @override
  final Iterable<Type> types = const [CreateClinicalNoteRequest, _$CreateClinicalNoteRequest];

  @override
  final String wireName = r'CreateClinicalNoteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateClinicalNoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.mealId != null) {
      yield r'mealId';
      yield serializers.serialize(
        object.mealId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.symptomId != null) {
      yield r'symptomId';
      yield serializers.serialize(
        object.symptomId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateClinicalNoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateClinicalNoteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mealId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mealId = valueDes;
          break;
        case r'symptomId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.symptomId = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.content = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateClinicalNoteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateClinicalNoteRequestBuilder();
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

