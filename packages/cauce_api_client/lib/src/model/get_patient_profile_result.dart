//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/patient_allergy_summary.dart';
import 'package:cauce_api_client/src/model/ibs_subtype.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/biological_sex.dart';
import 'package:cauce_api_client/src/model/nutritionist_assignment_summary.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_patient_profile_result.g.dart';

/// GetPatientProfileResult
///
/// Properties:
/// * [profileId] 
/// * [userId] 
/// * [dateOfBirth] 
/// * [biologicalSex] 
/// * [weightKg] 
/// * [heightCm] 
/// * [bmi] 
/// * [bmiCategory] 
/// * [age] 
/// * [ibsSubtype] 
/// * [diagnosisDate] 
/// * [medications] 
/// * [onboardingCompleted] 
/// * [allergies] 
/// * [assignedNutritionist] 
@BuiltValue()
abstract class GetPatientProfileResult implements Built<GetPatientProfileResult, GetPatientProfileResultBuilder> {
  @BuiltValueField(wireName: r'profileId')
  String? get profileId;

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'dateOfBirth')
  Date? get dateOfBirth;

  @BuiltValueField(wireName: r'biologicalSex')
  BiologicalSex? get biologicalSex;
  // enum biologicalSexEnum {  Male,  Female,  Other,  };

  @BuiltValueField(wireName: r'weightKg')
  double? get weightKg;

  @BuiltValueField(wireName: r'heightCm')
  double? get heightCm;

  @BuiltValueField(wireName: r'bmi')
  double? get bmi;

  @BuiltValueField(wireName: r'bmiCategory')
  String? get bmiCategory;

  @BuiltValueField(wireName: r'age')
  int? get age;

  @BuiltValueField(wireName: r'ibsSubtype')
  IbsSubtype? get ibsSubtype;
  // enum ibsSubtypeEnum {  IbsD,  IbsC,  IbsM,  IbsU,  };

  @BuiltValueField(wireName: r'diagnosisDate')
  Date? get diagnosisDate;

  @BuiltValueField(wireName: r'medications')
  String? get medications;

  @BuiltValueField(wireName: r'onboardingCompleted')
  bool? get onboardingCompleted;

  @BuiltValueField(wireName: r'allergies')
  BuiltList<PatientAllergySummary>? get allergies;

  @BuiltValueField(wireName: r'assignedNutritionist')
  NutritionistAssignmentSummary? get assignedNutritionist;

  GetPatientProfileResult._();

  factory GetPatientProfileResult([void updates(GetPatientProfileResultBuilder b)]) = _$GetPatientProfileResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetPatientProfileResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetPatientProfileResult> get serializer => _$GetPatientProfileResultSerializer();
}

class _$GetPatientProfileResultSerializer implements PrimitiveSerializer<GetPatientProfileResult> {
  @override
  final Iterable<Type> types = const [GetPatientProfileResult, _$GetPatientProfileResult];

  @override
  final String wireName = r'GetPatientProfileResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetPatientProfileResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.profileId != null) {
      yield r'profileId';
      yield serializers.serialize(
        object.profileId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.dateOfBirth != null) {
      yield r'dateOfBirth';
      yield serializers.serialize(
        object.dateOfBirth,
        specifiedType: const FullType(Date),
      );
    }
    if (object.biologicalSex != null) {
      yield r'biologicalSex';
      yield serializers.serialize(
        object.biologicalSex,
        specifiedType: const FullType(BiologicalSex),
      );
    }
    if (object.weightKg != null) {
      yield r'weightKg';
      yield serializers.serialize(
        object.weightKg,
        specifiedType: const FullType(double),
      );
    }
    if (object.heightCm != null) {
      yield r'heightCm';
      yield serializers.serialize(
        object.heightCm,
        specifiedType: const FullType(double),
      );
    }
    if (object.bmi != null) {
      yield r'bmi';
      yield serializers.serialize(
        object.bmi,
        specifiedType: const FullType(double),
      );
    }
    if (object.bmiCategory != null) {
      yield r'bmiCategory';
      yield serializers.serialize(
        object.bmiCategory,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType(int),
      );
    }
    if (object.ibsSubtype != null) {
      yield r'ibsSubtype';
      yield serializers.serialize(
        object.ibsSubtype,
        specifiedType: const FullType(IbsSubtype),
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
    if (object.assignedNutritionist != null) {
      yield r'assignedNutritionist';
      yield serializers.serialize(
        object.assignedNutritionist,
        specifiedType: const FullType(NutritionistAssignmentSummary),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetPatientProfileResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetPatientProfileResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'profileId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.profileId = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'dateOfBirth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.dateOfBirth = valueDes;
          break;
        case r'biologicalSex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BiologicalSex),
          ) as BiologicalSex;
          result.biologicalSex = valueDes;
          break;
        case r'weightKg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.weightKg = valueDes;
          break;
        case r'heightCm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.heightCm = valueDes;
          break;
        case r'bmi':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
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
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.age = valueDes;
          break;
        case r'ibsSubtype':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IbsSubtype),
          ) as IbsSubtype;
          result.ibsSubtype = valueDes;
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
        case r'assignedNutritionist':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NutritionistAssignmentSummary),
          ) as NutritionistAssignmentSummary;
          result.assignedNutritionist.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetPatientProfileResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetPatientProfileResultBuilder();
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

