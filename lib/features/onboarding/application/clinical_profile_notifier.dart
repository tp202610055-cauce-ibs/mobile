import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../patients/data/patients_repository.dart';
import '../../patients/domain/allergy.dart';
import '../../patients/domain/patient_profile.dart';
import 'onboarding_notifier.dart';

part 'clinical_profile_notifier.freezed.dart';
part 'clinical_profile_notifier.g.dart';

/// Estado del envio del paso 1 del wizard (US03).
@freezed
sealed class ClinicalProfileState with _$ClinicalProfileState {
  const factory ClinicalProfileState.idle() = ClinicalProfileIdle;
  const factory ClinicalProfileState.submitting() = ClinicalProfileSubmitting;
  const factory ClinicalProfileState.success() = ClinicalProfileSuccess;
  const factory ClinicalProfileState.failure(CauceApiError error) =
      ClinicalProfileFailure;

  const ClinicalProfileState._();

  bool get isSubmitting => this is ClinicalProfileSubmitting;

  CauceApiError? get error => switch (this) {
        ClinicalProfileFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna el envio del perfil clinico y sus alergias.
///
/// El paso 1 no es una peticion sino una secuencia: primero el perfil y
/// despues una declaracion por alergia marcada, porque el contrato no expone
/// un endpoint de lote para alergias. El orden es obligatorio en el sentido de
/// que el perfil tiene que existir antes de que el paso 2 pueda enviarse.
@riverpod
class ClinicalProfileNotifier extends _$ClinicalProfileNotifier {
  @override
  ClinicalProfileState build() => const ClinicalProfileState.idle();

  /// Envia el perfil y las alergias. Devuelve `true` si todo prospero.
  Future<bool> submit({
    required PatientProfileDraft draft,
    List<AllergyDeclarationDraft> allergies = const <AllergyDeclarationDraft>[],
  }) async {
    // El perfil es unico por paciente: un doble envio deja al segundo
    // chocando contra un 409 que no aporta nada.
    if (state.isSubmitting) {
      return false;
    }
    state = const ClinicalProfileState.submitting();

    final repository = ref.read(patientsRepositoryProvider);

    try {
      await _createProfile(repository, draft);
      await _declareAllergies(repository, allergies);
    } on CauceApiError catch (error) {
      state = ClinicalProfileState.failure(error);

      // El 409 significa que el perfil ya existia, de modo que la vista local
      // del onboarding quedo vieja. Se relee para que el guard mande al paso
      // que de verdad falta en vez de insistir con este.
      if (error is DuplicateProfileError) {
        await ref.read(onboardingNotifierProvider.notifier).refresh();
      }
      return false;
    }

    ref.read(onboardingNotifierProvider.notifier).profileCreated();
    state = const ClinicalProfileState.success();
    return true;
  }

  /// Crea el perfil, tolerando que ya estuviera creado.
  ///
  /// Un 409 `duplicate_patient_profile` en un reintento significa que el envio
  /// anterior si entro y el dispositivo no vio la respuesta. Tratarlo como
  /// falla dejaria al paciente sin salida: el perfil existe y volver a
  /// enviarlo dara 409 siempre.
  ///
  /// Se distingue del 409 de un primer intento porque ahi la vista local se
  /// relee igual y el guard corrige el rumbo.
  Future<void> _createProfile(
    PatientsRepository repository,
    PatientProfileDraft draft,
  ) async {
    try {
      await repository.createProfile(draft);
    } on DuplicateProfileError {
      // Nada que hacer: el perfil esta creado, que es lo que este paso
      // buscaba. Se sigue con las alergias.
    }
  }

  /// Declara las alergias de a una.
  ///
  /// Un 409 `duplicate_patient_allergy` se trata como exito: en un reintento
  /// son las que ya entraron en el intento anterior, y volver a fallar por
  /// ellas dejaria el paso imposible de completar.
  ///
  /// Cualquier otro error si interrumpe la secuencia y llega a la pantalla.
  /// Un `allergy_not_found` significa que la entrada del catalogo se desactivo
  /// entre que se cargo la lista y se envio el formulario; el paciente la
  /// desmarca y reintenta, y el perfil ya creado no estorba porque el 409 del
  /// perfil se absorbe arriba.
  Future<void> _declareAllergies(
    PatientsRepository repository,
    List<AllergyDeclarationDraft> allergies,
  ) async {
    for (final allergy in allergies) {
      try {
        await repository.declareAllergy(allergy);
      } on DuplicateAllergyError {
        continue;
      }
    }
  }

  void clearError() {
    if (state is ClinicalProfileFailure) {
      state = const ClinicalProfileState.idle();
    }
  }
}
