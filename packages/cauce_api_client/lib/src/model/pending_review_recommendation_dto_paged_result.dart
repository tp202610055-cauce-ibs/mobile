//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/pending_review_recommendation_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pending_review_recommendation_dto_paged_result.g.dart';

/// PendingReviewRecommendationDtoPagedResult
///
/// Properties:
/// * [items] 
/// * [page] 
/// * [pageSize] 
/// * [totalCount] 
@BuiltValue()
abstract class PendingReviewRecommendationDtoPagedResult implements Built<PendingReviewRecommendationDtoPagedResult, PendingReviewRecommendationDtoPagedResultBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<PendingReviewRecommendationDto>? get items;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalCount')
  int? get totalCount;

  PendingReviewRecommendationDtoPagedResult._();

  factory PendingReviewRecommendationDtoPagedResult([void updates(PendingReviewRecommendationDtoPagedResultBuilder b)]) = _$PendingReviewRecommendationDtoPagedResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PendingReviewRecommendationDtoPagedResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PendingReviewRecommendationDtoPagedResult> get serializer => _$PendingReviewRecommendationDtoPagedResultSerializer();
}

class _$PendingReviewRecommendationDtoPagedResultSerializer implements PrimitiveSerializer<PendingReviewRecommendationDtoPagedResult> {
  @override
  final Iterable<Type> types = const [PendingReviewRecommendationDtoPagedResult, _$PendingReviewRecommendationDtoPagedResult];

  @override
  final String wireName = r'PendingReviewRecommendationDtoPagedResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PendingReviewRecommendationDtoPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(PendingReviewRecommendationDto)]),
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
    PendingReviewRecommendationDtoPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PendingReviewRecommendationDtoPagedResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(PendingReviewRecommendationDto)]),
          ) as BuiltList<PendingReviewRecommendationDto>?;
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
  PendingReviewRecommendationDtoPagedResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PendingReviewRecommendationDtoPagedResultBuilder();
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

