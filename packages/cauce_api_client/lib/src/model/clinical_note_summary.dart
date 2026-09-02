//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'clinical_note_summary.g.dart';

/// ClinicalNoteSummary
///
/// Properties:
/// * [noteId] 
/// * [mealId] 
/// * [symptomId] 
/// * [content] 
/// * [createdAt] 
@BuiltValue()
abstract class ClinicalNoteSummary implements Built<ClinicalNoteSummary, ClinicalNoteSummaryBuilder> {
  @BuiltValueField(wireName: r'noteId')
  String? get noteId;

  @BuiltValueField(wireName: r'mealId')
  String? get mealId;

  @BuiltValueField(wireName: r'symptomId')
  String? get symptomId;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  ClinicalNoteSummary._();

  factory ClinicalNoteSummary([void updates(ClinicalNoteSummaryBuilder b)]) = _$ClinicalNoteSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClinicalNoteSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClinicalNoteSummary> get serializer => _$ClinicalNoteSummarySerializer();
}

class _$ClinicalNoteSummarySerializer implements PrimitiveSerializer<ClinicalNoteSummary> {
  @override
  final Iterable<Type> types = const [ClinicalNoteSummary, _$ClinicalNoteSummary];

  @override
  final String wireName = r'ClinicalNoteSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClinicalNoteSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.noteId != null) {
      yield r'noteId';
      yield serializers.serialize(
        object.noteId,
        specifiedType: const FullType(String),
      );
    }
    if (object.mealId != null) {
      yield r'mealId';
      yield serializers.serialize(
        object.mealId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.symptomId != null) {
      yield r'symptomId';
      yield serializers.serialize(
        object.symptomId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClinicalNoteSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ClinicalNoteSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'noteId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.noteId = valueDes;
          break;
        case r'mealId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mealId = valueDes;
          break;
        case r'symptomId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.symptomId = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.content = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClinicalNoteSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClinicalNoteSummaryBuilder();
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

