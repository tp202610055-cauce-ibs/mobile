//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_consent_result.g.dart';

/// MyConsentResult
///
/// Properties:
/// * [documentVersion] 
/// * [acceptedAt] 
/// * [consentTextHash] 
/// * [textAvailable] 
@BuiltValue()
abstract class MyConsentResult implements Built<MyConsentResult, MyConsentResultBuilder> {
  @BuiltValueField(wireName: r'documentVersion')
  String? get documentVersion;

  @BuiltValueField(wireName: r'acceptedAt')
  DateTime? get acceptedAt;

  @BuiltValueField(wireName: r'consentTextHash')
  String? get consentTextHash;

  @BuiltValueField(wireName: r'textAvailable')
  bool? get textAvailable;

  MyConsentResult._();

  factory MyConsentResult([void updates(MyConsentResultBuilder b)]) = _$MyConsentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyConsentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MyConsentResult> get serializer => _$MyConsentResultSerializer();
}

class _$MyConsentResultSerializer implements PrimitiveSerializer<MyConsentResult> {
  @override
  final Iterable<Type> types = const [MyConsentResult, _$MyConsentResult];

  @override
  final String wireName = r'MyConsentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyConsentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.documentVersion != null) {
      yield r'documentVersion';
      yield serializers.serialize(
        object.documentVersion,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.acceptedAt != null) {
      yield r'acceptedAt';
      yield serializers.serialize(
        object.acceptedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.consentTextHash != null) {
      yield r'consentTextHash';
      yield serializers.serialize(
        object.consentTextHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.textAvailable != null) {
      yield r'textAvailable';
      yield serializers.serialize(
        object.textAvailable,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MyConsentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyConsentResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'documentVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.documentVersion = valueDes;
          break;
        case r'acceptedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.acceptedAt = valueDes;
          break;
        case r'consentTextHash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.consentTextHash = valueDes;
          break;
        case r'textAvailable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.textAvailable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MyConsentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyConsentResultBuilder();
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

