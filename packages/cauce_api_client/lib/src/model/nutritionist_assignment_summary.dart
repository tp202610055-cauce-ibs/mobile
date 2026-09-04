//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'nutritionist_assignment_summary.g.dart';

/// NutritionistAssignmentSummary
///
/// Properties:
/// * [assignmentId] 
/// * [nutritionistUserId] 
/// * [nutritionistFullName] 
/// * [assignedAt] 
@BuiltValue()
abstract class NutritionistAssignmentSummary implements Built<NutritionistAssignmentSummary, NutritionistAssignmentSummaryBuilder> {
  @BuiltValueField(wireName: r'assignmentId')
  String? get assignmentId;

  @BuiltValueField(wireName: r'nutritionistUserId')
  String? get nutritionistUserId;

  @BuiltValueField(wireName: r'nutritionistFullName')
  String? get nutritionistFullName;

  @BuiltValueField(wireName: r'assignedAt')
  DateTime? get assignedAt;

  NutritionistAssignmentSummary._();

  factory NutritionistAssignmentSummary([void updates(NutritionistAssignmentSummaryBuilder b)]) = _$NutritionistAssignmentSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NutritionistAssignmentSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NutritionistAssignmentSummary> get serializer => _$NutritionistAssignmentSummarySerializer();
}

class _$NutritionistAssignmentSummarySerializer implements PrimitiveSerializer<NutritionistAssignmentSummary> {
  @override
  final Iterable<Type> types = const [NutritionistAssignmentSummary, _$NutritionistAssignmentSummary];

  @override
  final String wireName = r'NutritionistAssignmentSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NutritionistAssignmentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.assignmentId != null) {
      yield r'assignmentId';
      yield serializers.serialize(
        object.assignmentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.nutritionistUserId != null) {
      yield r'nutritionistUserId';
      yield serializers.serialize(
        object.nutritionistUserId,
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
    NutritionistAssignmentSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NutritionistAssignmentSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assignmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assignmentId = valueDes;
          break;
        case r'nutritionistUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nutritionistUserId = valueDes;
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
  NutritionistAssignmentSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NutritionistAssignmentSummaryBuilder();
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

