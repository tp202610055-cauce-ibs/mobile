import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/features/auth/application/email_verification_reminder_notifier.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_token_storage.dart';

const AuthenticatedUserSnapshot _unverified = AuthenticatedUserSnapshot(
  userId: 'e1f2a3b4-0000-0000-0000-000000000000',
  keycloakId: 'c2d3e4f5-0000-0000-0000-000000000000',
  email: 'nuevo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Nuevo',
  emailVerified: false,
  isInActivePilot: true,
);

Future<({ProviderContainer container, FakeTokenStorage storage})> _harness(
  AuthenticatedUserSnapshot? user,
) async {
  final storage = user == null
      ? FakeTokenStorage()
      : FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: user,
        );
  final container = ProviderContainer(
    overrides: <Override>[tokenStorageProvider.overrideWithValue(storage)],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).bootstrap();
  return (container: container, storage: storage);
}

void main() {
  group('EmailVerificationReminder', () {
    test('se muestra con la sesion sin verificar', () async {
      final h = await _harness(_unverified);

      expect(
        h.container.read(emailVerificationReminderProvider),
        const EmailVerificationReminderState.visible(
          email: 'nuevo@cauce.local',
        ),
      );
    });

    test('se oculta con el correo verificado o sin sesion', () async {
      final verified =
          await _harness(_unverified.copyWith(emailVerified: true));
      final signedOut = await _harness(null);

      expect(
        verified.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
      expect(
        signedOut.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
    });

    test('sigue sin verificar: lo avisa solo si se pidio', () async {
      final h = await _harness(_unverified);
      final notifier = h.container.read(
        emailVerificationReminderProvider.notifier,
      );

      await notifier.check(announce: false);
      expect(
        h.container.read(emailVerificationReminderProvider),
        const EmailVerificationReminderState.visible(
          email: 'nuevo@cauce.local',
        ),
      );

      await notifier.check();
      expect(
        h.container.read(emailVerificationReminderProvider),
        const EmailVerificationReminderState.visible(
          email: 'nuevo@cauce.local',
          stillPending: true,
        ),
      );
    });

    test('el snapshot guardado ya verificado lo retira', () async {
      final h = await _harness(_unverified);
      h.storage.userSnapshot = _unverified.copyWith(emailVerified: true);

      await h.container
          .read(emailVerificationReminderProvider.notifier)
          .check();

      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
    });

    test('un snapshot de otra cuenta no lo retira', () async {
      final h = await _harness(_unverified);
      h.storage.userSnapshot = _unverified.copyWith(
        email: 'otra@cauce.local',
        emailVerified: true,
      );

      await h.container
          .read(emailVerificationReminderProvider.notifier)
          .check();

      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderVisible>(),
      );
    });

    test('cerrar sesion lo oculta', () async {
      final h = await _harness(_unverified);

      h.container.read(sessionNotifierProvider.notifier).expire();

      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
    });
  });
}
