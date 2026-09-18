import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/custom_foods_repository.dart';
import '../domain/custom_food.dart';
import '../domain/nutrition_estimator.dart';

part 'custom_food_form_notifier.freezed.dart';
part 'custom_food_form_notifier.g.dart';

/// Estado del constructor de platos personalizados (US10).
@freezed
abstract class CustomFoodFormState with _$CustomFoodFormState {
  const factory CustomFoodFormState({
    @Default(CustomFoodDraft()) CustomFoodDraft draft,
    @Default(false) bool submitting,

    /// Platos que el paciente ya tiene. Alimenta el rechazo por nombre
    /// duplicado antes de enviar (CA02).
    @Default(<CustomFoodRecord>[]) List<CustomFoodRecord> existing,

    /// Coincidencias que devolvio el servidor y que el paciente todavia no
    /// reconocio (CA03). Mientras no este vacia, la pantalla muestra la
    /// advertencia en vez del formulario.
    @Default(<DetectedAllergen>[]) List<DetectedAllergen> pendingAllergens,

    /// Identificador del plato ya creado, tras un envio exitoso.
    String? createdId,
    CauceApiError? error,
  }) = _CustomFoodFormState;

  const CustomFoodFormState._();

  /// Nombres ya usados, en minusculas, para comparar sin distinguir caja.
  Set<String> get existingNames =>
      existing.map((record) => record.name.trim().toLowerCase()).toSet();

  List<CustomFoodIssue> get issues =>
      draft.issues(existingNames: existingNames);

  bool get canSubmit =>
      draft.canSubmit(existingNames: existingNames) && !submitting;

  /// Perfil nutricional estimado del plato (CA01, CP025).
  NutritionEstimate? get estimate =>
      NutritionEstimator.estimate(draft.ingredients);

  /// `true` mientras haya alergenos esperando confirmacion.
  bool get awaitingAllergenConfirmation => pendingAllergens.isNotEmpty;
}

/// Gobierna el armado, la validacion y el envio de un plato personalizado.
@riverpod
class CustomFoodFormNotifier extends _$CustomFoodFormNotifier {
  @override
  CustomFoodFormState build() => const CustomFoodFormState();

  /// Carga los platos que el paciente ya tiene.
  ///
  /// Un fallo no bloquea el formulario: sin la lista se pierde el rechazo
  /// instantaneo por nombre duplicado, y el 409 del servidor sigue siendo la
  /// autoridad final de todos modos.
  Future<void> loadExisting() async {
    try {
      final existing = await ref.read(customFoodsRepositoryProvider).list();
      state = state.copyWith(existing: existing);
    } on CauceApiError {
      state = state.copyWith(existing: const <CustomFoodRecord>[]);
    }
  }

  void setName(String name) {
    state = state.copyWith(
      draft: state.draft.copyWith(name: name),
      error: null,
    );
  }

  void setPortion(double portionSizeGrams) {
    state = state.copyWith(
      draft: state.draft.copyWith(portionSizeGrams: portionSizeGrams),
      error: null,
    );
  }

  /// Agrega un ingrediente. Si ya estaba, suma la proporcion.
  void addIngredient(CustomFoodIngredientDraft ingredient) {
    state = state.copyWith(
      draft: state.draft.withIngredient(ingredient),
      // Cambiar los ingredientes invalida la advertencia anterior: el cruce hay
      // que rehacerlo contra la composicion nueva.
      pendingAllergens: const <DetectedAllergen>[],
      error: null,
    );
  }

  void removeIngredientAt(int index) {
    state = state.copyWith(
      draft: state.draft.withoutIngredientAt(index),
      pendingAllergens: const <DetectedAllergen>[],
    );
  }

  /// Envia el plato sin confirmar alergenos (CA03, primer intento).
  ///
  /// Devuelve `true` si el plato quedo creado. Un 409 `unconfirmed_allergens`
  /// **no** es un fracaso: deja las coincidencias en el estado para que la
  /// pantalla pida la confirmacion explicita.
  Future<bool> submit() => _send(confirmedAllergens: false);

  /// Reenvia tras la confirmacion explicita del paciente (CA03, CP027).
  Future<bool> confirmAllergensAndSubmit() {
    if (!state.awaitingAllergenConfirmation) {
      return Future<bool>.value(false);
    }
    return _send(confirmedAllergens: true);
  }

  /// El paciente decidio no seguir con las coincidencias detectadas.
  ///
  /// Vuelve al formulario con todo cargado, para que pueda sacar el ingrediente
  /// en vez de perder el plato entero.
  void cancelAllergenConfirmation() {
    state = state.copyWith(pendingAllergens: const <DetectedAllergen>[]);
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  void reset() {
    state = CustomFoodFormState(existing: state.existing);
  }

  Future<bool> _send({required bool confirmedAllergens}) async {
    if (state.submitting ||
        !state.draft.canSubmit(
          existingNames: state.existingNames,
        )) {
      return false;
    }
    state = state.copyWith(submitting: true, error: null);

    try {
      final id = await ref.read(customFoodsRepositoryProvider).create(
            state.draft,
            confirmedAllergens: confirmedAllergens,
          );

      state = state.copyWith(
        submitting: false,
        createdId: id,
        pendingAllergens: const <DetectedAllergen>[],
      );
      return true;
    } on UnconfirmedAllergensError catch (error) {
      // No es un error terminal: es el paso intermedio del flujo. El cruce lo
      // hizo el servidor contra las alergias del perfil, y el cliente solo lo
      // muestra y pide confirmacion.
      state = state.copyWith(
        submitting: false,
        pendingAllergens: error.allergens,
      );
      return false;
    } on CauceApiError catch (error) {
      state = state.copyWith(submitting: false, error: error);
      return false;
    }
  }
}
