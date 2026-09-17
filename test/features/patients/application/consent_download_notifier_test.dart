import 'dart:io';

import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/patients/application/consent_download_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

/// Sustituye el guardado y la hoja de compartir del SO, que en un entorno de
/// prueba no existen.
class _FakeSharer implements ConsentPdfSharer {
  _FakeSharer({this.failure});

  final Exception? failure;
  final List<ConsentPdf> shared = <ConsentPdf>[];

  @override
  Future<String> share(ConsentPdf pdf) async {
    final pending = failure;
    if (pending != null) {
      throw pending;
    }
    shared.add(pdf);
    return '/tmp/${pdf.fileName}';
  }
}

({ProviderContainer container, FakePatientsRepository repo, _FakeSharer sharer})
    _harness({FakePatientsRepository? repository, _FakeSharer? sharer}) {
  final repo = repository ?? FakePatientsRepository();
  final fakeSharer = sharer ?? _FakeSharer();
  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(repo),
      consentPdfSharerProvider.overrideWithValue(fakeSharer),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
    ],
  );
  addTearDown(container.dispose);
  return (container: container, repo: repo, sharer: fakeSharer);
}

void main() {
  group('ConsentDownloadNotifier · descarga (HU0001 escenario 4)', () {
    test('nace en reposo', () {
      final h = _harness();

      expect(
        h.container.read(consentDownloadNotifierProvider),
        isA<ConsentDownloadIdle>(),
      );
    });

    test('CP004 paso 6: descarga el comprobante y lo ofrece al paciente',
        () async {
      final h = _harness();

      final ok = await h.container
          .read(consentDownloadNotifierProvider.notifier)
          .download();

      expect(ok, isTrue);
      expect(h.sharer.shared, hasLength(1));
      expect(
        h.container.read(consentDownloadNotifierProvider),
        isA<ConsentShared>(),
      );
    });

    test('CP004 paso 7: el nombre del archivo lleva la version aceptada',
        () async {
      // El backend nombra `consentimiento-<version>.pdf`. Es lo unico que el
      // cliente puede afirmar sobre la correspondencia con la version: el
      // contrato no expone todavia un endpoint JSON del consentimiento
      // aceptado, y el texto va dentro del PDF.
      final h = _harness();

      await h.container
          .read(consentDownloadNotifierProvider.notifier)
          .download();

      expect(h.sharer.shared.single.fileName, 'consentimiento-1.0.pdf');
    });

    test('el PDF llega con contenido, no vacio', () async {
      final h = _harness();

      await h.container
          .read(consentDownloadNotifierProvider.notifier)
          .download();

      expect(h.sharer.shared.single.bytes, isNotEmpty);
    });

    test('un doble toque no dispara dos descargas', () async {
      // Dos hojas de compartir encimadas dejan al paciente sin saber cual
      // atender.
      final h = _harness(
        repository: FakePatientsRepository(
          delay: const Duration(milliseconds: 50),
        ),
      );
      final notifier =
          h.container.read(consentDownloadNotifierProvider.notifier);

      final first = notifier.download();
      final second = await notifier.download();

      expect(second, isFalse);
      expect(await first, isTrue);
      expect(h.sharer.shared, hasLength(1));
    });
  });

  group('ConsentDownloadNotifier · fallos', () {
    test('un 404 consent_record_not_found llega tipado', () async {
      final repo = FakePatientsRepository()
        ..consentPdfError = const CauceApiError.consentRecordNotFound();
      final h = _harness(repository: repo);

      final ok = await h.container
          .read(consentDownloadNotifierProvider.notifier)
          .download();

      expect(ok, isFalse);
      expect(
        h.container.read(consentDownloadNotifierProvider).error,
        isA<ConsentRecordNotFoundError>(),
      );
      expect(h.sharer.shared, isEmpty);
    });

    test('un fallo de red se muestra y no deja archivo', () async {
      final repo = FakePatientsRepository()
        ..consentPdfError = const CauceApiError.network();
      final h = _harness(repository: repo);

      await h.container
          .read(consentDownloadNotifierProvider.notifier)
          .download();

      expect(
        h.container.read(consentDownloadNotifierProvider).error,
        isA<NetworkError>(),
      );
      expect(h.sharer.shared, isEmpty);
    });

    test('un fallo al escribir en disco no se confunde con uno de red',
        () async {
      // El backend hizo su parte. Reintentar no ayuda si el disco esta lleno,
      // asi que conviene que el mensaje no invite a lo mismo.
      final h = _harness(
        sharer: _FakeSharer(
          failure: const FileSystemException('No queda espacio'),
        ),
      );

      final ok = await h.container
          .read(consentDownloadNotifierProvider.notifier)
          .download();

      expect(ok, isFalse);
      expect(
        h.container.read(consentDownloadNotifierProvider).error,
        isA<UnknownError>(),
      );
    });

    test('clearError vuelve a reposo', () async {
      final repo = FakePatientsRepository()
        ..consentPdfError = const CauceApiError.network();
      final h = _harness(repository: repo);
      final notifier =
          h.container.read(consentDownloadNotifierProvider.notifier);

      await notifier.download();
      notifier.clearError();

      expect(
        h.container.read(consentDownloadNotifierProvider),
        isA<ConsentDownloadIdle>(),
      );
    });

    test('tras un fallo se puede reintentar', () async {
      final repo = FakePatientsRepository()
        ..consentPdfError = const CauceApiError.network();
      final h = _harness(repository: repo);
      final notifier =
          h.container.read(consentDownloadNotifierProvider.notifier);

      await notifier.download();
      repo.consentPdfError = null;
      final ok = await notifier.download();

      expect(ok, isTrue);
      expect(h.sharer.shared, hasLength(1));
    });
  });
}
