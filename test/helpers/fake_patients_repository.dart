import 'dart:typed_data';

import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/allergy.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';

/// Perfil clinico de referencia, con el onboarding todavia abierto.
///
/// Los valores son los del `DemoPatientSeeder` del backend, de modo que un
/// test que los cambie sin querer se nota contra el dato real.
final PatientProfile demoProfile = PatientProfile(
  profileId: 'a1b2c3d4-0000-4000-8000-000000000001',
  dateOfBirth: DateTime(1990, 5, 15),
  biologicalSex: BiologicalSexOption.female,
  weightKg: 62.5,
  heightCm: 162,
  bmi: 23.81,
  bmiCategory: BmiCategory.normal,
  age: 36,
  ibsSubtype: IbsSubtypeOption.ibsD,
  onboardingCompleted: false,
);

/// Borrador valido del formulario del paso 1.
final PatientProfileDraft demoDraft = PatientProfileDraft(
  dateOfBirth: DateTime(1990, 5, 15),
  biologicalSex: BiologicalSexOption.female,
  weightKg: 62.5,
  heightCm: 162,
  ibsSubtype: IbsSubtypeOption.ibsD,
);

/// Catalogo corto, con las tres naturalezas de reaccion representadas.
const List<AllergyCatalogEntry> demoCatalog = <AllergyCatalogEntry>[
  AllergyCatalogEntry(
    allergyId: 'aaaaaaaa-0000-4000-8000-000000000001',
    name: 'Gluten',
    type: AllergyTypeOption.intolerance,
  ),
  AllergyCatalogEntry(
    allergyId: 'aaaaaaaa-0000-4000-8000-000000000002',
    name: 'Mariscos',
    type: AllergyTypeOption.allergy,
  ),
  AllergyCatalogEntry(
    allergyId: 'aaaaaaaa-0000-4000-8000-000000000003',
    name: 'Sulfitos',
    type: AllergyTypeOption.sensitivity,
  ),
];

/// Consentimiento aceptado de referencia: la unica version publicada hoy.
final AcceptedConsent demoAcceptedConsent = AcceptedConsent(
  documentVersion: '1.0',
  acceptedAt: DateTime.utc(2026, 9, 12, 14, 5),
  textHash: '92169a2d08cb58170f4b6b0b0c7f5d3e9a1c2b4d6e8f0a1b2c3d4e5f60718293',
  textAvailable: true,
);

/// [PatientsRepository] controlable para tests de los notifiers.
///
/// Los errores se inyectan por metodo y no de forma global, porque el paso 1
/// del wizard encadena varias llamadas y los casos interesantes son justamente
/// los que fallan a mitad de camino.
class FakePatientsRepository implements PatientsRepository {
  FakePatientsRepository({
    this.profile,
    this.catalog = demoCatalog,
    this.delay = Duration.zero,
  });

  /// Lo que devuelve [fetchProfile]. `null` simula el 404 que el repositorio
  /// real traduce, es decir el estado "todavia no creo el perfil".
  PatientProfile? profile;

  List<AllergyCatalogEntry> catalog;

  /// Demora artificial, para observar el estado intermedio de envio.
  Duration delay;

  CauceApiError? fetchProfileError;
  CauceApiError? createProfileError;
  CauceApiError? catalogError;
  CauceApiError? consentPdfError;

  /// Lo que devuelve [acceptedConsent].
  AcceptedConsent acceptedConsentValue = demoAcceptedConsent;
  CauceApiError? acceptedConsentError;

  /// Error por `allergyId`, para simular que solo una declaracion falla.
  final Map<String, CauceApiError> declareAllergyErrors =
      <String, CauceApiError>{};

  int fetchProfileCalls = 0;
  final List<PatientProfileDraft> createdProfiles = <PatientProfileDraft>[];
  final List<AllergyDeclarationDraft> declaredAllergies =
      <AllergyDeclarationDraft>[];

  Future<void> _wait() => delay == Duration.zero
      ? Future<void>.value()
      : Future<void>.delayed(delay);

  @override
  Future<PatientProfile?> fetchProfile() async {
    fetchProfileCalls++;
    await _wait();
    final error = fetchProfileError;
    if (error != null) {
      throw error;
    }
    return profile;
  }

  @override
  Future<CreatedPatientProfile> createProfile(PatientProfileDraft draft) async {
    await _wait();
    final error = createProfileError;
    if (error != null) {
      throw error;
    }
    createdProfiles.add(draft);
    // El servidor pasa a tener perfil, con el onboarding todavia abierto.
    profile = demoProfile;
    return CreatedPatientProfile(
      profileId: 'a1b2c3d4-0000-4000-8000-000000000001',
      bmi: draft.bmi ?? 0,
      age: 36,
      bmiCategory: draft.bmiCategory,
      nutritionistAssigned: false,
    );
  }

  @override
  Future<List<AllergyCatalogEntry>> allergyCatalog() async {
    await _wait();
    final error = catalogError;
    if (error != null) {
      throw error;
    }
    return catalog;
  }

  @override
  Future<String> declareAllergy(AllergyDeclarationDraft draft) async {
    await _wait();
    final error = declareAllergyErrors[draft.allergyId];
    if (error != null) {
      throw error;
    }
    declaredAllergies.add(draft);
    return 'bbbbbbbb-0000-4000-8000-${declaredAllergies.length.toString().padLeft(12, '0')}';
  }

  @override
  Future<AcceptedConsent> acceptedConsent() async {
    await _wait();
    final error = acceptedConsentError;
    if (error != null) {
      throw error;
    }
    return acceptedConsentValue;
  }

  @override
  Future<ConsentPdf> consentPdf() async {
    await _wait();
    final error = consentPdfError;
    if (error != null) {
      throw error;
    }
    // Cabecera minima de un PDF real: basta para verificar que los bytes
    // llegan y no estan vacios, sin acarrear un archivo de prueba.
    return ConsentPdf(
      bytes: Uint8List.fromList('%PDF-1.7'.codeUnits),
      fileName: 'consentimiento-1.0.pdf',
    );
  }

  @override
  Future<NutritionistAssignment> assignNutritionist({
    required String invitationCode,
  }) async {
    await _wait();
    return NutritionistAssignment(
      nutritionistId: 'c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f',
      nutritionistFullName: 'Ana Quispe',
      assignedAt: DateTime.utc(2026, 9, 12, 14, 5),
    );
  }
}
