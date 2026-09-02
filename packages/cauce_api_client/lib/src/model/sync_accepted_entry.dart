//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_accepted_entry.g.dart';

/// SyncAcceptedEntry
///
/// Properties:
/// * [clientGuid] 
/// * [serverId] 
/// * [entityType] 
@BuiltValue()
abstract class SyncAcceptedEntry implements Built<SyncAcceptedEntry, SyncAcceptedEntryBuilder> {
  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'serverId')
  String? get serverId;

  @BuiltValueField(wireName: r'entityType')
  String? get entityType;

  SyncAcceptedEntry._();

  factory SyncAcceptedEntry([void updates(SyncAcceptedEntryBuilder b)]) = _$SyncAcceptedEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncAcceptedEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncAcceptedEntry> get serializer => _$SyncAcceptedEntrySerializer();
}

class _$SyncAcceptedEntrySerializer implements PrimitiveSerializer<SyncAcceptedEntry> {
  @override
  final Iterable<Type> types = const [SyncAcceptedEntry, _$SyncAcceptedEntry];

  @override
  final String wireName = r'SyncAcceptedEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncAcceptedEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clientGuid != null) {
      yield r'clientGuid';
      yield serializers.serialize(
        object.clientGuid,
        specifiedType: const FullType(String),
      );
    }
    if (object.serverId != null) {
      yield r'serverId';
      yield serializers.serialize(
        object.serverId,
        specifiedType: const FullType(String),
      );
    }
    if (object.entityType != null) {
      yield r'entityType';
      yield serializers.serialize(
        object.entityType,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncAcceptedEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncAcceptedEntryBuilder result,
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
        case r'serverId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serverId = valueDes;
          break;
        case r'entityType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.entityType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncAcceptedEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncAcceptedEntryBuilder();
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

