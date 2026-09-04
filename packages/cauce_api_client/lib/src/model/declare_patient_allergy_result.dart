//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'declare_patient_allergy_result.g.dart';

/// DeclarePatientAllergyResult
///
/// Properties:
/// * [patientAllergyId] 
@BuiltValue()
abstract class DeclarePatientAllergyResult implements Built<DeclarePatientAllergyResult, DeclarePatientAllergyResultBuilder> {
  @BuiltValueField(wireName: r'patientAllergyId')
  String? get patientAllergyId;

  DeclarePatientAllergyResult._();

  factory DeclarePatientAllergyResult([void updates(DeclarePatientAllergyResultBuilder b)]) = _$DeclarePatientAllergyResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeclarePatientAllergyResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeclarePatientAllergyResult> get serializer => _$DeclarePatientAllergyResultSerializer();
}

class _$DeclarePatientAllergyResultSerializer implements PrimitiveSerializer<DeclarePatientAllergyResult> {
  @override
  final Iterable<Type> types = const [DeclarePatientAllergyResult, _$DeclarePatientAllergyResult];

  @override
  final String wireName = r'DeclarePatientAllergyResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeclarePatientAllergyResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.patientAllergyId != null) {
      yield r'patientAllergyId';
      yield serializers.serialize(
        object.patientAllergyId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeclarePatientAllergyResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeclarePatientAllergyResultBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeclarePatientAllergyResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeclarePatientAllergyResultBuilder();
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

