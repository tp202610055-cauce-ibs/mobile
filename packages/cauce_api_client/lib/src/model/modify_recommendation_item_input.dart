//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/action_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'modify_recommendation_item_input.g.dart';

/// ModifyRecommendationItemInput
///
/// Properties:
/// * [foodId] 
/// * [actionType] 
/// * [reasoning] 
/// * [substituteFoodId] 
@BuiltValue()
abstract class ModifyRecommendationItemInput implements Built<ModifyRecommendationItemInput, ModifyRecommendationItemInputBuilder> {
  @BuiltValueField(wireName: r'foodId')
  String? get foodId;

  @BuiltValueField(wireName: r'actionType')
  ActionType? get actionType;
  // enum actionTypeEnum {  Suggest,  Reduce,  Avoid,  Substitute,  };

  @BuiltValueField(wireName: r'reasoning')
  String? get reasoning;

  @BuiltValueField(wireName: r'substituteFoodId')
  String? get substituteFoodId;

  ModifyRecommendationItemInput._();

  factory ModifyRecommendationItemInput([void updates(ModifyRecommendationItemInputBuilder b)]) = _$ModifyRecommendationItemInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ModifyRecommendationItemInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ModifyRecommendationItemInput> get serializer => _$ModifyRecommendationItemInputSerializer();
}

class _$ModifyRecommendationItemInputSerializer implements PrimitiveSerializer<ModifyRecommendationItemInput> {
  @override
  final Iterable<Type> types = const [ModifyRecommendationItemInput, _$ModifyRecommendationItemInput];

  @override
  final String wireName = r'ModifyRecommendationItemInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ModifyRecommendationItemInput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.foodId != null) {
      yield r'foodId';
      yield serializers.serialize(
        object.foodId,
        specifiedType: const FullType(String),
      );
    }
    if (object.actionType != null) {
      yield r'actionType';
      yield serializers.serialize(
        object.actionType,
        specifiedType: const FullType(ActionType),
      );
    }
    if (object.reasoning != null) {
      yield r'reasoning';
      yield serializers.serialize(
        object.reasoning,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.substituteFoodId != null) {
      yield r'substituteFoodId';
      yield serializers.serialize(
        object.substituteFoodId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ModifyRecommendationItemInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ModifyRecommendationItemInputBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'foodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.foodId = valueDes;
          break;
        case r'actionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActionType),
          ) as ActionType;
          result.actionType = valueDes;
          break;
        case r'reasoning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reasoning = valueDes;
          break;
        case r'substituteFoodId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.substituteFoodId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ModifyRecommendationItemInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ModifyRecommendationItemInputBuilder();
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

