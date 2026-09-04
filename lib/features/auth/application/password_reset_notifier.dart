import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/auth_repository.dart';

part 'password_reset_notifier.freezed.dart';
part 'password_reset_notifier.g.dart';

/// Estado del restablecimiento con token del deep link (US07 CA02).
@freezed
sealed class PasswordResetState with _$PasswordResetState {
  const factory PasswordResetState.idle() = PasswordResetIdle;
  const factory PasswordResetState.submitting() = PasswordResetSubmitting;
  const factory PasswordResetState.success() = PasswordResetSuccess;
  const factory PasswordResetState.failure(CauceApiError error) =
      PasswordResetFailure;

  const PasswordResetState._();

  bool get isSubmitting => this is PasswordResetSubmitting;

  CauceApiError? get error => switch (this) {
        PasswordResetFailure(:final error) => error,
        _ => null,
      };

  /// `true` cuando el enlace ya no sirve y hay que pedir uno nuevo.
  ///
  /// La pantalla lo usa para ofrecer el atajo a la solicitud, en vez de
  /// dejar al paciente reintentando con un token muerto.
  bool get needsFreshLink => switch (this) {
        PasswordResetFailure(error: PasswordResetTokenError()) => true,
        _ => false,
      };
}

/// Gobierna la confirmacion del restablecimiento.
@riverpod
class PasswordResetNotifier extends _$PasswordResetNotifier {
  @override
  PasswordResetState build() => const PasswordResetState.idle();

  /// Confirma la contrasena nueva con el token del enlace.
  Future<bool> submit({
    required String token,
    required String newPassword,
  }) async {
    if (state.isSubmitting) {
      return false;
    }
    state = const PasswordResetState.submitting();

    try {
      await ref
          .read(authRepositoryProvider)
          .confirmPasswordReset(token: token, newPassword: newPassword);
      state = const PasswordResetState.success();
      return true;
    } on CauceApiError catch (error) {
      state = PasswordResetState.failure(error);
      return false;
    }
  }

  void clearError() {
    if (state is PasswordResetFailure) {
      state = const PasswordResetState.idle();
    }
  }
}
