// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountDeletionNotifierHash() =>
    r'8114ee94c84dbb90d9ce0133697ffb69bf2f2466';

/// Gobierna la baja de cuenta, una vez que el paciente ya confirmo.
///
/// **No decide si hace falta la segunda confirmacion.** Esa es la pantalla,
/// que es quien la muestra y quien sabe si el paciente la otorgo. Aca llega el
/// resultado de esa decision, ya tomada.
///
/// Copied from [AccountDeletionNotifier].
@ProviderFor(AccountDeletionNotifier)
final accountDeletionNotifierProvider = AutoDisposeNotifierProvider<
    AccountDeletionNotifier, AccountDeletionState>.internal(
  AccountDeletionNotifier.new,
  name: r'accountDeletionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountDeletionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AccountDeletionNotifier = AutoDisposeNotifier<AccountDeletionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
