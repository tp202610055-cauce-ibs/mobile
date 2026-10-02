// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountDeletionNotifierHash() =>
    r'f860080e6744adb6e29eaab918fd7ee28ce23cea';

/// Gobierna la baja de cuenta, una vez que el paciente ya confirmo.
///
/// **No muestra la segunda confirmacion.** Informa si hace falta
/// ([requiresPilotAcknowledgement]), y la pantalla es quien la muestra y quien
/// sabe si el paciente la otorgo. Aca llega el resultado de esa decision, ya
/// tomada.
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
