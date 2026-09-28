import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/domain/session_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/canned_http_adapter.dart';
import '../helpers/fake_token_storage.dart';

const AuthenticatedUserSnapshot _verified = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

/// Cliente de `POST /auth/refresh` que responde siempre [statusCode].
Dio _refreshClientAnswering(int statusCode) {
  return Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = CannedHttpAdapter(
      CannedResponse.problem(
        statusCode: statusCode,
        errorCode: statusCode == 401 ? 'invalid_refresh_token' : null,
      ),
    );
}

/// Monta la aplicacion entera con una sesion guardada cuyo access token el
/// backend ya no acepta: toda peticion protegida responde 401.
Future<({ProviderContainer container, FakeTokenStorage storage})> _pumpApp(
  WidgetTester tester, {
  required int refreshStatus,
}) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-vencido',
    refreshToken: 'refresh-1',
    userSnapshot: _verified,
  );
  final borders = appBorders(
    storage: storage,
    adapter: CannedHttpAdapter(CannedResponse.problem(statusCode: 401)),
    refreshClient: _refreshClientAnswering(refreshStatus),
  );

  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(storage),
      ...borders.overrides,
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (container: container, storage: storage);
}

/// La vuelta al login cuando la sesion ya no se puede renovar (acta M49).
///
/// Monta `CauceApp` con la composicion real, como pide R12: el cableado entre
/// la red y la sesion es justamente lo que faltaba, y un test que armara el
/// interceptor suelto no lo habria visto.
void main() {
  testWidgets('un refresh rechazado lleva la app al login', (tester) async {
    final h = await _pumpApp(tester, refreshStatus: 401);

    expect(
      h.container.read(sessionNotifierProvider),
      isA<SessionUnauthenticated>(),
    );
    expect(find.byKey(const Key('login_email')), findsOneWidget);
    expect(h.storage.refreshToken, isNull);
  });

  testWidgets('un 500 del refresh no saca al paciente de la app',
      (tester) async {
    // Transitorio (acta M25): la sesion sigue y el paciente no pierde su
    // lugar por una caida momentanea del servidor.
    final h = await _pumpApp(tester, refreshStatus: 500);

    expect(
      h.container.read(sessionNotifierProvider),
      isA<SessionAuthenticated>(),
    );
    expect(find.byKey(const Key('login_email')), findsNothing);
    expect(h.storage.refreshToken, 'refresh-1');
  });
}
