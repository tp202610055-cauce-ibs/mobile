//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_review_status_dto.g.dart';

/// RecommendationReviewStatusDto
///
/// Properties:
/// * [hasRecommendationInReview] 
@BuiltValue()
abstract class RecommendationReviewStatusDto implements Built<RecommendationReviewStatusDto, RecommendationReviewStatusDtoBuilder> {
  @BuiltValueField(wireName: r'hasRecommendationInReview')
  bool? get hasRecommendationInReview;

  RecommendationReviewStatusDto._();

  factory RecommendationReviewStatusDto([void updates(RecommendationReviewStatusDtoBuilder b)]) = _$RecommendationReviewStatusDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecommendationReviewStatusDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecommendationReviewStatusDto> get serializer => _$RecommendationReviewStatusDtoSerializer();
}

class _$RecommendationReviewStatusDtoSerializer implements PrimitiveSerializer<RecommendationReviewStatusDto> {
  @override
  final Iterable<Type> types = const [RecommendationReviewStatusDto, _$RecommendationReviewStatusDto];

  @override
  final String wireName = r'RecommendationReviewStatusDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecommendationReviewStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.hasRecommendationInReview != null) {
      yield r'hasRecommendationInReview';
      yield serializers.serialize(
        object.hasRecommendationInReview,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RecommendationReviewStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecommendationReviewStatusDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'hasRecommendationInReview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasRecommendationInReview = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecommendationReviewStatusDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecommendationReviewStatusDtoBuilder();
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

