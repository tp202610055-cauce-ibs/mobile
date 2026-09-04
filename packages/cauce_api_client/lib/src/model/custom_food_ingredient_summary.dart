//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_food_ingredient_summary.g.dart';

/// CustomFoodIngredientSummary
///
/// Properties:
/// * [foodId] 
/// * [proportionGrams] 
@BuiltValue()
abstract class CustomFoodIngredientSummary implements Built<CustomFoodIngredientSummary, CustomFoodIngredientSummaryBuilder> {
  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'proportionGrams')
  double? get proportionGrams;

  CustomFoodIngredientSummary._();

  factory CustomFoodIngredientSummary([void updates(CustomFoodIngredientSummaryBuilder b)]) = _$CustomFoodIngredientSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CustomFoodIngredientSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CustomFoodIngredientSummary> get serializer => _$CustomFoodIngredientSummarySerializer();
}

class _$CustomFoodIngredientSummarySerializer implements PrimitiveSerializer<CustomFoodIngredientSummary> {
  @override
  final Iterable<Type> types = const [CustomFoodIngredientSummary, _$CustomFoodIngredientSummary];

  @override
  final String wireName = r'CustomFoodIngredientSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CustomFoodIngredientSummary object, {
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
    CustomFoodIngredientSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CustomFoodIngredientSummaryBuilder result,
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
  CustomFoodIngredientSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CustomFoodIngredientSummaryBuilder();
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

