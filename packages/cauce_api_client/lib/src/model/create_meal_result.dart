//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/fodmap_level.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_meal_result.g.dart';

/// CreateMealResult
///
/// Properties:
/// * [mealId] 
/// * [aggregatedFodmap] 
@BuiltValue()
abstract class CreateMealResult implements Built<CreateMealResult, CreateMealResultBuilder> {
  @BuiltValueField(wireName: r'mealId')
  String? get mealId;

  @BuiltValueField(wireName: r'aggregatedFodmap')
  FodmapLevel? get aggregatedFodmap;
  // enum aggregatedFodmapEnum {  Low,  Moderate,  High,  };

  CreateMealResult._();

  factory CreateMealResult([void updates(CreateMealResultBuilder b)]) = _$CreateMealResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateMealResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateMealResult> get serializer => _$CreateMealResultSerializer();
}

class _$CreateMealResultSerializer implements PrimitiveSerializer<CreateMealResult> {
  @override
  final Iterable<Type> types = const [CreateMealResult, _$CreateMealResult];

  @override
  final String wireName = r'CreateMealResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateMealResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.mealId != null) {
      yield r'mealId';
      yield serializers.serialize(
        object.mealId,
        specifiedType: const FullType(String),
      );
    }
    if (object.aggregatedFodmap != null) {
      yield r'aggregatedFodmap';
      yield serializers.serialize(
        object.aggregatedFodmap,
        specifiedType: const FullType(FodmapLevel),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateMealResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateMealResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mealId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mealId = valueDes;
          break;
        case r'aggregatedFodmap':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FodmapLevel),
          ) as FodmapLevel;
          result.aggregatedFodmap = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateMealResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateMealResultBuilder();
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

