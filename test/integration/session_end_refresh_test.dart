import 'dart:async';
import 'dart:typed_data';

import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/domain/session_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/canned_http_adapter.dart';
import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_token_storage.dart';

const String _baseUrl = 'http://localhost:5074';

/// `POST /auth/refresh` que responde un par rotado, con usuario, recien cuando
/// el test suelta [gate].
class _GatedRefreshAdapter implements HttpClientAdapter {
  _GatedRefreshAdapter(this.gate);

  final Completer<void> gate;
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    await gate.future;
    return ResponseBody.fromString(
      '{"accessToken":"access-2","refreshToken":"refresh-2",'
      '"user":{"userId":"${demoUser.userId}",'
      '"keycloakId":"${demoUser.keycloakId}","email":"${demoUser.email}",'
      '"role":"patient","fullName":"Paciente Demo","emailVerified":true,'
      '"isInActivePilot":true}}',
      200,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

typedef _Harness = ({
  ProviderContainer container,
  FakeTokenStorage storage,
  Completer<void> gate,
  _GatedRefreshAdapter refresh,
});

Future<_Harness> _harness() async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );
  final gate = Completer<void>();
  final refresh = _GatedRefreshAdapter(gate);
  final borders = appBorders(
    storage: storage,
    // Toda ruta protegida responde 401: el access token vencio.
    adapter: CannedHttpAdapter(
      CannedResponse.problem(statusCode: 401, errorCode: 'invalid_token'),
    ),
    refreshClient: Dio(BaseOptions(baseUrl: _baseUrl))
      ..httpClientAdapter = refresh,
  );
  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).bootstrap();
  return (
    container: container,
    storage: storage,
    gate: gate,
    refresh: refresh,
  );
}

/// Arranque siguiente sobre el mismo almacenamiento.
Future<SessionState> _nextLaunch(FakeTokenStorage storage) async {
  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(storage),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).bootstrap();
  return container.read(sessionNotifierProvider);
}

/// Deja una renovacion en vuelo, cierra la sesion con [close] y la suelta.
Future<void> _refreshFinishingAfter(
  _Harness h,
  Future<void> Function(SessionNotifier notifier) close,
) async {
  final request = h.container.read(dioProvider).get<dynamic>(
        '/api/v1/patients/me',
      );
  final failure = expectLater(request, throwsA(isA<DioException>()));
  await pumpEventQueue();
  expect(h.refresh.calls, 1, reason: 'la renovacion tiene que estar en vuelo');

  await close(h.container.read(sessionNotifierProvider.notifier));
  h.gate.complete();
  await failure;
}

void main() {
  group('Renovacion en vuelo al cerrar la sesion (HU0008, CP021)', () {
    test('tras el cierre por inactividad no vuelve a guardar las llaves',
        () async {
      final h = await _harness();

      await _refreshFinishingAfter(h, (n) => n.endForInactivity());

      expect(h.storage.accessToken, isNull);
      expect(h.storage.refreshToken, isNull);
      expect(h.storage.userSnapshot, isNull);
    });

    test('tras el cierre por inactividad el proximo arranque no abre sesion',
        () async {
      final h = await _harness();

      await _refreshFinishingAfter(h, (n) => n.endForInactivity());

      expect(await _nextLaunch(h.storage), isA<SessionUnauthenticated>());
    });

    test('tras el cierre manual no vuelve a guardar las llaves', () async {
      final h = await _harness();

      await _refreshFinishingAfter(h, (n) => n.logout());

      expect(h.storage.refreshToken, isNull);
      expect(await _nextLaunch(h.storage), isA<SessionUnauthenticated>());
    });

    test('sin cierre de por medio la renovacion si guarda el par nuevo',
        () async {
      final h = await _harness();
      final request = h.container.read(dioProvider).get<dynamic>(
            '/api/v1/patients/me',
          );
      final done = expectLater(request, throwsA(isA<DioException>()));
      await pumpEventQueue();

      h.gate.complete();
      await done;

      expect(h.storage.refreshToken, 'refresh-2');
    });
  });
}
