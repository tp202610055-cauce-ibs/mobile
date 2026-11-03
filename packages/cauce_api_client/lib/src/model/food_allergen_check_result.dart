//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'food_allergen_check_result.g.dart';

/// FoodAllergenCheckResult
///
/// Properties:
/// * [foodId] 
/// * [foodName] 
/// * [hasAllergenConflict] 
/// * [allergens] 
@BuiltValue()
abstract class FoodAllergenCheckResult implements Built<FoodAllergenCheckResult, FoodAllergenCheckResultBuilder> {
  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'foodName')
  String? get foodName;

  @BuiltValueField(wireName: r'hasAllergenConflict')
  bool? get hasAllergenConflict;

  @BuiltValueField(wireName: r'allergens')
  BuiltList<String>? get allergens;

  FoodAllergenCheckResult._();

  factory FoodAllergenCheckResult([void updates(FoodAllergenCheckResultBuilder b)]) = _$FoodAllergenCheckResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FoodAllergenCheckResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FoodAllergenCheckResult> get serializer => _$FoodAllergenCheckResultSerializer();
}

class _$FoodAllergenCheckResultSerializer implements PrimitiveSerializer<FoodAllergenCheckResult> {
  @override
  final Iterable<Type> types = const [FoodAllergenCheckResult, _$FoodAllergenCheckResult];

  @override
  final String wireName = r'FoodAllergenCheckResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FoodAllergenCheckResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.foodId != null) {
      yield r'foodId';
      yield serializers.serialize(
        object.foodId,
        specifiedType: const FullType(String),
      );
    }
    if (object.foodName != null) {
      yield r'foodName';
      yield serializers.serialize(
        object.foodName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.hasAllergenConflict != null) {
      yield r'hasAllergenConflict';
      yield serializers.serialize(
        object.hasAllergenConflict,
        specifiedType: const FullType(bool),
      );
    }
    if (object.allergens != null) {
      yield r'allergens';
      yield serializers.serialize(
        object.allergens,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FoodAllergenCheckResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FoodAllergenCheckResultBuilder result,
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
        case r'foodName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.foodName = valueDes;
          break;
        case r'hasAllergenConflict':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAllergenConflict = valueDes;
          break;
        case r'allergens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.allergens.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FoodAllergenCheckResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FoodAllergenCheckResultBuilder();
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

