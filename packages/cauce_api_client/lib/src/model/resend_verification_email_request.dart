//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'resend_verification_email_request.g.dart';

/// Cuerpo de la petición de reenvío del correo de verificación (acta A40). La respuesta es siempre 200  cuando la petición supera la validación, exista o no la cuenta, para no revelar qué correos están  registrados ni cuáles ya están verificados.
///
/// Properties:
/// * [email] - Correo electrónico de la cuenta que solicita el reenvío.
@BuiltValue()
abstract class ResendVerificationEmailRequest implements Built<ResendVerificationEmailRequest, ResendVerificationEmailRequestBuilder> {
  /// Correo electrónico de la cuenta que solicita el reenvío.
  @BuiltValueField(wireName: r'email')
  String? get email;

  ResendVerificationEmailRequest._();

  factory ResendVerificationEmailRequest([void updates(ResendVerificationEmailRequestBuilder b)]) = _$ResendVerificationEmailRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResendVerificationEmailRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResendVerificationEmailRequest> get serializer => _$ResendVerificationEmailRequestSerializer();
}

class _$ResendVerificationEmailRequestSerializer implements PrimitiveSerializer<ResendVerificationEmailRequest> {
  @override
  final Iterable<Type> types = const [ResendVerificationEmailRequest, _$ResendVerificationEmailRequest];

  @override
  final String wireName = r'ResendVerificationEmailRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResendVerificationEmailRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResendVerificationEmailRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResendVerificationEmailRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResendVerificationEmailRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResendVerificationEmailRequestBuilder();
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

