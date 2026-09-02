//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reject_recommendation_request.g.dart';

/// Cuerpo de la petición para rechazar una recomendación.
///
/// Properties:
/// * [reason] - Motivo del rechazo (entre 10 y 2000 caracteres).
@BuiltValue()
abstract class RejectRecommendationRequest implements Built<RejectRecommendationRequest, RejectRecommendationRequestBuilder> {
  /// Motivo del rechazo (entre 10 y 2000 caracteres).
  @BuiltValueField(wireName: r'reason')
  String? get reason;

  RejectRecommendationRequest._();

  factory RejectRecommendationRequest([void updates(RejectRecommendationRequestBuilder b)]) = _$RejectRecommendationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RejectRecommendationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RejectRecommendationRequest> get serializer => _$RejectRecommendationRequestSerializer();
}

class _$RejectRecommendationRequestSerializer implements PrimitiveSerializer<RejectRecommendationRequest> {
  @override
  final Iterable<Type> types = const [RejectRecommendationRequest, _$RejectRecommendationRequest];

  @override
  final String wireName = r'RejectRecommendationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RejectRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RejectRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RejectRecommendationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RejectRecommendationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RejectRecommendationRequestBuilder();
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

