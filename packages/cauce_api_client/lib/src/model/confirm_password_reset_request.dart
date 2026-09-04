//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_password_reset_request.g.dart';

/// Cuerpo de la petición de confirmación de restablecimiento de contraseña.
///
/// Properties:
/// * [token] - Token de restablecimiento recibido por correo.
/// * [newPassword] - Nueva contraseña elegida por el usuario.
@BuiltValue()
abstract class ConfirmPasswordResetRequest implements Built<ConfirmPasswordResetRequest, ConfirmPasswordResetRequestBuilder> {
  /// Token de restablecimiento recibido por correo.
  @BuiltValueField(wireName: r'token')
  String? get token;

  /// Nueva contraseña elegida por el usuario.
  @BuiltValueField(wireName: r'newPassword')
  String? get newPassword;

  ConfirmPasswordResetRequest._();

  factory ConfirmPasswordResetRequest([void updates(ConfirmPasswordResetRequestBuilder b)]) = _$ConfirmPasswordResetRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmPasswordResetRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmPasswordResetRequest> get serializer => _$ConfirmPasswordResetRequestSerializer();
}

class _$ConfirmPasswordResetRequestSerializer implements PrimitiveSerializer<ConfirmPasswordResetRequest> {
  @override
  final Iterable<Type> types = const [ConfirmPasswordResetRequest, _$ConfirmPasswordResetRequest];

  @override
  final String wireName = r'ConfirmPasswordResetRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmPasswordResetRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.newPassword != null) {
      yield r'newPassword';
      yield serializers.serialize(
        object.newPassword,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfirmPasswordResetRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConfirmPasswordResetRequestBuilder result,
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
        case r'newPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.newPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConfirmPasswordResetRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmPasswordResetRequestBuilder();
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

