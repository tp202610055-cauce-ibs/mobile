import 'dart:convert';

import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/config/env.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/glossary/data/glossary_repository.dart';
import 'package:cauce_mobile/features/history/application/history_composer.dart';
import 'package:cauce_mobile/features/history/presentation/widgets/history_cards.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/meals/presentation/meal_form_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/canned_http_adapter.dart';
import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_glossary_repository.dart';
import '../helpers/fake_ibs_sss_repository.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_recommendations_repository.dart';
import '../helpers/fake_token_storage.dart';
import '../helpers/sync_fixtures.dart';

/// Cuantas llamadas hacen Inicio y el Diario con el volumen de un paciente que
/// anota 5 comidas y 2 sintomas al dia durante 90 dias.

const String _pendingGuid = 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb';

/// Reloj mutable que la prueba adelanta para cruzar la ventana de frescura.
class _Clock {
  DateTime now = DateTime(2026, 10, 11, 15);

  DateTime call() => now;
}

/// Servidor falso: 450 comidas y 180 sintomas paginados como el backend. Los
/// sintomas se filtran por occurredAt y no por clientCreatedAt; aqui coinciden.
class _HistoryServer extends CannedHttpAdapter {
  _HistoryServer(DateTime newest)
      : _meals = <Map<String, dynamic>>[
          for (var i = 0; i < 450; i++)
            _meal(i, newest.toUtc().subtract(Duration(minutes: 288 * i))),
        ],
        _symptoms = <Map<String, dynamic>>[
          for (var i = 0; i < 180; i++)
            _symptom(i, newest.toUtc().subtract(Duration(hours: 12 * i))),
        ],
        super(const CannedResponse.ok(<String, dynamic>{}));

  final List<Map<String, dynamic>> _meals;
  final List<Map<String, dynamic>> _symptoms;

  static Map<String, dynamic> _meal(int i, DateTime at) => <String, dynamic>{
        'mealId': 'meal-$i',
        'clientGuid': 'meal-guid-$i',
        'mealTime': 'Lunch',
        'consumedAt': at.toIso8601String(),
        'clientCreatedAt': at.toIso8601String(),
        'syncStatus': 'SyncCompleted',
        'items': <Map<String, dynamic>>[
          <String, dynamic>{
            'foodId': 'food-1',
            'quantity': 150,
            'unit': 'Grams',
          },
        ],
        'aggregatedFodmap': 'Low',
      };

  static Map<String, dynamic> _symptom(int i, DateTime at) => <String, dynamic>{
        'symptomId': 'symptom-$i',
        'clientGuid': 'symptom-guid-$i',
        'symptomType': 'Bloating',
        'intensity': 40,
        'occurredAt': at.toIso8601String(),
        'hasMealAssociation': false,
        'syncStatus': 'SyncCompleted',
      };

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    final path = Uri.parse(options.path).path;
    if (options.method == 'GET' && path.endsWith('/api/v1/meals')) {
      return _page(options, _meals, 'clientCreatedAt');
    }
    if (options.method == 'GET' && path.endsWith('/api/v1/symptoms')) {
      return _page(options, _symptoms, 'occurredAt');
    }
    response = switch (path) {
      _ when path.endsWith('/sync/batch') => const CannedResponse.ok(
          <String, dynamic>{
            'accepted': <Map<String, dynamic>>[
              <String, dynamic>{
                'clientGuid': _pendingGuid,
                'serverId': 'cccccccc-cccc-4ccc-8ccc-cccccccccccc',
                'entityType': 'Meal',
              },
            ],
            'duplicates': <Map<String, dynamic>>[],
            'errors': <Map<String, dynamic>>[],
          },
        ),
      _ when path.endsWith('/foods') => const CannedResponse.ok(
          <String, dynamic>{
            'items': <Map<String, dynamic>>[],
            'page': 1,
            'pageSize': 100,
            'totalCount': 0,
          },
        ),
      _ => const CannedResponse.ok(<String, dynamic>{}),
    };
    return super.fetch(options, requestStream, cancelFuture);
  }

  Future<ResponseBody> _page(
    RequestOptions options,
    List<Map<String, dynamic>> all,
    String dateField,
  ) async {
    requests.add(
      CapturedRequest(
        method: options.method,
        path: options.path,
        body: const <String, dynamic>{},
        headers: options.headers,
        queryParameters: options.queryParameters,
      ),
    );
    final query = options.queryParameters;
    final from = DateTime.parse(query['from']! as String);
    final to = DateTime.parse(query['to']! as String);
    final page = query['page']! as int;
    final pageSize = query['pageSize']! as int;
    final inRange = all.where((item) {
      final at = DateTime.parse(item[dateField]! as String);
      return !at.isBefore(from) && !at.isAfter(to);
    }).toList();
    final start = (page - 1) * pageSize;
    final items = start >= inRange.length
        ? <Map<String, dynamic>>[]
        : inRange.sublist(start, (start + pageSize).clamp(0, inRange.length));

    return ResponseBody.fromString(
      jsonEncode(<String, dynamic>{
        'items': items,
        'page': page,
        'pageSize': pageSize,
        'totalCount': inRange.length,
      }),
      200,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }
}

typedef _Harness = ({
  _HistoryServer server,
  _Clock clock,
  FakeConnectivityMonitor connectivity,
  AppDatabase database,
});

Future<_Harness> _pumpApp(WidgetTester tester, {bool online = false}) async {
  Env.loadForTesting(const <String, String>{
    'API_BASE_URL': 'http://localhost:5074',
    'ENV_NAME': 'dev',
    'CLIENT_ID': 'cauce-mobile',
    'DEEP_LINK_SCHEME': 'cauce',
  });
  addTearDown(Env.reset);

  final clock = _Clock();
  final server = _HistoryServer(clock.now);
  final database = AppDatabase.memory();
  final connectivity = FakeConnectivityMonitor(online: online);
  addTearDown(database.close);
  addTearDown(connectivity.dispose);

  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );

  final container = ProviderContainer(
    overrides: <Override>[
      appDatabaseProvider.overrideWithValue(database),
      connectivityMonitorProvider.overrideWithValue(connectivity),
      dioProvider.overrideWith((ref) {
        final dio = buildDio(
          tokenStorage: storage,
          baseUrl: 'http://localhost:5074',
        );
        dio.httpClientAdapter = server;
        return dio;
      }),
      historyClockProvider.overrideWithValue(clock.call),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(storage),
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      ),
      glossaryRepositoryProvider.overrideWithValue(FakeGlossaryRepository()),
      ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
      recommendationsRepositoryProvider.overrideWithValue(
        FakeRecommendationsRepository()
          ..generationError = const CauceApiError.insufficientClinicalHistory(),
      ),
      recommendationRequestStoreProvider.overrideWithValue(
        InMemoryRecommendationRequestStore(),
      ),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();

  return (
    server: server,
    clock: clock,
    connectivity: connectivity,
    database: database,
  );
}

extension on _Harness {
  List<CapturedRequest> get mealRequests =>
      server.requestsFor('GET', '/api/v1/meals');
  List<CapturedRequest> get symptomRequests =>
      server.requestsFor('GET', '/api/v1/symptoms');

  /// Llamadas a `/meals` y `/symptoms` hasta ahora.
  (int, int) get calls => (mealRequests.length, symptomRequests.length);

  /// Llamadas hechas desde [base].
  (int, int) since((int, int) base) => (calls.$1 - base.$1, calls.$2 - base.$2);
}

DateTime _from(CapturedRequest request) =>
    DateTime.parse(request.queryParameters['from']! as String);

Future<void> _tap(WidgetTester tester, String key) async {
  final target = find.byKey(Key(key));
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pumpAndSettle();
}

/// Abre el formulario de comida desde el FAB y vuelve con el retroceso de
/// Android, sin registrar.
Future<void> _openAndCloseMealForm(WidgetTester tester) async {
  await tester.tap(find.byKey(cauceFabKey));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('fab_meal')));
  await tester.pumpAndSettle();
  expect(find.byType(MealFormScreen), findsOneWidget);

  await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    'flutter/navigation',
    const JSONMethodCodec().encodeMethodCall(const MethodCall('popRoute')),
    (_) {},
  );
  await tester.pumpAndSettle();
  expect(find.byType(MealFormScreen), findsNothing);
}

void main() {
  group('Carga del Diario y de Hoy con 450 comidas y 180 sintomas', () {
    testWidgets(
        'abrir la app pide una pagina por tipo para Hoy, y entrar al Diario '
        'carga la ventana una sola vez', (tester) async {
      final h = await _pumpApp(tester);

      final inicioDelDia =
          DateTime(2026, 10, 11).subtract(const Duration(minutes: 5)).toUtc();
      expect(h.calls, (1, 1));
      expect(h.mealRequests.map(_from).toSet(), <DateTime>{inicioDelDia});
      expect(h.symptomRequests.map(_from).toSet(), <DateTime>{inicioDelDia});
      expect(
        tester.widget<Text>(find.byKey(const Key('home_today_summary'))).data,
        startsWith('4 comidas'),
      );

      final base = h.calls;
      await _tap(tester, 'nav_journal');

      expect(h.since(base), (5, 2));
      final noventaDias =
          h.clock.now.toUtc().subtract(const Duration(days: 90));
      expect(
        h.mealRequests.skip(base.$1).map(_from).toSet(),
        <DateTime>{noventaDias},
      );
      expect(find.byType(HistoryCard), findsWidgets);
    });

    testWidgets(
        'volver de un formulario recarga Hoy y el Diario aunque no pasaron '
        '30 s', (tester) async {
      final h = await _pumpApp(tester);
      await _tap(tester, 'nav_journal');
      final base = h.calls;

      await _openAndCloseMealForm(tester);

      expect(h.since(base), (6, 3));
    });

    testWidgets(
        'volver de un formulario sin haber abierto el Diario solo recarga Hoy',
        (tester) async {
      final h = await _pumpApp(tester);
      final base = h.calls;

      await _openAndCloseMealForm(tester);

      expect(h.since(base), (1, 1));
    });

    testWidgets(
        'el fin de una sincronizacion recarga Hoy y el Diario aunque no '
        'pasaron 30 s', (tester) async {
      final h = await _pumpApp(tester);
      await insertPendingMeal(h.database, _pendingGuid);
      await _tap(tester, 'nav_journal');
      final base = h.calls;

      h.connectivity.emitReconnection();
      await tester.pumpAndSettle();

      expect(h.server.requestsFor('POST', '/sync/batch'), hasLength(1));
      expect(h.since(base), (6, 3));
    });

    testWidgets(
        'ida y vuelta entre Inicio y el Diario: dentro de 30 s no recarga, '
        'pasados 30 s si', (tester) async {
      final h = await _pumpApp(tester);
      await _tap(tester, 'nav_journal');
      final base = h.calls;

      await _tap(tester, 'nav_home');
      await _tap(tester, 'nav_journal');
      expect(h.since(base), (0, 0));

      h.clock.now = h.clock.now.add(const Duration(seconds: 31));
      await _tap(tester, 'nav_home');
      expect(h.since(base), (1, 1));
      await _tap(tester, 'nav_journal');
      expect(h.since(base), (6, 3));
    });

    testWidgets('«Ver mi diario» recarga el Diario solo si pasaron 30 s',
        (tester) async {
      final h = await _pumpApp(tester);
      await _tap(tester, 'nav_journal');
      await _tap(tester, 'nav_home');
      final base = h.calls;

      await _tap(tester, 'home_open_journal');
      expect(h.since(base), (0, 0));

      await _tap(tester, 'nav_home');
      h.clock.now = h.clock.now.add(const Duration(seconds: 31));
      await _tap(tester, 'home_open_journal');
      expect(h.since(base), (5, 2));
    });

    testWidgets('tirar para refrescar recarga el Diario aunque no pasaron 30 s',
        (tester) async {
      final h = await _pumpApp(tester);
      await _tap(tester, 'nav_journal');
      final base = h.calls;

      await tester.fling(
        find.byType(ListView).first,
        const Offset(0, 400),
        1000,
      );
      await tester.pumpAndSettle();

      expect(h.since(base), (5, 2));
    });
  });
}
