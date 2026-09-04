//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/recommendation_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_recommendation_result.g.dart';

/// GenerateRecommendationResult
///
/// Properties:
/// * [recommendationId] 
/// * [status] 
/// * [requiresReview] 
/// * [generatedAt] 
/// * [expiresAt] 
@BuiltValue()
abstract class GenerateRecommendationResult implements Built<GenerateRecommendationResult, GenerateRecommendationResultBuilder> {
  @BuiltValueField(wireName: r'recommendationId')
  String? get recommendationId;

  @BuiltValueField(wireName: r'status')
  RecommendationStatus? get status;
  // enum statusEnum {  Generated,  PendingReview,  Approved,  ModifiedApproved,  ManualApproved,  Rejected,  Delivered,  FeedbackReceived,  Expired,  };

  @BuiltValueField(wireName: r'requiresReview')
  bool? get requiresReview;

  @BuiltValueField(wireName: r'generatedAt')
  DateTime? get generatedAt;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  GenerateRecommendationResult._();

  factory GenerateRecommendationResult([void updates(GenerateRecommendationResultBuilder b)]) = _$GenerateRecommendationResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateRecommendationResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateRecommendationResult> get serializer => _$GenerateRecommendationResultSerializer();
}

class _$GenerateRecommendationResultSerializer implements PrimitiveSerializer<GenerateRecommendationResult> {
  @override
  final Iterable<Type> types = const [GenerateRecommendationResult, _$GenerateRecommendationResult];

  @override
  final String wireName = r'GenerateRecommendationResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateRecommendationResult object, {
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
    if (object.requiresReview != null) {
      yield r'requiresReview';
      yield serializers.serialize(
        object.requiresReview,
        specifiedType: const FullType(bool),
      );
    }
    if (object.generatedAt != null) {
      yield r'generatedAt';
      yield serializers.serialize(
        object.generatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateRecommendationResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenerateRecommendationResultBuilder result,
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
        case r'requiresReview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requiresReview = valueDes;
          break;
        case r'generatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.generatedAt = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenerateRecommendationResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateRecommendationResultBuilder();
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

