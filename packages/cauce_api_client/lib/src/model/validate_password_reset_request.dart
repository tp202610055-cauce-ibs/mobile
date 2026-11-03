//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'validate_password_reset_request.g.dart';

/// Cuerpo de la petición que comprueba si un enlace de restablecimiento todavía sirve.
///
/// Properties:
/// * [token] - Token de restablecimiento recibido por correo.
@BuiltValue()
abstract class ValidatePasswordResetRequest implements Built<ValidatePasswordResetRequest, ValidatePasswordResetRequestBuilder> {
  /// Token de restablecimiento recibido por correo.
  @BuiltValueField(wireName: r'token')
  String? get token;

  ValidatePasswordResetRequest._();

  factory ValidatePasswordResetRequest([void updates(ValidatePasswordResetRequestBuilder b)]) = _$ValidatePasswordResetRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ValidatePasswordResetRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ValidatePasswordResetRequest> get serializer => _$ValidatePasswordResetRequestSerializer();
}

class _$ValidatePasswordResetRequestSerializer implements PrimitiveSerializer<ValidatePasswordResetRequest> {
  @override
  final Iterable<Type> types = const [ValidatePasswordResetRequest, _$ValidatePasswordResetRequest];

  @override
  final String wireName = r'ValidatePasswordResetRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ValidatePasswordResetRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ValidatePasswordResetRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ValidatePasswordResetRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ValidatePasswordResetRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ValidatePasswordResetRequestBuilder();
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

