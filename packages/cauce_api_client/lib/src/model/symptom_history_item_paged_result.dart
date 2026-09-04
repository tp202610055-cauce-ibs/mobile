//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/symptom_history_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'symptom_history_item_paged_result.g.dart';

/// SymptomHistoryItemPagedResult
///
/// Properties:
/// * [items] 
/// * [page] 
/// * [pageSize] 
/// * [totalCount] 
@BuiltValue()
abstract class SymptomHistoryItemPagedResult implements Built<SymptomHistoryItemPagedResult, SymptomHistoryItemPagedResultBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<SymptomHistoryItem>? get items;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalCount')
  int? get totalCount;

  SymptomHistoryItemPagedResult._();

  factory SymptomHistoryItemPagedResult([void updates(SymptomHistoryItemPagedResultBuilder b)]) = _$SymptomHistoryItemPagedResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SymptomHistoryItemPagedResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SymptomHistoryItemPagedResult> get serializer => _$SymptomHistoryItemPagedResultSerializer();
}

class _$SymptomHistoryItemPagedResultSerializer implements PrimitiveSerializer<SymptomHistoryItemPagedResult> {
  @override
  final Iterable<Type> types = const [SymptomHistoryItemPagedResult, _$SymptomHistoryItemPagedResult];

  @override
  final String wireName = r'SymptomHistoryItemPagedResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SymptomHistoryItemPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SymptomHistoryItem)]),
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
    SymptomHistoryItemPagedResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SymptomHistoryItemPagedResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SymptomHistoryItem)]),
          ) as BuiltList<SymptomHistoryItem>?;
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
  SymptomHistoryItemPagedResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SymptomHistoryItemPagedResultBuilder();
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

