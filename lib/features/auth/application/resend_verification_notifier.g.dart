// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_verification_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resendVerificationNotifierHash() =>
    r'296bfa6ebb821c0ed5de3fd715479d6135c57ada';

/// Gobierna el reenvio del correo de verificacion.
///
/// `AuthRepository.resendVerificationEmail` existia desde Mobile-1.5 y nadie lo
/// llamaba: la pantalla de verificacion pendiente derivaba a un "soporte" que
/// no existe. El limite lo pone el backend, tres por hora por correo, y un
/// cuarto intento vuelve como 429 con su espera: se muestra ese error en vez
/// de duplicar la regla con un temporizador en el cliente.
///
/// Copied from [ResendVerificationNotifier].
@ProviderFor(ResendVerificationNotifier)
final resendVerificationNotifierProvider = AutoDisposeNotifierProvider<
    ResendVerificationNotifier, ResendVerificationState>.internal(
  ResendVerificationNotifier.new,
  name: r'resendVerificationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resendVerificationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ResendVerificationNotifier
    = AutoDisposeNotifier<ResendVerificationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
