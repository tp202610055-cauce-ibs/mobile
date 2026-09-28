//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portal_login_request.g.dart';

/// Cuerpo de la petición de inicio de sesión del portal web. No lleva cliente OIDC: el canal lo define  la ruta, y el backend usa siempre `cauce-web-portal` (acta A68).
///
/// Properties:
/// * [email] - Correo electrónico.
/// * [password] - Contraseña.
@BuiltValue()
abstract class PortalLoginRequest implements Built<PortalLoginRequest, PortalLoginRequestBuilder> {
  /// Correo electrónico.
  @BuiltValueField(wireName: r'email')
  String? get email;

  /// Contraseña.
  @BuiltValueField(wireName: r'password')
  String? get password;

  PortalLoginRequest._();

  factory PortalLoginRequest([void updates(PortalLoginRequestBuilder b)]) = _$PortalLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortalLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortalLoginRequest> get serializer => _$PortalLoginRequestSerializer();
}

class _$PortalLoginRequestSerializer implements PrimitiveSerializer<PortalLoginRequest> {
  @override
  final Iterable<Type> types = const [PortalLoginRequest, _$PortalLoginRequest];

  @override
  final String wireName = r'PortalLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortalLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortalLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortalLoginRequestBuilder result,
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
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortalLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortalLoginRequestBuilder();
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

