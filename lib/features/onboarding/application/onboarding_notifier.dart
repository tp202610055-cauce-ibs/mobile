import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/session_notifier.dart';
import '../../auth/domain/session_state.dart';
import '../../patients/data/patients_repository.dart';

part 'onboarding_notifier.freezed.dart';
part 'onboarding_notifier.g.dart';

/// Los dos pasos del wizard, en orden.
///
/// El orden no es cosmetico: el backend exige que el perfil exista antes de
/// aceptar la linea base. `CompletePatientOnboardingCommand` lanza
/// `PatientProfileNotFoundException` si no lo encuentra, y para entonces la
/// evaluacion ya quedo persistida.
enum OnboardingStep { clinicalProfile, ibsSssBaseline }

/// Situacion del onboarding clinico del paciente (US03 y US04).
///
/// No vive dentro de [SessionState] a proposito: la sesion es identidad, y el
/// perfil clinico es otra cosa. Mezclarlos ataria el bootstrap del arranque,
/// que hoy solo lee el Keystore, a una llamada protegida contra el backend.
@freezed
sealed class OnboardingState with _$OnboardingState {
  /// Falta completar [step]. El guard lleva al wizard.
  const factory OnboardingState.pending(OnboardingStep step) =
      OnboardingPending;

  /// El paciente eligio aplazar (CA05). Sigue faltando [step], pero puede usar
  /// el resto de la app y el recordatorio se muestra en el tablero.
  ///
  /// **Dura lo que dura la sesion de la app.** No se persiste, de modo que el
  /// proximo arranque en frio vuelve a ofrecer el wizard. Es deliberado: la
  /// linea base es el punto de comparacion de todo el piloto.
  const factory OnboardingState.deferred(OnboardingStep step) =
      OnboardingDeferred;

  /// Perfil creado y linea base registrada.
  const factory OnboardingState.completed() = OnboardingCompleted;

  /// No se pudo determinar, o la pregunta no aplica.
  ///
  /// Cubre dos casos que para el guard son el mismo: no hay sesion
  /// autenticada, o la hay pero la consulta al perfil no prospero. En los dos
  /// el guard no redirige, que es lo correcto en una app offline-first: sin
  /// red el paciente sigue usando el resto en vez de quedar atrapado.
  const factory OnboardingState.unavailable() = OnboardingUnavailable;

  const OnboardingState._();

  /// Paso pendiente, si lo hay.
  OnboardingStep? get step => switch (this) {
        OnboardingPending(:final step) => step,
        OnboardingDeferred(:final step) => step,
        OnboardingCompleted() || OnboardingUnavailable() => null,
      };

  /// `true` cuando el guard debe llevar al wizard.
  bool get requiresWizard => this is OnboardingPending;

  /// `true` cuando el tablero debe mostrar el recordatorio.
  bool get showsReminder => this is OnboardingDeferred;
}

/// Resuelve y gobierna el estado del onboarding clinico.
///
/// `keepAlive` porque el guard del router lo consulta en cada navegacion y
/// recalcularlo por pantalla dispararia una peticion de mas cada vez.
///
/// Observa la sesion en vez de exponer un bootstrap que alguien deba invocar:
/// cuando el paciente entra, el estado se resuelve solo, y cuando cierra
/// sesion se descarta. Un login nuevo vuelve a preguntarle al servidor, que es
/// lo que hace que aplazar no sobreviva al cambio de cuenta.
@Riverpod(keepAlive: true)
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  Future<OnboardingState> build() async {
    final session = ref.watch(sessionNotifierProvider);

    // Sin sesion valida no hay perfil que consultar. El correo sin verificar
    // tampoco cuenta: ese paciente esta confinado a una sola pantalla.
    if (session is! SessionAuthenticated) {
      return const OnboardingState.unavailable();
    }

    return _resolve();
  }

  /// Aplaza el paso pendiente (US03 CA05, US04 CA05).
  ///
  /// No avisa al backend: no existe endpoint para "aplazado" y no haria falta,
  /// porque el servidor ya sabe que el onboarding esta incompleto. Lo que
  /// cambia es solo si esta app insiste ahora o espera.
  void defer() {
    final current = state.valueOrNull;
    if (current is! OnboardingPending) {
      return;
    }
    state = AsyncData(OnboardingState.deferred(current.step));
  }

  /// Reanuda el wizard desde el recordatorio del tablero.
  void resume() {
    final current = state.valueOrNull;
    if (current is! OnboardingDeferred) {
      return;
    }
    state = AsyncData(OnboardingState.pending(current.step));
  }

  /// El paso 1 quedo guardado en el servidor.
  ///
  /// Se publica el estado directamente en vez de releer el perfil: la
  /// respuesta del `POST` ya confirmo que existe, y una consulta extra solo
  /// agregaria latencia entre los dos pasos del wizard.
  void profileCreated() {
    state = const AsyncData(
      OnboardingState.pending(OnboardingStep.ibsSssBaseline),
    );
  }

  /// La linea base quedo registrada y el backend cerro el onboarding.
  void baselineSubmitted() {
    state = const AsyncData(OnboardingState.completed());
  }

  /// Vuelve a preguntarle al servidor.
  ///
  /// Lo invoca quien detecta que la vista local quedo vieja: un 409
  /// `duplicate_patient_profile` o `duplicate_baseline_assessment` significa
  /// que el envio anterior si entro aunque el dispositivo no vio la respuesta.
  Future<void> refresh() async {
    state = const AsyncLoading<OnboardingState>().copyWithPrevious(state);
    state = await AsyncValue.guard(_resolve);
  }

  /// Traduce el perfil del backend a los tres estados posibles.
  ///
  /// `fetchProfile()` devuelve `null` ante el 404 `patient_profile_not_found`,
  /// que en este flujo significa "todavia no creo el perfil" y no un fallo.
  /// Cualquier otro error se propaga y termina en [AsyncError], que el guard
  /// lee como [OnboardingUnavailable].
  Future<OnboardingState> _resolve() async {
    final profile = await ref.read(patientsRepositoryProvider).fetchProfile();

    if (profile == null) {
      return const OnboardingState.pending(OnboardingStep.clinicalProfile);
    }
    return profile.onboardingCompleted
        ? const OnboardingState.completed()
        : const OnboardingState.pending(OnboardingStep.ibsSssBaseline);
  }
}

/// Estado del onboarding ya resuelto, listo para el guard del router.
///
/// El guard necesita un valor sincronico y no un `AsyncValue`: se evalua en
/// cada navegacion y no puede esperar. Mientras la consulta esta en vuelo, o
/// si fallo, devuelve [OnboardingUnavailable], que se traduce en "no
/// redirigir".
@Riverpod(keepAlive: true)
OnboardingState resolvedOnboarding(Ref ref) {
  return ref.watch(onboardingNotifierProvider).maybeWhen(
        data: (OnboardingState state) => state,
        orElse: () => const OnboardingState.unavailable(),
      );
}
