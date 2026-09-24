import 'dart:typed_data';

import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/allergy.dart';
import '../domain/patient_profile.dart';
import '../domain/patient_summary.dart';

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

/// Datos del consentimiento que acepto el paciente (HU0001 escenario 4).
class AcceptedConsent {
  const AcceptedConsent({
    required this.documentVersion,
    required this.acceptedAt,
    required this.textHash,
    required this.textAvailable,
  });

  final String documentVersion;

  /// Momento de aceptacion, siempre en UTC.
  final DateTime acceptedAt;

  /// Hash SHA-256 del texto aceptado.
  final String textHash;

  /// `false` cuando el texto de esa version no quedo guardado en el backend.
  ///
  /// Pasa con las aceptaciones anteriores a que existiera `consent_documents`.
  /// Para esas, el comprobante en PDF **no se puede emitir**: el servidor
  /// responde 404 en vez de imprimir un texto que no es el que se firmo.
  final bool textAvailable;
}

/// Enlace de descarga del archivo de portabilidad (HU0025).
///
/// El endpoint **no devuelve el ZIP**, devuelve una URL prefirmada contra
/// MinIO. Es otra mecanica que la del consentimiento, que llega como bytes:
/// aca lo que hay que abrir es un enlace.
class DataExportLink {
  const DataExportLink({required this.downloadUrl, required this.expiresAt});

  final String downloadUrl;

  /// Vencimiento del enlace, siempre en UTC.
  ///
  /// Son **60 minutos** desde el acta A60 del backend, que los bajo de los
  /// siete dias anteriores: una URL prefirmada es una credencial al portador y
  /// quien la tenga descarga el expediente clinico completo sin autenticarse.
  final DateTime expiresAt;
}

/// Reporte clinico personal ya generado (HU0024).
///
/// Como la exportacion, el endpoint devuelve **un enlace y no el PDF**. A
/// diferencia de ella, este vive **24 horas** y no 60 minutos: el reporte
/// tambien viaja por correo, de modo que el paciente puede volver a el mas
/// tarde desde ahi.
///
/// **La contraseña del PDF no esta aca, y no es un olvido.** El backend cifra
/// el documento y manda la clave en un correo aparte, despues de haber
/// respondido; nunca la persiste ni la incluye en la respuesta HTTP.
class ClinicalReport {
  const ClinicalReport({
    required this.reportId,
    required this.downloadUrl,
    required this.expiresAt,
  });

  final String reportId;
  final String downloadUrl;

  /// Vencimiento del enlace, siempre en UTC.
  final DateTime expiresAt;
}

/// Comprobante en PDF del consentimiento aceptado (HU0001 escenario 4).
class ConsentPdf {
  const ConsentPdf({required this.bytes, required this.fileName});

  final Uint8List bytes;

  /// Nombre sugerido por el backend, con la forma
  /// `consentimiento-<version>.pdf`. Lleva la version a proposito: el
  /// paciente puede descargar el mismo documento mas de una vez y necesita
  /// distinguir cual acepto.
  final String fileName;
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

  /// HU0001 escenario 4, CP004 paso 2. `GET /api/v1/patients/me/consent`.
  ///
  /// Version y fecha de aceptacion, para mostrarlas sin obligar al paciente a
  /// descargar el PDF solo para verlas.
  Future<AcceptedConsent> acceptedConsent() {
    return _guard(() async {
      final response = await _api.apiV1PatientsMeConsentGet();
      final result = response.data;
      final version = result?.documentVersion;
      final acceptedAt = result?.acceptedAt;

      if (version == null || acceptedAt == null) {
        throw const FormatException(
          'El consentimiento respondio sin documentVersion o sin acceptedAt.',
        );
      }

      return AcceptedConsent(
        documentVersion: version,
        acceptedAt: acceptedAt.toUtc(),
        textHash: result?.consentTextHash ?? '',
        // Ante la duda se asume que no hay texto: ofrecer una descarga que va
        // a fallar con 404 es peor que avisar de antemano.
        textAvailable: result?.textAvailable ?? false,
      );
    });
  }

  /// HU0001 escenario 4, CP004. `GET /api/v1/patients/me/consent/pdf`.
  ///
  /// Devuelve el comprobante del consentimiento **que el paciente acepto**,
  /// no el del texto vigente. La distincion la resuelve el backend; desde
  /// aca solo se transporta.
  ///
  /// El 404 `consent_record_not_found` se propaga tipado. Ya estaba en
  /// [CauceApiError] desde Mobile-1b, declarado a la espera de este caso de
  /// uso, y hasta ahora no lo consumia nadie.
  ///
  /// El nombre del archivo sale de `Content-Disposition`. Si el header no
  /// viniera, se cae a un nombre generico en vez de fallar: el PDF ya esta
  /// descargado y negarselo al paciente por un header ausente seria peor.
  Future<ConsentPdf> consentPdf() {
    return _guard(() async {
      final response = await _api.apiV1PatientsMeConsentPdfGet();
      final bytes = response.data;

      if (bytes == null || bytes.isEmpty) {
        throw const FormatException(
          'El comprobante del consentimiento llego vacio.',
        );
      }

      return ConsentPdf(
        bytes: bytes,
        fileName:
            _fileNameFrom(response.headers.value('content-disposition')) ??
                'consentimiento.pdf',
      );
    });
  }

  /// HU0023. `GET /api/v1/patients/me/summary`.
  ///
  /// Resuelve de una sola consulta todo lo que la pantalla de Perfil dibuja:
  /// identidad, estado del piloto, subtipo clinico y los tres puntajes de la
  /// evolucion IBS-SSS. El mockup `12-mi-perfil-v2` lo pide asi de forma
  /// explicita, y evita que la pantalla coordine cuatro cargas en paralelo.
  ///
  /// **Solo el nombre es obligatorio.** El resto del contrato es nullable y
  /// los huecos son estados legitimos que la pantalla sabe dibujar: sin linea
  /// base todavia, o sin nutricionista asignado.
  Future<PatientSummary> fetchSummary() {
    return _guard(() async {
      final response = await _api.apiV1PatientsMeSummaryGet();
      final result = response.data;
      final fullName = result?.patient?.fullName;

      if (fullName == null || fullName.isEmpty) {
        throw const FormatException(
          'El resumen del perfil respondio sin fullName.',
        );
      }

      return PatientSummary(
        fullName: fullName,
        ibsSubtype: IbsSubtypeOption.fromApi(result?.clinical?.ibsSubtype),
        pilotStartDate: result?.pilotStartDate?.toDateTime(),
        nutritionistName: result?.assignedNutritionist?.nutritionistFullName,
        ibsSssBaseline: result?.ibsSssBaseline,
        ibsSssLatest: result?.ibsSssLatest,
        cumulativeChange: result?.cumulativeChange,
        // Ante la duda, sin logro: anunciar una respuesta clinica que el
        // servidor no afirmo seria peor que omitir la pildora.
        significantClinicalResponse:
            result?.significantClinicalResponse ?? false,
      );
    });
  }

  /// HU0025, CP064 y CP065. `GET /api/v1/patients/me/export-data`.
  ///
  /// Un paciente sin registros **no es un error**: CP065 exige que la
  /// exportacion salga igual, con los CSV vacios pero con sus encabezados. El
  /// backend responde 200 en los dos casos y el cliente no distingue.
  Future<DataExportLink> exportData() {
    return _guard(() async {
      final response = await _api.apiV1PatientsMeExportDataGet();
      final result = response.data;
      final url = result?.downloadUrl;
      final expiresAt = result?.expiresAtUtc;

      if (url == null || url.isEmpty || expiresAt == null) {
        throw const FormatException(
          'La exportacion respondio sin downloadUrl o sin expiresAtUtc.',
        );
      }

      return DataExportLink(downloadUrl: url, expiresAt: expiresAt.toUtc());
    });
  }

  /// HU0026, CP066 y CP067. `DELETE /api/v1/patients/me`.
  ///
  /// [activePilotAcknowledged] viaja como `confirmedActivePilotAcknowledged` y
  /// es lo que el backend exige cuando el paciente participa de un piloto
  /// activo. Sin esa marca responde 409 y no borra nada, que es justamente lo
  /// que CP067 pide comprobar: sin la segunda confirmacion, la cuenta sigue.
  ///
  /// La baja **no es un borrado fisico**: el backend elimina lo identificable
  /// y anonimiza lo clinico que la norma obliga a conservar.
  Future<void> deleteAccount({required bool activePilotAcknowledged}) {
    return _guard(() async {
      await _api.apiV1PatientsMeDelete(
        confirmedActivePilotAcknowledged: activePilotAcknowledged,
      );
    });
  }

  /// HU0024, CP062 y CP063. `POST /api/v1/patients/me/report`.
  ///
  /// **El periodo se manda siempre explicito**, aunque el contrato lo declare
  /// opcional. Sin cuerpo el servidor cae a su ventana de 90 dias calculada
  /// contra su propio reloj, y eso haria depender lo que el paciente recibe de
  /// una hora que el cliente no controla ni puede probar.
  ///
  /// El 422 `patient_has_no_data_in_period` no es un fallo de la peticion: el
  /// backend lo devuelve antes de generar nada, para no emitir un PDF vacio.
  /// Llega tipado y la pantalla lo trata como un estado propio.
  Future<ClinicalReport> generateReport({
    required DateTime periodStart,
    required DateTime periodEnd,
  }) {
    return _guard(() async {
      final response = await _api.apiV1PatientsMeReportPost(
        generateMyClinicalReportRequest: GenerateMyClinicalReportRequest(
          (b) => b
            ..periodStart = _toDate(periodStart)
            ..periodEnd = _toDate(periodEnd),
        ),
      );

      final result = response.data;
      final reportId = result?.reportId;
      final url = result?.presignedUrl;
      final expiresAt = result?.presignedUrlExpiresAt;

      if (reportId == null || url == null || url.isEmpty || expiresAt == null) {
        throw const FormatException(
          'El reporte respondio sin reportId, presignedUrl o expiracion.',
        );
      }

      return ClinicalReport(
        reportId: reportId,
        downloadUrl: url,
        expiresAt: expiresAt.toUtc(),
      );
    });
  }

  /// Lee `filename` de la cabecera `Content-Disposition`.
  ///
  /// Recibe el valor y no el objeto `Headers` para no volver a importar dio
  /// aca: la promocion de `_guard()` a `core/` dejo este archivo sin esa
  /// dependencia y no vale la pena reintroducirla por una anotacion.
  String? _fileNameFrom(String? disposition) {
    if (disposition == null) {
      return null;
    }
    final match = RegExp('filename="?([^";]+)"?').firstMatch(disposition);
    return match?.group(1);
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

/// Perfil clinico del paciente, para la pantalla de perfil.
///
/// Devuelve `null` si todavia no lo creo, que es como el repositorio traduce
/// el 404. La pantalla lo trata como "sin datos clinicos que mostrar" y sigue
/// ofreciendo la seccion de privacidad, que no depende del perfil.
///
/// Sin `keepAlive`: el perfil puede cambiar desde la consulta con el
/// nutricionista, y recargarlo al entrar cuesta una peticion.
@riverpod
Future<PatientProfile?> patientProfile(Ref ref) {
  return ref.watch(patientsRepositoryProvider).fetchProfile();
}

/// Resumen del paciente, para la pantalla de Perfil (HU0023).
///
/// Sin `keepAlive`, por lo mismo que [patientProfile]: los puntajes cambian
/// cada vez que el paciente responde el cuestionario, y el nutricionista puede
/// asignarse desde la consulta. Recargarlo al entrar cuesta una peticion.
@riverpod
Future<PatientSummary> patientSummary(Ref ref) {
  return ref.watch(patientsRepositoryProvider).fetchSummary();
}

/// Consentimiento aceptado por el paciente, para la seccion de privacidad.
@riverpod
Future<AcceptedConsent> acceptedConsent(Ref ref) {
  return ref.watch(patientsRepositoryProvider).acceptedConsent();
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
