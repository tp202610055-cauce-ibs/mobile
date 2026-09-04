//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'approve_recommendation_request.g.dart';

/// Cuerpo de la petición para aprobar una recomendación.
///
/// Properties:
/// * [note] - Nota clínica de aprobación (entre 10 y 2000 caracteres).
@BuiltValue()
abstract class ApproveRecommendationRequest implements Built<ApproveRecommendationRequest, ApproveRecommendationRequestBuilder> {
  /// Nota clínica de aprobación (entre 10 y 2000 caracteres).
  @BuiltValueField(wireName: r'note')
  String? get note;

  ApproveRecommendationRequest._();

  factory ApproveRecommendationRequest([void updates(ApproveRecommendationRequestBuilder b)]) = _$ApproveRecommendationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApproveRecommendationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApproveRecommendationRequest> get serializer => _$ApproveRecommendationRequestSerializer();
}

class _$ApproveRecommendationRequestSerializer implements PrimitiveSerializer<ApproveRecommendationRequest> {
  @override
  final Iterable<Type> types = const [ApproveRecommendationRequest, _$ApproveRecommendationRequest];

  @override
  final String wireName = r'ApproveRecommendationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApproveRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApproveRecommendationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApproveRecommendationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApproveRecommendationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApproveRecommendationRequestBuilder();
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

