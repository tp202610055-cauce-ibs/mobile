//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/action_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_item_dto.g.dart';

/// RecommendationItemDto
///
/// Properties:
/// * [recommendationItemId] 
/// * [foodId] 
/// * [foodName] 
/// * [category] 
/// * [actionType] 
/// * [substituteFoodId] 
/// * [substituteFoodName] 
/// * [reasoning] 
@BuiltValue()
abstract class RecommendationItemDto implements Built<RecommendationItemDto, RecommendationItemDtoBuilder> {
  @BuiltValueField(wireName: r'recommendationItemId')
  String? get recommendationItemId;

  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'foodName')
  String? get foodName;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'actionType')
  ActionType? get actionType;
  // enum actionTypeEnum {  Suggest,  Reduce,  Avoid,  Substitute,  };

  @BuiltValueField(wireName: r'substituteFoodId')
  String? get substituteFoodId;

  @BuiltValueField(wireName: r'substituteFoodName')
  String? get substituteFoodName;

  @BuiltValueField(wireName: r'reasoning')
  String? get reasoning;

  RecommendationItemDto._();

  factory RecommendationItemDto([void updates(RecommendationItemDtoBuilder b)]) = _$RecommendationItemDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecommendationItemDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecommendationItemDto> get serializer => _$RecommendationItemDtoSerializer();
}

class _$RecommendationItemDtoSerializer implements PrimitiveSerializer<RecommendationItemDto> {
  @override
  final Iterable<Type> types = const [RecommendationItemDto, _$RecommendationItemDto];

  @override
  final String wireName = r'RecommendationItemDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecommendationItemDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.recommendationItemId != null) {
      yield r'recommendationItemId';
      yield serializers.serialize(
        object.recommendationItemId,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.actionType != null) {
      yield r'actionType';
      yield serializers.serialize(
        object.actionType,
        specifiedType: const FullType(ActionType),
      );
    }
    if (object.substituteFoodId != null) {
      yield r'substituteFoodId';
      yield serializers.serialize(
        object.substituteFoodId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.substituteFoodName != null) {
      yield r'substituteFoodName';
      yield serializers.serialize(
        object.substituteFoodName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.reasoning != null) {
      yield r'reasoning';
      yield serializers.serialize(
        object.reasoning,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RecommendationItemDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecommendationItemDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'recommendationItemId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recommendationItemId = valueDes;
          break;
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
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.category = valueDes;
          break;
        case r'actionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActionType),
          ) as ActionType;
          result.actionType = valueDes;
          break;
        case r'substituteFoodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.substituteFoodId = valueDes;
          break;
        case r'substituteFoodName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.substituteFoodName = valueDes;
          break;
        case r'reasoning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reasoning = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecommendationItemDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecommendationItemDtoBuilder();
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

