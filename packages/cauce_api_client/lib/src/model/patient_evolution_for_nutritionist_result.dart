//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/ibs_sss_evolution_entry.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'patient_evolution_for_nutritionist_result.g.dart';

/// PatientEvolutionForNutritionistResult
///
/// Properties:
/// * [ibsSssTimeline] 
/// * [baselineScore] 
/// * [latestScore] 
/// * [percentChangeFromBaseline] 
/// * [significantClinicalResponse] 
/// * [registrationFrequency14d] 
@BuiltValue()
abstract class PatientEvolutionForNutritionistResult implements Built<PatientEvolutionForNutritionistResult, PatientEvolutionForNutritionistResultBuilder> {
  @BuiltValueField(wireName: r'ibsSssTimeline')
  BuiltList<IbsSssEvolutionEntry>? get ibsSssTimeline;

  @BuiltValueField(wireName: r'baselineScore')
  int? get baselineScore;

  @BuiltValueField(wireName: r'latestScore')
  int? get latestScore;

  @BuiltValueField(wireName: r'percentChangeFromBaseline')
  double? get percentChangeFromBaseline;

  @BuiltValueField(wireName: r'significantClinicalResponse')
  bool? get significantClinicalResponse;

  @BuiltValueField(wireName: r'registrationFrequency14d')
  int? get registrationFrequency14d;

  PatientEvolutionForNutritionistResult._();

  factory PatientEvolutionForNutritionistResult([void updates(PatientEvolutionForNutritionistResultBuilder b)]) = _$PatientEvolutionForNutritionistResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PatientEvolutionForNutritionistResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PatientEvolutionForNutritionistResult> get serializer => _$PatientEvolutionForNutritionistResultSerializer();
}

class _$PatientEvolutionForNutritionistResultSerializer implements PrimitiveSerializer<PatientEvolutionForNutritionistResult> {
  @override
  final Iterable<Type> types = const [PatientEvolutionForNutritionistResult, _$PatientEvolutionForNutritionistResult];

  @override
  final String wireName = r'PatientEvolutionForNutritionistResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PatientEvolutionForNutritionistResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.ibsSssTimeline != null) {
      yield r'ibsSssTimeline';
      yield serializers.serialize(
        object.ibsSssTimeline,
        specifiedType: const FullType.nullable(BuiltList, [FullType(IbsSssEvolutionEntry)]),
      );
    }
    if (object.baselineScore != null) {
      yield r'baselineScore';
      yield serializers.serialize(
        object.baselineScore,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.latestScore != null) {
      yield r'latestScore';
      yield serializers.serialize(
        object.latestScore,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.percentChangeFromBaseline != null) {
      yield r'percentChangeFromBaseline';
      yield serializers.serialize(
        object.percentChangeFromBaseline,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.significantClinicalResponse != null) {
      yield r'significantClinicalResponse';
      yield serializers.serialize(
        object.significantClinicalResponse,
        specifiedType: const FullType(bool),
      );
    }
    if (object.registrationFrequency14d != null) {
      yield r'registrationFrequency14d';
      yield serializers.serialize(
        object.registrationFrequency14d,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PatientEvolutionForNutritionistResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PatientEvolutionForNutritionistResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'ibsSssTimeline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(IbsSssEvolutionEntry)]),
          ) as BuiltList<IbsSssEvolutionEntry>?;
          if (valueDes == null) continue;
          result.ibsSssTimeline.replace(valueDes);
          break;
        case r'baselineScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.baselineScore = valueDes;
          break;
        case r'latestScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.latestScore = valueDes;
          break;
        case r'percentChangeFromBaseline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.percentChangeFromBaseline = valueDes;
          break;
        case r'significantClinicalResponse':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.significantClinicalResponse = valueDes;
          break;
        case r'registrationFrequency14d':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.registrationFrequency14d = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PatientEvolutionForNutritionistResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PatientEvolutionForNutritionistResultBuilder();
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

