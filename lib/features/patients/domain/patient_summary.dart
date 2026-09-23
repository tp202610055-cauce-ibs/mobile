import 'package:freezed_annotation/freezed_annotation.dart';

import 'patient_profile.dart';

part 'patient_summary.freezed.dart';

/// Resumen del paciente para la pantalla de Perfil (P12, HU0023).
///
/// Lo resuelve `GET /patients/me/summary` de una sola consulta, que es lo que
/// el mockup `12-mi-perfil-v2` pide de forma explicita: "la pantalla ejecuta
/// una query consolidada en backend, no multiples requests desde cliente".
///
/// Modelo propio y no `api.MyProfileSummaryResult` por la misma razon que
/// [PatientProfile]: el generado es `built_value` y esta atado al ciclo de
/// regeneracion del cliente OpenAPI.
///
/// **Todo es opcional menos el nombre.** El contrato declara nullable cada
/// campo, y los casos son reales: un paciente sin linea base todavia no tiene
/// puntajes, y uno recien registrado no tiene nutricionista.
@freezed
abstract class PatientSummary with _$PatientSummary {
  const factory PatientSummary({
    required String fullName,
    IbsSubtypeOption? ibsSubtype,
    DateTime? pilotStartDate,
    String? nutritionistName,
    int? ibsSssBaseline,
    int? ibsSssLatest,

    /// Diferencia entre el ultimo puntaje y la linea base.
    ///
    /// **Negativo es mejoria**, igual que `deltaFromBaseline` del cuestionario
    /// periodico: el backend lo calcula como `latest - baseline`
    /// (`IbsSssAssessment.CompareTotalScoreTo`). El mockup describe el signo
    /// al reves; manda el backend.
    int? cumulativeChange,

    /// Si el cambio alcanza el MCID de 50 puntos.
    ///
    /// **Lo calcula el backend** (`IsClinicallySignificantImprovement`) y el
    /// cliente no lo re-deriva. Hasta este bloque el umbral estaba escrito
    /// tambien en el movil porque el contrato no lo exponia; ahora si.
    @Default(false) bool significantClinicalResponse,
  }) = _PatientSummary;

  const PatientSummary._();

  /// Iniciales para el avatar, cuando no hay foto.
  ///
  /// Primera letra del primer nombre mas primera letra del segundo termino,
  /// que es la regla que declara el mockup. Con un solo termino devuelve una
  /// sola letra en vez de inventar la segunda.
  String get initials {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return '';
    }

    final first = parts.first.substring(0, 1).toUpperCase();
    if (parts.length == 1) {
      return first;
    }

    return first + parts[1].substring(0, 1).toUpperCase();
  }

  /// `true` si hay dos puntajes para comparar.
  ///
  /// La linea base sola no es evolucion: el mockup reemplaza la tarjeta por su
  /// CTA hacia el cuestionario mientras falte.
  bool get hasEvolution => ibsSssBaseline != null && ibsSssLatest != null;

  bool get hasNutritionist =>
      nutritionistName != null && nutritionistName!.trim().isNotEmpty;

  /// `true` si el ultimo puntaje bajo respecto de la linea base.
  ///
  /// Solo gobierna el color y la flecha. El logro clinico lo decide
  /// [significantClinicalResponse], que viene del servidor.
  bool get hasImproved => (cumulativeChange ?? 0) < 0;

  /// Dias completos desde el inicio del piloto, o `null` si no hay fecha.
  int? daysInPilot(DateTime now) {
    final start = pilotStartDate;
    if (start == null) {
      return null;
    }

    final from = DateTime(start.year, start.month, start.day);
    final to = DateTime(now.year, now.month, now.day);
    final days = to.difference(from).inDays;
    return days < 0 ? 0 : days;
  }
}
