//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_nutritionist_result.g.dart';

/// CreateNutritionistResult
///
/// Properties:
/// * [userId] 
/// * [email] 
/// * [temporaryCredentialsEmailSent] 
@BuiltValue()
abstract class CreateNutritionistResult implements Built<CreateNutritionistResult, CreateNutritionistResultBuilder> {
  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'temporaryCredentialsEmailSent')
  bool? get temporaryCredentialsEmailSent;

  CreateNutritionistResult._();

  factory CreateNutritionistResult([void updates(CreateNutritionistResultBuilder b)]) = _$CreateNutritionistResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateNutritionistResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateNutritionistResult> get serializer => _$CreateNutritionistResultSerializer();
}

class _$CreateNutritionistResultSerializer implements PrimitiveSerializer<CreateNutritionistResult> {
  @override
  final Iterable<Type> types = const [CreateNutritionistResult, _$CreateNutritionistResult];

  @override
  final String wireName = r'CreateNutritionistResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateNutritionistResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.temporaryCredentialsEmailSent != null) {
      yield r'temporaryCredentialsEmailSent';
      yield serializers.serialize(
        object.temporaryCredentialsEmailSent,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateNutritionistResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateNutritionistResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'temporaryCredentialsEmailSent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.temporaryCredentialsEmailSent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateNutritionistResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateNutritionistResultBuilder();
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

