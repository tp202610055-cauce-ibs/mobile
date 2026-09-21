import 'package:cauce_mobile/core/auth/token_storage.dart';
import 'package:cauce_mobile/core/config/env.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'canned_http_adapter.dart';
import 'sync_fixtures.dart';

/// Los bordes que `CauceApp` necesita desde Mobile-3.2.
///
/// Montar la aplicacion entera enciende los servicios de fondo (acta M39), y
/// esos servicios abren la base local, escuchan la conectividad y salen a la
/// red. Un test que monta `CauceApp` tiene que falsear esos tres bordes o
/// revienta con `Env.load() no fue invocado`, que es lo que paso al cablear
/// los servicios.
///
/// Registra sus propios `addTearDown`, de modo que quien lo llama solo suma
/// [overrides] a su contenedor.
typedef AppBorders = ({
  List<Override> overrides,
  AppDatabase database,
  FakeConnectivityMonitor connectivity,
  CannedHttpAdapter adapter,
});

/// Arma los bordes y los deja listos para el `ProviderContainer`.
///
/// [online] en `false` por defecto: un test de navegacion o de identidad no
/// quiere que la cola salga a sincronizar de fondo y le ensucie las llamadas
/// que si esta observando.
AppBorders appBorders({
  required TokenStorage storage,
  bool online = false,
  CannedHttpAdapter? adapter,
}) {
  Env.loadForTesting(const <String, String>{
    'API_BASE_URL': 'http://localhost:5074',
    'ENV_NAME': 'dev',
    'CLIENT_ID': 'cauce-mobile',
    'DEEP_LINK_SCHEME': 'cauce',
  });
  addTearDown(Env.reset);

  final database = AppDatabase.memory();
  final connectivity = FakeConnectivityMonitor(online: online);
  final transport = adapter ??
      CannedHttpAdapter(const CannedResponse.ok(<String, dynamic>{}));

  addTearDown(database.close);
  addTearDown(connectivity.dispose);

  return (
    overrides: <Override>[
      appDatabaseProvider.overrideWithValue(database),
      connectivityMonitorProvider.overrideWithValue(connectivity),
      // Solo el transporte: interceptors, cliente generado y mapeo de errores
      // siguen siendo los de produccion.
      dioProvider.overrideWith((ref) {
        final dio = buildDio(
          tokenStorage: storage,
          baseUrl: 'http://localhost:5074',
        );
        dio.httpClientAdapter = transport;
        return dio;
      }),
    ],
    database: database,
    connectivity: connectivity,
    adapter: transport,
  );
}
