//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_profile_patient_info.g.dart';

/// MyProfilePatientInfo
///
/// Properties:
/// * [fullName] 
/// * [maskedEmail] 
@BuiltValue()
abstract class MyProfilePatientInfo implements Built<MyProfilePatientInfo, MyProfilePatientInfoBuilder> {
  @BuiltValueField(wireName: r'fullName')
  String? get fullName;

  @BuiltValueField(wireName: r'maskedEmail')
  String? get maskedEmail;

  MyProfilePatientInfo._();

  factory MyProfilePatientInfo([void updates(MyProfilePatientInfoBuilder b)]) = _$MyProfilePatientInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyProfilePatientInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MyProfilePatientInfo> get serializer => _$MyProfilePatientInfoSerializer();
}

class _$MyProfilePatientInfoSerializer implements PrimitiveSerializer<MyProfilePatientInfo> {
  @override
  final Iterable<Type> types = const [MyProfilePatientInfo, _$MyProfilePatientInfo];

  @override
  final String wireName = r'MyProfilePatientInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyProfilePatientInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.fullName != null) {
      yield r'fullName';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.maskedEmail != null) {
      yield r'maskedEmail';
      yield serializers.serialize(
        object.maskedEmail,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MyProfilePatientInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyProfilePatientInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fullName = valueDes;
          break;
        case r'maskedEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.maskedEmail = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MyProfilePatientInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyProfilePatientInfoBuilder();
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

