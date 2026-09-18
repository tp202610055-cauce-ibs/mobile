import '../../../../l10n/generated/app_localizations.dart';
import '../../../foods/domain/food_item.dart';
import '../../domain/meal_draft.dart';

/// Traduce los enums del registro de comidas al texto que ve el paciente.
///
/// Mismo criterio que `OnboardingLabels`: un `switch` exhaustivo en un solo
/// lugar, de modo que agregar un valor al dominio falle en compilacion aca y no
/// pase inadvertido en cuatro pantallas.
abstract final class MealLabels {
  static String mealTime(AppLocalizations l10n, MealTimeOption v) =>
      switch (v) {
        MealTimeOption.breakfast => l10n.mealTimeBreakfast,
        MealTimeOption.lunch => l10n.mealTimeLunch,
        MealTimeOption.dinner => l10n.mealTimeDinner,
        MealTimeOption.snack => l10n.mealTimeSnack,
      };

  static String unit(AppLocalizations l10n, MeasurementUnitOption v) =>
      switch (v) {
        MeasurementUnitOption.grams => l10n.measurementUnitGrams,
        MeasurementUnitOption.cups => l10n.measurementUnitCups,
        MeasurementUnitOption.units => l10n.measurementUnitUnits,
        MeasurementUnitOption.ounces => l10n.measurementUnitOunces,
        MeasurementUnitOption.tablespoons => l10n.measurementUnitTablespoons,
      };

  /// Carga FODMAP de la comida, en registro clinico neutro.
  ///
  /// Sin colores de alarma ni adjetivos: es una medicion que el nutricionista
  /// interpreta, no un veredicto sobre lo que el paciente comio.
  static String fodmapLoad(AppLocalizations l10n, FodmapLoad v) => switch (v) {
        FodmapLoad.low => l10n.mealsFodmapLow,
        FodmapLoad.moderate => l10n.mealsFodmapModerate,
        FodmapLoad.high => l10n.mealsFodmapHigh,
      };

  /// Motivo por el que el envio esta bloqueado (CA04).
  static String issue(AppLocalizations l10n, MealDraftIssue v) => switch (v) {
        MealDraftIssue.missingMealTime => l10n.mealsIssueMissingMealTime,
        MealDraftIssue.noItems => l10n.mealsIssueNoItems,
        MealDraftIssue.tooManyItems => l10n.mealsIssueTooManyItems,
        MealDraftIssue.invalidQuantity => l10n.mealsIssueInvalidQuantity,
        MealDraftIssue.invalidReference => l10n.mealsIssueInvalidReference,
        MealDraftIssue.futureConsumedAt => l10n.mealsIssueFutureConsumedAt,
      };
}
