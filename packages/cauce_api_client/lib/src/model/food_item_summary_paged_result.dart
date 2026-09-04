//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/food_item_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'food_item_summary_paged_result.g.dart';

/// FoodItemSummaryPagedResult
///
/// Properties:
/// * [items] 
/// * [page] 
/// * [pageSize] 
/// * [totalCount] 
@BuiltValue()
abstract class FoodItemSummaryPagedResult implements Built<FoodItemSummaryPagedResult, FoodItemSummaryPagedResultBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<FoodItemSummary>? get items;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalCount')
  int? get totalCount;

  FoodItemSummaryPagedResult._();

  factory FoodItemSummaryPagedResult([void updates(FoodItemSummaryPagedResultBuilder b)]) = _$FoodItemSummaryPagedResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FoodItemSummaryPagedResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FoodItemSummaryPagedResult> get serializer => _$FoodItemSummaryPagedResultSerializer();
}

class _$FoodItemSummaryPagedResultSerializer implements PrimitiveSerializer<FoodItemSummaryPagedResult> {
  @override
  final Iterable<Type> types = const [FoodItemSummaryPagedResult, _$FoodItemSummaryPagedResult];

  @override
  final String wireName = r'FoodItemSummaryPagedResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FoodItemSummaryPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
      );
    }
    if (object.page != null) {
      yield r'page';
      yield serializers.serialize(
        object.page,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageSize != null) {
      yield r'pageSize';
      yield serializers.serialize(
        object.pageSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalCount != null) {
      yield r'totalCount';
      yield serializers.serialize(
        object.totalCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FoodItemSummaryPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FoodItemSummaryPagedResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
          ) as BuiltList<FoodItemSummary>?;
          if (valueDes == null) continue;
          result.items.replace(valueDes);
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.page = valueDes;
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        case r'totalCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FoodItemSummaryPagedResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FoodItemSummaryPagedResultBuilder();
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

