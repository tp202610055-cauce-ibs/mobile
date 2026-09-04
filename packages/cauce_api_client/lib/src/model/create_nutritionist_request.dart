//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_nutritionist_request.g.dart';

/// Cuerpo de la petición de provisión de un nutricionista.
///
/// Properties:
/// * [email] - Correo electrónico del nutricionista.
/// * [fullName] - Nombre completo del nutricionista.
@BuiltValue()
abstract class CreateNutritionistRequest implements Built<CreateNutritionistRequest, CreateNutritionistRequestBuilder> {
  /// Correo electrónico del nutricionista.
  @BuiltValueField(wireName: r'email')
  String? get email;

  /// Nombre completo del nutricionista.
  @BuiltValueField(wireName: r'fullName')
  String? get fullName;

  CreateNutritionistRequest._();

  factory CreateNutritionistRequest([void updates(CreateNutritionistRequestBuilder b)]) = _$CreateNutritionistRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateNutritionistRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateNutritionistRequest> get serializer => _$CreateNutritionistRequestSerializer();
}

class _$CreateNutritionistRequestSerializer implements PrimitiveSerializer<CreateNutritionistRequest> {
  @override
  final Iterable<Type> types = const [CreateNutritionistRequest, _$CreateNutritionistRequest];

  @override
  final String wireName = r'CreateNutritionistRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateNutritionistRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fullName != null) {
      yield r'fullName';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateNutritionistRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateNutritionistRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'fullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fullName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateNutritionistRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateNutritionistRequestBuilder();
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

