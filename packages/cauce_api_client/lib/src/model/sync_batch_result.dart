//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/model/sync_accepted_entry.dart';
import 'package:cauce_api_client/src/model/sync_duplicate_entry.dart';
import 'package:cauce_api_client/src/model/sync_error_entry.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_batch_result.g.dart';

/// SyncBatchResult
///
/// Properties:
/// * [accepted] 
/// * [duplicates] 
/// * [errors] 
@BuiltValue()
abstract class SyncBatchResult implements Built<SyncBatchResult, SyncBatchResultBuilder> {
  @BuiltValueField(wireName: r'accepted')
  BuiltList<SyncAcceptedEntry>? get accepted;

  @BuiltValueField(wireName: r'duplicates')
  BuiltList<SyncDuplicateEntry>? get duplicates;

  @BuiltValueField(wireName: r'errors')
  BuiltList<SyncErrorEntry>? get errors;

  SyncBatchResult._();

  factory SyncBatchResult([void updates(SyncBatchResultBuilder b)]) = _$SyncBatchResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncBatchResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncBatchResult> get serializer => _$SyncBatchResultSerializer();
}

class _$SyncBatchResultSerializer implements PrimitiveSerializer<SyncBatchResult> {
  @override
  final Iterable<Type> types = const [SyncBatchResult, _$SyncBatchResult];

  @override
  final String wireName = r'SyncBatchResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncBatchResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accepted != null) {
      yield r'accepted';
      yield serializers.serialize(
        object.accepted,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SyncAcceptedEntry)]),
      );
    }
    if (object.duplicates != null) {
      yield r'duplicates';
      yield serializers.serialize(
        object.duplicates,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SyncDuplicateEntry)]),
      );
    }
    if (object.errors != null) {
      yield r'errors';
      yield serializers.serialize(
        object.errors,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SyncErrorEntry)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncBatchResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncBatchResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accepted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SyncAcceptedEntry)]),
          ) as BuiltList<SyncAcceptedEntry>?;
          if (valueDes == null) continue;
          result.accepted.replace(valueDes);
          break;
        case r'duplicates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SyncDuplicateEntry)]),
          ) as BuiltList<SyncDuplicateEntry>?;
          if (valueDes == null) continue;
          result.duplicates.replace(valueDes);
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SyncErrorEntry)]),
          ) as BuiltList<SyncErrorEntry>?;
          if (valueDes == null) continue;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncBatchResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncBatchResultBuilder();
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

