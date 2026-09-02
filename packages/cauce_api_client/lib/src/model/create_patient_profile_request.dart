//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/ibs_subtype.dart';
import 'package:cauce_api_client/src/model/biological_sex.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_patient_profile_request.g.dart';

/// Cuerpo de la petición de creación del perfil clínico del paciente.
///
/// Properties:
/// * [dateOfBirth] - Fecha de nacimiento.
/// * [biologicalSex] 
/// * [weightKg] - Peso en kilogramos.
/// * [heightCm] - Estatura en centímetros.
/// * [ibsSubtype] 
/// * [diagnosisDate] - Fecha de diagnóstico, opcional.
/// * [medications] - Medicación actual, opcional.
@BuiltValue()
abstract class CreatePatientProfileRequest implements Built<CreatePatientProfileRequest, CreatePatientProfileRequestBuilder> {
  /// Fecha de nacimiento.
  @BuiltValueField(wireName: r'dateOfBirth')
  Date? get dateOfBirth;

  @BuiltValueField(wireName: r'biologicalSex')
  BiologicalSex? get biologicalSex;
  // enum biologicalSexEnum {  Male,  Female,  Other,  };

  /// Peso en kilogramos.
  @BuiltValueField(wireName: r'weightKg')
  double? get weightKg;

  /// Estatura en centímetros.
  @BuiltValueField(wireName: r'heightCm')
  double? get heightCm;

  @BuiltValueField(wireName: r'ibsSubtype')
  IbsSubtype? get ibsSubtype;
  // enum ibsSubtypeEnum {  IbsD,  IbsC,  IbsM,  IbsU,  };

  /// Fecha de diagnóstico, opcional.
  @BuiltValueField(wireName: r'diagnosisDate')
  Date? get diagnosisDate;

  /// Medicación actual, opcional.
  @BuiltValueField(wireName: r'medications')
  String? get medications;

  CreatePatientProfileRequest._();

  factory CreatePatientProfileRequest([void updates(CreatePatientProfileRequestBuilder b)]) = _$CreatePatientProfileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePatientProfileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePatientProfileRequest> get serializer => _$CreatePatientProfileRequestSerializer();
}

class _$CreatePatientProfileRequestSerializer implements PrimitiveSerializer<CreatePatientProfileRequest> {
  @override
  final Iterable<Type> types = const [CreatePatientProfileRequest, _$CreatePatientProfileRequest];

  @override
  final String wireName = r'CreatePatientProfileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePatientProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePatientProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePatientProfileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePatientProfileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePatientProfileRequestBuilder();
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

