import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/error_mapper.dart';

part 'patients_repository.g.dart';

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
  const PatientsRepository(this._api);

  final PatientsApi _api;

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

  /// Ejecuta la llamada traduciendo cualquier falla al dominio.
  ///
  /// Replica el helper de `AuthRepository` en vez de compartirlo. Con dos
  /// consumidores, extraerlo a `core/` seria abstraccion prematura; si aparece
  /// un tercer repositorio, corresponde promoverlo (acta M29).
  Future<T> _guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      throw ErrorMapper.map(error);
    } on FormatException catch (error) {
      throw CauceApiError.unknown(statusCode: 201, detail: error.message);
    }
  }
}

@Riverpod(keepAlive: true)
PatientsRepository patientsRepository(Ref ref) {
  return PatientsRepository(ref.watch(patientsApiProvider));
}
