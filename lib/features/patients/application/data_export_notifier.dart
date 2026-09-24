import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/patients_repository.dart';

part 'data_export_notifier.freezed.dart';
part 'data_export_notifier.g.dart';

/// Abre el enlace de descarga del ZIP de portabilidad.
///
/// Se declara como interfaz por lo mismo que [ConsentPdfSharer]: en un entorno
/// de prueba no hay navegador que abrir, y un test no deberia depender de que
/// el sistema operativo responda.
abstract interface class DataExportLauncher {
  /// Abre [url] fuera de la app. Devuelve `false` si no se pudo.
  Future<bool> open(String url);
}

/// Implementacion real sobre `url_launcher`.
class PlatformDataExportLauncher implements DataExportLauncher {
  const PlatformDataExportLauncher();

  @override
  Future<bool> open(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return Future<bool>.value(false);
    }

    // `externalApplication` y no una vista dentro de la app: lo que se abre es
    // una descarga, y el gestor del sistema es quien sabe donde dejarla y como
    // mostrarsela despues al paciente.
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

@Riverpod(keepAlive: true)
DataExportLauncher dataExportLauncher(Ref ref) =>
    const PlatformDataExportLauncher();

/// Estado de la exportacion de datos (HU0025).
@freezed
sealed class DataExportState with _$DataExportState {
  const factory DataExportState.idle() = DataExportIdle;
  const factory DataExportState.requesting() = DataExportRequesting;

  /// El enlace llego y se abrio. [expiresAt] es cuando deja de servir.
  const factory DataExportState.opened(DateTime expiresAt) = DataExportOpened;

  /// El enlace llego pero el sistema no pudo abrirlo.
  const factory DataExportState.notOpened(DateTime expiresAt) =
      DataExportNotOpened;

  const factory DataExportState.failure(CauceApiError error) =
      DataExportFailure;

  const DataExportState._();

  bool get isRequesting => this is DataExportRequesting;

  CauceApiError? get error => switch (this) {
        DataExportFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna la solicitud de exportacion y la apertura de su enlace.
@riverpod
class DataExportNotifier extends _$DataExportNotifier {
  @override
  DataExportState build() => const DataExportState.idle();

  /// Pide la exportacion y abre el enlace prefirmado.
  ///
  /// **No distingue al paciente sin registros.** CP065 exige que la
  /// exportacion salga igual, con los CSV vacios y sus encabezados: el backend
  /// responde 200 en los dos casos y aca no hay nada que ramificar.
  Future<bool> request() async {
    if (state.isRequesting) {
      return false;
    }
    state = const DataExportState.requesting();

    try {
      final link = await ref.read(patientsRepositoryProvider).exportData();
      final opened =
          await ref.read(dataExportLauncherProvider).open(link.downloadUrl);

      // Si el sistema no abrio el enlace, el archivo existe igual. Se
      // distingue del fallo para poder decirlo sin llamarlo error: el backend
      // hizo su parte y el enlace sigue vivo su hora.
      state = opened
          ? DataExportState.opened(link.expiresAt)
          : DataExportState.notOpened(link.expiresAt);
      return opened;
    } on CauceApiError catch (error) {
      state = DataExportState.failure(error);
      return false;
    }
  }

  void reset() {
    if (state is! DataExportRequesting) {
      state = const DataExportState.idle();
    }
  }
}
