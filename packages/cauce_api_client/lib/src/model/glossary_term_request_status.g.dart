// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_term_request_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GlossaryTermRequestStatus _$pending =
    const GlossaryTermRequestStatus._('pending');

GlossaryTermRequestStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GlossaryTermRequestStatus> _$values =
    BuiltSet<GlossaryTermRequestStatus>(const <GlossaryTermRequestStatus>[
  _$pending,
]);

class _$GlossaryTermRequestStatusMeta {
  const _$GlossaryTermRequestStatusMeta();
  GlossaryTermRequestStatus get pending => _$pending;
  GlossaryTermRequestStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<GlossaryTermRequestStatus> get values => _$values;
}

abstract class _$GlossaryTermRequestStatusMixin {
  // ignore: non_constant_identifier_names
  _$GlossaryTermRequestStatusMeta get GlossaryTermRequestStatus =>
      const _$GlossaryTermRequestStatusMeta();
}

Serializer<GlossaryTermRequestStatus> _$glossaryTermRequestStatusSerializer =
    _$GlossaryTermRequestStatusSerializer();

class _$GlossaryTermRequestStatusSerializer
    implements PrimitiveSerializer<GlossaryTermRequestStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'Pending',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Pending': 'pending',
  };

  @override
  final Iterable<Type> types = const <Type>[GlossaryTermRequestStatus];
  @override
  final String wireName = 'GlossaryTermRequestStatus';

  @override
  Object serialize(Serializers serializers, GlossaryTermRequestStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GlossaryTermRequestStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GlossaryTermRequestStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
