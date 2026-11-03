//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ibs_sss_cycle_status.g.dart';

class IbsSssCycleStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'None')
  static const IbsSssCycleStatus none = _$none;
  @BuiltValueEnumConst(wireName: r'Pending')
  static const IbsSssCycleStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'Missed')
  static const IbsSssCycleStatus missed = _$missed;
  @BuiltValueEnumConst(wireName: r'Completed')
  static const IbsSssCycleStatus completed = _$completed;

  static Serializer<IbsSssCycleStatus> get serializer => _$ibsSssCycleStatusSerializer;

  const IbsSssCycleStatus._(String name): super(name);

  static BuiltSet<IbsSssCycleStatus> get values => _$values;
  static IbsSssCycleStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class IbsSssCycleStatusMixin = Object with _$IbsSssCycleStatusMixin;

