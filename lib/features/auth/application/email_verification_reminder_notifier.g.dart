// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_reminder_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emailVerificationReminderHash() =>
    r'd71bd393f61c21f52ed7198b50d9325eb8ba5957';

/// Muestra el recordatorio mientras la sesion tenga el correo sin verificar.
///
/// Comprueba contra el snapshot guardado, que el refresh actualiza sin tocar
/// la sesion en memoria. Sin contrasena no hay otra fuente.
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
