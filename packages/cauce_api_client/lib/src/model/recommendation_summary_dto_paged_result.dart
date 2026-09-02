//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/recommendation_summary_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_summary_dto_paged_result.g.dart';

/// RecommendationSummaryDtoPagedResult
///
/// Properties:
/// * [items] 
/// * [page] 
/// * [pageSize] 
/// * [totalCount] 
@BuiltValue()
abstract class RecommendationSummaryDtoPagedResult implements Built<RecommendationSummaryDtoPagedResult, RecommendationSummaryDtoPagedResultBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<RecommendationSummaryDto>? get items;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalCount')
  int? get totalCount;

  RecommendationSummaryDtoPagedResult._();

  factory RecommendationSummaryDtoPagedResult([void updates(RecommendationSummaryDtoPagedResultBuilder b)]) = _$RecommendationSummaryDtoPagedResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecommendationSummaryDtoPagedResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecommendationSummaryDtoPagedResult> get serializer => _$RecommendationSummaryDtoPagedResultSerializer();
}

class _$RecommendationSummaryDtoPagedResultSerializer implements PrimitiveSerializer<RecommendationSummaryDtoPagedResult> {
  @override
  final Iterable<Type> types = const [RecommendationSummaryDtoPagedResult, _$RecommendationSummaryDtoPagedResult];

  @override
  final String wireName = r'RecommendationSummaryDtoPagedResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecommendationSummaryDtoPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(RecommendationSummaryDto)]),
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
    RecommendationSummaryDtoPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecommendationSummaryDtoPagedResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(RecommendationSummaryDto)]),
          ) as BuiltList<RecommendationSummaryDto>?;
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
  RecommendationSummaryDtoPagedResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecommendationSummaryDtoPagedResultBuilder();
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

