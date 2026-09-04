//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/custom_food_ingredient_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_custom_food_request.g.dart';

/// Cuerpo de la petición de creación de un alimento personalizado.
///
/// Properties:
/// * [name] - Nombre del alimento personalizado.
/// * [portionSizeGrams] - Tamaño de porción en gramos.
/// * [ingredients] - Ingredientes del alimento personalizado.
/// * [confirmedAllergens] - Confirma la creación pese a coincidencias con alergias declaradas (US10 CA03). Por defecto  false: si hay coincidencias sin confirmar, la respuesta es 409 con el detalle.
@BuiltValue()
abstract class CreateCustomFoodRequest implements Built<CreateCustomFoodRequest, CreateCustomFoodRequestBuilder> {
  /// Nombre del alimento personalizado.
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// Tamaño de porción en gramos.
  @BuiltValueField(wireName: r'portionSizeGrams')
  double? get portionSizeGrams;

  /// Ingredientes del alimento personalizado.
  @BuiltValueField(wireName: r'ingredients')
  BuiltList<CustomFoodIngredientRequest>? get ingredients;

  /// Confirma la creación pese a coincidencias con alergias declaradas (US10 CA03). Por defecto  false: si hay coincidencias sin confirmar, la respuesta es 409 con el detalle.
  @BuiltValueField(wireName: r'confirmedAllergens')
  bool? get confirmedAllergens;

  CreateCustomFoodRequest._();

  factory CreateCustomFoodRequest([void updates(CreateCustomFoodRequestBuilder b)]) = _$CreateCustomFoodRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateCustomFoodRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateCustomFoodRequest> get serializer => _$CreateCustomFoodRequestSerializer();
}

class _$CreateCustomFoodRequestSerializer implements PrimitiveSerializer<CreateCustomFoodRequest> {
  @override
  final Iterable<Type> types = const [CreateCustomFoodRequest, _$CreateCustomFoodRequest];

  @override
  final String wireName = r'CreateCustomFoodRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateCustomFoodRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.portionSizeGrams != null) {
      yield r'portionSizeGrams';
      yield serializers.serialize(
        object.portionSizeGrams,
        specifiedType: const FullType(double),
      );
    }
    if (object.ingredients != null) {
      yield r'ingredients';
      yield serializers.serialize(
        object.ingredients,
        specifiedType: const FullType.nullable(BuiltList, [FullType(CustomFoodIngredientRequest)]),
      );
    }
    if (object.confirmedAllergens != null) {
      yield r'confirmedAllergens';
      yield serializers.serialize(
        object.confirmedAllergens,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateCustomFoodRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateCustomFoodRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'portionSizeGrams':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.portionSizeGrams = valueDes;
          break;
        case r'ingredients':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CustomFoodIngredientRequest)]),
          ) as BuiltList<CustomFoodIngredientRequest>?;
          if (valueDes == null) continue;
          result.ingredients.replace(valueDes);
          break;
        case r'confirmedAllergens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.confirmedAllergens = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateCustomFoodRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateCustomFoodRequestBuilder();
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

