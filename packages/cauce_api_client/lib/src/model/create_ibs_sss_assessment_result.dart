//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/severity_category.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_ibs_sss_assessment_result.g.dart';

/// CreateIbsSssAssessmentResult
///
/// Properties:
/// * [assessmentId] 
/// * [totalScore] 
/// * [severityCategory] 
/// * [nextAssessmentDate] 
/// * [triggeredOnboardingCompletion] 
@BuiltValue()
abstract class CreateIbsSssAssessmentResult implements Built<CreateIbsSssAssessmentResult, CreateIbsSssAssessmentResultBuilder> {
  @BuiltValueField(wireName: r'assessmentId')
  String? get assessmentId;

  @BuiltValueField(wireName: r'totalScore')
  int? get totalScore;

  @BuiltValueField(wireName: r'severityCategory')
  SeverityCategory? get severityCategory;
  // enum severityCategoryEnum {  Mild,  Moderate,  Severe,  };

  @BuiltValueField(wireName: r'nextAssessmentDate')
  Date? get nextAssessmentDate;

  @BuiltValueField(wireName: r'triggeredOnboardingCompletion')
  bool? get triggeredOnboardingCompletion;

  CreateIbsSssAssessmentResult._();

  factory CreateIbsSssAssessmentResult([void updates(CreateIbsSssAssessmentResultBuilder b)]) = _$CreateIbsSssAssessmentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateIbsSssAssessmentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateIbsSssAssessmentResult> get serializer => _$CreateIbsSssAssessmentResultSerializer();
}

class _$CreateIbsSssAssessmentResultSerializer implements PrimitiveSerializer<CreateIbsSssAssessmentResult> {
  @override
  final Iterable<Type> types = const [CreateIbsSssAssessmentResult, _$CreateIbsSssAssessmentResult];

  @override
  final String wireName = r'CreateIbsSssAssessmentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateIbsSssAssessmentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.assessmentId != null) {
      yield r'assessmentId';
      yield serializers.serialize(
        object.assessmentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalScore != null) {
      yield r'totalScore';
      yield serializers.serialize(
        object.totalScore,
        specifiedType: const FullType(int),
      );
    }
    if (object.severityCategory != null) {
      yield r'severityCategory';
      yield serializers.serialize(
        object.severityCategory,
        specifiedType: const FullType(SeverityCategory),
      );
    }
    if (object.nextAssessmentDate != null) {
      yield r'nextAssessmentDate';
      yield serializers.serialize(
        object.nextAssessmentDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.triggeredOnboardingCompletion != null) {
      yield r'triggeredOnboardingCompletion';
      yield serializers.serialize(
        object.triggeredOnboardingCompletion,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateIbsSssAssessmentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateIbsSssAssessmentResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assessmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assessmentId = valueDes;
          break;
        case r'totalScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalScore = valueDes;
          break;
        case r'severityCategory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SeverityCategory),
          ) as SeverityCategory;
          result.severityCategory = valueDes;
          break;
        case r'nextAssessmentDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.nextAssessmentDate = valueDes;
          break;
        case r'triggeredOnboardingCompletion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.triggeredOnboardingCompletion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateIbsSssAssessmentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateIbsSssAssessmentResultBuilder();
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

