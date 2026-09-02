//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_fcm_token_request.g.dart';

/// Cuerpo de la petición de registro del token de notificaciones push del dispositivo.
///
/// Properties:
/// * [fcmToken] - Token de FCM del dispositivo, o null para desvincularlo.
@BuiltValue()
abstract class UpdateFcmTokenRequest implements Built<UpdateFcmTokenRequest, UpdateFcmTokenRequestBuilder> {
  /// Token de FCM del dispositivo, o null para desvincularlo.
  @BuiltValueField(wireName: r'fcmToken')
  String? get fcmToken;

  UpdateFcmTokenRequest._();

  factory UpdateFcmTokenRequest([void updates(UpdateFcmTokenRequestBuilder b)]) = _$UpdateFcmTokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateFcmTokenRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateFcmTokenRequest> get serializer => _$UpdateFcmTokenRequestSerializer();
}

class _$UpdateFcmTokenRequestSerializer implements PrimitiveSerializer<UpdateFcmTokenRequest> {
  @override
  final Iterable<Type> types = const [UpdateFcmTokenRequest, _$UpdateFcmTokenRequest];

  @override
  final String wireName = r'UpdateFcmTokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateFcmTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.fcmToken != null) {
      yield r'fcmToken';
      yield serializers.serialize(
        object.fcmToken,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateFcmTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateFcmTokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fcmToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fcmToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateFcmTokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateFcmTokenRequestBuilder();
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

