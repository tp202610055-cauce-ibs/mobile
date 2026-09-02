//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/fodmap_level.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'food_item_detail.g.dart';

/// FoodItemDetail
///
/// Properties:
/// * [foodId] 
/// * [name] 
/// * [category] 
/// * [caloriesPer100g] 
/// * [proteinGPer100g] 
/// * [carbsGPer100g] 
/// * [fatGPer100g] 
/// * [fiberGPer100g] 
/// * [fodmapLevel] 
/// * [fodmapTags] 
/// * [isPeruvian] 
/// * [isActive] 
@BuiltValue()
abstract class FoodItemDetail implements Built<FoodItemDetail, FoodItemDetailBuilder> {
  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'caloriesPer100g')
  double? get caloriesPer100g;

  @BuiltValueField(wireName: r'proteinGPer100g')
  double? get proteinGPer100g;

  @BuiltValueField(wireName: r'carbsGPer100g')
  double? get carbsGPer100g;

  @BuiltValueField(wireName: r'fatGPer100g')
  double? get fatGPer100g;

  @BuiltValueField(wireName: r'fiberGPer100g')
  double? get fiberGPer100g;

  @BuiltValueField(wireName: r'fodmapLevel')
  FodmapLevel? get fodmapLevel;
  // enum fodmapLevelEnum {  Low,  Moderate,  High,  };

  @BuiltValueField(wireName: r'fodmapTags')
  String? get fodmapTags;

  @BuiltValueField(wireName: r'isPeruvian')
  bool? get isPeruvian;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  FoodItemDetail._();

  factory FoodItemDetail([void updates(FoodItemDetailBuilder b)]) = _$FoodItemDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FoodItemDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FoodItemDetail> get serializer => _$FoodItemDetailSerializer();
}

class _$FoodItemDetailSerializer implements PrimitiveSerializer<FoodItemDetail> {
  @override
  final Iterable<Type> types = const [FoodItemDetail, _$FoodItemDetail];

  @override
  final String wireName = r'FoodItemDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FoodItemDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.foodId != null) {
      yield r'foodId';
      yield serializers.serialize(
        object.foodId,
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
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.caloriesPer100g != null) {
      yield r'caloriesPer100g';
      yield serializers.serialize(
        object.caloriesPer100g,
        specifiedType: const FullType(double),
      );
    }
    if (object.proteinGPer100g != null) {
      yield r'proteinGPer100g';
      yield serializers.serialize(
        object.proteinGPer100g,
        specifiedType: const FullType(double),
      );
    }
    if (object.carbsGPer100g != null) {
      yield r'carbsGPer100g';
      yield serializers.serialize(
        object.carbsGPer100g,
        specifiedType: const FullType(double),
      );
    }
    if (object.fatGPer100g != null) {
      yield r'fatGPer100g';
      yield serializers.serialize(
        object.fatGPer100g,
        specifiedType: const FullType(double),
      );
    }
    if (object.fiberGPer100g != null) {
      yield r'fiberGPer100g';
      yield serializers.serialize(
        object.fiberGPer100g,
        specifiedType: const FullType(double),
      );
    }
    if (object.fodmapLevel != null) {
      yield r'fodmapLevel';
      yield serializers.serialize(
        object.fodmapLevel,
        specifiedType: const FullType(FodmapLevel),
      );
    }
    if (object.fodmapTags != null) {
      yield r'fodmapTags';
      yield serializers.serialize(
        object.fodmapTags,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.isPeruvian != null) {
      yield r'isPeruvian';
      yield serializers.serialize(
        object.isPeruvian,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FoodItemDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FoodItemDetailBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.category = valueDes;
          break;
        case r'caloriesPer100g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.caloriesPer100g = valueDes;
          break;
        case r'proteinGPer100g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.proteinGPer100g = valueDes;
          break;
        case r'carbsGPer100g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.carbsGPer100g = valueDes;
          break;
        case r'fatGPer100g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.fatGPer100g = valueDes;
          break;
        case r'fiberGPer100g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.fiberGPer100g = valueDes;
          break;
        case r'fodmapLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FodmapLevel),
          ) as FodmapLevel;
          result.fodmapLevel = valueDes;
          break;
        case r'fodmapTags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fodmapTags = valueDes;
          break;
        case r'isPeruvian':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isPeruvian = valueDes;
          break;
        case r'isActive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FoodItemDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FoodItemDetailBuilder();
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

