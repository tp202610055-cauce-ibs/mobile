// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_record_owner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localRecordOwnerHash() => r'8a309af132d80c68f2e8faeb4f5343e89e05739d';

/// Cuenta duena de las filas locales: la de la sesion, o `null` sin sesion.
///
/// Se lee en cada consulta, de modo que un cambio de cuenta no deja filas
/// ajenas a la vista ni en la cola.
///
/// Copied from [localRecordOwner].
@ProviderFor(localRecordOwner)
final localRecordOwnerProvider = Provider<String? Function()>.internal(
  localRecordOwner,
  name: r'localRecordOwnerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localRecordOwnerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalRecordOwnerRef = ProviderRef<String? Function()>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
