import '../../../../core/errors/cauce_api_error.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/custom_food.dart';

/// Traduce los enums del constructor de platos al texto que ve el paciente.
///
/// Mismo criterio que `OnboardingLabels` y `MealLabels`: un `switch` exhaustivo
/// en un solo lugar, de modo que agregar un valor falle en compilacion aca.
abstract final class CustomFoodLabels {
  static String issue(AppLocalizations l10n, CustomFoodIssue v) => switch (v) {
        CustomFoodIssue.invalidName => l10n.customFoodIssueInvalidName,
        CustomFoodIssue.duplicateName => l10n.customFoodIssueDuplicateName,
        CustomFoodIssue.invalidPortion => l10n.customFoodIssueInvalidPortion,
        CustomFoodIssue.noIngredients => l10n.customFoodIssueNoIngredients,
        CustomFoodIssue.invalidProportion =>
          l10n.customFoodIssueInvalidProportion,
        CustomFoodIssue.duplicateIngredient =>
          l10n.customFoodIssueDuplicateIngredient,
      };

  /// Severidad de una alergia detectada (CA03).
  ///
  /// El caso `null` se trata de forma explicita y no se degrada a un valor
  /// concreto: el servidor mando una severidad que el cliente no reconoce, y
  /// atribuirle una inventada seria peor que decir que no se sabe. La
  /// coincidencia se muestra igual, que es lo que el paciente necesita saber.
  static String allergenSeverity(
    AppLocalizations l10n,
    DetectedAllergenSeverity? v,
  ) =>
      switch (v) {
        DetectedAllergenSeverity.mild => l10n.customFoodAllergenSeverityMild,
        DetectedAllergenSeverity.moderate =>
          l10n.customFoodAllergenSeverityModerate,
        DetectedAllergenSeverity.severe =>
          l10n.customFoodAllergenSeveritySevere,
        null => l10n.customFoodAllergenSeverityUnknown,
      };
}
