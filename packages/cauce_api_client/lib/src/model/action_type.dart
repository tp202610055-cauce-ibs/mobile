//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'action_type.g.dart';

class ActionType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Suggest')
  static const ActionType suggest = _$suggest;
  @BuiltValueEnumConst(wireName: r'Reduce')
  static const ActionType reduce = _$reduce;
  @BuiltValueEnumConst(wireName: r'Avoid')
  static const ActionType avoid = _$avoid;
  @BuiltValueEnumConst(wireName: r'Substitute')
  static const ActionType substitute = _$substitute;

  static Serializer<ActionType> get serializer => _$actionTypeSerializer;

  const ActionType._(String name): super(name);

  static BuiltSet<ActionType> get values => _$values;
  static ActionType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ActionTypeMixin = Object with _$ActionTypeMixin;

