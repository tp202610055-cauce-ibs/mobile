import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/register_notifier.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/domain/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_token_storage.dart';

({
  ProviderContainer container,
  FakeAuthRepository repository,
  FakeTokenStorage storage,
}) _harness({CauceApiError? error, Duration delay = Duration.zero}) {
  final repository = FakeAuthRepository(error: error, delay: delay);
  final storage = FakeTokenStorage();
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(repository),
      tokenStorageProvider.overrideWithValue(storage),
    ],
  );
  addTearDown(container.dispose);
  return (container: container, repository: repository, storage: storage);
}

Future<bool> _submit(
  ProviderContainer container, {
  String email = 'nuevo@cauce.local',
  String fullName = 'Paciente Nuevo',
  String password = 'ClaveSegura1',
  String consentVersion = '1.0.0',
  String consentHash = 'sha256:abc',
  String? invitationCode,
}) {
  return container.read(registerNotifierProvider.notifier).submit(
        email: email,
        fullName: fullName,
        password: password,
        consentDocumentVersion: consentVersion,
        consentTextHash: consentHash,
        invitationCode: invitationCode,
      );
}

void main() {
  group('RegisterNotifier · exito', () {
    test('deja al paciente esperando la verificacion del correo', () async {
      final h = _harness();

      final ok = await _submit(h.container);

      expect(ok, isTrue);
      expect(
        h.container.read(registerNotifierProvider),
        isA<RegisterSuccess>(),
      );
      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.pendingEmailVerification(
          email: 'nuevo@cauce.local',
        ),
      );
    });

    test('no persiste sesion: el 201 no trae tokens', () async {
      final h = _harness();

      await _submit(h.container);

      expect(h.storage.saveSessionCalls, 0);
      expect(h.storage.refreshToken, isNull);
    });

    test('reenvia version y hash del consentimiento sin tocarlos', () async {
      // Recalcular el hash produciria uno distinto al del backend y un 400
      // consent_text_mismatch en cada registro.
      final h = _harness();

      await _submit(
        h.container,
        consentVersion: '2.1.0',
        consentHash: 'sha256:deadbeef',
      );

      expect(h.repository.lastConsentVersion, '2.1.0');
      expect(h.repository.lastConsentHash, 'sha256:deadbeef');
    });

    test('recorta espacios de correo y nombre', () async {
      final h = _harness();

      await _submit(
        h.container,
        email: '  nuevo@cauce.local ',
        fullName: '  Paciente Nuevo  ',
      );

      expect(h.repository.lastEmail, 'nuevo@cauce.local');
      expect(h.repository.lastFullName, 'Paciente Nuevo');
    });

    test('envia el codigo de invitacion cuando lo hay', () async {
      final h = _harness();

      await _submit(h.container, invitationCode: ' KAELIN2026 ');

      expect(h.repository.lastInvitationCode, 'KAELIN2026');
    });
  });

  group('RegisterNotifier · errores del contrato', () {
    test('correo duplicado queda como fallo', () async {
      final h = _harness(error: const CauceApiError.duplicateEmail());

      final ok = await _submit(h.container);

      expect(ok, isFalse);
      expect(
        h.container.read(registerNotifierProvider).error,
        isA<DuplicateEmailError>(),
      );
      // La sesion no se mueve: el paciente sigue sin cuenta.
      expect(
        h.container.read(sessionNotifierProvider),
        isA<SessionUnknown>(),
      );
    });

    test('consentimiento desactualizado pide recarga', () async {
      // Cambio mientras el paciente completaba el formulario. Reintentar con
      // el hash viejo fallaria igual.
      final h = _harness(error: const CauceApiError.consentMismatch());

      await _submit(h.container);

      expect(
        h.container.read(registerNotifierProvider).needsConsentReload,
        isTrue,
      );
    });

    test('los demas errores no piden recarga del consentimiento', () async {
      final h = _harness(error: const CauceApiError.duplicateEmail());

      await _submit(h.container);

      expect(
        h.container.read(registerNotifierProvider).needsConsentReload,
        isFalse,
      );
    });

    test('los tres motivos de codigo de invitacion se conservan', () async {
      for (final reason in InvitationCodeReason.values) {
        final h = _harness(
          error: CauceApiError.invitationCode(reason: reason),
        );

        await _submit(h.container, invitationCode: 'CODIGO12');

        expect(
          h.container.read(registerNotifierProvider).error,
          isA<InvitationCodeError>().having(
            (e) => e.reason,
            'reason',
            reason,
          ),
          reason: reason.name,
        );
      }
    });

    test('un fallo de Keycloak se comunica como error del servidor', () async {
      final h = _harness(error: const CauceApiError.keycloakIntegration());

      await _submit(h.container);

      expect(
        h.container.read(registerNotifierProvider).error,
        isA<KeycloakIntegrationError>(),
      );
    });

    test('validacion expone los errores por campo', () async {
      final h = _harness(
        error: const CauceApiError.validation(
          fieldErrors: <String, List<String>>{
            'password': <String>['La contrasena debe contener un digito.'],
          },
          errorCode: 'validation_error',
        ),
      );

      await _submit(h.container);

      final error = h.container.read(registerNotifierProvider).error;
      expect(
        (error! as ValidationError).fieldErrors['password'],
        isNotEmpty,
      );
    });
  });

  group('RegisterNotifier · control de reentrada', () {
    test('un doble toque no emite dos registros', () async {
      // 5 por hora por IP: el segundo envio consume una quinta parte del cupo
      // de toda la red del hospital.
      final h = _harness(delay: const Duration(milliseconds: 40));

      await Future.wait<bool>(<Future<bool>>[
        _submit(h.container),
        _submit(h.container),
      ]);

      expect(h.repository.registerCalls, 1);
    });
  });
}
