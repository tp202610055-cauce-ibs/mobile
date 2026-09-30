import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/auth_repository.dart';

part 'resend_verification_notifier.freezed.dart';
part 'resend_verification_notifier.g.dart';

/// Estado del reenvio del correo de verificacion (US01 CA01).
@freezed
sealed class ResendVerificationState with _$ResendVerificationState {
  const factory ResendVerificationState.idle() = ResendVerificationIdle;
  const factory ResendVerificationState.sending() = ResendVerificationSending;

  /// El backend acepto el pedido.
  ///
  /// El acuse es generico a proposito: el backend responde 200 aunque la
  /// cuenta no exista o ya este verificada, para no revelar cuales hay.
  const factory ResendVerificationState.sent() = ResendVerificationSent;

  const factory ResendVerificationState.failure(CauceApiError error) =
      ResendVerificationFailure;

  const ResendVerificationState._();

  bool get isSending => this is ResendVerificationSending;

  CauceApiError? get error => switch (this) {
        ResendVerificationFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna el reenvio del correo de verificacion.
///
/// `AuthRepository.resendVerificationEmail` existia desde Mobile-1.5 y nadie lo
/// llamaba: la pantalla de verificacion pendiente derivaba a un "soporte" que
/// no existe. El limite lo pone el backend, tres por hora por correo, y un
/// cuarto intento vuelve como 429 con su espera: se muestra ese error en vez
/// de duplicar la regla con un temporizador en el cliente.
@riverpod
class ResendVerificationNotifier extends _$ResendVerificationNotifier {
  @override
  ResendVerificationState build() => const ResendVerificationState.idle();

  /// Pide un correo nuevo. Devuelve `true` si el backend lo acepto.
  Future<bool> resend({required String email}) async {
    if (state.isSending || email.trim().isEmpty) {
      return false;
    }
    state = const ResendVerificationState.sending();

    try {
      await ref
          .read(authRepositoryProvider)
          .resendVerificationEmail(email: email.trim());
      state = const ResendVerificationState.sent();
      return true;
    } on CauceApiError catch (error) {
      state = ResendVerificationState.failure(error);
      return false;
    }
  }
}
