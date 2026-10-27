//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/action_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_food_preview_dto.g.dart';

/// RecommendationFoodPreviewDto
///
/// Properties:
/// * [foodName] 
/// * [actionType] 
/// * [substituteFoodName] 
@BuiltValue()
abstract class RecommendationFoodPreviewDto implements Built<RecommendationFoodPreviewDto, RecommendationFoodPreviewDtoBuilder> {
  @BuiltValueField(wireName: r'foodName')
  String? get foodName;

  @BuiltValueField(wireName: r'actionType')
  ActionType? get actionType;
  // enum actionTypeEnum {  Suggest,  Reduce,  Avoid,  Substitute,  };

  @BuiltValueField(wireName: r'substituteFoodName')
  String? get substituteFoodName;

  RecommendationFoodPreviewDto._();

  factory RecommendationFoodPreviewDto([void updates(RecommendationFoodPreviewDtoBuilder b)]) = _$RecommendationFoodPreviewDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecommendationFoodPreviewDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecommendationFoodPreviewDto> get serializer => _$RecommendationFoodPreviewDtoSerializer();
}

class _$RecommendationFoodPreviewDtoSerializer implements PrimitiveSerializer<RecommendationFoodPreviewDto> {
  @override
  final Iterable<Type> types = const [RecommendationFoodPreviewDto, _$RecommendationFoodPreviewDto];

  @override
  final String wireName = r'RecommendationFoodPreviewDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecommendationFoodPreviewDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.foodName != null) {
      yield r'foodName';
      yield serializers.serialize(
        object.foodName,
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
    if (object.substituteFoodName != null) {
      yield r'substituteFoodName';
      yield serializers.serialize(
        object.substituteFoodName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RecommendationFoodPreviewDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecommendationFoodPreviewDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'foodName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.foodName = valueDes;
          break;
        case r'actionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActionType),
          ) as ActionType;
          result.actionType = valueDes;
          break;
        case r'substituteFoodName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.substituteFoodName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecommendationFoodPreviewDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecommendationFoodPreviewDtoBuilder();
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

