//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assign_nutritionist_request.g.dart';

/// Cuerpo de la petición de canje de un código de invitación después del registro (acta A41). Permite a  un paciente que se registró sin código vincularse a un nutricionista más adelante.
///
/// Properties:
/// * [invitationCode] - Código de invitación emitido por el nutricionista. Se normaliza a mayúsculas sin espacios  envolventes antes de validarse.
@BuiltValue()
abstract class AssignNutritionistRequest implements Built<AssignNutritionistRequest, AssignNutritionistRequestBuilder> {
  /// Código de invitación emitido por el nutricionista. Se normaliza a mayúsculas sin espacios  envolventes antes de validarse.
  @BuiltValueField(wireName: r'invitationCode')
  String? get invitationCode;

  AssignNutritionistRequest._();

  factory AssignNutritionistRequest([void updates(AssignNutritionistRequestBuilder b)]) = _$AssignNutritionistRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignNutritionistRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignNutritionistRequest> get serializer => _$AssignNutritionistRequestSerializer();
}

class _$AssignNutritionistRequestSerializer implements PrimitiveSerializer<AssignNutritionistRequest> {
  @override
  final Iterable<Type> types = const [AssignNutritionistRequest, _$AssignNutritionistRequest];

  @override
  final String wireName = r'AssignNutritionistRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignNutritionistRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.invitationCode != null) {
      yield r'invitationCode';
      yield serializers.serialize(
        object.invitationCode,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AssignNutritionistRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignNutritionistRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invitationCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.invitationCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssignNutritionistRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignNutritionistRequestBuilder();
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

