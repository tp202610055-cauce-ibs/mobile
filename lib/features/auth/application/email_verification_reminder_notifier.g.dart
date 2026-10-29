// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_reminder_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailVerificationReminderHash() =>
    r'60ea8b09bdc222bd33f6f1900b772980d56408cc';

/// Muestra el recordatorio mientras la sesion tenga el correo sin verificar.
///
/// Se retira solo cuando cualquier renovacion de sesion trae el correo
/// verificado: la del boton y tambien la automatica de la red.
///
/// Copied from [EmailVerificationReminder].
@ProviderFor(EmailVerificationReminder)
final emailVerificationReminderProvider = NotifierProvider<
    EmailVerificationReminder, EmailVerificationReminderState>.internal(
  EmailVerificationReminder.new,
  name: r'emailVerificationReminderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emailVerificationReminderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EmailVerificationReminder = Notifier<EmailVerificationReminderState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
