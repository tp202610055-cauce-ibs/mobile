//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/symptom_batch_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/meal_batch_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_batch_request.g.dart';

/// Cuerpo de la petición de sincronización por lotes de comidas y síntomas.
///
/// Properties:
/// * [meals] - Comidas del lote.
/// * [symptoms] - Síntomas del lote.
@BuiltValue()
abstract class SyncBatchRequest implements Built<SyncBatchRequest, SyncBatchRequestBuilder> {
  /// Comidas del lote.
  @BuiltValueField(wireName: r'meals')
  BuiltList<MealBatchItem>? get meals;

  /// Síntomas del lote.
  @BuiltValueField(wireName: r'symptoms')
  BuiltList<SymptomBatchItem>? get symptoms;

  SyncBatchRequest._();

  factory SyncBatchRequest([void updates(SyncBatchRequestBuilder b)]) = _$SyncBatchRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncBatchRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncBatchRequest> get serializer => _$SyncBatchRequestSerializer();
}

class _$SyncBatchRequestSerializer implements PrimitiveSerializer<SyncBatchRequest> {
  @override
  final Iterable<Type> types = const [SyncBatchRequest, _$SyncBatchRequest];

  @override
  final String wireName = r'SyncBatchRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncBatchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.meals != null) {
      yield r'meals';
      yield serializers.serialize(
        object.meals,
        specifiedType: const FullType.nullable(BuiltList, [FullType(MealBatchItem)]),
      );
    }
    if (object.symptoms != null) {
      yield r'symptoms';
      yield serializers.serialize(
        object.symptoms,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SymptomBatchItem)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncBatchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncBatchRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'meals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(MealBatchItem)]),
          ) as BuiltList<MealBatchItem>?;
          if (valueDes == null) continue;
          result.meals.replace(valueDes);
          break;
        case r'symptoms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SymptomBatchItem)]),
          ) as BuiltList<SymptomBatchItem>?;
          if (valueDes == null) continue;
          result.symptoms.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncBatchRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncBatchRequestBuilder();
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

