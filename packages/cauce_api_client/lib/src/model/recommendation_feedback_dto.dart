//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/feedback_outcome.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_feedback_dto.g.dart';

/// RecommendationFeedbackDto
///
/// Properties:
/// * [feedbackId] 
/// * [wasApplied] 
/// * [outcome] 
/// * [comment] 
/// * [submittedAt] 
@BuiltValue()
abstract class RecommendationFeedbackDto implements Built<RecommendationFeedbackDto, RecommendationFeedbackDtoBuilder> {
  @BuiltValueField(wireName: r'feedbackId')
  String? get feedbackId;

  @BuiltValueField(wireName: r'wasApplied')
  bool? get wasApplied;

  @BuiltValueField(wireName: r'outcome')
  FeedbackOutcome? get outcome;
  // enum outcomeEnum {  Improvement,  NoChange,  Worsening,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'submittedAt')
  DateTime? get submittedAt;

  RecommendationFeedbackDto._();

  factory RecommendationFeedbackDto([void updates(RecommendationFeedbackDtoBuilder b)]) = _$RecommendationFeedbackDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecommendationFeedbackDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecommendationFeedbackDto> get serializer => _$RecommendationFeedbackDtoSerializer();
}

class _$RecommendationFeedbackDtoSerializer implements PrimitiveSerializer<RecommendationFeedbackDto> {
  @override
  final Iterable<Type> types = const [RecommendationFeedbackDto, _$RecommendationFeedbackDto];

  @override
  final String wireName = r'RecommendationFeedbackDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecommendationFeedbackDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.feedbackId != null) {
      yield r'feedbackId';
      yield serializers.serialize(
        object.feedbackId,
        specifiedType: const FullType(String),
      );
    }
    if (object.wasApplied != null) {
      yield r'wasApplied';
      yield serializers.serialize(
        object.wasApplied,
        specifiedType: const FullType(bool),
      );
    }
    if (object.outcome != null) {
      yield r'outcome';
      yield serializers.serialize(
        object.outcome,
        specifiedType: const FullType(FeedbackOutcome),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.submittedAt != null) {
      yield r'submittedAt';
      yield serializers.serialize(
        object.submittedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RecommendationFeedbackDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecommendationFeedbackDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'feedbackId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feedbackId = valueDes;
          break;
        case r'wasApplied':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.wasApplied = valueDes;
          break;
        case r'outcome':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeedbackOutcome),
          ) as FeedbackOutcome;
          result.outcome = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'submittedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.submittedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecommendationFeedbackDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecommendationFeedbackDtoBuilder();
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

