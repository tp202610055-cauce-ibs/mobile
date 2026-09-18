import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/patients_repository.dart';

part 'consent_download_notifier.freezed.dart';
part 'consent_download_notifier.g.dart';

/// Escribe el comprobante en disco y se lo ofrece al paciente.
///
/// Se declara como interfaz para que los tests no toquen el sistema de
/// archivos ni levanten la hoja de compartir del SO, que en un entorno de
/// prueba no existe.
abstract interface class ConsentPdfSharer {
  /// Guarda [pdf] y abre la hoja de compartir. Devuelve la ruta escrita.
  Future<String> share(ConsentPdf pdf);
}

/// Implementacion real sobre `path_provider` y `share_plus`.
class PlatformConsentPdfSharer implements ConsentPdfSharer {
  const PlatformConsentPdfSharer();

  @override
  Future<String> share(ConsentPdf pdf) async {
    // Directorio temporal y no el de documentos: el archivo es un vehiculo
    // para la hoja de compartir, no una copia que la app deba custodiar.
    // Guardar datos de salud en el almacenamiento de la app sin necesidad
    // seria ampliar la superficie bajo la Ley N° 29733 sin motivo.
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/${pdf.fileName}');
    await file.writeAsBytes(pdf.bytes, flush: true);

    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[XFile(file.path, mimeType: 'application/pdf')],
        fileNameOverrides: <String>[pdf.fileName],
      ),
    );
    return file.path;
  }
}

@Riverpod(keepAlive: true)
ConsentPdfSharer consentPdfSharer(Ref ref) => const PlatformConsentPdfSharer();

/// Estado de la descarga del consentimiento (HU0001 escenario 4).
@freezed
sealed class ConsentDownloadState with _$ConsentDownloadState {
  const factory ConsentDownloadState.idle() = ConsentDownloadIdle;
  const factory ConsentDownloadState.downloading() = ConsentDownloading;

  /// El PDF se escribio y se ofrecio al paciente. [path] es donde quedo.
  const factory ConsentDownloadState.shared(String path) = ConsentShared;
  const factory ConsentDownloadState.failure(CauceApiError error) =
      ConsentDownloadFailure;

  const ConsentDownloadState._();

  bool get isDownloading => this is ConsentDownloading;

  CauceApiError? get error => switch (this) {
        ConsentDownloadFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna la descarga del comprobante del consentimiento.
@riverpod
class ConsentDownloadNotifier extends _$ConsentDownloadNotifier {
  @override
  ConsentDownloadState build() => const ConsentDownloadState.idle();

  /// Pide el PDF al backend y se lo entrega al paciente.
  ///
  /// Devuelve `true` si el comprobante llego y se pudo ofrecer.
  Future<bool> download() async {
    // Un doble toque dispararia dos descargas y dos hojas de compartir
    // encimadas.
    if (state.isDownloading) {
      return false;
    }
    state = const ConsentDownloadState.downloading();

    try {
      final pdf = await ref.read(patientsRepositoryProvider).consentPdf();
      final path = await ref.read(consentPdfSharerProvider).share(pdf);
      state = ConsentDownloadState.shared(path);
      return true;
    } on CauceApiError catch (error) {
      state = ConsentDownloadState.failure(error);
      return false;
    } on FileSystemException catch (error) {
      // Sin espacio o sin permiso de escritura. El backend hizo su parte, de
      // modo que se distingue del fallo de red: reintentar no ayuda si el
      // disco esta lleno.
      state = ConsentDownloadState.failure(
        CauceApiError.unknown(statusCode: 0, detail: error.message),
      );
      return false;
    }
  }

  void clearError() {
    if (state is ConsentDownloadFailure) {
      state = const ConsentDownloadState.idle();
    }
  }
}
