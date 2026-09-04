//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ibs_subtype.g.dart';

class IbsSubtype extends EnumClass {

  @BuiltValueEnumConst(wireName: r'IbsD')
  static const IbsSubtype ibsD = _$ibsD;
  @BuiltValueEnumConst(wireName: r'IbsC')
  static const IbsSubtype ibsC = _$ibsC;
  @BuiltValueEnumConst(wireName: r'IbsM')
  static const IbsSubtype ibsM = _$ibsM;
  @BuiltValueEnumConst(wireName: r'IbsU')
  static const IbsSubtype ibsU = _$ibsU;

  static Serializer<IbsSubtype> get serializer => _$ibsSubtypeSerializer;

  const IbsSubtype._(String name): super(name);

  static BuiltSet<IbsSubtype> get values => _$values;
  static IbsSubtype valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class IbsSubtypeMixin = Object with _$IbsSubtypeMixin;

