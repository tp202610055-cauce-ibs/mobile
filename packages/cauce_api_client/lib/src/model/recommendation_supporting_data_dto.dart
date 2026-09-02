//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_supporting_data_dto.g.dart';

/// RecommendationSupportingDataDto
///
/// Properties:
/// * [symptomCountsLast14d] 
/// * [mealCountsLast14d] 
/// * [topFodmapHighFoodsLast14d] 
/// * [correlationWindowHours] 
/// * [analysisWindowFrom] 
/// * [analysisWindowTo] 
@BuiltValue()
abstract class RecommendationSupportingDataDto implements Built<RecommendationSupportingDataDto, RecommendationSupportingDataDtoBuilder> {
  @BuiltValueField(wireName: r'symptomCountsLast14d')
  int? get symptomCountsLast14d;

  @BuiltValueField(wireName: r'mealCountsLast14d')
  int? get mealCountsLast14d;

  @BuiltValueField(wireName: r'topFodmapHighFoodsLast14d')
  BuiltList<String>? get topFodmapHighFoodsLast14d;

  @BuiltValueField(wireName: r'correlationWindowHours')
  int? get correlationWindowHours;

  @BuiltValueField(wireName: r'analysisWindowFrom')
  DateTime? get analysisWindowFrom;

  @BuiltValueField(wireName: r'analysisWindowTo')
  DateTime? get analysisWindowTo;

  RecommendationSupportingDataDto._();

  factory RecommendationSupportingDataDto([void updates(RecommendationSupportingDataDtoBuilder b)]) = _$RecommendationSupportingDataDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RecommendationSupportingDataDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecommendationSupportingDataDto> get serializer => _$RecommendationSupportingDataDtoSerializer();
}

class _$RecommendationSupportingDataDtoSerializer implements PrimitiveSerializer<RecommendationSupportingDataDto> {
  @override
  final Iterable<Type> types = const [RecommendationSupportingDataDto, _$RecommendationSupportingDataDto];

  @override
  final String wireName = r'RecommendationSupportingDataDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecommendationSupportingDataDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.symptomCountsLast14d != null) {
      yield r'symptomCountsLast14d';
      yield serializers.serialize(
        object.symptomCountsLast14d,
        specifiedType: const FullType(int),
      );
    }
    if (object.mealCountsLast14d != null) {
      yield r'mealCountsLast14d';
      yield serializers.serialize(
        object.mealCountsLast14d,
        specifiedType: const FullType(int),
      );
    }
    if (object.topFodmapHighFoodsLast14d != null) {
      yield r'topFodmapHighFoodsLast14d';
      yield serializers.serialize(
        object.topFodmapHighFoodsLast14d,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.correlationWindowHours != null) {
      yield r'correlationWindowHours';
      yield serializers.serialize(
        object.correlationWindowHours,
        specifiedType: const FullType(int),
      );
    }
    if (object.analysisWindowFrom != null) {
      yield r'analysisWindowFrom';
      yield serializers.serialize(
        object.analysisWindowFrom,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.analysisWindowTo != null) {
      yield r'analysisWindowTo';
      yield serializers.serialize(
        object.analysisWindowTo,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RecommendationSupportingDataDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecommendationSupportingDataDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symptomCountsLast14d':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.symptomCountsLast14d = valueDes;
          break;
        case r'mealCountsLast14d':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.mealCountsLast14d = valueDes;
          break;
        case r'topFodmapHighFoodsLast14d':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.topFodmapHighFoodsLast14d.replace(valueDes);
          break;
        case r'correlationWindowHours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.correlationWindowHours = valueDes;
          break;
        case r'analysisWindowFrom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.analysisWindowFrom = valueDes;
          break;
        case r'analysisWindowTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.analysisWindowTo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RecommendationSupportingDataDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RecommendationSupportingDataDtoBuilder();
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

