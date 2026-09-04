import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/auth_repository.dart';
import 'session_notifier.dart';

part 'register_notifier.freezed.dart';
part 'register_notifier.g.dart';

/// Estado del formulario de registro (US01).
@freezed
sealed class RegisterState with _$RegisterState {
  const factory RegisterState.idle() = RegisterIdle;
  const factory RegisterState.submitting() = RegisterSubmitting;
  const factory RegisterState.success() = RegisterSuccess;
  const factory RegisterState.failure(CauceApiError error) = RegisterFailure;

  const RegisterState._();

  bool get isSubmitting => this is RegisterSubmitting;

  CauceApiError? get error => switch (this) {
        RegisterFailure(:final error) => error,
        _ => null,
      };

  /// `true` cuando el consentimiento cambio mientras el paciente completaba
  /// el formulario y hay que recargarlo antes de reintentar.
  bool get needsConsentReload => switch (this) {
        RegisterFailure(error: ConsentMismatchError()) => true,
        _ => false,
      };
}

/// Gobierna el envio del registro de paciente.
@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() => const RegisterState.idle();

  /// Registra al paciente y lo deja esperando la verificacion del correo.
  ///
  /// [consentDocumentVersion] y [consentTextHash] son los que devolvio
  /// `GET /consent/current`, reenviados sin recalcular.
  Future<bool> submit({
    required String email,
    required String fullName,
    required String password,
    required String consentDocumentVersion,
    required String consentTextHash,
    String? invitationCode,
  }) async {
    // 5 registros por hora por IP: un doble envio consume una quinta parte del
    // cupo de toda la red del hospital.
    if (state.isSubmitting) {
      return false;
    }
    state = const RegisterState.submitting();

    final trimmedEmail = email.trim();
    try {
      final result = await ref.read(authRepositoryProvider).register(
            email: trimmedEmail,
            fullName: fullName.trim(),
            password: password,
            consentDocumentVersion: consentDocumentVersion,
            consentTextHash: consentTextHash,
            invitationCode: invitationCode?.trim(),
          );

      // El registro no emite tokens, asi que no hay sesion que persistir. Solo
      // se publica el estado para que el guard lleve al aviso.
      ref
          .read(sessionNotifierProvider.notifier)
          .registrationSucceeded(email: result.email);

      state = const RegisterState.success();
      return true;
    } on CauceApiError catch (error) {
      state = RegisterState.failure(error);
      return false;
    }
  }

  void clearError() {
    if (state is RegisterFailure) {
      state = const RegisterState.idle();
    }
  }
}
