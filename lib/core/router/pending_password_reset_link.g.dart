// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_password_reset_link.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pendingPasswordResetLinkHash() =>
    r'27dd837afc8e512819b091c4cb0c171875a2c35d';

/// Enlace de restablecimiento en curso, que sobrevive a las reconstrucciones
/// del router. Leerlo no lo consume: se limpia solo al terminar el flujo.
///
/// Copied from [PendingPasswordResetLink].
@ProviderFor(PendingPasswordResetLink)
final pendingPasswordResetLinkProvider =
    NotifierProvider<PendingPasswordResetLink, String?>.internal(
  PendingPasswordResetLink.new,
  name: r'pendingPasswordResetLinkProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingPasswordResetLinkHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PendingPasswordResetLink = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
