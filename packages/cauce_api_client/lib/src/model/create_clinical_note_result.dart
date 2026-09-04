//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_clinical_note_result.g.dart';

/// CreateClinicalNoteResult
///
/// Properties:
/// * [noteId] 
@BuiltValue()
abstract class CreateClinicalNoteResult implements Built<CreateClinicalNoteResult, CreateClinicalNoteResultBuilder> {
  @BuiltValueField(wireName: r'noteId')
  String? get noteId;

  CreateClinicalNoteResult._();

  factory CreateClinicalNoteResult([void updates(CreateClinicalNoteResultBuilder b)]) = _$CreateClinicalNoteResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateClinicalNoteResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateClinicalNoteResult> get serializer => _$CreateClinicalNoteResultSerializer();
}

class _$CreateClinicalNoteResultSerializer implements PrimitiveSerializer<CreateClinicalNoteResult> {
  @override
  final Iterable<Type> types = const [CreateClinicalNoteResult, _$CreateClinicalNoteResult];

  @override
  final String wireName = r'CreateClinicalNoteResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateClinicalNoteResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.noteId != null) {
      yield r'noteId';
      yield serializers.serialize(
        object.noteId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateClinicalNoteResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateClinicalNoteResultBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateClinicalNoteResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateClinicalNoteResultBuilder();
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

