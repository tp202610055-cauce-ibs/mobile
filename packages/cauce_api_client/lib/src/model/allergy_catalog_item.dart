//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/allergy_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'allergy_catalog_item.g.dart';

/// AllergyCatalogItem
///
/// Properties:
/// * [allergyId] 
/// * [name] 
/// * [allergyType] 
/// * [description] 
@BuiltValue()
abstract class AllergyCatalogItem implements Built<AllergyCatalogItem, AllergyCatalogItemBuilder> {
  @BuiltValueField(wireName: r'allergyId')
  String? get allergyId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'allergyType')
  AllergyType? get allergyType;
  // enum allergyTypeEnum {  Allergy,  Intolerance,  Sensitivity,  };

  @BuiltValueField(wireName: r'description')
  String? get description;

  AllergyCatalogItem._();

  factory AllergyCatalogItem([void updates(AllergyCatalogItemBuilder b)]) = _$AllergyCatalogItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AllergyCatalogItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AllergyCatalogItem> get serializer => _$AllergyCatalogItemSerializer();
}

class _$AllergyCatalogItemSerializer implements PrimitiveSerializer<AllergyCatalogItem> {
  @override
  final Iterable<Type> types = const [AllergyCatalogItem, _$AllergyCatalogItem];

  @override
  final String wireName = r'AllergyCatalogItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AllergyCatalogItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.allergyId != null) {
      yield r'allergyId';
      yield serializers.serialize(
        object.allergyId,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.allergyType != null) {
      yield r'allergyType';
      yield serializers.serialize(
        object.allergyType,
        specifiedType: const FullType(AllergyType),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AllergyCatalogItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AllergyCatalogItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'allergyId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.allergyId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'allergyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AllergyType),
          ) as AllergyType;
          result.allergyType = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AllergyCatalogItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AllergyCatalogItemBuilder();
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

