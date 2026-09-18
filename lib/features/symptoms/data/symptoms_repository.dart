import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/symptom_draft.dart';

part 'symptoms_repository.g.dart';

/// Registro e historial de sintomas (US11).
class SymptomsRepository {
  const SymptomsRepository(this._api);

  final SymptomsApi _api;

  /// `POST /api/v1/symptoms`.
  ///
  /// **El cliente no calcula la ventana de 4 horas.** Manda `occurredAt` y
  /// `clientCreatedAt`, y el servidor busca la comida mas reciente en la ventana
  /// y responde `associatedMealId` y `hasMealAssociation` (DEC-B3-06,
  /// HU0011 CA01).
  ///
  /// Detalle del servidor que conviene tener presente al leer el resultado: la
  /// ventana se ancla en `clientCreatedAt`, no en `occurredAt`. Un sintoma de
  /// ayer registrado hoy se asocia contra el momento del registro.
  Future<CreatedSymptom> create(
    SymptomDraft draft, {
    required String clientGuid,
  }) {
    final symptomType = draft.symptomType;
    final intensity = draft.intensity;
    if (symptomType == null || intensity == null) {
      throw StateError('El sintoma exige tipo e intensidad.');
    }

    return guardApiCall(
      () async {
        final now = DateTime.now().toUtc();
        final response = await _api.apiV1SymptomsPost(
          createSymptomRequest: CreateSymptomRequest(
            (b) => b
              ..clientGuid = clientGuid
              ..symptomType = symptomType.toApi()
              ..intensity = intensity
              ..occurredAt = (draft.occurredAt ?? now).toUtc()
              ..clientCreatedAt = now,
          ),
        );

        final symptomId = response.data?.symptomId;
        if (symptomId == null) {
          throw const FormatException('El registro respondio sin symptomId.');
        }

        return CreatedSymptom(
          symptomId: symptomId,
          associatedMealId: response.data?.associatedMealId,
          // Si el campo faltara se asume que no hubo asociacion: afirmar lo
          // contrario le mostraria al paciente un vinculo que el servidor no
          // confirmo.
          hasMealAssociation: response.data?.hasMealAssociation ?? false,
        );
      },
      malformedResponseStatus: 201,
    );
  }

  /// Ventana por defecto del historial.
  ///
  /// **`from` y `to` no se pueden omitir.** El contrato los declara opcionales,
  /// pero el controlador los recibe como `DateTime` **no nullable**: sin ellos
  /// se enlazan a `default(DateTime)`, o sea `0001-01-01`, y la consulta filtra
  /// por el rango vacio `[0001-01-01, 0001-01-01]`. El endpoint responde 200
  /// con cero resultados, que es peor que un error porque parece un historial
  /// vacio. Verificado contra el backend el 2026-09-18: sin rango `totalCount`
  /// da 0, con rango da 8 sobre los mismos datos.
  static const Duration defaultWindow = Duration(days: 90);

  /// Margen hacia adelante del rango.
  ///
  /// El servidor filtra por `ClientCreatedAt <= to`, y acepta hasta 5 minutos
  /// de desfase de reloj del dispositivo. Un dia de margen cubre eso y la
  /// diferencia de zona horaria sin dejar afuera lo que el paciente acaba de
  /// registrar.
  static const Duration forwardMargin = Duration(days: 1);

  /// `GET /api/v1/symptoms`. Historial paginado del paciente.
  ///
  /// Sin [from] y [to] explicitos se usa la ventana por defecto. Ver
  /// [defaultWindow]: omitirlos del todo devuelve un historial vacio.
  Future<SymptomHistoryPage> history({
    DateTime? from,
    DateTime? to,
    int page = 1,
    int pageSize = 50,
    DateTime? now,
  }) {
    final reference = (now ?? DateTime.now()).toUtc();
    final start = (from ?? reference.subtract(defaultWindow)).toUtc();
    final end = (to ?? reference.add(forwardMargin)).toUtc();

    return guardApiCall(() async {
      final response = await _api.apiV1SymptomsGet(
        from: start,
        to: end,
        page: page,
        pageSize: pageSize,
      );

      final result = response.data;
      return SymptomHistoryPage(
        items: result?.items?.map(_toRecord).nonNulls.toList() ??
            const <SymptomRecord>[],
        page: result?.page ?? page,
        pageSize: result?.pageSize ?? pageSize,
        totalCount: result?.totalCount ?? 0,
      );
    });
  }

  SymptomRecord? _toRecord(SymptomHistoryItem item) {
    final symptomId = item.symptomId;
    final occurredAt = item.occurredAt;
    final intensity = item.intensity;
    if (symptomId == null || occurredAt == null || intensity == null) {
      return null;
    }

    return SymptomRecord(
      symptomId: symptomId,
      occurredAt: occurredAt,
      intensity: intensity,
      clientGuid: item.clientGuid,
      symptomType: SymptomTypeOption.fromApi(item.symptomType),
      associatedMealId: item.associatedMealId,
      hasMealAssociation: item.hasMealAssociation ?? false,
    );
  }
}

@Riverpod(keepAlive: true)
SymptomsRepository symptomsRepository(Ref ref) {
  return SymptomsRepository(ref.watch(symptomsApiProvider));
}
