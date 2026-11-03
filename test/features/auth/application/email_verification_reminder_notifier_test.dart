import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/refreshed_user.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/errors/session_expired_exception.dart';
import 'package:cauce_mobile/core/network/session_renewal.dart';
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

/// Renovacion falsa: corre [onRenew], que hace lo que haria el interceptor.
class _FakeRenewal implements SessionRenewal {
  _FakeRenewal(this.onRenew);

  Future<void> Function() onRenew;
  int calls = 0;

  @override
  Future<void> renew() {
    calls++;
    return onRenew();
  }
}

typedef _Harness = ({
  ProviderContainer container,
  FakeTokenStorage storage,
  _FakeRenewal renewal,
});

/// Lo que deja una renovacion exitosa: guarda el usuario y lo publica.
Future<void> Function() _renewsWith(
  _Harness h,
  AuthenticatedUserSnapshot user,
) {
  return () async {
    h.storage.userSnapshot = user;
    h.container.read(refreshedUserProvider.notifier).publish(user);
  };
}

Future<_Harness> _harness(AuthenticatedUserSnapshot? user) async {
  final storage = user == null
      ? FakeTokenStorage()
      : FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: user,
        );
  final renewal = _FakeRenewal(() async {});
  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(storage),
      sessionRenewalProvider.overrideWithValue(renewal),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).bootstrap();
  return (container: container, storage: storage, renewal: renewal);
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

    test('confirmar renueva y, si el servidor lo da verificado, lo retira',
        () async {
      final h = await _harness(_unverified);
      h.renewal.onRenew =
          _renewsWith(h, _unverified.copyWith(emailVerified: true));

      await h.container
          .read(emailVerificationReminderProvider.notifier)
          .confirm();

      expect(h.renewal.calls, 1);
      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
    });

    test('confirmar sin verificar avisa que sigue pendiente', () async {
      final h = await _harness(_unverified);
      h.renewal.onRenew = _renewsWith(h, _unverified);

      await h.container
          .read(emailVerificationReminderProvider.notifier)
          .confirm();

      expect(
        h.container.read(emailVerificationReminderProvider),
        const EmailVerificationReminderState.visible(
          email: 'nuevo@cauce.local',
          stillPending: true,
        ),
      );
    });

    test('un error de red queda en el estado y se puede reintentar', () async {
      final h = await _harness(_unverified);
      final notifier =
          h.container.read(emailVerificationReminderProvider.notifier);
      h.renewal.onRenew = () async => throw const CauceApiError.network();

      await notifier.confirm();
      expect(
        h.container.read(emailVerificationReminderProvider),
        const EmailVerificationReminderState.visible(
          email: 'nuevo@cauce.local',
          error: CauceApiError.network(),
        ),
      );

      h.renewal.onRenew =
          _renewsWith(h, _unverified.copyWith(emailVerified: true));
      await notifier.confirm();
      expect(h.renewal.calls, 2);
      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
    });

    test('una sesion vencida durante la renovacion no deja error', () async {
      final h = await _harness(_unverified);
      h.renewal.onRenew = () async {
        h.container.read(sessionNotifierProvider.notifier).expire();
        throw const SessionExpiredException();
      };

      await h.container
          .read(emailVerificationReminderProvider.notifier)
          .confirm();

      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
    });

    test('cualquier renovacion que publique el correo verificado lo retira',
        () async {
      final h = await _harness(_unverified);
      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderVisible>(),
      );

      h.container
          .read(refreshedUserProvider.notifier)
          .publish(_unverified.copyWith(emailVerified: true));

      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderHidden>(),
      );
      expect(h.renewal.calls, 0);
    });

    test('una renovacion de otra cuenta o sin verificar no lo retira',
        () async {
      final h = await _harness(_unverified);

      h.container.read(refreshedUserProvider.notifier)
        ..publish(_unverified)
        ..publish(_unverified.copyWith(userId: 'otra', emailVerified: true));

      expect(
        h.container.read(emailVerificationReminderProvider),
        isA<EmailVerificationReminderVisible>(),
      );
    });

    test('comprobar en silencio no avisa ni sale a la red', () async {
      final h = await _harness(_unverified);

      await h.container
          .read(emailVerificationReminderProvider.notifier)
          .check();

      expect(
        h.container.read(emailVerificationReminderProvider),
        const EmailVerificationReminderState.visible(
          email: 'nuevo@cauce.local',
        ),
      );
      expect(h.renewal.calls, 0);
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
