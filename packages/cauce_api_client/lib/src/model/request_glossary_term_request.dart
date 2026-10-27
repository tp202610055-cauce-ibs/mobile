//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_glossary_term_request.g.dart';

/// Solicitud para agregar un término al glosario.
///
/// Properties:
/// * [term] - Término pedido; se recortan los espacios de los extremos y admite hasta 100 caracteres.
@BuiltValue()
abstract class RequestGlossaryTermRequest implements Built<RequestGlossaryTermRequest, RequestGlossaryTermRequestBuilder> {
  /// Término pedido; se recortan los espacios de los extremos y admite hasta 100 caracteres.
  @BuiltValueField(wireName: r'term')
  String? get term;

  RequestGlossaryTermRequest._();

  factory RequestGlossaryTermRequest([void updates(RequestGlossaryTermRequestBuilder b)]) = _$RequestGlossaryTermRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestGlossaryTermRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestGlossaryTermRequest> get serializer => _$RequestGlossaryTermRequestSerializer();
}

class _$RequestGlossaryTermRequestSerializer implements PrimitiveSerializer<RequestGlossaryTermRequest> {
  @override
  final Iterable<Type> types = const [RequestGlossaryTermRequest, _$RequestGlossaryTermRequest];

  @override
  final String wireName = r'RequestGlossaryTermRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestGlossaryTermRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.term != null) {
      yield r'term';
      yield serializers.serialize(
        object.term,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestGlossaryTermRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestGlossaryTermRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'term':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.term = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestGlossaryTermRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestGlossaryTermRequestBuilder();
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

