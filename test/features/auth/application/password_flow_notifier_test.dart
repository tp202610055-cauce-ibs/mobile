import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/password_recovery_notifier.dart';
import 'package:cauce_mobile/features/auth/application/password_reset_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';

({ProviderContainer container, FakeAuthRepository repository}) _harness({
  CauceApiError? error,
  Duration delay = Duration.zero,
}) {
  final repository = FakeAuthRepository(error: error, delay: delay);
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(repository),
    ],
  );
  addTearDown(container.dispose);
  return (container: container, repository: repository);
}

void main() {
  group('PasswordRecoveryNotifier · US07 CA01', () {
    test('una solicitud aceptada pasa a enviado', () async {
      final h = _harness();

      final ok = await h.container
          .read(passwordRecoveryNotifierProvider.notifier)
          .submit(email: 'paciente.demo@cauce.local');

      expect(ok, isTrue);
      expect(
        h.container.read(passwordRecoveryNotifierProvider),
        isA<PasswordRecoverySent>(),
      );
      expect(h.repository.requestPasswordResetCalls, 1);
    });

    test('recorta espacios del correo', () async {
      final h = _harness();

      await h.container
          .read(passwordRecoveryNotifierProvider.notifier)
          .submit(email: '  paciente.demo@cauce.local ');

      expect(h.repository.lastEmail, 'paciente.demo@cauce.local');
    });

    test('un rate limit deja el error con su espera', () async {
      // 3 por hora por IP: es la politica mas estricta del contrato, asi que
      // este error es el mas probable de este flujo.
      final h = _harness(
        error: const CauceApiError.rateLimited(retryAfterSeconds: 900),
      );

      final ok = await h.container
          .read(passwordRecoveryNotifierProvider.notifier)
          .submit(email: 'a@b.co');

      expect(ok, isFalse);
      expect(
        h.container.read(passwordRecoveryNotifierProvider).error,
        isA<RateLimitedError>().having(
          (e) => e.retryAfterSeconds,
          'retryAfterSeconds',
          900,
        ),
      );
    });

    test('sin red no avanza a la confirmacion', () async {
      final h = _harness(error: const CauceApiError.network());

      final ok = await h.container
          .read(passwordRecoveryNotifierProvider.notifier)
          .submit(email: 'a@b.co');

      expect(ok, isFalse);
      expect(
        h.container.read(passwordRecoveryNotifierProvider),
        isA<PasswordRecoveryFailure>(),
      );
    });

    test('un doble toque no emite dos solicitudes', () async {
      final h = _harness(delay: const Duration(milliseconds: 40));
      final notifier = h.container.read(
        passwordRecoveryNotifierProvider.notifier,
      );

      await Future.wait<bool>(<Future<bool>>[
        notifier.submit(email: 'a@b.co'),
        notifier.submit(email: 'a@b.co'),
      ]);

      expect(h.repository.requestPasswordResetCalls, 1);
    });
  });

  group('PasswordResetNotifier · US07 CA02', () {
    test('una confirmacion aceptada pasa a exito', () async {
      final h = _harness();

      final ok = await h.container
          .read(passwordResetNotifierProvider.notifier)
          .submit(token: 'abc123', newPassword: 'NuevaClave1');

      expect(ok, isTrue);
      expect(
        h.container.read(passwordResetNotifierProvider),
        isA<PasswordResetSuccess>(),
      );
      expect(h.repository.lastToken, 'abc123');
      expect(h.repository.lastNewPassword, 'NuevaClave1');
    });

    test('un token invalido pide enlace nuevo', () async {
      final h = _harness(
        error: const CauceApiError.passwordResetToken(
          reason: PasswordResetTokenReason.invalid,
        ),
      );

      await h.container
          .read(passwordResetNotifierProvider.notifier)
          .submit(token: 'roto', newPassword: 'NuevaClave1');

      // Reintentar con el mismo token no va a funcionar nunca: la pantalla
      // debe ofrecer la salida en vez de dejar reintentar.
      expect(
        h.container.read(passwordResetNotifierProvider).needsFreshLink,
        isTrue,
      );
    });

    test('un token vencido tambien pide enlace nuevo', () async {
      final h = _harness(
        error: const CauceApiError.passwordResetToken(
          reason: PasswordResetTokenReason.expired,
        ),
      );

      await h.container
          .read(passwordResetNotifierProvider.notifier)
          .submit(token: 'viejo', newPassword: 'NuevaClave1');

      expect(
        h.container.read(passwordResetNotifierProvider).needsFreshLink,
        isTrue,
      );
    });

    test('una contrasena debil no pide enlace nuevo', () async {
      // El token sigue sirviendo: el problema es la contrasena, y ofrecer un
      // enlace nuevo mandaria al paciente a rehacer un tramite innecesario.
      final h = _harness(
        error: const CauceApiError.validation(
          fieldErrors: <String, List<String>>{
            'newPassword': <String>['Debe contener al menos un digito.'],
          },
          errorCode: 'validation_error',
        ),
      );

      await h.container
          .read(passwordResetNotifierProvider.notifier)
          .submit(token: 'abc123', newPassword: 'debil');

      final state = h.container.read(passwordResetNotifierProvider);
      expect(state.needsFreshLink, isFalse);
      expect(state.error, isA<ValidationError>());
    });

    test('un doble toque no emite dos confirmaciones', () async {
      final h = _harness(delay: const Duration(milliseconds: 40));
      final notifier = h.container.read(passwordResetNotifierProvider.notifier);

      await Future.wait<bool>(<Future<bool>>[
        notifier.submit(token: 'abc', newPassword: 'NuevaClave1'),
        notifier.submit(token: 'abc', newPassword: 'NuevaClave1'),
      ]);

      expect(h.repository.confirmPasswordResetCalls, 1);
    });

    test('clearError vuelve a idle', () async {
      final h = _harness(error: const CauceApiError.network());
      final notifier = h.container.read(passwordResetNotifierProvider.notifier);
      await notifier.submit(token: 'abc', newPassword: 'NuevaClave1');

      notifier.clearError();

      expect(
        h.container.read(passwordResetNotifierProvider),
        isA<PasswordResetIdle>(),
      );
    });
  });
}
