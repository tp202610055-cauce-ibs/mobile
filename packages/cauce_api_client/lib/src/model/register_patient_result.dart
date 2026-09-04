//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/user_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_patient_result.g.dart';

/// RegisterPatientResult
///
/// Properties:
/// * [userId] 
/// * [email] 
/// * [status] 
/// * [emailVerificationRequired] 
@BuiltValue()
abstract class RegisterPatientResult implements Built<RegisterPatientResult, RegisterPatientResultBuilder> {
  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'status')
  UserStatus? get status;
  // enum statusEnum {  PendingActivation,  Active,  Inactive,  Suspended,  };

  @BuiltValueField(wireName: r'emailVerificationRequired')
  bool? get emailVerificationRequired;

  RegisterPatientResult._();

  factory RegisterPatientResult([void updates(RegisterPatientResultBuilder b)]) = _$RegisterPatientResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterPatientResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterPatientResult> get serializer => _$RegisterPatientResultSerializer();
}

class _$RegisterPatientResultSerializer implements PrimitiveSerializer<RegisterPatientResult> {
  @override
  final Iterable<Type> types = const [RegisterPatientResult, _$RegisterPatientResult];

  @override
  final String wireName = r'RegisterPatientResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterPatientResult object, {
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
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(UserStatus),
      );
    }
    if (object.emailVerificationRequired != null) {
      yield r'emailVerificationRequired';
      yield serializers.serialize(
        object.emailVerificationRequired,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RegisterPatientResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterPatientResultBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserStatus),
          ) as UserStatus;
          result.status = valueDes;
          break;
        case r'emailVerificationRequired':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.emailVerificationRequired = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RegisterPatientResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterPatientResultBuilder();
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

