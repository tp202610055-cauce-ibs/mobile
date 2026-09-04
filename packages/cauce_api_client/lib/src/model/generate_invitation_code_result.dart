//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_invitation_code_result.g.dart';

/// GenerateInvitationCodeResult
///
/// Properties:
/// * [code] 
/// * [expiresAt] 
@BuiltValue()
abstract class GenerateInvitationCodeResult implements Built<GenerateInvitationCodeResult, GenerateInvitationCodeResultBuilder> {
  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  GenerateInvitationCodeResult._();

  factory GenerateInvitationCodeResult([void updates(GenerateInvitationCodeResultBuilder b)]) = _$GenerateInvitationCodeResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateInvitationCodeResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateInvitationCodeResult> get serializer => _$GenerateInvitationCodeResultSerializer();
}

class _$GenerateInvitationCodeResultSerializer implements PrimitiveSerializer<GenerateInvitationCodeResult> {
  @override
  final Iterable<Type> types = const [GenerateInvitationCodeResult, _$GenerateInvitationCodeResult];

  @override
  final String wireName = r'GenerateInvitationCodeResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateInvitationCodeResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateInvitationCodeResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenerateInvitationCodeResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenerateInvitationCodeResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateInvitationCodeResultBuilder();
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

