import 'dart:async';

import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/foods/data/food_catalog_store.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/history/application/history_composer.dart';
import 'package:cauce_mobile/features/history/application/history_notifier.dart';
import 'package:cauce_mobile/features/history/domain/history_entry.dart';
import 'package:cauce_mobile/features/meals/data/meals_local_store.dart';
import 'package:cauce_mobile/features/meals/data/meals_repository.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/meals/domain/meal_record.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/paged_history_fakes.dart';
import '../../../helpers/sync_fixtures.dart';

class _MockMealsRepository extends Mock implements MealsRepository {}

class _MockSymptomsRepository extends Mock implements SymptomsRepository {}

const String _mealGuid = '11111111-1111-4111-8111-111111111111';
const String _symptomGuid = '22222222-2222-4222-8222-222222222222';

/// Momento fijo de las pruebas de la ventana completa.
final DateTime _now = DateTime.utc(2026, 10, 11, 20);

/// Cuenta las lecturas de nombres del catalogo.
class _CountingCatalog extends FoodCatalogStore {
  _CountingCatalog(super.db);

  int calls = 0;

  @override
  Future<List<FoodItem>> findByIds(Iterable<String> foodIds) {
    calls++;
    return super.findByIds(foodIds);
  }
}

/// Cuenta las lecturas de items de comidas locales.
class _CountingMealsStore extends MealsLocalStore {
  _CountingMealsStore(AppDatabase db) : super(db, const Uuid());

  int itemReads = 0;

  @override
  Future<List<MealItemLocal>> itemsOf(String clientGuid) {
    itemReads++;
    return super.itemsOf(clientGuid);
  }

  @override
  Future<List<MealItemLocal>> itemsOfMany(Iterable<String> clientGuids) {
    itemReads++;
    return super.itemsOfMany(clientGuids);
  }
}

/// Almacen local que falla al leer, como un disco que no responde.
class _BrokenMealsStore extends MealsLocalStore {
  _BrokenMealsStore(AppDatabase db) : super(db, const Uuid());

  @override
  Future<List<MealLocal>> forHistory({required DateTime from}) async {
    throw StateError('lectura local fallida');
  }
}

/// Registra cada asignacion de estado y cuantas iban al cerrarse.
class _SpyHistory extends HistoryNotifier {
  int assigned = 0;
  int? assignedAtDispose;

  @override
  HistoryState build() {
    ref.onDispose(() => assignedAtDispose = assigned);
    return super.build();
  }

  @override
  set state(HistoryState value) {
    assigned++;
    super.state = value;
  }
}

/// Deja correr las consultas locales y las respuestas falsas pendientes.
Future<void> _settle() async {
  for (var i = 0; i < 20; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

/// Agrega un alimento a la caja local del catalogo.
Future<void> _insertFood(AppDatabase db, String foodId, String name) {
  return db.into(db.foodCatalogCache).insert(
        FoodCatalogCacheCompanion.insert(
          foodId: foodId,
          name: name,
          nameNormalized: name.toLowerCase(),
          category: 'cereales',
          fodmapLevel: 'Low',
          isPeruvian: true,
        ),
      );
}

/// Contenedor con repositorios paginados, base en memoria y reloj fijo.
ProviderContainer _pagedContainer({
  required AppDatabase database,
  required MealsRepository meals,
  required SymptomsRepository symptoms,
  DateTime Function()? clock,
  List<Override> extra = const <Override>[],
}) {
  final container = ProviderContainer(
    overrides: <Override>[
      appDatabaseProvider.overrideWithValue(database),
      mealsRepositoryProvider.overrideWithValue(meals),
      symptomsRepositoryProvider.overrideWithValue(symptoms),
      historyClockProvider.overrideWithValue(clock ?? () => _now),
      ...extra,
    ],
  );
  addTearDown(container.dispose);
  container.listen(historyNotifierProvider, (_, __) {});
  return container;
}

void main() {
  late AppDatabase database;
  late _MockMealsRepository meals;
  late _MockSymptomsRepository symptoms;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase.memory();
    meals = _MockMealsRepository();
    symptoms = _MockSymptomsRepository();
    container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(database),
        mealsRepositoryProvider.overrideWithValue(meals),
        symptomsRepositoryProvider.overrideWithValue(symptoms),
      ],
    );

    when(
      () => meals.history(
        from: any(named: 'from'),
        to: any(named: 'to'),
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
      ),
    ).thenAnswer((_) async => const MealHistoryPage());
    when(
      () => symptoms.history(
        from: any(named: 'from'),
        to: any(named: 'to'),
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
      ),
    ).thenAnswer((_) async => const SymptomHistoryPage());
  });

  tearDown(() async {
    container.dispose();
    await database.close();
  });

  HistoryNotifier notifier() =>
      container.read(historyNotifierProvider.notifier);
  HistoryState state() => container.read(historyNotifierProvider);

  group('HistoryNotifier · composicion del historial', () {
    test('no usa GET /history: junta comidas y sintomas del servidor',
        () async {
      // El contrato aplana la jerarquia polimorfica de HistoryEvent y el
      // cliente generado descarta el payload en silencio.
      when(
        () => meals.history(
          from: any(named: 'from'),
          to: any(named: 'to'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => MealHistoryPage(
          items: <MealRecord>[
            MealRecord(
              mealId: 'server-meal',
              consumedAt: DateTime.utc(2026, 9, 18, 13),
              mealTime: MealTimeOption.lunch,
            ),
          ],
          totalCount: 1,
        ),
      );
      when(
        () => symptoms.history(
          from: any(named: 'from'),
          to: any(named: 'to'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => SymptomHistoryPage(
          items: <SymptomRecord>[
            SymptomRecord(
              symptomId: 'server-symptom',
              occurredAt: DateTime.utc(2026, 9, 18, 15),
              intensity: 40,
              symptomType: SymptomTypeOption.bloating,
            ),
          ],
          totalCount: 1,
        ),
      );

      await notifier().load();

      expect(state().entries, hasLength(2));
      expect(
        state().entries.map((e) => e.kind),
        containsAll(<HistoryEntryKind>[
          HistoryEntryKind.meal,
          HistoryEntryKind.symptom,
        ]),
      );
    });

    test('ordena de la mas reciente a la mas vieja', () async {
      when(
        () => meals.history(
          from: any(named: 'from'),
          to: any(named: 'to'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => MealHistoryPage(
          items: <MealRecord>[
            MealRecord(
              mealId: 'm1',
              consumedAt: DateTime.utc(2026, 9, 18, 8),
            ),
            MealRecord(
              mealId: 'm2',
              consumedAt: DateTime.utc(2026, 9, 18, 20),
            ),
          ],
          totalCount: 2,
        ),
      );

      await notifier().load();

      expect(state().entries.first.serverId, 'm2');
      expect(state().entries.last.serverId, 'm1');
    });

    test('intercala lo pendiente del dispositivo', () async {
      await insertPendingMeal(database, _mealGuid);
      await insertPendingSymptom(database, _symptomGuid);

      await notifier().load();

      expect(state().entries, hasLength(2));
      expect(state().unsynced, hasLength(2));
      expect(
        state().entries.map((e) => e.syncState).toSet(),
        <HistoryEntrySyncState>{HistoryEntrySyncState.pending},
      );
    });

    test('no duplica una fila que ya sincronizo', () async {
      // La local y la remota son la misma comida: se deduplica por clientGuid,
      // que es exactamente para lo que existe.
      await insertPendingMeal(
        database,
        _mealGuid,
        status: LocalSyncStatus.completed,
      );
      when(
        () => meals.history(
          from: any(named: 'from'),
          to: any(named: 'to'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => MealHistoryPage(
          items: <MealRecord>[
            MealRecord(
              mealId: 'server-meal',
              clientGuid: _mealGuid,
              consumedAt: DateTime.utc(2026, 9, 18, 13),
            ),
          ],
          totalCount: 1,
        ),
      );

      await notifier().load();

      expect(state().entries, hasLength(1));
      // Gana la del servidor: trae datos que la local no tiene.
      expect(state().entries.single.serverId, 'server-meal');
    });

    test('un fallo del servidor no vacia lo local', () async {
      // Es justamente lo que el paciente no puede consultar en ningun otro
      // lado.
      await insertPendingMeal(database, _mealGuid);
      when(
        () => meals.history(
          from: any(named: 'from'),
          to: any(named: 'to'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenThrow(const CauceApiError.network());

      await notifier().load();

      expect(state().error, isA<NetworkError>());
      expect(state().entries, hasLength(1));
    });
  });

  group('HistoryNotifier · notas de contexto (US13)', () {
    test('una entrada sincronizada admite nota', () async {
      when(
        () => meals.history(
          from: any(named: 'from'),
          to: any(named: 'to'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async => MealHistoryPage(
          items: <MealRecord>[
            MealRecord(
              mealId: 'server-meal',
              consumedAt: DateTime.utc(2026, 9, 18, 13),
            ),
          ],
          totalCount: 1,
        ),
      );

      await notifier().load();

      expect(state().entries.single.acceptsNote, isTrue);
    });

    test('una entrada pendiente no admite nota', () async {
      // `CreateClinicalNoteRequest` exige un mealId o symptomId **del
      // servidor**: ofrecer la accion llevaria a un 404 despues de escribir.
      await insertPendingMeal(database, _mealGuid);

      await notifier().load();

      expect(state().entries.single.acceptsNote, isFalse);
    });

    test('una entrada terminal tampoco', () async {
      await insertPendingSymptom(
        database,
        _symptomGuid,
        status: LocalSyncStatus.failed,
      );

      await notifier().load();

      expect(state().entries.single.acceptsNote, isFalse);
      expect(state().entries.single.isDiscardable, isTrue);
    });
  });

  group('HistoryNotifier · descarte de una fila trabada', () {
    test('la borra y relee', () async {
      await insertPendingMeal(
        database,
        _mealGuid,
        status: LocalSyncStatus.failed,
      );
      await notifier().load();
      expect(state().entries, hasLength(1));

      await notifier().discard(_mealGuid);

      expect(state().entries, isEmpty);
      expect(await database.select(database.mealsLocal).get(), isEmpty);
    });

    test('no borra una que ya llego al servidor', () async {
      await insertPendingMeal(
        database,
        _mealGuid,
        status: LocalSyncStatus.completed,
      );

      await notifier().discard(_mealGuid);

      expect(await database.select(database.mealsLocal).get(), hasLength(1));
    });
  });

  group('HistoryNotifier · la ventana completa', () {
    late AppDatabase db;

    setUp(() => db = AppDatabase.memory());
    tearDown(() => db.close());

    test('carga todas las paginas: 250 comidas en 3 y 120 sintomas en 2',
        () async {
      final meals = PagedMealsRepository(mealRecords(250, newest: _now));
      final symptoms = PagedSymptomsRepository(
        symptomRecords(120, newest: _now),
      );
      final c = _pagedContainer(database: db, meals: meals, symptoms: symptoms);

      await c.read(historyNotifierProvider.notifier).load();

      expect(meals.calls.map((call) => call.page), <int>[1, 2, 3]);
      expect(symptoms.calls.map((call) => call.page), <int>[1, 2]);
      expect(
        <HistoryCall>[...meals.calls, ...symptoms.calls]
            .map((call) => call.pageSize)
            .toSet(),
        <int>{100},
      );
      expect(c.read(historyNotifierProvider).entries, hasLength(370));
    });

    test('usa el mismo from y to, en UTC, en todas las paginas', () async {
      final meals = PagedMealsRepository(mealRecords(250, newest: _now));
      final symptoms = PagedSymptomsRepository(
        symptomRecords(120, newest: _now),
      );
      final c = _pagedContainer(database: db, meals: meals, symptoms: symptoms);

      await c.read(historyNotifierProvider.notifier).load();

      final calls = <HistoryCall>[...meals.calls, ...symptoms.calls];
      expect(
        calls.map((call) => call.from).toSet(),
        <DateTime>{_now.subtract(const Duration(days: 90))},
      );
      expect(
        calls.map((call) => call.to).toSet(),
        <DateTime>{_now.add(const Duration(days: 1))},
      );
      expect(calls.every((call) => call.from!.isUtc && call.to!.isUtc), isTrue);
    });

    test(
        'se detiene en 10 paginas por tipo aunque el servidor diga que hay mas',
        () async {
      final meals = PagedMealsRepository(
        mealRecords(1100, newest: _now, step: const Duration(hours: 1)),
        totalCount: 5000,
      );
      final symptoms = PagedSymptomsRepository(
        symptomRecords(1100, newest: _now, step: const Duration(hours: 1)),
        totalCount: 5000,
      );
      final c = _pagedContainer(database: db, meals: meals, symptoms: symptoms);

      await c.read(historyNotifierProvider.notifier).load();

      expect(meals.calls, hasLength(10));
      expect(symptoms.calls, hasLength(10));
      expect(c.read(historyNotifierProvider).entries, hasLength(2000));
      expect(c.read(historyNotifierProvider).error, isNull);
    });

    test('se detiene ante una pagina vacia', () async {
      final meals = PagedMealsRepository(
        mealRecords(150, newest: _now),
        totalCount: 400,
      );
      final c = _pagedContainer(
        database: db,
        meals: meals,
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
      );

      await c.read(historyNotifierProvider.notifier).load();

      expect(meals.calls.map((call) => call.page), <int>[1, 2, 3]);
      expect(c.read(historyNotifierProvider).entries, hasLength(150));
    });

    test('resuelve la comida asociada que llego en otra pagina', () async {
      final all = mealRecords(250, newest: _now);
      final cena = all[220].copyWith(mealTime: MealTimeOption.dinner);
      all[220] = cena;
      final sintoma = SymptomRecord(
        symptomId: 'symptom-asociado',
        occurredAt: cena.consumedAt.add(const Duration(minutes: 90)),
        intensity: 50,
        associatedMealId: cena.mealId,
        hasMealAssociation: true,
      );
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(all),
        symptoms: PagedSymptomsRepository(<SymptomRecord>[sintoma]),
      );

      await c.read(historyNotifierProvider.notifier).load();

      final entry = c
          .read(historyNotifierProvider)
          .entries
          .singleWhere((e) => e.serverId == 'symptom-asociado');
      expect(entry.associatedMealTime, MealTimeOption.dinner);
      expect(entry.associatedMealDelay, const Duration(minutes: 90));
    });

    test(
        'si falla una pagina intermedia de comidas conserva lo llegado, '
        'los sintomas y lo local', () async {
      await insertPendingMeal(db, _mealGuid, clientCreatedAt: _now);
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(
          mealRecords(250, newest: _now),
          failOnPage: 2,
        ),
        symptoms: PagedSymptomsRepository(symptomRecords(120, newest: _now)),
      );

      await c.read(historyNotifierProvider.notifier).load();

      final state = c.read(historyNotifierProvider);
      final kinds = state.entries.map((e) => e.kind).toList();
      expect(kinds.where((k) => k == HistoryEntryKind.meal), hasLength(101));
      expect(kinds.where((k) => k == HistoryEntryKind.symptom), hasLength(120));
      expect(state.unsynced, hasLength(1));
      expect(state.error, isA<NetworkError>());
      expect(state.loading, isFalse);
    });

    test('si fallan los sintomas, las comidas siguen', () async {
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(mealRecords(250, newest: _now)),
        symptoms: PagedSymptomsRepository(
          symptomRecords(120, newest: _now),
          failOnPage: 1,
        ),
      );

      await c.read(historyNotifierProvider.notifier).load();

      final state = c.read(historyNotifierProvider);
      expect(state.entries, hasLength(250));
      expect(state.error, isA<NetworkError>());
    });

    test('no duplica lo que el servidor repite entre paginas', () async {
      // Una fila nueva a mitad de la carga corre el resto un lugar.
      final all = mealRecords(200, newest: _now);
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(
          all,
          totalCount: 200,
          pages: <List<MealRecord>>[all.sublist(0, 100), all.sublist(99, 199)],
        ),
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
      );

      await c.read(historyNotifierProvider.notifier).load();

      final ids = c
          .read(historyNotifierProvider)
          .entries
          .map((e) => e.serverId)
          .toList();
      expect(ids, hasLength(199));
      expect(ids.toSet(), hasLength(199));
    });

    test('cada comida lleva sus alimentos con cantidad y unidad', () async {
      await _insertFood(db, 'food-1', 'Arroz blanco cocido');
      await _insertFood(
        db,
        'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa',
        'Avena cocida',
      );
      await insertPendingMeal(db, _mealGuid, clientCreatedAt: _now);
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(mealRecords(1, newest: _now)),
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
      );

      await c.read(historyNotifierProvider.notifier).load();

      final entries = c.read(historyNotifierProvider).entries;
      expect(
        entries.singleWhere((e) => e.serverId == 'meal-0').items,
        const <HistoryMealItem>[
          HistoryMealItem(
            name: 'Arroz blanco cocido',
            quantity: 150,
            unit: MeasurementUnitOption.grams,
          ),
        ],
      );
      expect(
        entries.singleWhere((e) => e.clientGuid == _mealGuid).items,
        const <HistoryMealItem>[
          HistoryMealItem(
            name: 'Avena cocida',
            quantity: 150,
            unit: MeasurementUnitOption.grams,
          ),
        ],
      );
    });

    test('un plato personalizado queda sin nombre', () async {
      final propio = MealRecord(
        mealId: 'meal-propio',
        consumedAt: _now,
        mealTime: MealTimeOption.lunch,
        items: const <MealRecordItem>[
          MealRecordItem(
            customFoodId: 'custom-1',
            quantity: 1,
            unit: MeasurementUnitOption.units,
          ),
        ],
      );
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(<MealRecord>[propio]),
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
      );

      await c.read(historyNotifierProvider.notifier).load();

      final items = c.read(historyNotifierProvider).entries.single.items;
      expect(items.single.name, isNull);
      expect(items.single.unit, MeasurementUnitOption.units);
    });
  });

  group('HistoryNotifier · una carga a la vez', () {
    late AppDatabase db;

    setUp(() => db = AppDatabase.memory());
    tearDown(() => db.close());

    test('una carga pedida durante otra se hace una sola vez al terminar',
        () async {
      final meals = PagedMealsRepository(mealRecords(3, newest: _now))
        ..gate = Completer<void>();
      final c = _pagedContainer(
        database: db,
        meals: meals,
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
      );
      final notifier = c.read(historyNotifierProvider.notifier);

      final loads = <Future<void>>[
        notifier.load(),
        notifier.load(),
        notifier.load(),
      ];
      await _settle();
      expect(meals.calls, hasLength(1));

      meals.gate!.complete();
      await Future.wait(loads);

      expect(meals.calls, hasLength(2));
    });

    test('loading vuelve a false aunque falle la lectura local', () async {
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(const <MealRecord>[]),
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
        extra: <Override>[
          mealsLocalStoreProvider.overrideWithValue(_BrokenMealsStore(db)),
        ],
      );

      await expectLater(
        c.read(historyNotifierProvider.notifier).load(),
        throwsA(isA<StateError>()),
      );

      expect(c.read(historyNotifierProvider).loading, isFalse);
    });

    test('pide nombres e items una vez por carga', () async {
      for (var i = 0; i < 30; i++) {
        await insertPendingMeal(
          db,
          'local-$i',
          clientCreatedAt: _now.subtract(Duration(hours: i)),
        );
      }
      final catalog = _CountingCatalog(db);
      final store = _CountingMealsStore(db);
      final c = _pagedContainer(
        database: db,
        meals: PagedMealsRepository(mealRecords(40, newest: _now)),
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
        extra: <Override>[
          foodCatalogStoreProvider.overrideWithValue(catalog),
          mealsLocalStoreProvider.overrideWithValue(store),
        ],
      );

      await c.read(historyNotifierProvider.notifier).load();

      expect(c.read(historyNotifierProvider).entries, hasLength(70));
      expect(catalog.calls, 1);
      expect(store.itemReads, 1);
    });

    test(
        'si el Diario se cierra en mitad de la carga, no asigna estado '
        'ni lanza error', () async {
      final meals = PagedMealsRepository(mealRecords(3, newest: _now))
        ..gate = Completer<void>();
      late _SpyHistory spy;
      final c = ProviderContainer(
        overrides: <Override>[
          appDatabaseProvider.overrideWithValue(db),
          mealsRepositoryProvider.overrideWithValue(meals),
          symptomsRepositoryProvider.overrideWithValue(
            PagedSymptomsRepository(const <SymptomRecord>[]),
          ),
          historyClockProvider.overrideWithValue(() => _now),
          historyNotifierProvider.overrideWith(() => spy = _SpyHistory()),
        ],
      );
      addTearDown(c.dispose);
      final subscription = c.listen(historyNotifierProvider, (_, __) {});
      final notifier = c.read(historyNotifierProvider.notifier);

      final first = notifier.load();
      final queued = notifier.load();
      await _settle();
      expect(meals.calls, hasLength(1));

      subscription.close();
      await _settle();
      expect(spy.assignedAtDispose, isNotNull);

      meals.gate!.complete();
      await expectLater(Future.wait(<Future<void>>[first, queued]), completes);

      expect(spy.assigned, spy.assignedAtDispose);
      expect(meals.calls, hasLength(1));
    });
  });

  group('HistoryNotifier · ventana de frescura', () {
    late AppDatabase db;
    late PagedMealsRepository meals;
    late DateTime now;
    late HistoryNotifier notifier;

    setUp(() {
      db = AppDatabase.memory();
      meals = PagedMealsRepository(mealRecords(3, newest: _now));
      now = _now;
      final c = _pagedContainer(
        database: db,
        meals: meals,
        symptoms: PagedSymptomsRepository(const <SymptomRecord>[]),
        clock: () => now,
      );
      notifier = c.read(historyNotifierProvider.notifier);
    });
    tearDown(() => db.close());

    test('reloadIfOpen no carga si el Diario no se abrio', () async {
      await notifier.reloadIfOpen();
      await notifier.reloadIfOpen(onlyIfStale: true);

      expect(meals.calls, isEmpty);
    });

    test('al volver a la pestana dentro de 30 s no recarga', () async {
      await notifier.load();
      now = now.add(const Duration(seconds: 29));

      await notifier.reloadIfOpen(onlyIfStale: true);

      expect(meals.calls, hasLength(1));
    });

    test('pasados 30 s, volver a la pestana recarga', () async {
      await notifier.load();
      now = now.add(const Duration(seconds: 30));

      await notifier.reloadIfOpen(onlyIfStale: true);

      expect(meals.calls, hasLength(2));
    });

    test('una carga en curso cuenta como fresca al volver a la pestana',
        () async {
      meals.gate = Completer<void>();
      final first = notifier.load();
      await _settle();

      final second = notifier.reloadIfOpen(onlyIfStale: true);
      meals.gate!.complete();
      await Future.wait(<Future<void>>[first, second]);

      expect(meals.calls, hasLength(1));
    });

    test('tras una carga con error, volver a la pestana dentro de 30 s recarga',
        () async {
      meals.failOnPage = 1;
      await notifier.load();
      meals.failOnPage = null;
      now = now.add(const Duration(seconds: 1));

      await notifier.reloadIfOpen(onlyIfStale: true);

      expect(meals.calls, hasLength(2));
    });

    test('tirar para refrescar recarga aunque no pasaron 30 s', () async {
      await notifier.load();
      now = now.add(const Duration(seconds: 1));

      await notifier.load();

      expect(meals.calls, hasLength(2));
    });

    test(
        'volver de un formulario o terminar una sincronizacion recarga '
        'aunque no pasaron 30 s', () async {
      await notifier.load();
      now = now.add(const Duration(seconds: 1));

      await notifier.reloadIfOpen();

      expect(meals.calls, hasLength(2));
    });
  });
}
