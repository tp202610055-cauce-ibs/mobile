import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'allergy.freezed.dart';

/// Naturaleza de la reaccion, segun el catalogo cerrado del backend.
///
/// La distincion es clinica y no cosmetica: una alergia es inmunologica, una
/// intolerancia es digestiva y una sensibilidad es una reaccion adversa sin
/// mecanismo inmunologico confirmado. El motor de recomendaciones las trata
/// distinto, asi que el dato se conserva tal cual.
enum AllergyTypeOption {
  allergy,
  intolerance,
  sensitivity;

  static AllergyTypeOption? fromApi(api.AllergyType? value) {
    return switch (value) {
      api.AllergyType.allergy => AllergyTypeOption.allergy,
      api.AllergyType.intolerance => AllergyTypeOption.intolerance,
      api.AllergyType.sensitivity => AllergyTypeOption.sensitivity,
      _ => null,
    };
  }
}

/// Severidad declarada por el paciente para una alergia concreta.
enum AllergySeverityLevel {
  mild,
  moderate,
  severe;

  api.AllergySeverity toApi() => switch (this) {
        AllergySeverityLevel.mild => api.AllergySeverity.mild,
        AllergySeverityLevel.moderate => api.AllergySeverity.moderate,
        AllergySeverityLevel.severe => api.AllergySeverity.severe,
      };

  static AllergySeverityLevel? fromApi(api.AllergySeverity? value) {
    return switch (value) {
      api.AllergySeverity.mild => AllergySeverityLevel.mild,
      api.AllergySeverity.moderate => AllergySeverityLevel.moderate,
      api.AllergySeverity.severe => AllergySeverityLevel.severe,
      _ => null,
    };
  }
}

/// Entrada del catalogo cerrado que devuelve `GET /api/v1/allergies`.
///
/// El paciente no puede inventar alergias: elige de esta lista. El backend la
/// siembra con diez entradas relevantes para SII.
@freezed
abstract class AllergyCatalogEntry with _$AllergyCatalogEntry {
  const factory AllergyCatalogEntry({
    required String allergyId,
    required String name,
    AllergyTypeOption? type,
    String? description,
  }) = _AllergyCatalogEntry;

  const AllergyCatalogEntry._();
}

/// Alergia que el paciente marco en el formulario, todavia sin enviar.
///
/// Viaja hacia `POST /api/v1/patients/allergies`, una peticion por entrada: el
/// contrato no expone un endpoint de lote para esto.
@freezed
abstract class AllergyDeclarationDraft with _$AllergyDeclarationDraft {
  const factory AllergyDeclarationDraft({
    required String allergyId,
    required AllergySeverityLevel severity,
    String? notes,
  }) = _AllergyDeclarationDraft;

  const AllergyDeclarationDraft._();
}

/// Alergia ya declarada, tal como la devuelve el backend dentro del perfil.
@freezed
abstract class AllergyDeclaration with _$AllergyDeclaration {
  const factory AllergyDeclaration({
    required String patientAllergyId,
    required String allergyId,
    required String allergyName,
    AllergyTypeOption? type,
    AllergySeverityLevel? severity,
    String? notes,
    DateTime? declaredAt,
  }) = _AllergyDeclaration;

  const AllergyDeclaration._();
}
