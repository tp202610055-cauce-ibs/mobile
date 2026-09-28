//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_symptom_meal_association_request.g.dart';

/// Cuerpo de la corrección manual de la comida asociada a un síntoma.
///
/// Properties:
/// * [mealId] - Comida que se asocia al síntoma, o null para desvincularlo.
@BuiltValue()
abstract class SetSymptomMealAssociationRequest implements Built<SetSymptomMealAssociationRequest, SetSymptomMealAssociationRequestBuilder> {
  /// Comida que se asocia al síntoma, o null para desvincularlo.
  @BuiltValueField(wireName: r'mealId')
  String? get mealId;

  SetSymptomMealAssociationRequest._();

  factory SetSymptomMealAssociationRequest([void updates(SetSymptomMealAssociationRequestBuilder b)]) = _$SetSymptomMealAssociationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetSymptomMealAssociationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetSymptomMealAssociationRequest> get serializer => _$SetSymptomMealAssociationRequestSerializer();
}

class _$SetSymptomMealAssociationRequestSerializer implements PrimitiveSerializer<SetSymptomMealAssociationRequest> {
  @override
  final Iterable<Type> types = const [SetSymptomMealAssociationRequest, _$SetSymptomMealAssociationRequest];

  @override
  final String wireName = r'SetSymptomMealAssociationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetSymptomMealAssociationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.mealId != null) {
      yield r'mealId';
      yield serializers.serialize(
        object.mealId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SetSymptomMealAssociationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SetSymptomMealAssociationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mealId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mealId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetSymptomMealAssociationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetSymptomMealAssociationRequestBuilder();
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

