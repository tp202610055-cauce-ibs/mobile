//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/glossary_term_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'glossary_result.g.dart';

/// GlossaryResult
///
/// Properties:
/// * [terms] 
/// * [contentStatus] 
@BuiltValue()
abstract class GlossaryResult implements Built<GlossaryResult, GlossaryResultBuilder> {
  @BuiltValueField(wireName: r'terms')
  BuiltList<GlossaryTermDto>? get terms;

  @BuiltValueField(wireName: r'contentStatus')
  String? get contentStatus;

  GlossaryResult._();

  factory GlossaryResult([void updates(GlossaryResultBuilder b)]) = _$GlossaryResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GlossaryResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GlossaryResult> get serializer => _$GlossaryResultSerializer();
}

class _$GlossaryResultSerializer implements PrimitiveSerializer<GlossaryResult> {
  @override
  final Iterable<Type> types = const [GlossaryResult, _$GlossaryResult];

  @override
  final String wireName = r'GlossaryResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GlossaryResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.terms != null) {
      yield r'terms';
      yield serializers.serialize(
        object.terms,
        specifiedType: const FullType.nullable(BuiltList, [FullType(GlossaryTermDto)]),
      );
    }
    if (object.contentStatus != null) {
      yield r'contentStatus';
      yield serializers.serialize(
        object.contentStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GlossaryResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GlossaryResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'terms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(GlossaryTermDto)]),
          ) as BuiltList<GlossaryTermDto>?;
          if (valueDes == null) continue;
          result.terms.replace(valueDes);
          break;
        case r'contentStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contentStatus = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GlossaryResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GlossaryResultBuilder();
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

