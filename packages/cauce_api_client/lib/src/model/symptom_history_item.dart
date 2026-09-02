//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/sync_status.dart';
import 'package:cauce_api_client/src/model/symptom_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'symptom_history_item.g.dart';

/// SymptomHistoryItem
///
/// Properties:
/// * [symptomId] 
/// * [clientGuid] 
/// * [symptomType] 
/// * [intensity] 
/// * [occurredAt] 
/// * [associatedMealId] 
/// * [hasMealAssociation] 
/// * [syncStatus] 
@BuiltValue()
abstract class SymptomHistoryItem implements Built<SymptomHistoryItem, SymptomHistoryItemBuilder> {
  @BuiltValueField(wireName: r'symptomId')
  String? get symptomId;

  @BuiltValueField(wireName: r'clientGuid')
  String? get clientGuid;

  @BuiltValueField(wireName: r'symptomType')
  SymptomType? get symptomType;
  // enum symptomTypeEnum {  AbdominalPain,  Bloating,  Flatulence,  Diarrhea,  Constipation,  Other,  Nausea,  Reflux,  Urgency,  };

  @BuiltValueField(wireName: r'intensity')
  int? get intensity;

  @BuiltValueField(wireName: r'occurredAt')
  DateTime? get occurredAt;

  @BuiltValueField(wireName: r'associatedMealId')
  String? get associatedMealId;

  @BuiltValueField(wireName: r'hasMealAssociation')
  bool? get hasMealAssociation;

  @BuiltValueField(wireName: r'syncStatus')
  SyncStatus? get syncStatus;
  // enum syncStatusEnum {  SyncPending,  SyncCompleted,  };

  SymptomHistoryItem._();

  factory SymptomHistoryItem([void updates(SymptomHistoryItemBuilder b)]) = _$SymptomHistoryItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SymptomHistoryItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SymptomHistoryItem> get serializer => _$SymptomHistoryItemSerializer();
}

class _$SymptomHistoryItemSerializer implements PrimitiveSerializer<SymptomHistoryItem> {
  @override
  final Iterable<Type> types = const [SymptomHistoryItem, _$SymptomHistoryItem];

  @override
  final String wireName = r'SymptomHistoryItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SymptomHistoryItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.symptomId != null) {
      yield r'symptomId';
      yield serializers.serialize(
        object.symptomId,
        specifiedType: const FullType(String),
      );
    }
    if (object.clientGuid != null) {
      yield r'clientGuid';
      yield serializers.serialize(
        object.clientGuid,
        specifiedType: const FullType(String),
      );
    }
    if (object.symptomType != null) {
      yield r'symptomType';
      yield serializers.serialize(
        object.symptomType,
        specifiedType: const FullType(SymptomType),
      );
    }
    if (object.intensity != null) {
      yield r'intensity';
      yield serializers.serialize(
        object.intensity,
        specifiedType: const FullType(int),
      );
    }
    if (object.occurredAt != null) {
      yield r'occurredAt';
      yield serializers.serialize(
        object.occurredAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.associatedMealId != null) {
      yield r'associatedMealId';
      yield serializers.serialize(
        object.associatedMealId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.hasMealAssociation != null) {
      yield r'hasMealAssociation';
      yield serializers.serialize(
        object.hasMealAssociation,
        specifiedType: const FullType(bool),
      );
    }
    if (object.syncStatus != null) {
      yield r'syncStatus';
      yield serializers.serialize(
        object.syncStatus,
        specifiedType: const FullType(SyncStatus),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SymptomHistoryItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SymptomHistoryItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symptomId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symptomId = valueDes;
          break;
        case r'clientGuid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientGuid = valueDes;
          break;
        case r'symptomType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SymptomType),
          ) as SymptomType;
          result.symptomType = valueDes;
          break;
        case r'intensity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.intensity = valueDes;
          break;
        case r'occurredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        case r'associatedMealId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.associatedMealId = valueDes;
          break;
        case r'hasMealAssociation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMealAssociation = valueDes;
          break;
        case r'syncStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SyncStatus),
          ) as SyncStatus;
          result.syncStatus = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SymptomHistoryItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SymptomHistoryItemBuilder();
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

