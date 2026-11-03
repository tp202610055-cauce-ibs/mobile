// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_without_invitation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$showsNoInvitationNoticeHash() =>
    r'64c4c7c7c400521d6d77566bbdc4f346fe67daf1';

/// `true` si la sesion actual es la de esa cuenta (CP055 paso 5).
///
/// Copied from [showsNoInvitationNotice].
@ProviderFor(showsNoInvitationNotice)
final showsNoInvitationNoticeProvider = AutoDisposeProvider<bool>.internal(
  showsNoInvitationNotice,
  name: r'showsNoInvitationNoticeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showsNoInvitationNoticeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShowsNoInvitationNoticeRef = AutoDisposeProviderRef<bool>;
String _$registeredWithoutInvitationHash() =>
    r'4276510fcfd989d3bd89b7b5f6c0fb0f11dba5b8';

/// `userId` de la cuenta recien registrada sin codigo de invitacion.
///
/// Vive solo en memoria: el aviso que alimenta no sobrevive a un reinicio.
///
/// Copied from [RegisteredWithoutInvitation].
@ProviderFor(RegisteredWithoutInvitation)
final registeredWithoutInvitationProvider =
    NotifierProvider<RegisteredWithoutInvitation, String?>.internal(
  RegisteredWithoutInvitation.new,
  name: r'registeredWithoutInvitationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$registeredWithoutInvitationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RegisteredWithoutInvitation = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
