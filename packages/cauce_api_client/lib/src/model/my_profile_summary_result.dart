//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/my_profile_patient_info.dart';
import 'package:cauce_api_client/src/model/my_profile_clinical_info.dart';
import 'package:cauce_api_client/src/model/nutritionist_assignment_summary.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_profile_summary_result.g.dart';

/// MyProfileSummaryResult
///
/// Properties:
/// * [patient] 
/// * [clinical] 
/// * [pilotStartDate] 
/// * [assignedNutritionist] 
/// * [ibsSssBaseline] 
/// * [ibsSssLatest] 
/// * [cumulativeChange] 
/// * [significantClinicalResponse] 
@BuiltValue()
abstract class MyProfileSummaryResult implements Built<MyProfileSummaryResult, MyProfileSummaryResultBuilder> {
  @BuiltValueField(wireName: r'patient')
  MyProfilePatientInfo? get patient;

  @BuiltValueField(wireName: r'clinical')
  MyProfileClinicalInfo? get clinical;

  @BuiltValueField(wireName: r'pilotStartDate')
  Date? get pilotStartDate;

  @BuiltValueField(wireName: r'assignedNutritionist')
  NutritionistAssignmentSummary? get assignedNutritionist;

  @BuiltValueField(wireName: r'ibsSssBaseline')
  int? get ibsSssBaseline;

  @BuiltValueField(wireName: r'ibsSssLatest')
  int? get ibsSssLatest;

  @BuiltValueField(wireName: r'cumulativeChange')
  int? get cumulativeChange;

  @BuiltValueField(wireName: r'significantClinicalResponse')
  bool? get significantClinicalResponse;

  MyProfileSummaryResult._();

  factory MyProfileSummaryResult([void updates(MyProfileSummaryResultBuilder b)]) = _$MyProfileSummaryResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyProfileSummaryResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MyProfileSummaryResult> get serializer => _$MyProfileSummaryResultSerializer();
}

class _$MyProfileSummaryResultSerializer implements PrimitiveSerializer<MyProfileSummaryResult> {
  @override
  final Iterable<Type> types = const [MyProfileSummaryResult, _$MyProfileSummaryResult];

  @override
  final String wireName = r'MyProfileSummaryResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyProfileSummaryResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.patient != null) {
      yield r'patient';
      yield serializers.serialize(
        object.patient,
        specifiedType: const FullType(MyProfilePatientInfo),
      );
    }
    if (object.clinical != null) {
      yield r'clinical';
      yield serializers.serialize(
        object.clinical,
        specifiedType: const FullType(MyProfileClinicalInfo),
      );
    }
    if (object.pilotStartDate != null) {
      yield r'pilotStartDate';
      yield serializers.serialize(
        object.pilotStartDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.assignedNutritionist != null) {
      yield r'assignedNutritionist';
      yield serializers.serialize(
        object.assignedNutritionist,
        specifiedType: const FullType(NutritionistAssignmentSummary),
      );
    }
    if (object.ibsSssBaseline != null) {
      yield r'ibsSssBaseline';
      yield serializers.serialize(
        object.ibsSssBaseline,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.ibsSssLatest != null) {
      yield r'ibsSssLatest';
      yield serializers.serialize(
        object.ibsSssLatest,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.cumulativeChange != null) {
      yield r'cumulativeChange';
      yield serializers.serialize(
        object.cumulativeChange,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.significantClinicalResponse != null) {
      yield r'significantClinicalResponse';
      yield serializers.serialize(
        object.significantClinicalResponse,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MyProfileSummaryResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyProfileSummaryResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'patient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MyProfilePatientInfo),
          ) as MyProfilePatientInfo;
          result.patient.replace(valueDes);
          break;
        case r'clinical':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MyProfileClinicalInfo),
          ) as MyProfileClinicalInfo;
          result.clinical.replace(valueDes);
          break;
        case r'pilotStartDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.pilotStartDate = valueDes;
          break;
        case r'assignedNutritionist':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NutritionistAssignmentSummary),
          ) as NutritionistAssignmentSummary;
          result.assignedNutritionist.replace(valueDes);
          break;
        case r'ibsSssBaseline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.ibsSssBaseline = valueDes;
          break;
        case r'ibsSssLatest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.ibsSssLatest = valueDes;
          break;
        case r'cumulativeChange':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.cumulativeChange = valueDes;
          break;
        case r'significantClinicalResponse':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.significantClinicalResponse = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MyProfileSummaryResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyProfileSummaryResultBuilder();
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

