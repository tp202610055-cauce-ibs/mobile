// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibs_sss_cycle_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const IbsSssCycleStatus _$none = const IbsSssCycleStatus._('none');
const IbsSssCycleStatus _$pending = const IbsSssCycleStatus._('pending');
const IbsSssCycleStatus _$missed = const IbsSssCycleStatus._('missed');
const IbsSssCycleStatus _$completed = const IbsSssCycleStatus._('completed');

IbsSssCycleStatus _$valueOf(String name) {
  switch (name) {
    case 'none':
      return _$none;
    case 'pending':
      return _$pending;
    case 'missed':
      return _$missed;
    case 'completed':
      return _$completed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<IbsSssCycleStatus> _$values =
    BuiltSet<IbsSssCycleStatus>(const <IbsSssCycleStatus>[
  _$none,
  _$pending,
  _$missed,
  _$completed,
]);

class _$IbsSssCycleStatusMeta {
  const _$IbsSssCycleStatusMeta();
  IbsSssCycleStatus get none => _$none;
  IbsSssCycleStatus get pending => _$pending;
  IbsSssCycleStatus get missed => _$missed;
  IbsSssCycleStatus get completed => _$completed;
  IbsSssCycleStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<IbsSssCycleStatus> get values => _$values;
}

abstract class _$IbsSssCycleStatusMixin {
  // ignore: non_constant_identifier_names
  _$IbsSssCycleStatusMeta get IbsSssCycleStatus =>
      const _$IbsSssCycleStatusMeta();
}

Serializer<IbsSssCycleStatus> _$ibsSssCycleStatusSerializer =
    _$IbsSssCycleStatusSerializer();

class _$IbsSssCycleStatusSerializer
    implements PrimitiveSerializer<IbsSssCycleStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'None',
    'pending': 'Pending',
    'missed': 'Missed',
    'completed': 'Completed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'None': 'none',
    'Pending': 'pending',
    'Missed': 'missed',
    'Completed': 'completed',
  };

  @override
  final Iterable<Type> types = const <Type>[IbsSssCycleStatus];
  @override
  final String wireName = 'IbsSssCycleStatus';

  @override
  Object serialize(Serializers serializers, IbsSssCycleStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IbsSssCycleStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IbsSssCycleStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
