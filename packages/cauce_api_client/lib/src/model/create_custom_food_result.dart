//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_custom_food_result.g.dart';

/// CreateCustomFoodResult
///
/// Properties:
/// * [customFoodId] 
@BuiltValue()
abstract class CreateCustomFoodResult implements Built<CreateCustomFoodResult, CreateCustomFoodResultBuilder> {
  @BuiltValueField(wireName: r'customFoodId')
  String? get customFoodId;

  CreateCustomFoodResult._();

  factory CreateCustomFoodResult([void updates(CreateCustomFoodResultBuilder b)]) = _$CreateCustomFoodResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateCustomFoodResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateCustomFoodResult> get serializer => _$CreateCustomFoodResultSerializer();
}

class _$CreateCustomFoodResultSerializer implements PrimitiveSerializer<CreateCustomFoodResult> {
  @override
  final Iterable<Type> types = const [CreateCustomFoodResult, _$CreateCustomFoodResult];

  @override
  final String wireName = r'CreateCustomFoodResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateCustomFoodResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.customFoodId != null) {
      yield r'customFoodId';
      yield serializers.serialize(
        object.customFoodId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateCustomFoodResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateCustomFoodResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'customFoodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customFoodId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateCustomFoodResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateCustomFoodResultBuilder();
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

