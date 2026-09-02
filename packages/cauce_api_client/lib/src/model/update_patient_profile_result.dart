//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_patient_profile_result.g.dart';

/// UpdatePatientProfileResult
///
/// Properties:
/// * [bmi] 
/// * [bmiCategory] 
/// * [age] 
@BuiltValue()
abstract class UpdatePatientProfileResult implements Built<UpdatePatientProfileResult, UpdatePatientProfileResultBuilder> {
  @BuiltValueField(wireName: r'bmi')
  double? get bmi;

  @BuiltValueField(wireName: r'bmiCategory')
  String? get bmiCategory;

  @BuiltValueField(wireName: r'age')
  int? get age;

  UpdatePatientProfileResult._();

  factory UpdatePatientProfileResult([void updates(UpdatePatientProfileResultBuilder b)]) = _$UpdatePatientProfileResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePatientProfileResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePatientProfileResult> get serializer => _$UpdatePatientProfileResultSerializer();
}

class _$UpdatePatientProfileResultSerializer implements PrimitiveSerializer<UpdatePatientProfileResult> {
  @override
  final Iterable<Type> types = const [UpdatePatientProfileResult, _$UpdatePatientProfileResult];

  @override
  final String wireName = r'UpdatePatientProfileResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePatientProfileResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePatientProfileResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdatePatientProfileResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePatientProfileResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePatientProfileResultBuilder();
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

