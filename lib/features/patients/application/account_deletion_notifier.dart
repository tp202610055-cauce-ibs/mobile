import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/token_storage_provider.dart';
import '../../../core/errors/cauce_api_error.dart';
import '../../auth/application/session_notifier.dart';
import '../data/patients_repository.dart';

part 'account_deletion_notifier.freezed.dart';
part 'account_deletion_notifier.g.dart';

/// Estado de la baja de cuenta (HU0026).
@freezed
sealed class AccountDeletionState with _$AccountDeletionState {
  const factory AccountDeletionState.idle() = AccountDeletionIdle;
  const factory AccountDeletionState.deleting() = AccountDeleting;

  /// El backend confirmo la baja y la sesion local ya se cerro.
  const factory AccountDeletionState.deleted() = AccountDeleted;

  const factory AccountDeletionState.failure(CauceApiError error) =
      AccountDeletionFailure;

  const AccountDeletionState._();

  bool get isDeleting => this is AccountDeleting;

  CauceApiError? get error => switch (this) {
        AccountDeletionFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna la baja de cuenta, una vez que el paciente ya confirmo.
///
/// **No muestra la segunda confirmacion.** Informa si hace falta
/// ([requiresPilotAcknowledgement]), y la pantalla es quien la muestra y quien
/// sabe si el paciente la otorgo. Aca llega el resultado de esa decision, ya
/// tomada.
@riverpod
class AccountDeletionNotifier extends _$AccountDeletionNotifier {
  @override
  AccountDeletionState build() => const AccountDeletionState.idle();

  /// Si el paciente participa de un piloto activo y la baja necesita el acuse.
  ///
  /// **Lee el snapshot guardado, no el de memoria.** Desde el acta M49 el
  /// refresh reescribe el guardado con el usuario vigente pero no lo publica
  /// en la sesion, para no reconstruir el router cada 15 minutos. El guardado
  /// es entonces el mas fresco que tiene el dispositivo. Si no hay ninguno se
  /// cae al de memoria, que es el del login.
  ///
  /// Aunque los dos esten viejos, el backend tiene la ultima palabra: sin el
  /// acuse responde 409 `active_pilot_retention` y no borra nada.
  Future<bool> requiresPilotAcknowledgement() async {
    final stored = await ref.read(tokenStorageProvider).readUserSnapshot();
    return stored?.isInActivePilot ??
        ref.read(sessionNotifierProvider).user?.isInActivePilot ??
        false;
  }

  /// Ejecuta la baja y cierra la sesion local.
  ///
  /// [activePilotAcknowledged] es la segunda confirmacion de CP067. Sin ella,
  /// un paciente con piloto activo recibe 409 y **no se borra nada**, que es
  /// exactamente lo que el caso de prueba pide comprobar.
  ///
  /// Al recibir 204 se cierra la sesion: el guard del router lleva al login en
  /// cuanto el estado pasa a no autenticado. La pantalla no navega sola.
  Future<bool> delete({required bool activePilotAcknowledged}) async {
    if (state.isDeleting) {
      return false;
    }
    state = const AccountDeletionState.deleting();

    try {
      await ref.read(patientsRepositoryProvider).deleteAccount(
            activePilotAcknowledged: activePilotAcknowledged,
          );
    } on CauceApiError catch (error) {
      state = AccountDeletionState.failure(error);
      return false;
    }

    // La cuenta ya no existe del lado del servidor. El cierre de sesion local
    // va despues y no dentro del `try`: si el aviso de logout fallara, la baja
    // ya ocurrio y dejar la sesion abierta seria peor.
    await ref.read(sessionNotifierProvider.notifier).logout();
    state = const AccountDeletionState.deleted();
    return true;
  }

  void clearError() {
    if (state is AccountDeletionFailure) {
      state = const AccountDeletionState.idle();
    }
  }
}
