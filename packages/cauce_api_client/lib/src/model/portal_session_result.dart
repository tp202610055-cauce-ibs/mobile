//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/authenticated_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portal_session_result.g.dart';

/// Respuesta del inicio de sesión y de la renovación del portal web. A diferencia de la del móvil, no  trae el refresh token: viaja en la cookie `HttpOnly``cauce_portal_rt`, fuera del alcance del  JavaScript del portal (acta A68). El portal guarda el access token solo en memoria.
///
/// Properties:
/// * [accessToken] - Token de acceso JWT, para el header `Authorization: Bearer`.
/// * [expiresIn] - Vigencia del token de acceso, en segundos.
/// * [tokenType] - Tipo de token, `Bearer`.
/// * [user] 
@BuiltValue()
abstract class PortalSessionResult implements Built<PortalSessionResult, PortalSessionResultBuilder> {
  /// Token de acceso JWT, para el header `Authorization: Bearer`.
  @BuiltValueField(wireName: r'accessToken')
  String? get accessToken;

  /// Vigencia del token de acceso, en segundos.
  @BuiltValueField(wireName: r'expiresIn')
  int? get expiresIn;

  /// Tipo de token, `Bearer`.
  @BuiltValueField(wireName: r'tokenType')
  String? get tokenType;

  @BuiltValueField(wireName: r'user')
  AuthenticatedUser? get user;

  PortalSessionResult._();

  factory PortalSessionResult([void updates(PortalSessionResultBuilder b)]) = _$PortalSessionResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortalSessionResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortalSessionResult> get serializer => _$PortalSessionResultSerializer();
}

class _$PortalSessionResultSerializer implements PrimitiveSerializer<PortalSessionResult> {
  @override
  final Iterable<Type> types = const [PortalSessionResult, _$PortalSessionResult];

  @override
  final String wireName = r'PortalSessionResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortalSessionResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accessToken != null) {
      yield r'accessToken';
      yield serializers.serialize(
        object.accessToken,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.expiresIn != null) {
      yield r'expiresIn';
      yield serializers.serialize(
        object.expiresIn,
        specifiedType: const FullType(int),
      );
    }
    if (object.tokenType != null) {
      yield r'tokenType';
      yield serializers.serialize(
        object.tokenType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(AuthenticatedUser),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortalSessionResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortalSessionResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accessToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accessToken = valueDes;
          break;
        case r'expiresIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiresIn = valueDes;
          break;
        case r'tokenType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tokenType = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthenticatedUser),
          ) as AuthenticatedUser;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortalSessionResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortalSessionResultBuilder();
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

