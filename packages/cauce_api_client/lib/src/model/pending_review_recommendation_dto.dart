//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/recommendation_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pending_review_recommendation_dto.g.dart';

/// PendingReviewRecommendationDto
///
/// Properties:
/// * [recommendationId] 
/// * [patientId] 
/// * [patientFullName] 
/// * [status] 
/// * [confidenceScore] 
/// * [itemsCount] 
/// * [generatedAt] 
/// * [expiresAt] 
@BuiltValue()
abstract class PendingReviewRecommendationDto implements Built<PendingReviewRecommendationDto, PendingReviewRecommendationDtoBuilder> {
  @BuiltValueField(wireName: r'recommendationId')
  String? get recommendationId;

  @BuiltValueField(wireName: r'patientId')
  String? get patientId;

  @BuiltValueField(wireName: r'patientFullName')
  String? get patientFullName;

  @BuiltValueField(wireName: r'status')
  RecommendationStatus? get status;
  // enum statusEnum {  Generated,  PendingReview,  Approved,  ModifiedApproved,  ManualApproved,  Rejected,  Delivered,  FeedbackReceived,  Expired,  };

  @BuiltValueField(wireName: r'confidenceScore')
  double? get confidenceScore;

  @BuiltValueField(wireName: r'itemsCount')
  int? get itemsCount;

  @BuiltValueField(wireName: r'generatedAt')
  DateTime? get generatedAt;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  PendingReviewRecommendationDto._();

  factory PendingReviewRecommendationDto([void updates(PendingReviewRecommendationDtoBuilder b)]) = _$PendingReviewRecommendationDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PendingReviewRecommendationDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PendingReviewRecommendationDto> get serializer => _$PendingReviewRecommendationDtoSerializer();
}

class _$PendingReviewRecommendationDtoSerializer implements PrimitiveSerializer<PendingReviewRecommendationDto> {
  @override
  final Iterable<Type> types = const [PendingReviewRecommendationDto, _$PendingReviewRecommendationDto];

  @override
  final String wireName = r'PendingReviewRecommendationDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PendingReviewRecommendationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.recommendationId != null) {
      yield r'recommendationId';
      yield serializers.serialize(
        object.recommendationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.patientId != null) {
      yield r'patientId';
      yield serializers.serialize(
        object.patientId,
        specifiedType: const FullType(String),
      );
    }
    if (object.patientFullName != null) {
      yield r'patientFullName';
      yield serializers.serialize(
        object.patientFullName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(RecommendationStatus),
      );
    }
    if (object.confidenceScore != null) {
      yield r'confidenceScore';
      yield serializers.serialize(
        object.confidenceScore,
        specifiedType: const FullType(double),
      );
    }
    if (object.itemsCount != null) {
      yield r'itemsCount';
      yield serializers.serialize(
        object.itemsCount,
        specifiedType: const FullType(int),
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
    PendingReviewRecommendationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PendingReviewRecommendationDtoBuilder result,
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
        case r'patientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.patientId = valueDes;
          break;
        case r'patientFullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.patientFullName = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RecommendationStatus),
          ) as RecommendationStatus;
          result.status = valueDes;
          break;
        case r'confidenceScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.confidenceScore = valueDes;
          break;
        case r'itemsCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.itemsCount = valueDes;
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
  PendingReviewRecommendationDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PendingReviewRecommendationDtoBuilder();
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

