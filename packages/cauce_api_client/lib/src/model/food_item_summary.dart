//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/fodmap_level.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'food_item_summary.g.dart';

/// FoodItemSummary
///
/// Properties:
/// * [foodId] 
/// * [name] 
/// * [category] 
/// * [fodmapLevel] 
/// * [isPeruvian] 
@BuiltValue()
abstract class FoodItemSummary implements Built<FoodItemSummary, FoodItemSummaryBuilder> {
  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'fodmapLevel')
  FodmapLevel? get fodmapLevel;
  // enum fodmapLevelEnum {  Low,  Moderate,  High,  };

  @BuiltValueField(wireName: r'isPeruvian')
  bool? get isPeruvian;

  FoodItemSummary._();

  factory FoodItemSummary([void updates(FoodItemSummaryBuilder b)]) = _$FoodItemSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FoodItemSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FoodItemSummary> get serializer => _$FoodItemSummarySerializer();
}

class _$FoodItemSummarySerializer implements PrimitiveSerializer<FoodItemSummary> {
  @override
  final Iterable<Type> types = const [FoodItemSummary, _$FoodItemSummary];

  @override
  final String wireName = r'FoodItemSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FoodItemSummary object, {
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
    if (object.fodmapLevel != null) {
      yield r'fodmapLevel';
      yield serializers.serialize(
        object.fodmapLevel,
        specifiedType: const FullType(FodmapLevel),
      );
    }
    if (object.isPeruvian != null) {
      yield r'isPeruvian';
      yield serializers.serialize(
        object.isPeruvian,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FoodItemSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FoodItemSummaryBuilder result,
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
        case r'fodmapLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FodmapLevel),
          ) as FodmapLevel;
          result.fodmapLevel = valueDes;
          break;
        case r'isPeruvian':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isPeruvian = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FoodItemSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FoodItemSummaryBuilder();
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

