import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/history/application/history_notifier.dart';
import 'package:cauce_mobile/features/history/domain/history_entry.dart';
import 'package:cauce_mobile/features/meals/data/meals_repository.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/meals/domain/meal_record.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/sync_fixtures.dart';

class _MockMealsRepository extends Mock implements MealsRepository {}

class _MockSymptomsRepository extends Mock implements SymptomsRepository {}

const String _mealGuid = '11111111-1111-4111-8111-111111111111';
const String _symptomGuid = '22222222-2222-4222-8222-222222222222';

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
}
