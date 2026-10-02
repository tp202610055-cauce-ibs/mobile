//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/recommendation_source.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/recommendation_status.dart';
import 'package:cauce_api_client/src/model/recommendation_supporting_data_dto.dart';
import 'package:cauce_api_client/src/model/recommendation_feedback_dto.dart';
import 'package:cauce_api_client/src/model/archive_reason.dart';
import 'package:cauce_api_client/src/model/explanation_source.dart';
import 'package:cauce_api_client/src/model/recommendation_item_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_detail_dto.g.dart';

/// RecommendationDetailDto
///
/// Properties:
/// * [recommendationId] 
/// * [patientId] 
/// * [modelVersionName] 
/// * [status] 
/// * [confidenceScore] 
/// * [autoApproved] 
/// * [reviewedByNutritionistId] 
/// * [nutritionistNote] 
/// * [aiExplanation] 
/// * [explanationSource] 
/// * [generatedAt] 
/// * [reviewedAt] 
/// * [deliveredAt] 
/// * [expiresAt] 
/// * [items] 
/// * [feedback] 
/// * [reviewedByNutritionistName] 
/// * [steps] 
/// * [supportingData] 
/// * [title] 
/// * [description] 
/// * [source_] 
/// * [isActive] 
/// * [archivedAt] 
/// * [archiveReason] 
/// * [validUntil] 
@BuiltValue()
abstract class RecommendationDetailDto implements Built<RecommendationDetailDto, RecommendationDetailDtoBuilder> {
  @BuiltValueField(wireName: r'recommendationId')
  String? get recommendationId;

  @BuiltValueField(wireName: r'patientId')
  String? get patientId;

  @BuiltValueField(wireName: r'modelVersionName')
  String? get modelVersionName;

  @BuiltValueField(wireName: r'status')
  RecommendationStatus? get status;
  // enum statusEnum {  Generated,  PendingReview,  Approved,  ModifiedApproved,  ManualApproved,  Rejected,  Delivered,  FeedbackReceived,  Expired,  };

  @BuiltValueField(wireName: r'confidenceScore')
  double? get confidenceScore;

  @BuiltValueField(wireName: r'autoApproved')
  bool? get autoApproved;

  @BuiltValueField(wireName: r'reviewedByNutritionistId')
  String? get reviewedByNutritionistId;

  @BuiltValueField(wireName: r'nutritionistNote')
  String? get nutritionistNote;

  @BuiltValueField(wireName: r'aiExplanation')
  String? get aiExplanation;

  @BuiltValueField(wireName: r'explanationSource')
  ExplanationSource? get explanationSource;
  // enum explanationSourceEnum {  LlmGenerated,  Fallback,  Manual,  };

  @BuiltValueField(wireName: r'generatedAt')
  DateTime? get generatedAt;

  @BuiltValueField(wireName: r'reviewedAt')
  DateTime? get reviewedAt;

  @BuiltValueField(wireName: r'deliveredAt')
  DateTime? get deliveredAt;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<RecommendationItemDto>? get items;

  @BuiltValueField(wireName: r'feedback')
  RecommendationFeedbackDto? get feedback;

  @BuiltValueField(wireName: r'reviewedByNutritionistName')
  String? get reviewedByNutritionistName;

  @BuiltValueField(wireName: r'steps')
  BuiltList<String>? get steps;

  @BuiltValueField(wireName: r'supportingData')
  RecommendationSupportingDataDto? get supportingData;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'source')
  RecommendationSource? get source_;
  // enum source_Enum {  EngineGenerated,  Manual,  };

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  @BuiltValueField(wireName: r'archivedAt')
  DateTime? get archivedAt;

  @BuiltValueField(wireName: r'archiveReason')
  ArchiveReason? get archiveReason;
  // enum archiveReasonEnum {  TemporalExpiration,  ManualSubstitution,  ObjectiveMet,  PlanChange,  };

  @BuiltValueField(wireName: r'validUntil')
  DateTime? get validUntil;

  RecommendationDetailDto._();

  factory RecommendationDetailDto([void updates(RecommendationDetailDtoBuilder b)]) = _$RecommendationDetailDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecommendationDetailDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecommendationDetailDto> get serializer => _$RecommendationDetailDtoSerializer();
}

class _$RecommendationDetailDtoSerializer implements PrimitiveSerializer<RecommendationDetailDto> {
  @override
  final Iterable<Type> types = const [RecommendationDetailDto, _$RecommendationDetailDto];

  @override
  final String wireName = r'RecommendationDetailDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecommendationDetailDto object, {
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
    if (object.modelVersionName != null) {
      yield r'modelVersionName';
      yield serializers.serialize(
        object.modelVersionName,
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
    if (object.autoApproved != null) {
      yield r'autoApproved';
      yield serializers.serialize(
        object.autoApproved,
        specifiedType: const FullType(bool),
      );
    }
    if (object.reviewedByNutritionistId != null) {
      yield r'reviewedByNutritionistId';
      yield serializers.serialize(
        object.reviewedByNutritionistId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.nutritionistNote != null) {
      yield r'nutritionistNote';
      yield serializers.serialize(
        object.nutritionistNote,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.aiExplanation != null) {
      yield r'aiExplanation';
      yield serializers.serialize(
        object.aiExplanation,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.explanationSource != null) {
      yield r'explanationSource';
      yield serializers.serialize(
        object.explanationSource,
        specifiedType: const FullType(ExplanationSource),
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
    if (object.deliveredAt != null) {
      yield r'deliveredAt';
      yield serializers.serialize(
        object.deliveredAt,
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
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(RecommendationItemDto)]),
      );
    }
    if (object.feedback != null) {
      yield r'feedback';
      yield serializers.serialize(
        object.feedback,
        specifiedType: const FullType(RecommendationFeedbackDto),
      );
    }
    if (object.reviewedByNutritionistName != null) {
      yield r'reviewedByNutritionistName';
      yield serializers.serialize(
        object.reviewedByNutritionistName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.steps != null) {
      yield r'steps';
      yield serializers.serialize(
        object.steps,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.supportingData != null) {
      yield r'supportingData';
      yield serializers.serialize(
        object.supportingData,
        specifiedType: const FullType(RecommendationSupportingDataDto),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.source_ != null) {
      yield r'source';
      yield serializers.serialize(
        object.source_,
        specifiedType: const FullType(RecommendationSource),
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
    if (object.validUntil != null) {
      yield r'validUntil';
      yield serializers.serialize(
        object.validUntil,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RecommendationDetailDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecommendationDetailDtoBuilder result,
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
        case r'modelVersionName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.modelVersionName = valueDes;
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
        case r'autoApproved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.autoApproved = valueDes;
          break;
        case r'reviewedByNutritionistId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reviewedByNutritionistId = valueDes;
          break;
        case r'nutritionistNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nutritionistNote = valueDes;
          break;
        case r'aiExplanation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.aiExplanation = valueDes;
          break;
        case r'explanationSource':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ExplanationSource),
          ) as ExplanationSource;
          result.explanationSource = valueDes;
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
        case r'deliveredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.deliveredAt = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(RecommendationItemDto)]),
          ) as BuiltList<RecommendationItemDto>?;
          if (valueDes == null) continue;
          result.items.replace(valueDes);
          break;
        case r'feedback':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RecommendationFeedbackDto),
          ) as RecommendationFeedbackDto;
          result.feedback.replace(valueDes);
          break;
        case r'reviewedByNutritionistName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reviewedByNutritionistName = valueDes;
          break;
        case r'steps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.steps.replace(valueDes);
          break;
        case r'supportingData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RecommendationSupportingDataDto),
          ) as RecommendationSupportingDataDto;
          result.supportingData.replace(valueDes);
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RecommendationSource),
          ) as RecommendationSource;
          result.source_ = valueDes;
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
        case r'validUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecommendationDetailDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecommendationDetailDtoBuilder();
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

