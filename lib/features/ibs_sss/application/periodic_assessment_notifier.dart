import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/ibs_sss_repository.dart';
import '../domain/ibs_sss_assessment.dart';

part 'periodic_assessment_notifier.freezed.dart';
part 'periodic_assessment_notifier.g.dart';

/// Estado del cuestionario IBS-SSS periodico (US12).
@freezed
abstract class PeriodicAssessmentState with _$PeriodicAssessmentState {
  const factory PeriodicAssessmentState({
    @Default(IbsSssAnswers()) IbsSssAnswers answers,
    @Default(false) bool submitting,
    @Default(false) bool loading,

    /// Resultado del envio. **Solo existe despues de enviar** (CA04).
    IbsSssResult? result,

    /// Serie de evolucion, para el grafico de CA03.
    @Default(<IbsSssEvolutionPoint>[]) List<IbsSssEvolutionPoint> evolution,
    CauceApiError? error,
  }) = _PeriodicAssessmentState;

  const PeriodicAssessmentState._();

  /// `true` cuando las cinco dimensiones tienen respuesta.
  bool get canSubmit => answers.isComplete && !submitting;

  /// Dimensiones que faltan, en orden de presentacion.
  List<IbsSssDimension> get missing => answers.missing;

  /// Punto mas reciente de la serie.
  IbsSssEvolutionPoint? get latestPoint =>
      evolution.isEmpty ? null : evolution.last;

  /// `true` si la ultima evaluacion mejora la linea base de forma
  /// clinicamente significativa (reduccion de 50 puntos o mas).
  bool get showsSignificantImprovement =>
      latestPoint?.isClinicallySignificantImprovement ?? false;
}

/// Gobierna las respuestas y el envio de una evaluacion periodica.
///
/// **CA04 no necesita logica nueva.** El cliente nunca calcula el puntaje: manda
/// las cinco dimensiones y recibe `totalScore` y la categoria ya resueltos por
/// el servidor. No exponerlo antes del envio no es una regla de pantalla que
/// haya que respetar, es la forma en que esta construido el flujo entero: el
/// numero no existe de este lado hasta que el servidor lo devuelve.
@riverpod
class PeriodicAssessmentNotifier extends _$PeriodicAssessmentNotifier {
  @override
  PeriodicAssessmentState build() => const PeriodicAssessmentState();

  /// Trae la serie de evolucion para el grafico de CA03.
  ///
  /// Un fallo deja el grafico vacio sin bloquear el cuestionario: responderlo
  /// es lo importante, y verlo en contexto es una mejora.
  Future<void> loadEvolution() async {
    state = state.copyWith(loading: true);
    try {
      final evolution = await ref.read(ibsSssRepositoryProvider).evolution();
      state = state.copyWith(loading: false, evolution: evolution);
    } on CauceApiError {
      state = state.copyWith(
        loading: false,
        evolution: const <IbsSssEvolutionPoint>[],
      );
    }
  }

  /// Registra la respuesta de una dimension.
  void answer(IbsSssDimension dimension, int value) {
    state = state.copyWith(
      answers: state.answers.withAnswer(dimension, value),
      error: null,
    );
  }

  /// Envia la evaluacion periodica. Devuelve `true` si el backend la acepto.
  ///
  /// Nada parcial sale del dispositivo: sin las cinco dimensiones ni siquiera
  /// se intenta, con el mismo criterio que la linea base.
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    state = state.copyWith(submitting: true, error: null);

    try {
      final result = await ref.read(ibsSssRepositoryProvider).submit(
            state.answers,
            assessmentType: IbsSssAssessmentType.periodic,
          );

      state = state.copyWith(submitting: false, result: result);
      // Recien ahora la serie incluye lo que el paciente acaba de responder.
      await loadEvolution();
      return true;
    } on CauceApiError catch (error) {
      state = state.copyWith(submitting: false, error: error);
      return false;
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}

/// Serie de evolucion del paciente, de la linea base en adelante.
///
/// La consume la tarjeta de Inicio para mostrar el cambio contra la linea
/// base. No es un endpoint nuevo: `GET /ibs-sss/evolution` ya se consumia
/// desde el cuestionario periodico (US12 CA03). El grafico grande con eje
/// temporal llega en Mobile-4 con HU0023.
@riverpod
Future<List<IbsSssEvolutionPoint>> ibsSssEvolution(Ref ref) {
  return ref.watch(ibsSssRepositoryProvider).evolution();
}

/// Evaluacion IBS-SSS mas reciente del paciente.
///
/// Alimenta el aviso de la home: su `nextAssessmentDate` dice cuando vence el
/// ciclo de catorce dias que agenda el backend.
@riverpod
Future<IbsSssAssessmentSummaryData?> latestIbsSssAssessment(Ref ref) {
  return ref.watch(ibsSssRepositoryProvider).latestAssessment();
}
