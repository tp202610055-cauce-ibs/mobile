import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/auth_repository.dart';

part 'password_recovery_notifier.freezed.dart';
part 'password_recovery_notifier.g.dart';

/// Estado de la solicitud de recuperacion (US07 CA01).
@freezed
sealed class PasswordRecoveryState with _$PasswordRecoveryState {
  const factory PasswordRecoveryState.idle() = PasswordRecoveryIdle;
  const factory PasswordRecoveryState.submitting() = PasswordRecoverySubmitting;

  /// El backend acepto la solicitud.
  ///
  /// No significa que el correo exista: el backend responde 200 en ambos casos
  /// para no filtrar si una cuenta esta registrada.
  const factory PasswordRecoveryState.sent() = PasswordRecoverySent;

  const factory PasswordRecoveryState.failure(CauceApiError error) =
      PasswordRecoveryFailure;

  const PasswordRecoveryState._();

  bool get isSubmitting => this is PasswordRecoverySubmitting;

  CauceApiError? get error => switch (this) {
        PasswordRecoveryFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna el envio del enlace de recuperacion.
@riverpod
class PasswordRecoveryNotifier extends _$PasswordRecoveryNotifier {
  @override
  PasswordRecoveryState build() => const PasswordRecoveryState.idle();

  /// Solicita el enlace. Devuelve `true` si el backend lo acepto.
  Future<bool> submit({required String email}) async {
    if (state.isSubmitting) {
      return false;
    }
    state = const PasswordRecoveryState.submitting();

    try {
      await ref
          .read(authRepositoryProvider)
          .requestPasswordReset(email: email.trim());
      state = const PasswordRecoveryState.sent();
      return true;
    } on CauceApiError catch (error) {
      state = PasswordRecoveryState.failure(error);
      return false;
    }
  }

  void clearError() {
    if (state is PasswordRecoveryFailure) {
      state = const PasswordRecoveryState.idle();
    }
  }
}
