//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/ibs_sss_assessment_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ibs_sss_evolution_entry.g.dart';

/// IbsSssEvolutionEntry
///
/// Properties:
/// * [assessment] 
/// * [deltaFromBaseline] 
@BuiltValue()
abstract class IbsSssEvolutionEntry implements Built<IbsSssEvolutionEntry, IbsSssEvolutionEntryBuilder> {
  @BuiltValueField(wireName: r'assessment')
  IbsSssAssessmentSummary? get assessment;

  @BuiltValueField(wireName: r'deltaFromBaseline')
  int? get deltaFromBaseline;

  IbsSssEvolutionEntry._();

  factory IbsSssEvolutionEntry([void updates(IbsSssEvolutionEntryBuilder b)]) = _$IbsSssEvolutionEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IbsSssEvolutionEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IbsSssEvolutionEntry> get serializer => _$IbsSssEvolutionEntrySerializer();
}

class _$IbsSssEvolutionEntrySerializer implements PrimitiveSerializer<IbsSssEvolutionEntry> {
  @override
  final Iterable<Type> types = const [IbsSssEvolutionEntry, _$IbsSssEvolutionEntry];

  @override
  final String wireName = r'IbsSssEvolutionEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IbsSssEvolutionEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.assessment != null) {
      yield r'assessment';
      yield serializers.serialize(
        object.assessment,
        specifiedType: const FullType(IbsSssAssessmentSummary),
      );
    }
    if (object.deltaFromBaseline != null) {
      yield r'deltaFromBaseline';
      yield serializers.serialize(
        object.deltaFromBaseline,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    IbsSssEvolutionEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IbsSssEvolutionEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assessment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IbsSssAssessmentSummary),
          ) as IbsSssAssessmentSummary;
          result.assessment.replace(valueDes);
          break;
        case r'deltaFromBaseline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.deltaFromBaseline = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IbsSssEvolutionEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IbsSssEvolutionEntryBuilder();
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

