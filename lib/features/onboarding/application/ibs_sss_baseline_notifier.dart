import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../ibs_sss/data/ibs_sss_repository.dart';
import '../../ibs_sss/domain/ibs_sss_baseline.dart';
import 'onboarding_notifier.dart';

part 'ibs_sss_baseline_notifier.freezed.dart';
part 'ibs_sss_baseline_notifier.g.dart';

/// Estado del paso 2 del wizard (US04).
///
/// Sostiene las respuestas mientras el paciente las completa, ademas del ciclo
/// de envio. A diferencia del paso 1, donde los campos viven en controladores
/// de texto, aca el dato es un mapa de cinco enteros y tenerlo en el notifier
/// permite validar la completitud sin recorrer el arbol de widgets.
@freezed
sealed class IbsSssBaselineState with _$IbsSssBaselineState {
  const factory IbsSssBaselineState({
    @Default(IbsSssBaselineAnswers()) IbsSssBaselineAnswers answers,
    @Default(false) bool submitting,

    /// Resultado devuelto por el servidor, disponible recien tras el envio.
    IbsSssBaselineResult? result,
    CauceApiError? error,
  }) = _IbsSssBaselineState;

  const IbsSssBaselineState._();

  /// `true` cuando las cinco dimensiones tienen respuesta (CA02).
  bool get canSubmit => answers.isComplete && !submitting;
}

/// Gobierna las respuestas y el envio de la linea base IBS-SSS.
@riverpod
class IbsSssBaselineNotifier extends _$IbsSssBaselineNotifier {
  @override
  IbsSssBaselineState build() => const IbsSssBaselineState();

  /// Registra la respuesta de una dimension.
  ///
  /// Limpia el error pendiente: si el paciente esta corrigiendo respuestas, el
  /// mensaje del envio anterior ya no describe lo que tiene en pantalla.
  void answer(IbsSssDimension dimension, int value) {
    state = state.copyWith(
      answers: state.answers.withAnswer(dimension, value),
      error: null,
    );
  }

  /// Envia la linea base. Devuelve `true` si el backend la acepto.
  ///
  /// Nada parcial sale del dispositivo (CA01 y CA02): sin las cinco
  /// dimensiones ni siquiera se intenta. La linea base es irrepetible, y una
  /// evaluacion incompleta gastaria la unica que el paciente puede registrar.
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    state = state.copyWith(submitting: true, error: null);

    try {
      final result = await ref
          .read(ibsSssRepositoryProvider)
          .submitBaseline(state.answers);

      state = state.copyWith(submitting: false, result: result);
      // El onboarding **no** se cierra aca. El servidor ya lo cerro, pero si
      // se publicara ese estado ahora el guard mandaria a la home en el acto y
      // el paciente nunca veria el resultado de su cuestionario. Lo cierra
      // [acknowledgeResult] cuando el paciente lo da por leido.
      return true;
    } on CauceApiError catch (error) {
      state = state.copyWith(submitting: false, error: error);
      await _reconcile(error);
      return false;
    }
  }

  /// Relee el estado del onboarding cuando el error revela que la vista local
  /// quedo vieja.
  ///
  /// Dos casos, los dos con la misma respuesta util:
  ///
  /// - **409 `duplicate_baseline_assessment`**: el envio anterior si entro. El
  ///   onboarding ya esta cerrado y reintentar solo repetiria el 409.
  /// - **404 `patient_profile_not_found`**: el backend guarda la evaluacion y
  ///   recien despues intenta cerrar el onboarding, asi que este 404 llega con
  ///   la linea base **ya persistida**. Reintentar daria 409. El wizard
  ///   secuencial hace inalcanzable este caso, y se contempla igual porque su
  ///   efecto en el servidor no es reversible desde el cliente.
  Future<void> _reconcile(CauceApiError error) async {
    if (error is DuplicateBaselineAssessmentError ||
        error is PatientProfileNotFoundError) {
      await ref.read(onboardingNotifierProvider.notifier).refresh();
    }
  }

  /// El paciente leyo el resultado y cierra el paso 2.
  ///
  /// Recien aca se publica el onboarding como completo, que es lo que hace que
  /// el guard lleve a la home. Es idempotente: sin resultado no hace nada, de
  /// modo que un toque repetido no altera el estado.
  void acknowledgeResult() {
    if (state.result == null) {
      return;
    }
    ref.read(onboardingNotifierProvider.notifier).baselineSubmitted();
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}
