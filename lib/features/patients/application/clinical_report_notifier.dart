import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/patients_repository.dart';
import 'data_export_notifier.dart';

part 'clinical_report_notifier.freezed.dart';
part 'clinical_report_notifier.g.dart';

/// Periodo que cubre el reporte (HU0024, CP062 paso 4).
///
/// Dos opciones y no las tres de Evolucion: aca el tope no es una preferencia
/// de lectura sino el limite que impone el backend, que rechaza cualquier
/// rango mayor a 90 dias.
///
/// **Enum propio y no `IbsSssEvolutionRange`.** Comparten el atomo visual y
/// nada mas: aquel recorta que puntos se dibujan en un grafico ya cargado, y
/// este decide que le pide al servidor.
enum ClinicalReportPeriod {
  /// Seleccion por defecto al abrir la pantalla.
  last30(30),

  /// El maximo que acepta el backend.
  last90(90);

  const ClinicalReportPeriod(this.days);

  final int days;
}

/// Estado de la generacion del reporte (HU0024).
@freezed
sealed class ClinicalReportState with _$ClinicalReportState {
  const factory ClinicalReportState.idle() = ClinicalReportIdle;
  const factory ClinicalReportState.generating() = ClinicalReportGenerating;

  /// El PDF se genero y su enlace quedo disponible.
  ///
  /// [openedDownload] dice si el sistema llego a abrirlo. En `false` el
  /// reporte existe igual: lo que fallo fue el navegador, no el servidor.
  const factory ClinicalReportState.ready({
    required ClinicalReport report,
    required bool openedDownload,
  }) = ClinicalReportReady;

  /// El periodo no tiene registros (CP063). Estado propio y no un error: el
  /// backend lo responde a proposito para no emitir un PDF vacio.
  const factory ClinicalReportState.noData() = ClinicalReportNoData;

  const factory ClinicalReportState.failure(CauceApiError error) =
      ClinicalReportFailure;

  const ClinicalReportState._();

  bool get isGenerating => this is ClinicalReportGenerating;

  CauceApiError? get error => switch (this) {
        ClinicalReportFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna la generacion del reporte y la apertura de su enlace.
@riverpod
class ClinicalReportNotifier extends _$ClinicalReportNotifier {
  @override
  ClinicalReportState build() => const ClinicalReportState.idle();

  /// Pide el reporte del [period] y abre su enlace.
  ///
  /// El rango se calcula **en el cliente** contra [now], que los tests fijan:
  /// `hoy - N dias` a `hoy`. Delegarlo en el valor por defecto del servidor
  /// haria que el resultado dependiera de su reloj.
  Future<bool> generate(
    ClinicalReportPeriod period, {
    DateTime? now,
  }) async {
    // Un doble toque generaria dos reportes, cada uno con su contraseña, y el
    // paciente recibiria cuatro correos sin saber cual abre cual.
    if (state.isGenerating) {
      return false;
    }
    state = const ClinicalReportState.generating();

    final end = now ?? DateTime.now();
    final start = end.subtract(Duration(days: period.days));

    try {
      final report = await ref.read(patientsRepositoryProvider).generateReport(
            periodStart: start,
            periodEnd: end,
          );
      final opened =
          await ref.read(dataExportLauncherProvider).open(report.downloadUrl);

      state = ClinicalReportState.ready(
        report: report,
        openedDownload: opened,
      );
      return true;
    } on PatientHasNoDataInPeriodError {
      // CP063. No se distingue como fallo porque no lo es: el paciente pidio
      // un rango vacio y el servidor se nego a fabricar un PDF sin contenido.
      state = const ClinicalReportState.noData();
      return false;
    } on CauceApiError catch (error) {
      state = ClinicalReportState.failure(error);
      return false;
    }
  }

  /// Reabre el enlace de un reporte ya generado, sin volver a pedirlo.
  ///
  /// Evita que reintentar la descarga cueste un reporte nuevo, con su
  /// contraseña nueva y sus dos correos nuevos.
  Future<bool> openDownload() async {
    final current = state;
    if (current is! ClinicalReportReady) {
      return false;
    }

    final opened = await ref
        .read(dataExportLauncherProvider)
        .open(current.report.downloadUrl);
    state = ClinicalReportState.ready(
      report: current.report,
      openedDownload: opened,
    );
    return opened;
  }

  void reset() {
    if (!state.isGenerating) {
      state = const ClinicalReportState.idle();
    }
  }
}
