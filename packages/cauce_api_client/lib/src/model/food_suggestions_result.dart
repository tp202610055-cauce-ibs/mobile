//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/food_item_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'food_suggestions_result.g.dart';

/// FoodSuggestionsResult
///
/// Properties:
/// * [frequentLast30Days] 
/// * [recentLast24Hours] 
/// * [catalogSuggestions] 
@BuiltValue()
abstract class FoodSuggestionsResult implements Built<FoodSuggestionsResult, FoodSuggestionsResultBuilder> {
  @BuiltValueField(wireName: r'frequentLast30Days')
  BuiltList<FoodItemSummary>? get frequentLast30Days;

  @BuiltValueField(wireName: r'recentLast24Hours')
  BuiltList<FoodItemSummary>? get recentLast24Hours;

  @BuiltValueField(wireName: r'catalogSuggestions')
  BuiltList<FoodItemSummary>? get catalogSuggestions;

  FoodSuggestionsResult._();

  factory FoodSuggestionsResult([void updates(FoodSuggestionsResultBuilder b)]) = _$FoodSuggestionsResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FoodSuggestionsResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FoodSuggestionsResult> get serializer => _$FoodSuggestionsResultSerializer();
}

class _$FoodSuggestionsResultSerializer implements PrimitiveSerializer<FoodSuggestionsResult> {
  @override
  final Iterable<Type> types = const [FoodSuggestionsResult, _$FoodSuggestionsResult];

  @override
  final String wireName = r'FoodSuggestionsResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FoodSuggestionsResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.frequentLast30Days != null) {
      yield r'frequentLast30Days';
      yield serializers.serialize(
        object.frequentLast30Days,
        specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
      );
    }
    if (object.recentLast24Hours != null) {
      yield r'recentLast24Hours';
      yield serializers.serialize(
        object.recentLast24Hours,
        specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
      );
    }
    if (object.catalogSuggestions != null) {
      yield r'catalogSuggestions';
      yield serializers.serialize(
        object.catalogSuggestions,
        specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FoodSuggestionsResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FoodSuggestionsResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'frequentLast30Days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
          ) as BuiltList<FoodItemSummary>?;
          if (valueDes == null) continue;
          result.frequentLast30Days.replace(valueDes);
          break;
        case r'recentLast24Hours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
          ) as BuiltList<FoodItemSummary>?;
          if (valueDes == null) continue;
          result.recentLast24Hours.replace(valueDes);
          break;
        case r'catalogSuggestions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(FoodItemSummary)]),
          ) as BuiltList<FoodItemSummary>?;
          if (valueDes == null) continue;
          result.catalogSuggestions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FoodSuggestionsResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FoodSuggestionsResultBuilder();
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

