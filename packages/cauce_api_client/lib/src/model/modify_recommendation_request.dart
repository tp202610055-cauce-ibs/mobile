//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/modify_recommendation_item_input.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'modify_recommendation_request.g.dart';

/// Cuerpo de la petición de aprobación con modificación de una recomendación (US17 CA03).
///
/// Properties:
/// * [clinicalNote] - Nota clínica de la modificación.
/// * [items] - Nuevos ítems que reemplazan a los actuales, o null para conservarlos.
/// * [title] - Nuevo título, o null para conservarlo.
/// * [description] - Nueva descripción, o null para conservarla.
/// * [steps] - Nuevos pasos, o null para conservarlos.
@BuiltValue()
abstract class ModifyRecommendationRequest implements Built<ModifyRecommendationRequest, ModifyRecommendationRequestBuilder> {
  /// Nota clínica de la modificación.
  @BuiltValueField(wireName: r'clinicalNote')
  String? get clinicalNote;

  /// Nuevos ítems que reemplazan a los actuales, o null para conservarlos.
  @BuiltValueField(wireName: r'items')
  BuiltList<ModifyRecommendationItemInput>? get items;

  /// Nuevo título, o null para conservarlo.
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// Nueva descripción, o null para conservarla.
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// Nuevos pasos, o null para conservarlos.
  @BuiltValueField(wireName: r'steps')
  BuiltList<String>? get steps;

  ModifyRecommendationRequest._();

  factory ModifyRecommendationRequest([void updates(ModifyRecommendationRequestBuilder b)]) = _$ModifyRecommendationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ModifyRecommendationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ModifyRecommendationRequest> get serializer => _$ModifyRecommendationRequestSerializer();
}

class _$ModifyRecommendationRequestSerializer implements PrimitiveSerializer<ModifyRecommendationRequest> {
  @override
  final Iterable<Type> types = const [ModifyRecommendationRequest, _$ModifyRecommendationRequest];

  @override
  final String wireName = r'ModifyRecommendationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ModifyRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clinicalNote != null) {
      yield r'clinicalNote';
      yield serializers.serialize(
        object.clinicalNote,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(ModifyRecommendationItemInput)]),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ModifyRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ModifyRecommendationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clinicalNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clinicalNote = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ModifyRecommendationItemInput)]),
          ) as BuiltList<ModifyRecommendationItemInput>?;
          if (valueDes == null) continue;
          result.items.replace(valueDes);
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ModifyRecommendationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ModifyRecommendationRequestBuilder();
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

