//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/archive_reason.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'archive_recommendation_request.g.dart';

/// Cuerpo de la petición de archivado de una recomendación (US30 CA01).
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class ArchiveRecommendationRequest implements Built<ArchiveRecommendationRequest, ArchiveRecommendationRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  ArchiveReason? get reason;
  // enum reasonEnum {  TemporalExpiration,  ManualSubstitution,  ObjectiveMet,  PlanChange,  };

  ArchiveRecommendationRequest._();

  factory ArchiveRecommendationRequest([void updates(ArchiveRecommendationRequestBuilder b)]) = _$ArchiveRecommendationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ArchiveRecommendationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ArchiveRecommendationRequest> get serializer => _$ArchiveRecommendationRequestSerializer();
}

class _$ArchiveRecommendationRequestSerializer implements PrimitiveSerializer<ArchiveRecommendationRequest> {
  @override
  final Iterable<Type> types = const [ArchiveRecommendationRequest, _$ArchiveRecommendationRequest];

  @override
  final String wireName = r'ArchiveRecommendationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ArchiveRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(ArchiveReason),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ArchiveRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ArchiveRecommendationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArchiveReason),
          ) as ArchiveReason;
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
  ArchiveRecommendationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ArchiveRecommendationRequestBuilder();
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

