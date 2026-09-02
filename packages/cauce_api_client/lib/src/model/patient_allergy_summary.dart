//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/allergy_severity.dart';
import 'package:cauce_api_client/src/model/allergy_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'patient_allergy_summary.g.dart';

/// PatientAllergySummary
///
/// Properties:
/// * [patientAllergyId] 
/// * [allergyId] 
/// * [allergyName] 
/// * [allergyType] 
/// * [severity] 
/// * [notes] 
/// * [declaredAt] 
@BuiltValue()
abstract class PatientAllergySummary implements Built<PatientAllergySummary, PatientAllergySummaryBuilder> {
  @BuiltValueField(wireName: r'patientAllergyId')
  String? get patientAllergyId;

  @BuiltValueField(wireName: r'allergyId')
  String? get allergyId;

  @BuiltValueField(wireName: r'allergyName')
  String? get allergyName;

  @BuiltValueField(wireName: r'allergyType')
  AllergyType? get allergyType;
  // enum allergyTypeEnum {  Allergy,  Intolerance,  Sensitivity,  };

  @BuiltValueField(wireName: r'severity')
  AllergySeverity? get severity;
  // enum severityEnum {  Mild,  Moderate,  Severe,  };

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'declaredAt')
  DateTime? get declaredAt;

  PatientAllergySummary._();

  factory PatientAllergySummary([void updates(PatientAllergySummaryBuilder b)]) = _$PatientAllergySummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PatientAllergySummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PatientAllergySummary> get serializer => _$PatientAllergySummarySerializer();
}

class _$PatientAllergySummarySerializer implements PrimitiveSerializer<PatientAllergySummary> {
  @override
  final Iterable<Type> types = const [PatientAllergySummary, _$PatientAllergySummary];

  @override
  final String wireName = r'PatientAllergySummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PatientAllergySummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.patientAllergyId != null) {
      yield r'patientAllergyId';
      yield serializers.serialize(
        object.patientAllergyId,
        specifiedType: const FullType(String),
      );
    }
    if (object.allergyId != null) {
      yield r'allergyId';
      yield serializers.serialize(
        object.allergyId,
        specifiedType: const FullType(String),
      );
    }
    if (object.allergyName != null) {
      yield r'allergyName';
      yield serializers.serialize(
        object.allergyName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.allergyType != null) {
      yield r'allergyType';
      yield serializers.serialize(
        object.allergyType,
        specifiedType: const FullType(AllergyType),
      );
    }
    if (object.severity != null) {
      yield r'severity';
      yield serializers.serialize(
        object.severity,
        specifiedType: const FullType(AllergySeverity),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.declaredAt != null) {
      yield r'declaredAt';
      yield serializers.serialize(
        object.declaredAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PatientAllergySummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PatientAllergySummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'patientAllergyId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.patientAllergyId = valueDes;
          break;
        case r'allergyId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.allergyId = valueDes;
          break;
        case r'allergyName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.allergyName = valueDes;
          break;
        case r'allergyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AllergyType),
          ) as AllergyType;
          result.allergyType = valueDes;
          break;
        case r'severity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AllergySeverity),
          ) as AllergySeverity;
          result.severity = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'declaredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.declaredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PatientAllergySummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PatientAllergySummaryBuilder();
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

