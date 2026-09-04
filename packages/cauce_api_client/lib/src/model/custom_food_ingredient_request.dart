//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_food_ingredient_request.g.dart';

/// CustomFoodIngredientRequest
///
/// Properties:
/// * [foodId] 
/// * [proportionGrams] 
@BuiltValue()
abstract class CustomFoodIngredientRequest implements Built<CustomFoodIngredientRequest, CustomFoodIngredientRequestBuilder> {
  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'proportionGrams')
  double? get proportionGrams;

  CustomFoodIngredientRequest._();

  factory CustomFoodIngredientRequest([void updates(CustomFoodIngredientRequestBuilder b)]) = _$CustomFoodIngredientRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CustomFoodIngredientRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CustomFoodIngredientRequest> get serializer => _$CustomFoodIngredientRequestSerializer();
}

class _$CustomFoodIngredientRequestSerializer implements PrimitiveSerializer<CustomFoodIngredientRequest> {
  @override
  final Iterable<Type> types = const [CustomFoodIngredientRequest, _$CustomFoodIngredientRequest];

  @override
  final String wireName = r'CustomFoodIngredientRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CustomFoodIngredientRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.foodId != null) {
      yield r'foodId';
      yield serializers.serialize(
        object.foodId,
        specifiedType: const FullType(String),
      );
    }
    if (object.proportionGrams != null) {
      yield r'proportionGrams';
      yield serializers.serialize(
        object.proportionGrams,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CustomFoodIngredientRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CustomFoodIngredientRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'foodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.foodId = valueDes;
          break;
        case r'proportionGrams':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.proportionGrams = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CustomFoodIngredientRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CustomFoodIngredientRequestBuilder();
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

