// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refreshed_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$refreshedUserHash() => r'4a7f51b0b57339ec91a50ba3679298c8571f43da';

/// Ultimo usuario que trajo una renovacion de sesion, o `null` si ninguna.
/// Se publica aparte de la sesion en memoria para no reconstruir el router.
///
/// Copied from [RefreshedUser].
@ProviderFor(RefreshedUser)
final refreshedUserProvider =
    NotifierProvider<RefreshedUser, AuthenticatedUserSnapshot?>.internal(
  RefreshedUser.new,
  name: r'refreshedUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$refreshedUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RefreshedUser = Notifier<AuthenticatedUserSnapshot?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
