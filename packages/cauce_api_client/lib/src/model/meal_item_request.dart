//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/measurement_unit.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meal_item_request.g.dart';

/// MealItemRequest
///
/// Properties:
/// * [foodId] 
/// * [customFoodId] 
/// * [quantity] 
/// * [unit] 
@BuiltValue()
abstract class MealItemRequest implements Built<MealItemRequest, MealItemRequestBuilder> {
  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'customFoodId')
  String? get customFoodId;

  @BuiltValueField(wireName: r'quantity')
  double? get quantity;

  @BuiltValueField(wireName: r'unit')
  MeasurementUnit? get unit;
  // enum unitEnum {  Grams,  Cups,  Units,  Ounces,  Tablespoons,  };

  MealItemRequest._();

  factory MealItemRequest([void updates(MealItemRequestBuilder b)]) = _$MealItemRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MealItemRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MealItemRequest> get serializer => _$MealItemRequestSerializer();
}

class _$MealItemRequestSerializer implements PrimitiveSerializer<MealItemRequest> {
  @override
  final Iterable<Type> types = const [MealItemRequest, _$MealItemRequest];

  @override
  final String wireName = r'MealItemRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MealItemRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.foodId != null) {
      yield r'foodId';
      yield serializers.serialize(
        object.foodId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.customFoodId != null) {
      yield r'customFoodId';
      yield serializers.serialize(
        object.customFoodId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(double),
      );
    }
    if (object.unit != null) {
      yield r'unit';
      yield serializers.serialize(
        object.unit,
        specifiedType: const FullType(MeasurementUnit),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MealItemRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MealItemRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'foodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.foodId = valueDes;
          break;
        case r'customFoodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.customFoodId = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.quantity = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MeasurementUnit),
          ) as MeasurementUnit;
          result.unit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MealItemRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MealItemRequestBuilder();
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

