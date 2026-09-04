//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_patient_request.g.dart';

/// Cuerpo de la petición de registro de paciente. La dirección IP no se recibe del  cliente: el backend la deriva del contexto de la conexión.
///
/// Properties:
/// * [email] - Correo electrónico del paciente.
/// * [fullName] - Nombre completo del paciente.
/// * [password] - Contraseña elegida por el paciente.
/// * [consentDocumentVersion] - Versión del documento de consentimiento aceptado.
/// * [consentTextHash] - Hash SHA-256 (hex) del texto de consentimiento aceptado.
/// * [invitationCode] - Código de invitación opcional.
@BuiltValue()
abstract class RegisterPatientRequest implements Built<RegisterPatientRequest, RegisterPatientRequestBuilder> {
  /// Correo electrónico del paciente.
  @BuiltValueField(wireName: r'email')
  String? get email;

  /// Nombre completo del paciente.
  @BuiltValueField(wireName: r'fullName')
  String? get fullName;

  /// Contraseña elegida por el paciente.
  @BuiltValueField(wireName: r'password')
  String? get password;

  /// Versión del documento de consentimiento aceptado.
  @BuiltValueField(wireName: r'consentDocumentVersion')
  String? get consentDocumentVersion;

  /// Hash SHA-256 (hex) del texto de consentimiento aceptado.
  @BuiltValueField(wireName: r'consentTextHash')
  String? get consentTextHash;

  /// Código de invitación opcional.
  @BuiltValueField(wireName: r'invitationCode')
  String? get invitationCode;

  RegisterPatientRequest._();

  factory RegisterPatientRequest([void updates(RegisterPatientRequestBuilder b)]) = _$RegisterPatientRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterPatientRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterPatientRequest> get serializer => _$RegisterPatientRequestSerializer();
}

class _$RegisterPatientRequestSerializer implements PrimitiveSerializer<RegisterPatientRequest> {
  @override
  final Iterable<Type> types = const [RegisterPatientRequest, _$RegisterPatientRequest];

  @override
  final String wireName = r'RegisterPatientRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterPatientRequest object, {
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
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.consentDocumentVersion != null) {
      yield r'consentDocumentVersion';
      yield serializers.serialize(
        object.consentDocumentVersion,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.consentTextHash != null) {
      yield r'consentTextHash';
      yield serializers.serialize(
        object.consentTextHash,
        specifiedType: const FullType.nullable(String),
      );
    }
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
    RegisterPatientRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterPatientRequestBuilder result,
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
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.password = valueDes;
          break;
        case r'consentDocumentVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.consentDocumentVersion = valueDes;
          break;
        case r'consentTextHash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.consentTextHash = valueDes;
          break;
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
  RegisterPatientRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterPatientRequestBuilder();
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

