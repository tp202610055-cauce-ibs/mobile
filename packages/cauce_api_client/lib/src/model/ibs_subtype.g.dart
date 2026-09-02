// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibs_subtype.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const IbsSubtype _$ibsD = const IbsSubtype._('ibsD');
const IbsSubtype _$ibsC = const IbsSubtype._('ibsC');
const IbsSubtype _$ibsM = const IbsSubtype._('ibsM');
const IbsSubtype _$ibsU = const IbsSubtype._('ibsU');

IbsSubtype _$valueOf(String name) {
  switch (name) {
    case 'ibsD':
      return _$ibsD;
    case 'ibsC':
      return _$ibsC;
    case 'ibsM':
      return _$ibsM;
    case 'ibsU':
      return _$ibsU;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<IbsSubtype> _$values = BuiltSet<IbsSubtype>(const <IbsSubtype>[
  _$ibsD,
  _$ibsC,
  _$ibsM,
  _$ibsU,
]);

class _$IbsSubtypeMeta {
  const _$IbsSubtypeMeta();
  IbsSubtype get ibsD => _$ibsD;
  IbsSubtype get ibsC => _$ibsC;
  IbsSubtype get ibsM => _$ibsM;
  IbsSubtype get ibsU => _$ibsU;
  IbsSubtype valueOf(String name) => _$valueOf(name);
  BuiltSet<IbsSubtype> get values => _$values;
}

abstract class _$IbsSubtypeMixin {
  // ignore: non_constant_identifier_names
  _$IbsSubtypeMeta get IbsSubtype => const _$IbsSubtypeMeta();
}

Serializer<IbsSubtype> _$ibsSubtypeSerializer = _$IbsSubtypeSerializer();

class _$IbsSubtypeSerializer implements PrimitiveSerializer<IbsSubtype> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ibsD': 'IbsD',
    'ibsC': 'IbsC',
    'ibsM': 'IbsM',
    'ibsU': 'IbsU',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'IbsD': 'ibsD',
    'IbsC': 'ibsC',
    'IbsM': 'ibsM',
    'IbsU': 'ibsU',
  };

  @override
  final Iterable<Type> types = const <Type>[IbsSubtype];
  @override
  final String wireName = 'IbsSubtype';

  @override
  Object serialize(Serializers serializers, IbsSubtype object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IbsSubtype deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IbsSubtype.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
