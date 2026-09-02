//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_patient_profile_result.g.dart';

/// CreatePatientProfileResult
///
/// Properties:
/// * [profileId] 
/// * [bmi] 
/// * [bmiCategory] 
/// * [age] 
/// * [nutritionistAssigned] 
/// * [nutritionistAssignmentId] 
@BuiltValue()
abstract class CreatePatientProfileResult implements Built<CreatePatientProfileResult, CreatePatientProfileResultBuilder> {
  @BuiltValueField(wireName: r'profileId')
  String? get profileId;

  @BuiltValueField(wireName: r'bmi')
  double? get bmi;

  @BuiltValueField(wireName: r'bmiCategory')
  String? get bmiCategory;

  @BuiltValueField(wireName: r'age')
  int? get age;

  @BuiltValueField(wireName: r'nutritionistAssigned')
  bool? get nutritionistAssigned;

  @BuiltValueField(wireName: r'nutritionistAssignmentId')
  String? get nutritionistAssignmentId;

  CreatePatientProfileResult._();

  factory CreatePatientProfileResult([void updates(CreatePatientProfileResultBuilder b)]) = _$CreatePatientProfileResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePatientProfileResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePatientProfileResult> get serializer => _$CreatePatientProfileResultSerializer();
}

class _$CreatePatientProfileResultSerializer implements PrimitiveSerializer<CreatePatientProfileResult> {
  @override
  final Iterable<Type> types = const [CreatePatientProfileResult, _$CreatePatientProfileResult];

  @override
  final String wireName = r'CreatePatientProfileResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePatientProfileResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.profileId != null) {
      yield r'profileId';
      yield serializers.serialize(
        object.profileId,
        specifiedType: const FullType(String),
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
    if (object.nutritionistAssigned != null) {
      yield r'nutritionistAssigned';
      yield serializers.serialize(
        object.nutritionistAssigned,
        specifiedType: const FullType(bool),
      );
    }
    if (object.nutritionistAssignmentId != null) {
      yield r'nutritionistAssignmentId';
      yield serializers.serialize(
        object.nutritionistAssignmentId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePatientProfileResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePatientProfileResultBuilder result,
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
        case r'nutritionistAssigned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.nutritionistAssigned = valueDes;
          break;
        case r'nutritionistAssignmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nutritionistAssignmentId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePatientProfileResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePatientProfileResultBuilder();
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

