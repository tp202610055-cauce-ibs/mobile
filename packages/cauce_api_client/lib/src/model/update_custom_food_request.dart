//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/custom_food_ingredient_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_custom_food_request.g.dart';

/// Cuerpo de la petición de actualización de un alimento personalizado.
///
/// Properties:
/// * [name] - Nuevo nombre del alimento personalizado.
/// * [portionSizeGrams] - Nuevo tamaño de porción en gramos.
/// * [ingredients] - Nuevo conjunto de ingredientes.
/// * [confirmedAllergens] - Confirma el guardado pese a coincidencias con alergias declaradas (US10 CA03). Por defecto  false: si hay coincidencias sin confirmar, la respuesta es 409 con el detalle.
@BuiltValue()
abstract class UpdateCustomFoodRequest implements Built<UpdateCustomFoodRequest, UpdateCustomFoodRequestBuilder> {
  /// Nuevo nombre del alimento personalizado.
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// Nuevo tamaño de porción en gramos.
  @BuiltValueField(wireName: r'portionSizeGrams')
  double? get portionSizeGrams;

  /// Nuevo conjunto de ingredientes.
  @BuiltValueField(wireName: r'ingredients')
  BuiltList<CustomFoodIngredientRequest>? get ingredients;

  /// Confirma el guardado pese a coincidencias con alergias declaradas (US10 CA03). Por defecto  false: si hay coincidencias sin confirmar, la respuesta es 409 con el detalle.
  @BuiltValueField(wireName: r'confirmedAllergens')
  bool? get confirmedAllergens;

  UpdateCustomFoodRequest._();

  factory UpdateCustomFoodRequest([void updates(UpdateCustomFoodRequestBuilder b)]) = _$UpdateCustomFoodRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateCustomFoodRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateCustomFoodRequest> get serializer => _$UpdateCustomFoodRequestSerializer();
}

class _$UpdateCustomFoodRequestSerializer implements PrimitiveSerializer<UpdateCustomFoodRequest> {
  @override
  final Iterable<Type> types = const [UpdateCustomFoodRequest, _$UpdateCustomFoodRequest];

  @override
  final String wireName = r'UpdateCustomFoodRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateCustomFoodRequest object, {
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
    UpdateCustomFoodRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateCustomFoodRequestBuilder result,
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
  UpdateCustomFoodRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateCustomFoodRequestBuilder();
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

