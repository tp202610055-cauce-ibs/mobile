import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/patients/application/account_deletion_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

/// Arma el notifier con la sesion ya resuelta desde [loginInPilot], que es el
/// snapshot en memoria. Despues del arranque, el guardado se puede reescribir
/// por separado, como hace el refresh desde el acta M49.
Future<
    ({
      ProviderContainer container,
      FakeTokenStorage storage,
      FakePatientsRepository repository,
    })> _harness({bool? loginInPilot = false}) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: loginInPilot == null
        ? null
        : demoUser.copyWith(isInActivePilot: loginInPilot),
  );
  final repository = FakePatientsRepository();
  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(repository),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(storage),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).bootstrap();
  return (container: container, storage: storage, repository: repository);
}

void main() {
  group('AccountDeletionNotifier · acuse de piloto (CP067, acta M49)', () {
    test('el guardado le gana al de memoria cuando dice "en piloto"', () async {
      final h = await _harness();
      h.storage.userSnapshot = demoUser.copyWith(isInActivePilot: true);

      final requires = await h.container
          .read(accountDeletionNotifierProvider.notifier)
          .requiresPilotAcknowledgement();

      expect(requires, isTrue);
    });

    test('el guardado le gana al de memoria cuando dice "fuera"', () async {
      final h = await _harness(loginInPilot: true);
      h.storage.userSnapshot = demoUser.copyWith(isInActivePilot: false);

      final requires = await h.container
          .read(accountDeletionNotifierProvider.notifier)
          .requiresPilotAcknowledgement();

      expect(requires, isFalse);
    });

    test('sin snapshot guardado cae al de memoria', () async {
      final h = await _harness(loginInPilot: true);
      h.storage.userSnapshot = null;

      final requires = await h.container
          .read(accountDeletionNotifierProvider.notifier)
          .requiresPilotAcknowledgement();

      expect(requires, isTrue);
    });

    test('sin ningun snapshot no pide el acuse', () async {
      // Sin sesion: el backend igual responde 409 si hiciera falta.
      final h = await _harness(loginInPilot: null);

      final requires = await h.container
          .read(accountDeletionNotifierProvider.notifier)
          .requiresPilotAcknowledgement();

      expect(requires, isFalse);
    });
  });

  group('AccountDeletionNotifier · 409 active_pilot_retention', () {
    test('queda como fallo tipado y no cierra la sesion', () async {
      final h = await _harness();
      h.repository.serverInActivePilot = true;

      final deleted = await h.container
          .read(accountDeletionNotifierProvider.notifier)
          .delete(activePilotAcknowledged: false);

      expect(deleted, isFalse);
      expect(
        h.container.read(accountDeletionNotifierProvider).error,
        isA<ActivePilotRetentionError>(),
      );
      expect(h.storage.clearSessionCalls, 0);
    });

    test('con el acuse la baja prospera y cierra la sesion', () async {
      final h = await _harness();
      h.repository.serverInActivePilot = true;

      final deleted = await h.container
          .read(accountDeletionNotifierProvider.notifier)
          .delete(activePilotAcknowledged: true);

      expect(deleted, isTrue);
      expect(h.repository.deleteAcknowledgements, <bool>[true]);
      expect(h.storage.clearSessionCalls, 1);
    });
  });
}
