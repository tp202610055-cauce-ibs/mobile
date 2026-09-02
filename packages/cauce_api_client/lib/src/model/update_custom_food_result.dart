//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_custom_food_result.g.dart';

/// UpdateCustomFoodResult
///
/// Properties:
/// * [customFoodId] 
@BuiltValue()
abstract class UpdateCustomFoodResult implements Built<UpdateCustomFoodResult, UpdateCustomFoodResultBuilder> {
  @BuiltValueField(wireName: r'customFoodId')
  String? get customFoodId;

  UpdateCustomFoodResult._();

  factory UpdateCustomFoodResult([void updates(UpdateCustomFoodResultBuilder b)]) = _$UpdateCustomFoodResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateCustomFoodResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateCustomFoodResult> get serializer => _$UpdateCustomFoodResultSerializer();
}

class _$UpdateCustomFoodResultSerializer implements PrimitiveSerializer<UpdateCustomFoodResult> {
  @override
  final Iterable<Type> types = const [UpdateCustomFoodResult, _$UpdateCustomFoodResult];

  @override
  final String wireName = r'UpdateCustomFoodResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateCustomFoodResult object, {
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
    UpdateCustomFoodResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateCustomFoodResultBuilder result,
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
  UpdateCustomFoodResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateCustomFoodResultBuilder();
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

