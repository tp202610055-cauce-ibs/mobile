//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'glossary_term_request_status.g.dart';

class GlossaryTermRequestStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Pending')
  static const GlossaryTermRequestStatus pending = _$pending;

  static Serializer<GlossaryTermRequestStatus> get serializer => _$glossaryTermRequestStatusSerializer;

  const GlossaryTermRequestStatus._(String name): super(name);

  static BuiltSet<GlossaryTermRequestStatus> get values => _$values;
  static GlossaryTermRequestStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class GlossaryTermRequestStatusMixin = Object with _$GlossaryTermRequestStatusMixin;

