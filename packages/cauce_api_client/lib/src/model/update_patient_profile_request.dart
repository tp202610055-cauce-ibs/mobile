//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/ibs_subtype.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_patient_profile_request.g.dart';

/// Cuerpo de la petición de actualización del perfil clínico. Los campos en  null no se modifican.
///
/// Properties:
/// * [weightKg] - Nuevo peso en kilogramos, opcional.
/// * [heightCm] - Nueva estatura en centímetros, opcional.
/// * [ibsSubtype] 
/// * [diagnosisDate] - Nueva fecha de diagnóstico, opcional.
/// * [medications] - Nueva medicación, opcional.
@BuiltValue()
abstract class UpdatePatientProfileRequest implements Built<UpdatePatientProfileRequest, UpdatePatientProfileRequestBuilder> {
  /// Nuevo peso en kilogramos, opcional.
  @BuiltValueField(wireName: r'weightKg')
  double? get weightKg;

  /// Nueva estatura en centímetros, opcional.
  @BuiltValueField(wireName: r'heightCm')
  double? get heightCm;

  @BuiltValueField(wireName: r'ibsSubtype')
  IbsSubtype? get ibsSubtype;
  // enum ibsSubtypeEnum {  IbsD,  IbsC,  IbsM,  IbsU,  };

  /// Nueva fecha de diagnóstico, opcional.
  @BuiltValueField(wireName: r'diagnosisDate')
  Date? get diagnosisDate;

  /// Nueva medicación, opcional.
  @BuiltValueField(wireName: r'medications')
  String? get medications;

  UpdatePatientProfileRequest._();

  factory UpdatePatientProfileRequest([void updates(UpdatePatientProfileRequestBuilder b)]) = _$UpdatePatientProfileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePatientProfileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePatientProfileRequest> get serializer => _$UpdatePatientProfileRequestSerializer();
}

class _$UpdatePatientProfileRequestSerializer implements PrimitiveSerializer<UpdatePatientProfileRequest> {
  @override
  final Iterable<Type> types = const [UpdatePatientProfileRequest, _$UpdatePatientProfileRequest];

  @override
  final String wireName = r'UpdatePatientProfileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePatientProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.weightKg != null) {
      yield r'weightKg';
      yield serializers.serialize(
        object.weightKg,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.heightCm != null) {
      yield r'heightCm';
      yield serializers.serialize(
        object.heightCm,
        specifiedType: const FullType.nullable(double),
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
    UpdatePatientProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdatePatientProfileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'weightKg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.weightKg = valueDes;
          break;
        case r'heightCm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
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
  UpdatePatientProfileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePatientProfileRequestBuilder();
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

