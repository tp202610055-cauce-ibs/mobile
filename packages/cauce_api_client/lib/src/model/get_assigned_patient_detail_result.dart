//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/patient_allergy_summary.dart';
import 'package:cauce_api_client/src/model/ibs_subtype.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/biological_sex.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_assigned_patient_detail_result.g.dart';

/// GetAssignedPatientDetailResult
///
/// Properties:
/// * [patientUserId] 
/// * [fullName] 
/// * [age] 
/// * [bmi] 
/// * [bmiCategory] 
/// * [ibsSubtype] 
/// * [onboardingCompleted] 
/// * [allergies] 
/// * [biologicalSex] 
/// * [diagnosisDate] 
/// * [medications] 
@BuiltValue()
abstract class GetAssignedPatientDetailResult implements Built<GetAssignedPatientDetailResult, GetAssignedPatientDetailResultBuilder> {
  @BuiltValueField(wireName: r'patientUserId')
  String? get patientUserId;

  @BuiltValueField(wireName: r'fullName')
  String? get fullName;

  @BuiltValueField(wireName: r'age')
  int? get age;

  @BuiltValueField(wireName: r'bmi')
  double? get bmi;

  @BuiltValueField(wireName: r'bmiCategory')
  String? get bmiCategory;

  @BuiltValueField(wireName: r'ibsSubtype')
  IbsSubtype? get ibsSubtype;
  // enum ibsSubtypeEnum {  IbsD,  IbsC,  IbsM,  IbsU,  };

  @BuiltValueField(wireName: r'onboardingCompleted')
  bool? get onboardingCompleted;

  @BuiltValueField(wireName: r'allergies')
  BuiltList<PatientAllergySummary>? get allergies;

  @BuiltValueField(wireName: r'biologicalSex')
  BiologicalSex? get biologicalSex;
  // enum biologicalSexEnum {  Male,  Female,  Other,  };

  @BuiltValueField(wireName: r'diagnosisDate')
  Date? get diagnosisDate;

  @BuiltValueField(wireName: r'medications')
  String? get medications;

  GetAssignedPatientDetailResult._();

  factory GetAssignedPatientDetailResult([void updates(GetAssignedPatientDetailResultBuilder b)]) = _$GetAssignedPatientDetailResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAssignedPatientDetailResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAssignedPatientDetailResult> get serializer => _$GetAssignedPatientDetailResultSerializer();
}

class _$GetAssignedPatientDetailResultSerializer implements PrimitiveSerializer<GetAssignedPatientDetailResult> {
  @override
  final Iterable<Type> types = const [GetAssignedPatientDetailResult, _$GetAssignedPatientDetailResult];

  @override
  final String wireName = r'GetAssignedPatientDetailResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAssignedPatientDetailResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.patientUserId != null) {
      yield r'patientUserId';
      yield serializers.serialize(
        object.patientUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.fullName != null) {
      yield r'fullName';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.bmi != null) {
      yield r'bmi';
      yield serializers.serialize(
        object.bmi,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.bmiCategory != null) {
      yield r'bmiCategory';
      yield serializers.serialize(
        object.bmiCategory,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.ibsSubtype != null) {
      yield r'ibsSubtype';
      yield serializers.serialize(
        object.ibsSubtype,
        specifiedType: const FullType(IbsSubtype),
      );
    }
    if (object.onboardingCompleted != null) {
      yield r'onboardingCompleted';
      yield serializers.serialize(
        object.onboardingCompleted,
        specifiedType: const FullType(bool),
      );
    }
    if (object.allergies != null) {
      yield r'allergies';
      yield serializers.serialize(
        object.allergies,
        specifiedType: const FullType.nullable(BuiltList, [FullType(PatientAllergySummary)]),
      );
    }
    if (object.biologicalSex != null) {
      yield r'biologicalSex';
      yield serializers.serialize(
        object.biologicalSex,
        specifiedType: const FullType(BiologicalSex),
      );
    }
    if (object.diagnosisDate != null) {
      yield r'diagnosisDate';
      yield serializers.serialize(
        object.diagnosisDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.medications != null) {
      yield r'medications';
      yield serializers.serialize(
        object.medications,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAssignedPatientDetailResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetAssignedPatientDetailResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'patientUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.patientUserId = valueDes;
          break;
        case r'fullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fullName = valueDes;
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.age = valueDes;
          break;
        case r'bmi':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.bmi = valueDes;
          break;
        case r'bmiCategory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bmiCategory = valueDes;
          break;
        case r'ibsSubtype':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IbsSubtype),
          ) as IbsSubtype;
          result.ibsSubtype = valueDes;
          break;
        case r'onboardingCompleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.onboardingCompleted = valueDes;
          break;
        case r'allergies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(PatientAllergySummary)]),
          ) as BuiltList<PatientAllergySummary>?;
          if (valueDes == null) continue;
          result.allergies.replace(valueDes);
          break;
        case r'biologicalSex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BiologicalSex),
          ) as BiologicalSex;
          result.biologicalSex = valueDes;
          break;
        case r'diagnosisDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.diagnosisDate = valueDes;
          break;
        case r'medications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.medications = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetAssignedPatientDetailResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAssignedPatientDetailResultBuilder();
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

