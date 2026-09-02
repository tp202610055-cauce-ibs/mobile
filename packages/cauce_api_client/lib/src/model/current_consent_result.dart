//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'current_consent_result.g.dart';

/// CurrentConsentResult
///
/// Properties:
/// * [version] 
/// * [text] 
/// * [hash] 
@BuiltValue()
abstract class CurrentConsentResult implements Built<CurrentConsentResult, CurrentConsentResultBuilder> {
  @BuiltValueField(wireName: r'version')
  String? get version;

  @BuiltValueField(wireName: r'text')
  String? get text;

  @BuiltValueField(wireName: r'hash')
  String? get hash;

  CurrentConsentResult._();

  factory CurrentConsentResult([void updates(CurrentConsentResultBuilder b)]) = _$CurrentConsentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CurrentConsentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CurrentConsentResult> get serializer => _$CurrentConsentResultSerializer();
}

class _$CurrentConsentResultSerializer implements PrimitiveSerializer<CurrentConsentResult> {
  @override
  final Iterable<Type> types = const [CurrentConsentResult, _$CurrentConsentResult];

  @override
  final String wireName = r'CurrentConsentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CurrentConsentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.text != null) {
      yield r'text';
      yield serializers.serialize(
        object.text,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.hash != null) {
      yield r'hash';
      yield serializers.serialize(
        object.hash,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CurrentConsentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CurrentConsentResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.version = valueDes;
          break;
        case r'text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.text = valueDes;
          break;
        case r'hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.hash = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CurrentConsentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CurrentConsentResultBuilder();
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

