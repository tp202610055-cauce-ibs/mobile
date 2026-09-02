//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/glossary_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'glossary_term_dto.g.dart';

/// GlossaryTermDto
///
/// Properties:
/// * [term] 
/// * [definition] 
/// * [category] 
@BuiltValue()
abstract class GlossaryTermDto implements Built<GlossaryTermDto, GlossaryTermDtoBuilder> {
  @BuiltValueField(wireName: r'term')
  String? get term;

  @BuiltValueField(wireName: r'definition')
  String? get definition;

  @BuiltValueField(wireName: r'category')
  GlossaryCategory? get category;
  // enum categoryEnum {  Nutritional,  ClinicalIbs,  System,  };

  GlossaryTermDto._();

  factory GlossaryTermDto([void updates(GlossaryTermDtoBuilder b)]) = _$GlossaryTermDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GlossaryTermDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GlossaryTermDto> get serializer => _$GlossaryTermDtoSerializer();
}

class _$GlossaryTermDtoSerializer implements PrimitiveSerializer<GlossaryTermDto> {
  @override
  final Iterable<Type> types = const [GlossaryTermDto, _$GlossaryTermDto];

  @override
  final String wireName = r'GlossaryTermDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GlossaryTermDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.term != null) {
      yield r'term';
      yield serializers.serialize(
        object.term,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.definition != null) {
      yield r'definition';
      yield serializers.serialize(
        object.definition,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(GlossaryCategory),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GlossaryTermDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GlossaryTermDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'term':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.term = valueDes;
          break;
        case r'definition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.definition = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GlossaryCategory),
          ) as GlossaryCategory;
          result.category = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GlossaryTermDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GlossaryTermDtoBuilder();
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

