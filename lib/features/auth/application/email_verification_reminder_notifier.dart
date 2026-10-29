import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/token_storage_provider.dart';
import '../domain/session_state.dart';
import 'session_notifier.dart';

part 'email_verification_reminder_notifier.freezed.dart';
part 'email_verification_reminder_notifier.g.dart';

/// Recordatorio de verificacion del correo en Inicio.
@freezed
sealed class EmailVerificationReminderState
    with _$EmailVerificationReminderState {
  const factory EmailVerificationReminderState.hidden() =
      EmailVerificationReminderHidden;

  /// [stillPending] es el resultado de la ultima comprobacion pedida.
  const factory EmailVerificationReminderState.visible({
    required String email,
    @Default(false) bool checking,
    @Default(false) bool stillPending,
  }) = EmailVerificationReminderVisible;
}

/// Muestra el recordatorio mientras la sesion tenga el correo sin verificar.
///
/// Comprueba contra el snapshot guardado, que el refresh actualiza sin tocar
/// la sesion en memoria. Sin contrasena no hay otra fuente.
@Riverpod(keepAlive: true)
class EmailVerificationReminder extends _$EmailVerificationReminder {
  @override
  EmailVerificationReminderState build() {
    final session = ref.watch(sessionNotifierProvider);
    if (session case SessionAuthenticated(:final user)
        when !user.emailVerified) {
      return EmailVerificationReminderState.visible(email: user.email);
    }
    return const EmailVerificationReminderState.hidden();
  }

  /// Vuelve a mirar el snapshot. Con [announce] avisa si sigue sin verificar.
  Future<void> check({bool announce = true}) async {
    final current = state;
    if (current is! EmailVerificationReminderVisible || current.checking) {
      return;
    }
    state = current.copyWith(checking: true, stillPending: false);

    var verified = false;
    try {
      final stored = await ref.read(tokenStorageProvider).readUserSnapshot();
      verified = stored != null &&
          stored.email == current.email &&
          stored.emailVerified;
    } on Object {
      // Un Keystore que no responde cuenta como "todavia no".
    }

    // La sesion pudo cambiar durante la lectura.
    if (state is! EmailVerificationReminderVisible) {
      return;
    }
    state = verified
        ? const EmailVerificationReminderState.hidden()
        : current.copyWith(checking: false, stillPending: announce);
  }
}
