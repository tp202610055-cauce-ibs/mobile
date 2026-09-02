//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/meal_item_request.dart';
import 'package:cauce_api_client/src/model/meal_time.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_meal_request.g.dart';

/// Cuerpo de la petición de registro de una comida. El Cauce.Api.Contracts.ClinicalRegistry.CreateMealRequest.ClientGuid puede  omitirse en el cuerpo y enviarse en el encabezado `Idempotency-Key`.
///
/// Properties:
/// * [clientGuid] - Identificador del dispositivo (UUID v4), opcional si viaja en el encabezado.
/// * [mealTime] 
/// * [consumedAt] - Momento de consumo.
/// * [clientCreatedAt] - Momento de creación en el dispositivo.
/// * [items] - Ítems de la comida.
@BuiltValue()
abstract class CreateMealRequest implements Built<CreateMealRequest, CreateMealRequestBuilder> {
  /// Identificador del dispositivo (UUID v4), opcional si viaja en el encabezado.
  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'mealTime')
  MealTime? get mealTime;
  // enum mealTimeEnum {  Breakfast,  Lunch,  Dinner,  Snack,  };

  /// Momento de consumo.
  @BuiltValueField(wireName: r'consumedAt')
  DateTime? get consumedAt;

  /// Momento de creación en el dispositivo.
  @BuiltValueField(wireName: r'clientCreatedAt')
  DateTime? get clientCreatedAt;

  /// Ítems de la comida.
  @BuiltValueField(wireName: r'items')
  BuiltList<MealItemRequest>? get items;

  CreateMealRequest._();

  factory CreateMealRequest([void updates(CreateMealRequestBuilder b)]) = _$CreateMealRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateMealRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateMealRequest> get serializer => _$CreateMealRequestSerializer();
}

class _$CreateMealRequestSerializer implements PrimitiveSerializer<CreateMealRequest> {
  @override
  final Iterable<Type> types = const [CreateMealRequest, _$CreateMealRequest];

  @override
  final String wireName = r'CreateMealRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateMealRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clientGuid != null) {
      yield r'clientGuid';
      yield serializers.serialize(
        object.clientGuid,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.mealTime != null) {
      yield r'mealTime';
      yield serializers.serialize(
        object.mealTime,
        specifiedType: const FullType(MealTime),
      );
    }
    if (object.consumedAt != null) {
      yield r'consumedAt';
      yield serializers.serialize(
        object.consumedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.clientCreatedAt != null) {
      yield r'clientCreatedAt';
      yield serializers.serialize(
        object.clientCreatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(MealItemRequest)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateMealRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateMealRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clientGuid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientGuid = valueDes;
          break;
        case r'mealTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MealTime),
          ) as MealTime;
          result.mealTime = valueDes;
          break;
        case r'consumedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.consumedAt = valueDes;
          break;
        case r'clientCreatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.clientCreatedAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(MealItemRequest)]),
          ) as BuiltList<MealItemRequest>?;
          if (valueDes == null) continue;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateMealRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateMealRequestBuilder();
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

