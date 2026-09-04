//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/recommendation_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_manual_recommendation_result.g.dart';

/// CreateManualRecommendationResult
///
/// Properties:
/// * [recommendationId] 
/// * [status] 
@BuiltValue()
abstract class CreateManualRecommendationResult implements Built<CreateManualRecommendationResult, CreateManualRecommendationResultBuilder> {
  @BuiltValueField(wireName: r'recommendationId')
  String? get recommendationId;

  @BuiltValueField(wireName: r'status')
  RecommendationStatus? get status;
  // enum statusEnum {  Generated,  PendingReview,  Approved,  ModifiedApproved,  ManualApproved,  Rejected,  Delivered,  FeedbackReceived,  Expired,  };

  CreateManualRecommendationResult._();

  factory CreateManualRecommendationResult([void updates(CreateManualRecommendationResultBuilder b)]) = _$CreateManualRecommendationResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateManualRecommendationResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateManualRecommendationResult> get serializer => _$CreateManualRecommendationResultSerializer();
}

class _$CreateManualRecommendationResultSerializer implements PrimitiveSerializer<CreateManualRecommendationResult> {
  @override
  final Iterable<Type> types = const [CreateManualRecommendationResult, _$CreateManualRecommendationResult];

  @override
  final String wireName = r'CreateManualRecommendationResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateManualRecommendationResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.recommendationId != null) {
      yield r'recommendationId';
      yield serializers.serialize(
        object.recommendationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(RecommendationStatus),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateManualRecommendationResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateManualRecommendationResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'recommendationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recommendationId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RecommendationStatus),
          ) as RecommendationStatus;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateManualRecommendationResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateManualRecommendationResultBuilder();
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

