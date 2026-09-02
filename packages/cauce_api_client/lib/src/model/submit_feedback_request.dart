//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/feedback_outcome.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_feedback_request.g.dart';

/// Cuerpo de la petición para enviar retroalimentación sobre una recomendación.
///
/// Properties:
/// * [wasApplied] - Indica si el paciente aplicó la recomendación.
/// * [outcome] 
/// * [comment] - Comentario opcional (máximo 500 caracteres).
@BuiltValue()
abstract class SubmitFeedbackRequest implements Built<SubmitFeedbackRequest, SubmitFeedbackRequestBuilder> {
  /// Indica si el paciente aplicó la recomendación.
  @BuiltValueField(wireName: r'wasApplied')
  bool? get wasApplied;

  @BuiltValueField(wireName: r'outcome')
  FeedbackOutcome? get outcome;
  // enum outcomeEnum {  Improvement,  NoChange,  Worsening,  };

  /// Comentario opcional (máximo 500 caracteres).
  @BuiltValueField(wireName: r'comment')
  String? get comment;

  SubmitFeedbackRequest._();

  factory SubmitFeedbackRequest([void updates(SubmitFeedbackRequestBuilder b)]) = _$SubmitFeedbackRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitFeedbackRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitFeedbackRequest> get serializer => _$SubmitFeedbackRequestSerializer();
}

class _$SubmitFeedbackRequestSerializer implements PrimitiveSerializer<SubmitFeedbackRequest> {
  @override
  final Iterable<Type> types = const [SubmitFeedbackRequest, _$SubmitFeedbackRequest];

  @override
  final String wireName = r'SubmitFeedbackRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitFeedbackRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.wasApplied != null) {
      yield r'wasApplied';
      yield serializers.serialize(
        object.wasApplied,
        specifiedType: const FullType(bool),
      );
    }
    if (object.outcome != null) {
      yield r'outcome';
      yield serializers.serialize(
        object.outcome,
        specifiedType: const FullType(FeedbackOutcome),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmitFeedbackRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmitFeedbackRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'wasApplied':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.wasApplied = valueDes;
          break;
        case r'outcome':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeedbackOutcome),
          ) as FeedbackOutcome;
          result.outcome = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmitFeedbackRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitFeedbackRequestBuilder();
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

