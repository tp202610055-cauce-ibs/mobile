//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/severity_category.dart';
import 'package:cauce_api_client/src/model/assessment_type.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ibs_sss_assessment_summary.g.dart';

/// IbsSssAssessmentSummary
///
/// Properties:
/// * [assessmentId] 
/// * [assessmentType] 
/// * [cycleNumber] 
/// * [painSeverity] 
/// * [painFrequency] 
/// * [bloatingSeverity] 
/// * [bowelHabitsDissatisfaction] 
/// * [lifeInterference] 
/// * [totalScore] 
/// * [severityCategory] 
/// * [completedAt] 
/// * [nextAssessmentDate] 
@BuiltValue()
abstract class IbsSssAssessmentSummary implements Built<IbsSssAssessmentSummary, IbsSssAssessmentSummaryBuilder> {
  @BuiltValueField(wireName: r'assessmentId')
  String? get assessmentId;

  @BuiltValueField(wireName: r'assessmentType')
  AssessmentType? get assessmentType;
  // enum assessmentTypeEnum {  Baseline,  Periodic,  };

  @BuiltValueField(wireName: r'cycleNumber')
  int? get cycleNumber;

  @BuiltValueField(wireName: r'painSeverity')
  int? get painSeverity;

  @BuiltValueField(wireName: r'painFrequency')
  int? get painFrequency;

  @BuiltValueField(wireName: r'bloatingSeverity')
  int? get bloatingSeverity;

  @BuiltValueField(wireName: r'bowelHabitsDissatisfaction')
  int? get bowelHabitsDissatisfaction;

  @BuiltValueField(wireName: r'lifeInterference')
  int? get lifeInterference;

  @BuiltValueField(wireName: r'totalScore')
  int? get totalScore;

  @BuiltValueField(wireName: r'severityCategory')
  SeverityCategory? get severityCategory;
  // enum severityCategoryEnum {  Mild,  Moderate,  Severe,  };

  @BuiltValueField(wireName: r'completedAt')
  DateTime? get completedAt;

  @BuiltValueField(wireName: r'nextAssessmentDate')
  Date? get nextAssessmentDate;

  IbsSssAssessmentSummary._();

  factory IbsSssAssessmentSummary([void updates(IbsSssAssessmentSummaryBuilder b)]) = _$IbsSssAssessmentSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IbsSssAssessmentSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IbsSssAssessmentSummary> get serializer => _$IbsSssAssessmentSummarySerializer();
}

class _$IbsSssAssessmentSummarySerializer implements PrimitiveSerializer<IbsSssAssessmentSummary> {
  @override
  final Iterable<Type> types = const [IbsSssAssessmentSummary, _$IbsSssAssessmentSummary];

  @override
  final String wireName = r'IbsSssAssessmentSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IbsSssAssessmentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.assessmentId != null) {
      yield r'assessmentId';
      yield serializers.serialize(
        object.assessmentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.assessmentType != null) {
      yield r'assessmentType';
      yield serializers.serialize(
        object.assessmentType,
        specifiedType: const FullType(AssessmentType),
      );
    }
    if (object.cycleNumber != null) {
      yield r'cycleNumber';
      yield serializers.serialize(
        object.cycleNumber,
        specifiedType: const FullType(int),
      );
    }
    if (object.painSeverity != null) {
      yield r'painSeverity';
      yield serializers.serialize(
        object.painSeverity,
        specifiedType: const FullType(int),
      );
    }
    if (object.painFrequency != null) {
      yield r'painFrequency';
      yield serializers.serialize(
        object.painFrequency,
        specifiedType: const FullType(int),
      );
    }
    if (object.bloatingSeverity != null) {
      yield r'bloatingSeverity';
      yield serializers.serialize(
        object.bloatingSeverity,
        specifiedType: const FullType(int),
      );
    }
    if (object.bowelHabitsDissatisfaction != null) {
      yield r'bowelHabitsDissatisfaction';
      yield serializers.serialize(
        object.bowelHabitsDissatisfaction,
        specifiedType: const FullType(int),
      );
    }
    if (object.lifeInterference != null) {
      yield r'lifeInterference';
      yield serializers.serialize(
        object.lifeInterference,
        specifiedType: const FullType(int),
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
    if (object.completedAt != null) {
      yield r'completedAt';
      yield serializers.serialize(
        object.completedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.nextAssessmentDate != null) {
      yield r'nextAssessmentDate';
      yield serializers.serialize(
        object.nextAssessmentDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    IbsSssAssessmentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IbsSssAssessmentSummaryBuilder result,
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
        case r'assessmentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AssessmentType),
          ) as AssessmentType;
          result.assessmentType = valueDes;
          break;
        case r'cycleNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.cycleNumber = valueDes;
          break;
        case r'painSeverity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.painSeverity = valueDes;
          break;
        case r'painFrequency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.painFrequency = valueDes;
          break;
        case r'bloatingSeverity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bloatingSeverity = valueDes;
          break;
        case r'bowelHabitsDissatisfaction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bowelHabitsDissatisfaction = valueDes;
          break;
        case r'lifeInterference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lifeInterference = valueDes;
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
        case r'completedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.completedAt = valueDes;
          break;
        case r'nextAssessmentDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.nextAssessmentDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IbsSssAssessmentSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IbsSssAssessmentSummaryBuilder();
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

