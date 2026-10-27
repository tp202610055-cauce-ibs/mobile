//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/glossary_term_request_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'glossary_term_request_result.g.dart';

/// GlossaryTermRequestResult
///
/// Properties:
/// * [id] 
/// * [term] 
/// * [status] 
/// * [requestedAt] 
@BuiltValue()
abstract class GlossaryTermRequestResult implements Built<GlossaryTermRequestResult, GlossaryTermRequestResultBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'term')
  String? get term;

  @BuiltValueField(wireName: r'status')
  GlossaryTermRequestStatus? get status;
  // enum statusEnum {  Pending,  };

  @BuiltValueField(wireName: r'requestedAt')
  DateTime? get requestedAt;

  GlossaryTermRequestResult._();

  factory GlossaryTermRequestResult([void updates(GlossaryTermRequestResultBuilder b)]) = _$GlossaryTermRequestResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GlossaryTermRequestResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GlossaryTermRequestResult> get serializer => _$GlossaryTermRequestResultSerializer();
}

class _$GlossaryTermRequestResultSerializer implements PrimitiveSerializer<GlossaryTermRequestResult> {
  @override
  final Iterable<Type> types = const [GlossaryTermRequestResult, _$GlossaryTermRequestResult];

  @override
  final String wireName = r'GlossaryTermRequestResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GlossaryTermRequestResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.term != null) {
      yield r'term';
      yield serializers.serialize(
        object.term,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(GlossaryTermRequestStatus),
      );
    }
    if (object.requestedAt != null) {
      yield r'requestedAt';
      yield serializers.serialize(
        object.requestedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GlossaryTermRequestResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GlossaryTermRequestResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'term':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.term = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GlossaryTermRequestStatus),
          ) as GlossaryTermRequestStatus;
          result.status = valueDes;
          break;
        case r'requestedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.requestedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GlossaryTermRequestResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GlossaryTermRequestResultBuilder();
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

