//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/ibs_subtype.dart';
import 'package:cauce_api_client/src/model/priority_level.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assigned_patient_summary.g.dart';

/// AssignedPatientSummary
///
/// Properties:
/// * [patientUserId] 
/// * [patientFullName] 
/// * [assignmentId] 
/// * [assignedAt] 
/// * [profileCompleted] 
/// * [ibsSubtype] 
/// * [latestIbsSssScore] 
/// * [lastActivityAt] 
/// * [pendingReviewOver24hCount] 
/// * [priorityLevel] 
@BuiltValue()
abstract class AssignedPatientSummary implements Built<AssignedPatientSummary, AssignedPatientSummaryBuilder> {
  @BuiltValueField(wireName: r'patientUserId')
  String? get patientUserId;

  @BuiltValueField(wireName: r'patientFullName')
  String? get patientFullName;

  @BuiltValueField(wireName: r'assignmentId')
  String? get assignmentId;

  @BuiltValueField(wireName: r'assignedAt')
  DateTime? get assignedAt;

  @BuiltValueField(wireName: r'profileCompleted')
  bool? get profileCompleted;

  @BuiltValueField(wireName: r'ibsSubtype')
  IbsSubtype? get ibsSubtype;
  // enum ibsSubtypeEnum {  IbsD,  IbsC,  IbsM,  IbsU,  };

  @BuiltValueField(wireName: r'latestIbsSssScore')
  int? get latestIbsSssScore;

  @BuiltValueField(wireName: r'lastActivityAt')
  DateTime? get lastActivityAt;

  @BuiltValueField(wireName: r'pendingReviewOver24hCount')
  int? get pendingReviewOver24hCount;

  @BuiltValueField(wireName: r'priorityLevel')
  PriorityLevel? get priorityLevel;
  // enum priorityLevelEnum {  None,  Low,  Medium,  High,  };

  AssignedPatientSummary._();

  factory AssignedPatientSummary([void updates(AssignedPatientSummaryBuilder b)]) = _$AssignedPatientSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignedPatientSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignedPatientSummary> get serializer => _$AssignedPatientSummarySerializer();
}

class _$AssignedPatientSummarySerializer implements PrimitiveSerializer<AssignedPatientSummary> {
  @override
  final Iterable<Type> types = const [AssignedPatientSummary, _$AssignedPatientSummary];

  @override
  final String wireName = r'AssignedPatientSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignedPatientSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.patientUserId != null) {
      yield r'patientUserId';
      yield serializers.serialize(
        object.patientUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.patientFullName != null) {
      yield r'patientFullName';
      yield serializers.serialize(
        object.patientFullName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.assignmentId != null) {
      yield r'assignmentId';
      yield serializers.serialize(
        object.assignmentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.assignedAt != null) {
      yield r'assignedAt';
      yield serializers.serialize(
        object.assignedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.profileCompleted != null) {
      yield r'profileCompleted';
      yield serializers.serialize(
        object.profileCompleted,
        specifiedType: const FullType(bool),
      );
    }
    if (object.ibsSubtype != null) {
      yield r'ibsSubtype';
      yield serializers.serialize(
        object.ibsSubtype,
        specifiedType: const FullType(IbsSubtype),
      );
    }
    if (object.latestIbsSssScore != null) {
      yield r'latestIbsSssScore';
      yield serializers.serialize(
        object.latestIbsSssScore,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.lastActivityAt != null) {
      yield r'lastActivityAt';
      yield serializers.serialize(
        object.lastActivityAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.pendingReviewOver24hCount != null) {
      yield r'pendingReviewOver24hCount';
      yield serializers.serialize(
        object.pendingReviewOver24hCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.priorityLevel != null) {
      yield r'priorityLevel';
      yield serializers.serialize(
        object.priorityLevel,
        specifiedType: const FullType(PriorityLevel),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AssignedPatientSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignedPatientSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'patientUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.patientUserId = valueDes;
          break;
        case r'patientFullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.patientFullName = valueDes;
          break;
        case r'assignmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assignmentId = valueDes;
          break;
        case r'assignedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.assignedAt = valueDes;
          break;
        case r'profileCompleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.profileCompleted = valueDes;
          break;
        case r'ibsSubtype':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IbsSubtype),
          ) as IbsSubtype;
          result.ibsSubtype = valueDes;
          break;
        case r'latestIbsSssScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.latestIbsSssScore = valueDes;
          break;
        case r'lastActivityAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastActivityAt = valueDes;
          break;
        case r'pendingReviewOver24hCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingReviewOver24hCount = valueDes;
          break;
        case r'priorityLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PriorityLevel),
          ) as PriorityLevel;
          result.priorityLevel = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssignedPatientSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignedPatientSummaryBuilder();
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

