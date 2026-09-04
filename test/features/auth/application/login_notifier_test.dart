import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/login_notifier.dart';
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

void main() {
  group('LoginNotifier · exito', () {
    test('persiste la sesion y publica el estado autenticado', () async {
      final h = _harness();

      final ok = await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: 'paciente.demo@cauce.local', password: 'Secreta1');

      expect(ok, isTrue);
      expect(h.container.read(loginNotifierProvider), isA<LoginSuccess>());
      expect(h.storage.saveSessionCalls, 1);
      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.authenticated(demoUser),
      );
    });

    test('recorta espacios del correo antes de enviarlo', () async {
      // Un espacio pegado al final del correo, tipico del autocompletado del
      // teclado, produciria un 401 que el paciente no sabria explicar.
      final h = _harness();

      await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: '  paciente.demo@cauce.local  ', password: 'Secreta1');

      expect(h.repository.lastEmail, 'paciente.demo@cauce.local');
    });

    test('la contrasena se envia intacta', () async {
      // Recortarla cambiaria una contrasena valida que empiece o termine con
      // espacio, que es legitima.
      final h = _harness();

      await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: 'a@b.co', password: ' Secreta1 ');

      expect(h.repository.lastPassword, ' Secreta1 ');
    });
  });

  group('LoginNotifier · errores del contrato', () {
    test('credenciales invalidas quedan como fallo', () async {
      final h = _harness(error: const CauceApiError.invalidCredentials());

      final ok = await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: 'a@b.co', password: 'mala');

      expect(ok, isFalse);
      expect(
        h.container.read(loginNotifierProvider).error,
        isA<InvalidCredentialsError>(),
      );
      expect(h.storage.saveSessionCalls, 0);
      expect(
        h.container.read(sessionNotifierProvider),
        isA<SessionUnknown>(),
      );
    });

    test('cuenta bloqueada conserva lockedUntil para el countdown', () async {
      final lockedUntil = DateTime.utc(2026, 9, 2, 18);
      final h = _harness(
        error: CauceApiError.accountLocked(lockedUntil: lockedUntil),
      );

      await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: 'a@b.co', password: 'mala');

      expect(
        h.container.read(loginNotifierProvider).error,
        isA<AccountLockedError>().having(
          (e) => e.lockedUntil,
          'lockedUntil',
          lockedUntil,
        ),
      );
    });

    test('rate limit conserva los segundos de espera', () async {
      final h = _harness(
        error: const CauceApiError.rateLimited(retryAfterSeconds: 45),
      );

      await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: 'a@b.co', password: 'x');

      expect(
        h.container.read(loginNotifierProvider).error,
        isA<RateLimitedError>().having(
          (e) => e.retryAfterSeconds,
          'retryAfterSeconds',
          45,
        ),
      );
    });

    test('validacion expone los errores por campo', () async {
      final h = _harness(
        error: const CauceApiError.validation(
          fieldErrors: <String, List<String>>{
            'email': <String>['Formato invalido'],
          },
          errorCode: 'validation_error',
        ),
      );

      await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: 'roto', password: 'x');

      final error = h.container.read(loginNotifierProvider).error;
      expect(error, isA<ValidationError>());
      expect(
        (error! as ValidationError).fieldErrors['email'],
        <String>['Formato invalido'],
      );
    });

    test('sin red queda como error de red', () async {
      final h = _harness(error: const CauceApiError.network());

      await h.container
          .read(loginNotifierProvider.notifier)
          .submit(email: 'a@b.co', password: 'x');

      expect(
        h.container.read(loginNotifierProvider).error,
        isA<NetworkError>(),
      );
    });
  });

  group('LoginNotifier · control de reentrada', () {
    test('un doble toque no emite dos logins', () async {
      // El backend limita a 10 por minuto por IP: el segundo envio gastaria
      // cupo sin aportar nada.
      final h = _harness(delay: const Duration(milliseconds: 40));
      final notifier = h.container.read(loginNotifierProvider.notifier);

      final first = notifier.submit(email: 'a@b.co', password: 'x');
      final second = notifier.submit(email: 'a@b.co', password: 'x');
      final results = await Future.wait<bool>(<Future<bool>>[first, second]);

      expect(h.repository.loginCalls, 1);
      expect(results, <bool>[true, false]);
    });

    test('durante el envio el estado es submitting', () async {
      final h = _harness(delay: const Duration(milliseconds: 40));
      final notifier = h.container.read(loginNotifierProvider.notifier);

      final pending = notifier.submit(email: 'a@b.co', password: 'x');
      expect(h.container.read(loginNotifierProvider).isSubmitting, isTrue);

      await pending;
      expect(h.container.read(loginNotifierProvider).isSubmitting, isFalse);
    });
  });

  group('LoginNotifier · limpieza del error', () {
    test('clearError vuelve a idle tras un fallo', () async {
      final h = _harness(error: const CauceApiError.invalidCredentials());
      final notifier = h.container.read(loginNotifierProvider.notifier);
      await notifier.submit(email: 'a@b.co', password: 'x');

      notifier.clearError();

      expect(h.container.read(loginNotifierProvider), isA<LoginIdle>());
    });

    test('clearError no altera un exito', () async {
      final h = _harness();
      final notifier = h.container.read(loginNotifierProvider.notifier);
      await notifier.submit(email: 'a@b.co', password: 'x');

      notifier.clearError();

      expect(h.container.read(loginNotifierProvider), isA<LoginSuccess>());
    });
  });
}
