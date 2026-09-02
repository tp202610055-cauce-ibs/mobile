//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/custom_food_ingredient_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_food_summary.g.dart';

/// CustomFoodSummary
///
/// Properties:
/// * [customFoodId] 
/// * [name] 
/// * [portionSizeGrams] 
/// * [createdAt] 
/// * [ingredients] 
@BuiltValue()
abstract class CustomFoodSummary implements Built<CustomFoodSummary, CustomFoodSummaryBuilder> {
  @BuiltValueField(wireName: r'customFoodId')
  String? get customFoodId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'portionSizeGrams')
  double? get portionSizeGrams;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'ingredients')
  BuiltList<CustomFoodIngredientSummary>? get ingredients;

  CustomFoodSummary._();

  factory CustomFoodSummary([void updates(CustomFoodSummaryBuilder b)]) = _$CustomFoodSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CustomFoodSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CustomFoodSummary> get serializer => _$CustomFoodSummarySerializer();
}

class _$CustomFoodSummarySerializer implements PrimitiveSerializer<CustomFoodSummary> {
  @override
  final Iterable<Type> types = const [CustomFoodSummary, _$CustomFoodSummary];

  @override
  final String wireName = r'CustomFoodSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CustomFoodSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.customFoodId != null) {
      yield r'customFoodId';
      yield serializers.serialize(
        object.customFoodId,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.ingredients != null) {
      yield r'ingredients';
      yield serializers.serialize(
        object.ingredients,
        specifiedType: const FullType.nullable(BuiltList, [FullType(CustomFoodIngredientSummary)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CustomFoodSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CustomFoodSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'customFoodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customFoodId = valueDes;
          break;
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
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'ingredients':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CustomFoodIngredientSummary)]),
          ) as BuiltList<CustomFoodIngredientSummary>?;
          if (valueDes == null) continue;
          result.ingredients.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CustomFoodSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CustomFoodSummaryBuilder();
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

