//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assign_nutritionist_result.g.dart';

/// AssignNutritionistResult
///
/// Properties:
/// * [nutritionistId] 
/// * [nutritionistFullName] 
/// * [assignedAt] 
@BuiltValue()
abstract class AssignNutritionistResult implements Built<AssignNutritionistResult, AssignNutritionistResultBuilder> {
  @BuiltValueField(wireName: r'nutritionistId')
  String? get nutritionistId;

  @BuiltValueField(wireName: r'nutritionistFullName')
  String? get nutritionistFullName;

  @BuiltValueField(wireName: r'assignedAt')
  DateTime? get assignedAt;

  AssignNutritionistResult._();

  factory AssignNutritionistResult([void updates(AssignNutritionistResultBuilder b)]) = _$AssignNutritionistResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignNutritionistResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignNutritionistResult> get serializer => _$AssignNutritionistResultSerializer();
}

class _$AssignNutritionistResultSerializer implements PrimitiveSerializer<AssignNutritionistResult> {
  @override
  final Iterable<Type> types = const [AssignNutritionistResult, _$AssignNutritionistResult];

  @override
  final String wireName = r'AssignNutritionistResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignNutritionistResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.nutritionistId != null) {
      yield r'nutritionistId';
      yield serializers.serialize(
        object.nutritionistId,
        specifiedType: const FullType(String),
      );
    }
    if (object.nutritionistFullName != null) {
      yield r'nutritionistFullName';
      yield serializers.serialize(
        object.nutritionistFullName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.assignedAt != null) {
      yield r'assignedAt';
      yield serializers.serialize(
        object.assignedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AssignNutritionistResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignNutritionistResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nutritionistId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nutritionistId = valueDes;
          break;
        case r'nutritionistFullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nutritionistFullName = valueDes;
          break;
        case r'assignedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.assignedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssignNutritionistResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignNutritionistResultBuilder();
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

