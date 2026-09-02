//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'archive_reason.g.dart';

class ArchiveReason extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TemporalExpiration')
  static const ArchiveReason temporalExpiration = _$temporalExpiration;
  @BuiltValueEnumConst(wireName: r'ManualSubstitution')
  static const ArchiveReason manualSubstitution = _$manualSubstitution;
  @BuiltValueEnumConst(wireName: r'ObjectiveMet')
  static const ArchiveReason objectiveMet = _$objectiveMet;
  @BuiltValueEnumConst(wireName: r'PlanChange')
  static const ArchiveReason planChange = _$planChange;

  static Serializer<ArchiveReason> get serializer => _$archiveReasonSerializer;

  const ArchiveReason._(String name): super(name);

  static BuiltSet<ArchiveReason> get values => _$values;
  static ArchiveReason valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ArchiveReasonMixin = Object with _$ArchiveReasonMixin;

