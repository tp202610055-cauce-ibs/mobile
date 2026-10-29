import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/authenticated_user_snapshot.dart';
import '../../../core/auth/refreshed_user.dart';
import '../../../core/auth/token_storage_provider.dart';
import '../../../core/errors/cauce_api_error.dart';
import '../../../core/errors/session_expired_exception.dart';
import '../../../core/network/session_renewal.dart';
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

  /// [stillPending] y [error] son el resultado de la ultima comprobacion.
  const factory EmailVerificationReminderState.visible({
    required String email,
    @Default(false) bool checking,
    @Default(false) bool stillPending,
    CauceApiError? error,
  }) = EmailVerificationReminderVisible;
}

/// Muestra el recordatorio mientras la sesion tenga el correo sin verificar.
///
/// Se retira solo cuando cualquier renovacion de sesion trae el correo
/// verificado: la del boton y tambien la automatica de la red.
@Riverpod(keepAlive: true)
class EmailVerificationReminder extends _$EmailVerificationReminder {
  @override
  EmailVerificationReminderState build() {
    final session = ref.watch(sessionNotifierProvider);
    ref.listen<AuthenticatedUserSnapshot?>(refreshedUserProvider, (_, user) {
      if (_confirms(user) && state is EmailVerificationReminderVisible) {
        state = const EmailVerificationReminderState.hidden();
      }
    });

    if (session case SessionAuthenticated(:final user)
        when !user.emailVerified &&
            !_confirms(ref.read(refreshedUserProvider))) {
      return EmailVerificationReminderState.visible(email: user.email);
    }
    return const EmailVerificationReminderState.hidden();
  }

  /// "Ya lo verifique": renueva la sesion, que trae el estado del servidor.
  Future<void> confirm() async {
    final current = state;
    if (current is! EmailVerificationReminderVisible || current.checking) {
      return;
    }
    state = current.copyWith(checking: true, stillPending: false, error: null);

    try {
      await ref.read(sessionRenewalProvider).renew();
    } on SessionExpiredException {
      // La sesion termino y el recordatorio se oculta con ella.
      return;
    } on CauceApiError catch (error) {
      if (state is EmailVerificationReminderVisible) {
        state = current.copyWith(stillPending: false, error: error);
      }
      return;
    }

    final verified = await _storedVerified(current.email);
    if (state is! EmailVerificationReminderVisible) {
      return;
    }
    state = verified
        ? const EmailVerificationReminderState.hidden()
        : current.copyWith(stillPending: true, error: null);
  }

  /// Vuelve a mirar el snapshot guardado, sin red ni aviso.
  Future<void> check() async {
    final current = state;
    if (current is! EmailVerificationReminderVisible || current.checking) {
      return;
    }
    final verified = await _storedVerified(current.email);
    if (verified && state is EmailVerificationReminderVisible) {
      state = const EmailVerificationReminderState.hidden();
    }
  }

  bool _confirms(AuthenticatedUserSnapshot? refreshed) {
    final session = ref.read(sessionNotifierProvider);
    return refreshed != null &&
        refreshed.emailVerified &&
        session is SessionAuthenticated &&
        refreshed.userId == session.user.userId;
  }

  Future<bool> _storedVerified(String email) async {
    try {
      final stored = await ref.read(tokenStorageProvider).readUserSnapshot();
      return stored != null && stored.email == email && stored.emailVerified;
    } on Object {
      // Un Keystore que no responde cuenta como "todavia no".
      return false;
    }
  }
}
