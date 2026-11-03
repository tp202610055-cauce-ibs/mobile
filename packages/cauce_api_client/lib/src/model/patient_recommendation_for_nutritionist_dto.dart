//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/recommendation_food_preview_dto.dart';
import 'package:cauce_api_client/src/model/recommendation_source.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/recommendation_status.dart';
import 'package:cauce_api_client/src/model/archive_reason.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'patient_recommendation_for_nutritionist_dto.g.dart';

/// PatientRecommendationForNutritionistDto
///
/// Properties:
/// * [recommendationId] 
/// * [status] 
/// * [source_] 
/// * [title] 
/// * [itemsCount] 
/// * [generatedAt] 
/// * [reviewedAt] 
/// * [expiresAt] 
/// * [validUntil] 
/// * [isActive] 
/// * [archivedAt] 
/// * [archiveReason] 
/// * [foods] 
@BuiltValue()
abstract class PatientRecommendationForNutritionistDto implements Built<PatientRecommendationForNutritionistDto, PatientRecommendationForNutritionistDtoBuilder> {
  @BuiltValueField(wireName: r'recommendationId')
  String? get recommendationId;

  @BuiltValueField(wireName: r'status')
  RecommendationStatus? get status;
  // enum statusEnum {  Generated,  PendingReview,  Approved,  ModifiedApproved,  ManualApproved,  Rejected,  Delivered,  FeedbackReceived,  Expired,  };

  @BuiltValueField(wireName: r'source')
  RecommendationSource? get source_;
  // enum source_Enum {  EngineGenerated,  Manual,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'itemsCount')
  int? get itemsCount;

  @BuiltValueField(wireName: r'generatedAt')
  DateTime? get generatedAt;

  @BuiltValueField(wireName: r'reviewedAt')
  DateTime? get reviewedAt;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'validUntil')
  DateTime? get validUntil;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  @BuiltValueField(wireName: r'archivedAt')
  DateTime? get archivedAt;

  @BuiltValueField(wireName: r'archiveReason')
  ArchiveReason? get archiveReason;
  // enum archiveReasonEnum {  TemporalExpiration,  ManualSubstitution,  ObjectiveMet,  PlanChange,  };

  @BuiltValueField(wireName: r'foods')
  BuiltList<RecommendationFoodPreviewDto>? get foods;

  PatientRecommendationForNutritionistDto._();

  factory PatientRecommendationForNutritionistDto([void updates(PatientRecommendationForNutritionistDtoBuilder b)]) = _$PatientRecommendationForNutritionistDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PatientRecommendationForNutritionistDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PatientRecommendationForNutritionistDto> get serializer => _$PatientRecommendationForNutritionistDtoSerializer();
}

class _$PatientRecommendationForNutritionistDtoSerializer implements PrimitiveSerializer<PatientRecommendationForNutritionistDto> {
  @override
  final Iterable<Type> types = const [PatientRecommendationForNutritionistDto, _$PatientRecommendationForNutritionistDto];

  @override
  final String wireName = r'PatientRecommendationForNutritionistDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PatientRecommendationForNutritionistDto object, {
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
    if (object.source_ != null) {
      yield r'source';
      yield serializers.serialize(
        object.source_,
        specifiedType: const FullType(RecommendationSource),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType.nullable(String),
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
    if (object.reviewedAt != null) {
      yield r'reviewedAt';
      yield serializers.serialize(
        object.reviewedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.validUntil != null) {
      yield r'validUntil';
      yield serializers.serialize(
        object.validUntil,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.archivedAt != null) {
      yield r'archivedAt';
      yield serializers.serialize(
        object.archivedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.archiveReason != null) {
      yield r'archiveReason';
      yield serializers.serialize(
        object.archiveReason,
        specifiedType: const FullType(ArchiveReason),
      );
    }
    if (object.foods != null) {
      yield r'foods';
      yield serializers.serialize(
        object.foods,
        specifiedType: const FullType.nullable(BuiltList, [FullType(RecommendationFoodPreviewDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PatientRecommendationForNutritionistDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PatientRecommendationForNutritionistDtoBuilder result,
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
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RecommendationSource),
          ) as RecommendationSource;
          result.source_ = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
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
        case r'reviewedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reviewedAt = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        case r'validUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        case r'isActive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'archivedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.archivedAt = valueDes;
          break;
        case r'archiveReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArchiveReason),
          ) as ArchiveReason;
          result.archiveReason = valueDes;
          break;
        case r'foods':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(RecommendationFoodPreviewDto)]),
          ) as BuiltList<RecommendationFoodPreviewDto>?;
          if (valueDes == null) continue;
          result.foods.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PatientRecommendationForNutritionistDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PatientRecommendationForNutritionistDtoBuilder();
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

