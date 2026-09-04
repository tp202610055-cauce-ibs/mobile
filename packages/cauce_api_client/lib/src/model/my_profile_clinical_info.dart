//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/ibs_subtype.dart';
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_profile_clinical_info.g.dart';

/// MyProfileClinicalInfo
///
/// Properties:
/// * [ibsSubtype] 
/// * [diagnosisDate] 
/// * [age] 
@BuiltValue()
abstract class MyProfileClinicalInfo implements Built<MyProfileClinicalInfo, MyProfileClinicalInfoBuilder> {
  @BuiltValueField(wireName: r'ibsSubtype')
  IbsSubtype? get ibsSubtype;
  // enum ibsSubtypeEnum {  IbsD,  IbsC,  IbsM,  IbsU,  };

  @BuiltValueField(wireName: r'diagnosisDate')
  Date? get diagnosisDate;

  @BuiltValueField(wireName: r'age')
  int? get age;

  MyProfileClinicalInfo._();

  factory MyProfileClinicalInfo([void updates(MyProfileClinicalInfoBuilder b)]) = _$MyProfileClinicalInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyProfileClinicalInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MyProfileClinicalInfo> get serializer => _$MyProfileClinicalInfoSerializer();
}

class _$MyProfileClinicalInfoSerializer implements PrimitiveSerializer<MyProfileClinicalInfo> {
  @override
  final Iterable<Type> types = const [MyProfileClinicalInfo, _$MyProfileClinicalInfo];

  @override
  final String wireName = r'MyProfileClinicalInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyProfileClinicalInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    MyProfileClinicalInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyProfileClinicalInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  MyProfileClinicalInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyProfileClinicalInfoBuilder();
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

