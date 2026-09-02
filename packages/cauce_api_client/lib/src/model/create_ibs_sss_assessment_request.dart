//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/assessment_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_ibs_sss_assessment_request.g.dart';

/// Cuerpo de la petición de registro de una evaluación IBS-SSS. El cliente envía  únicamente las cinco dimensiones; el servidor calcula el puntaje total y la categoría.
///
/// Properties:
/// * [assessmentType] 
/// * [painSeverity] - Severidad del dolor (0–100).
/// * [painFrequency] - Frecuencia del dolor (0–100).
/// * [bloatingSeverity] - Severidad de la distensión (0–100).
/// * [bowelHabitsDissatisfaction] - Insatisfacción con el hábito intestinal (0–100).
/// * [lifeInterference] - Interferencia con la vida diaria (0–100).
@BuiltValue()
abstract class CreateIbsSssAssessmentRequest implements Built<CreateIbsSssAssessmentRequest, CreateIbsSssAssessmentRequestBuilder> {
  @BuiltValueField(wireName: r'assessmentType')
  AssessmentType? get assessmentType;
  // enum assessmentTypeEnum {  Baseline,  Periodic,  };

  /// Severidad del dolor (0–100).
  @BuiltValueField(wireName: r'painSeverity')
  int? get painSeverity;

  /// Frecuencia del dolor (0–100).
  @BuiltValueField(wireName: r'painFrequency')
  int? get painFrequency;

  /// Severidad de la distensión (0–100).
  @BuiltValueField(wireName: r'bloatingSeverity')
  int? get bloatingSeverity;

  /// Insatisfacción con el hábito intestinal (0–100).
  @BuiltValueField(wireName: r'bowelHabitsDissatisfaction')
  int? get bowelHabitsDissatisfaction;

  /// Interferencia con la vida diaria (0–100).
  @BuiltValueField(wireName: r'lifeInterference')
  int? get lifeInterference;

  CreateIbsSssAssessmentRequest._();

  factory CreateIbsSssAssessmentRequest([void updates(CreateIbsSssAssessmentRequestBuilder b)]) = _$CreateIbsSssAssessmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateIbsSssAssessmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateIbsSssAssessmentRequest> get serializer => _$CreateIbsSssAssessmentRequestSerializer();
}

class _$CreateIbsSssAssessmentRequestSerializer implements PrimitiveSerializer<CreateIbsSssAssessmentRequest> {
  @override
  final Iterable<Type> types = const [CreateIbsSssAssessmentRequest, _$CreateIbsSssAssessmentRequest];

  @override
  final String wireName = r'CreateIbsSssAssessmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateIbsSssAssessmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.assessmentType != null) {
      yield r'assessmentType';
      yield serializers.serialize(
        object.assessmentType,
        specifiedType: const FullType(AssessmentType),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateIbsSssAssessmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateIbsSssAssessmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assessmentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AssessmentType),
          ) as AssessmentType;
          result.assessmentType = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateIbsSssAssessmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateIbsSssAssessmentRequestBuilder();
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

