import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/canned_http_adapter.dart';
import '../helpers/fake_token_storage.dart';
import '../helpers/sync_fixtures.dart';

/// Los servicios de fondo, sobre la composicion real de la aplicacion.
///
/// **Esta es la prueba que le falto a Mobile-3.** Los 17 tests de `SyncWorker`
/// lo instancian a mano y le disparan la reconexion ellos mismos, de modo que
/// pasaban en verde mientras en la aplicacion de verdad nadie creaba el objeto
/// y la cola no subia nunca. Aca se monta `CauceApp` entero, con los providers
/// de produccion, y solo se sustituyen los bordes: el transporte HTTP, la
/// conectividad, el Keystore y el archivo de la base.
///
/// Si alguien borra el `ref.watch(sessionBackgroundServicesProvider)` de
/// `app.dart`, este archivo se pone rojo. Ese es su trabajo (R12).

const AuthenticatedUserSnapshot _verified = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

const String _pendingGuid = 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb';

/// Adaptador que responde por sufijo de ruta y deja pasar el resto.
///
/// La tolerancia es deliberada: lo que se afirma aca es que **se llamo** a
/// `/sync/batch`, y hacer fallar el test por una ruta lateral que la home
/// consulta de paso lo volveria fragil sin agregar nada.
class _RoutedAdapter extends CannedHttpAdapter {
  _RoutedAdapter(this.routes) : super(const CannedResponse.ok(<String, dynamic>{}));

  final Map<String, CannedResponse> routes;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    for (final entry in routes.entries) {
      if (options.path.endsWith(entry.key)) {
        response = entry.value;
        return super.fetch(options, null, cancelFuture);
      }
    }
    response = const CannedResponse.ok(<String, dynamic>{});
    return super.fetch(options, null, cancelFuture);
  }
}

/// Lote aceptado por el servidor, con el guid que el test encolo.
CannedResponse get _batchAccepted => const CannedResponse.ok(<String, dynamic>{
      'accepted': <Map<String, dynamic>>[
        <String, dynamic>{
          'clientGuid': _pendingGuid,
          'serverId': 'cccccccc-cccc-4ccc-8ccc-cccccccccccc',
          'entityType': 'Meal',
        },
      ],
      'duplicates': <Map<String, dynamic>>[],
      'errors': <Map<String, dynamic>>[],
    });

CannedResponse get _emptyCatalogPage => const CannedResponse.ok(
      <String, dynamic>{
        'items': <Map<String, dynamic>>[],
        'page': 1,
        'pageSize': 100,
        'totalCount': 0,
      },
    );

typedef _Harness = ({
  ProviderContainer container,
  _RoutedAdapter adapter,
  FakeConnectivityMonitor connectivity,
  AppDatabase database,
});

Future<_Harness> _pumpApp(
  WidgetTester tester, {
  required bool online,
  AuthenticatedUserSnapshot? session = _verified,
}) async {
  final adapter = _RoutedAdapter(<String, CannedResponse>{
    '/sync/batch': _batchAccepted,
    '/foods': _emptyCatalogPage,
    '/auth/logout': const CannedResponse.noContent(),
  });
  final connectivity = FakeConnectivityMonitor(online: online);
  final database = AppDatabase.memory();
  final storage = session == null
      ? FakeTokenStorage()
      : FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: session,
        );

  addTearDown(connectivity.dispose);
  addTearDown(database.close);

  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(storage),
      connectivityMonitorProvider.overrideWithValue(connectivity),
      appDatabaseProvider.overrideWithValue(database),
      // Solo el transporte: interceptors, cliente generado y mapeo de errores
      // son los de produccion.
      dioProvider.overrideWith((ref) {
        final dio = buildDio(
          tokenStorage: storage,
          baseUrl: 'http://localhost:5074',
        );
        dio.httpClientAdapter = adapter;
        return dio;
      }),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();

  return (
    container: container,
    adapter: adapter,
    connectivity: connectivity,
    database: database,
  );
}

void main() {
  group('R12 · los servicios de fondo se encienden con la sesion', () {
    testWidgets('lo pendiente sube solo al volver la conexion',
        (tester) async {
      // Arranca sin red y con una comida ya encolada, que es como queda el
      // dispositivo despues de un registro en modo avion.
      final h = await _pumpApp(tester, online: false);
      await insertPendingMeal(h.database, _pendingGuid);

      expect(
        h.adapter.requestsFor('POST', '/sync/batch'),
        isEmpty,
        reason: 'sin conexion no deberia haber salido ningun lote',
      );

      // Vuelve la conexion. Nadie toca la pantalla: esto es exactamente lo
      // que en el celular no pasaba.
      h.connectivity.emitReconnection();
      await tester.pumpAndSettle();

      expect(h.adapter.requestsFor('POST', '/sync/batch'), hasLength(1));
    });

    testWidgets('el lote lleva la comida que estaba pendiente',
        (tester) async {
      final h = await _pumpApp(tester, online: false);
      await insertPendingMeal(h.database, _pendingGuid);

      h.connectivity.emitReconnection();
      await tester.pumpAndSettle();

      final batch = h.adapter.requestsFor('POST', '/sync/batch').single;
      expect(batch.body.toString(), contains(_pendingGuid));
    });

    testWidgets('el catalogo se refresca al abrir sesion (acta M35)',
        (tester) async {
      final h = await _pumpApp(tester, online: true);

      expect(
        h.adapter.requestsFor('GET', '/foods'),
        isNotEmpty,
        reason: 'el refresher tiene que correr al restaurar la sesion',
      );
    });

    testWidgets('sin sesion no se enciende nada', (tester) async {
      // Sin sesion la app se queda en el login, y un worker escuchando ahi
      // solo puede hacer dano.
      final h = await _pumpApp(tester, online: true, session: null);
      await insertPendingMeal(h.database, _pendingGuid);

      h.connectivity.emitReconnection();
      await tester.pumpAndSettle();

      expect(h.adapter.requestsFor('POST', '/sync/batch'), isEmpty);
    });
  });
}
