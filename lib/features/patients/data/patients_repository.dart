import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/allergy.dart';
import '../domain/patient_profile.dart';

part 'patients_repository.g.dart';

/// Resultado de crear el perfil clinico (US03).
class CreatedPatientProfile {
  const CreatedPatientProfile({
    required this.profileId,
    required this.bmi,
    required this.age,
    required this.nutritionistAssigned,
    this.bmiCategory,
  });

  final String profileId;

  /// IMC calculado por el servidor. Es el autoritativo: el que muestra el
  /// formulario mientras el paciente escribe es una vista previa.
  final double bmi;

  final int age;
  final BmiCategory? bmiCategory;

  /// `true` si al crear el perfil el backend vinculo tambien al nutricionista
  /// del codigo de invitacion usado en el registro.
  final bool nutritionistAssigned;
}

/// Vinculo establecido entre el paciente y su nutricionista (US20 CA02).
class NutritionistAssignment {
  const NutritionistAssignment({
    required this.nutritionistId,
    required this.nutritionistFullName,
    required this.assignedAt,
  });

  /// Identificador de la cuenta del nutricionista.
  final String nutritionistId;

  final String nutritionistFullName;

  /// Momento de la asignacion, siempre en UTC.
  final DateTime assignedAt;
}

/// Acceso a los endpoints del paciente autenticado.
///
/// Hermano de `AuthRepository` y separado de el a proposito (acta M29): todo
/// lo que vive aca exige un Bearer valido y la politica `Patient` del backend,
/// mientras que identidad es anonima o casi. Un 401 o un 403 significan cosas
/// distintas en cada uno.
///
/// Misma frontera que `AuthRepository`: hacia adentro habla `built_value` y
/// `DioException`; hacia afuera solo tipos del dominio y [CauceApiError].
class PatientsRepository {
  const PatientsRepository(this._api, this._allergiesApi);

  final PatientsApi _api;

  /// El catalogo de alergias vive en su propio tag del contrato porque el
  /// backend lo expone a cualquier autenticado. Se consume desde aca igual:
  /// su unico lector en el movil es el formulario de perfil del paciente, y
  /// un repositorio con un solo metodo de lectura no se sostendria solo.
  final AllergiesApi _allergiesApi;

  /// US20 CA02. `POST /api/v1/patients/me/nutritionist-assignment`.
  ///
  /// Canjea un codigo de invitacion despues del registro. Cierra el callejon
  /// sin salida de quien se registro sin codigo y no tenia forma de vincularse
  /// a un nutricionista.
  ///
  /// El backend normaliza el codigo a mayusculas y recorta los espacios
  /// envolventes, con las mismas reglas que el registro (longitud 8 a 20,
  /// `^[A-Z0-9]+$`). Se envia tal cual lo tipeo el paciente: normalizarlo aca
  /// tambien duplicaria una regla que el servidor ya aplica.
  ///
  /// **El codigo no se consume si el canje falla.** Todas las comprobaciones,
  /// incluida la disponibilidad del nutricionista, ocurren antes de marcarlo
  /// como usado, de modo que ante un [NutritionistNotAvailableError] el mismo
  /// codigo sigue sirviendo mas tarde.
  Future<NutritionistAssignment> assignNutritionist({
    required String invitationCode,
  }) {
    return _guard(() async {
      final response = await _api.apiV1PatientsMeNutritionistAssignmentPost(
        assignNutritionistRequest: AssignNutritionistRequest(
          (b) => b..invitationCode = invitationCode,
        ),
      );
      final result = response.data;
      final nutritionistId = result?.nutritionistId;
      final assignedAt = result?.assignedAt;

      if (nutritionistId == null || assignedAt == null) {
        throw const FormatException(
          'El canje respondio sin nutritionistId o sin assignedAt.',
        );
      }

      return NutritionistAssignment(
        nutritionistId: nutritionistId,
        // El nombre solo alimenta el mensaje de confirmacion. Si faltara, la
        // vinculacion ya ocurrio y no tiene sentido invalidarla por eso.
        nutritionistFullName: result?.nutritionistFullName ?? '',
        assignedAt: assignedAt.toUtc(),
      );
    });
  }

  /// US03. `GET /api/v1/patients/profile`.
  ///
  /// Devuelve `null` cuando el paciente todavia no creo su perfil.
  ///
  /// El 404 `patient_profile_not_found` se atrapa aca a proposito. En el
  /// onboarding no es una falla sino un estado legitimo, el de "paso 1
  /// pendiente", y propagarlo como error obligaria a cada consumidor a
  /// desempaquetar un [CauceApiError] para distinguir "no existe" de "no se
  /// pudo consultar". El resto de los errores sigue propagandose: un 401, un
  /// 429 o un 500 no significan que el perfil no exista.
  Future<PatientProfile?> fetchProfile() async {
    try {
      return await _guard(() async {
        final response = await _api.apiV1PatientsProfileGet();
        return _toProfile(response.data);
      });
    } on PatientProfileNotFoundError {
      return null;
    }
  }

  /// US03 CA01. `POST /api/v1/patients/profile`.
  ///
  /// El endpoint no acepta `Idempotency-Key`: el contrato no lo declara para
  /// este recurso. La proteccion contra el doble envio es el 409
  /// `duplicate_patient_profile`, que la capa de aplicacion interpreta como
  /// "ya estaba creado" y no como falla.
  Future<CreatedPatientProfile> createProfile(PatientProfileDraft draft) {
    return _guard(() async {
      final response = await _api.apiV1PatientsProfilePost(
        createPatientProfileRequest: CreatePatientProfileRequest(
          (b) => b
            ..dateOfBirth = _toDate(draft.dateOfBirth)
            ..biologicalSex = draft.biologicalSex.toApi()
            ..weightKg = draft.weightKg
            ..heightCm = draft.heightCm
            ..ibsSubtype = draft.ibsSubtype.toApi()
            ..diagnosisDate = _toNullableDate(draft.diagnosisDate)
            ..medications = _blankToNull(draft.medications),
        ),
      );

      final result = response.data;
      final profileId = result?.profileId;
      final bmi = result?.bmi;
      final age = result?.age;

      if (profileId == null || bmi == null || age == null) {
        throw const FormatException(
          'La creacion del perfil respondio sin profileId, bmi o age.',
        );
      }

      return CreatedPatientProfile(
        profileId: profileId,
        bmi: bmi,
        age: age,
        bmiCategory: BmiCategory.fromWire(result?.bmiCategory),
        nutritionistAssigned: result?.nutritionistAssigned ?? false,
      );
    });
  }

  /// US03. `GET /api/v1/allergies`.
  ///
  /// Catalogo cerrado: el paciente elige de aca y no puede declarar una
  /// alergia que el backend no conozca.
  ///
  /// Una entrada sin `allergyId` o sin `name` se descarta en vez de tumbar la
  /// lista entera. Es preferible un catalogo con una opcion menos que un
  /// formulario que no se puede abrir.
  Future<List<AllergyCatalogEntry>> allergyCatalog() {
    return _guard(() async {
      final response = await _allergiesApi.apiV1AllergiesGet();
      // Sin `BuiltList` explicito: el tipo llega por inferencia desde el
      // cliente generado. Nombrarlo obligaria a declarar `built_collection`
      // como dependencia directa del app solo para escribir una anotacion.
      final items = response.data;
      if (items == null) {
        return const <AllergyCatalogEntry>[];
      }

      return items
          .map(
            (item) {
              final allergyId = item.allergyId;
              final name = item.name;
              if (allergyId == null || name == null || name.isEmpty) {
                return null;
              }
              return AllergyCatalogEntry(
                allergyId: allergyId,
                name: name,
                type: AllergyTypeOption.fromApi(item.allergyType),
                description: item.description,
              );
            },
          )
          .whereType<AllergyCatalogEntry>()
          .toList();
    });
  }

  /// US03. `POST /api/v1/patients/allergies`.
  ///
  /// Una peticion por alergia: el contrato no expone un endpoint de lote para
  /// este recurso. Devuelve el identificador de la declaracion creada.
  Future<String> declareAllergy(AllergyDeclarationDraft draft) {
    return _guard(() async {
      final response = await _api.apiV1PatientsAllergiesPost(
        declareAllergyRequest: DeclareAllergyRequest(
          (b) => b
            ..allergyId = draft.allergyId
            ..severity = draft.severity.toApi()
            ..notes = _blankToNull(draft.notes),
        ),
      );

      final patientAllergyId = response.data?.patientAllergyId;
      if (patientAllergyId == null) {
        throw const FormatException(
          'La declaracion de alergia respondio sin patientAllergyId.',
        );
      }
      return patientAllergyId;
    });
  }

  /// Traduce el perfil generado al tipo del dominio.
  ///
  /// Valida los campos que el flujo necesita si o si en vez de asumirlos. El
  /// esquema OpenAPI no marca nada como `required`, de modo que el generador
  /// los emite nullable aunque el contrato garantice su presencia; la misma
  /// situacion que resuelve `AuthenticatedUserSnapshot.fromApi`.
  PatientProfile _toProfile(GetPatientProfileResult? result) {
    final profileId = result?.profileId;
    final dateOfBirth = result?.dateOfBirth;
    final weightKg = result?.weightKg;
    final heightCm = result?.heightCm;
    final bmi = result?.bmi;
    final age = result?.age;
    final onboardingCompleted = result?.onboardingCompleted;

    if (profileId == null ||
        dateOfBirth == null ||
        weightKg == null ||
        heightCm == null ||
        bmi == null ||
        age == null ||
        onboardingCompleted == null) {
      throw const FormatException(
        'El perfil llego incompleto: falta algun campo obligatorio.',
      );
    }

    return PatientProfile(
      profileId: profileId,
      dateOfBirth: dateOfBirth.toDateTime(),
      biologicalSex: BiologicalSexOption.fromApi(result?.biologicalSex),
      weightKg: weightKg,
      heightCm: heightCm,
      bmi: bmi,
      bmiCategory: BmiCategory.fromWire(result?.bmiCategory),
      age: age,
      ibsSubtype: IbsSubtypeOption.fromApi(result?.ibsSubtype),
      diagnosisDate: result?.diagnosisDate?.toDateTime(),
      medications: result?.medications,
      onboardingCompleted: onboardingCompleted,
      allergies: _toDeclarations(result?.allergies),
    );
  }

  /// Traduce las alergias declaradas que vienen dentro del perfil.
  ///
  /// Una entrada sin identificador se descarta: el perfil completo sigue
  /// siendo util aunque una declaracion venga corrupta.
  List<AllergyDeclaration> _toDeclarations(
    Iterable<PatientAllergySummary>? summaries,
  ) {
    if (summaries == null) {
      return const <AllergyDeclaration>[];
    }
    return summaries
        .map(
          (summary) {
            final patientAllergyId = summary.patientAllergyId;
            final allergyId = summary.allergyId;
            if (patientAllergyId == null || allergyId == null) {
              return null;
            }
            return AllergyDeclaration(
              patientAllergyId: patientAllergyId,
              allergyId: allergyId,
              allergyName: summary.allergyName ?? '',
              type: AllergyTypeOption.fromApi(summary.allergyType),
              severity: AllergySeverityLevel.fromApi(summary.severity),
              notes: summary.notes,
              declaredAt: summary.declaredAt?.toUtc(),
            );
          },
        )
        .whereType<AllergyDeclaration>()
        .toList();
  }

  /// Descarta la hora: el contrato espera `format: date`, no `date-time`.
  Date _toDate(DateTime value) => Date(value.year, value.month, value.day);

  Date? _toNullableDate(DateTime? value) =>
      value == null ? null : _toDate(value);

  /// Un campo opcional vacio viaja como `null` y no como cadena vacia, para
  /// que el backend lo persista ausente en vez de presente y en blanco.
  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }

  /// Ejecuta la llamada traduciendo cualquier falla al dominio.
  ///
  /// Delega en [guardApiCall], promovido a `core/` en Mobile-2 por lo que
  /// dejo pedido el acta M29 al aparecer el tercer repositorio.
  Future<T> _guard<T>(Future<T> Function() call) =>
      guardApiCall(call, malformedResponseStatus: 201);
}

@Riverpod(keepAlive: true)
PatientsRepository patientsRepository(Ref ref) {
  return PatientsRepository(
    ref.watch(patientsApiProvider),
    ref.watch(allergiesApiProvider),
  );
}

/// Catalogo de alergias, cacheado mientras el formulario de perfil viva.
///
/// Provider aparte y no una lectura dentro del notifier, igual que
/// `currentConsentProvider`: asi la pantalla resuelve carga, error y reintento
/// con `AsyncValue` sin mezclar ese ciclo con el del envio del formulario.
///
/// Sin `keepAlive`: el catalogo se consulta una vez en todo el onboarding y
/// mantenerlo vivo despues solo retendria memoria.
@riverpod
Future<List<AllergyCatalogEntry>> allergyCatalog(Ref ref) {
  return ref.watch(patientsRepositoryProvider).allergyCatalog();
}
