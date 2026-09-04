//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_duplicate_entry.g.dart';

/// SyncDuplicateEntry
///
/// Properties:
/// * [clientGuid] 
/// * [existingServerId] 
@BuiltValue()
abstract class SyncDuplicateEntry implements Built<SyncDuplicateEntry, SyncDuplicateEntryBuilder> {
  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'existingServerId')
  String? get existingServerId;

  SyncDuplicateEntry._();

  factory SyncDuplicateEntry([void updates(SyncDuplicateEntryBuilder b)]) = _$SyncDuplicateEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncDuplicateEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncDuplicateEntry> get serializer => _$SyncDuplicateEntrySerializer();
}

class _$SyncDuplicateEntrySerializer implements PrimitiveSerializer<SyncDuplicateEntry> {
  @override
  final Iterable<Type> types = const [SyncDuplicateEntry, _$SyncDuplicateEntry];

  @override
  final String wireName = r'SyncDuplicateEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncDuplicateEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clientGuid != null) {
      yield r'clientGuid';
      yield serializers.serialize(
        object.clientGuid,
        specifiedType: const FullType(String),
      );
    }
    if (object.existingServerId != null) {
      yield r'existingServerId';
      yield serializers.serialize(
        object.existingServerId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncDuplicateEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncDuplicateEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clientGuid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientGuid = valueDes;
          break;
        case r'existingServerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.existingServerId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncDuplicateEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncDuplicateEntryBuilder();
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

