//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_symptom_result.g.dart';

/// CreateSymptomResult
///
/// Properties:
/// * [symptomId] 
/// * [associatedMealId] 
/// * [hasMealAssociation] 
@BuiltValue()
abstract class CreateSymptomResult implements Built<CreateSymptomResult, CreateSymptomResultBuilder> {
  @BuiltValueField(wireName: r'symptomId')
  String? get symptomId;

  @BuiltValueField(wireName: r'associatedMealId')
  String? get associatedMealId;

  @BuiltValueField(wireName: r'hasMealAssociation')
  bool? get hasMealAssociation;

  CreateSymptomResult._();

  factory CreateSymptomResult([void updates(CreateSymptomResultBuilder b)]) = _$CreateSymptomResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSymptomResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSymptomResult> get serializer => _$CreateSymptomResultSerializer();
}

class _$CreateSymptomResultSerializer implements PrimitiveSerializer<CreateSymptomResult> {
  @override
  final Iterable<Type> types = const [CreateSymptomResult, _$CreateSymptomResult];

  @override
  final String wireName = r'CreateSymptomResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSymptomResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.symptomId != null) {
      yield r'symptomId';
      yield serializers.serialize(
        object.symptomId,
        specifiedType: const FullType(String),
      );
    }
    if (object.associatedMealId != null) {
      yield r'associatedMealId';
      yield serializers.serialize(
        object.associatedMealId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.hasMealAssociation != null) {
      yield r'hasMealAssociation';
      yield serializers.serialize(
        object.hasMealAssociation,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSymptomResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateSymptomResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symptomId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symptomId = valueDes;
          break;
        case r'associatedMealId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.associatedMealId = valueDes;
          break;
        case r'hasMealAssociation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMealAssociation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateSymptomResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSymptomResultBuilder();
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

