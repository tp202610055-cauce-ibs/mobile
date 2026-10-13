import 'dart:async';

import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/features/history/application/history_composer.dart';
import 'package:cauce_mobile/features/history/application/today_journal_notifier.dart';
import 'package:cauce_mobile/features/meals/data/meals_repository.dart';
import 'package:cauce_mobile/features/meals/domain/meal_record.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/paged_history_fakes.dart';
import '../../../helpers/sync_fixtures.dart';

void main() {
  // Hora local, como la que entrega el reloj del telefono.
  final tarde = DateTime(2026, 10, 11, 15);

  late AppDatabase db;
  late DateTime now;
  late PagedMealsRepository meals;
  late PagedSymptomsRepository symptoms;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase.memory();
    now = tarde;
    meals = PagedMealsRepository(<MealRecord>[
      MealRecord(
        mealId: 'hoy',
        consumedAt: DateTime(2026, 10, 11, 13).toUtc(),
      ),
      MealRecord(
        mealId: 'ayer',
        consumedAt: DateTime(2026, 10, 10, 20).toUtc(),
      ),
    ]);
    symptoms = PagedSymptomsRepository(<SymptomRecord>[
      SymptomRecord(
        symptomId: 'hoy',
        occurredAt: DateTime(2026, 10, 11, 14).toUtc(),
        intensity: 30,
      ),
    ]);
    container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(db),
        mealsRepositoryProvider.overrideWithValue(meals),
        symptomsRepositoryProvider.overrideWithValue(symptoms),
        historyClockProvider.overrideWithValue(() => now),
      ],
    );
    container.listen(todayJournalNotifierProvider, (_, __) {});
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  TodayJournalNotifier notifier() =>
      container.read(todayJournalNotifierProvider.notifier);

  group('TodayJournalNotifier · lo de hoy para Inicio', () {
    test('cuenta lo de hoy en el dia local, del servidor y lo pendiente',
        () async {
      await insertPendingMeal(
        db,
        '11111111-1111-4111-8111-111111111111',
        clientCreatedAt: DateTime(2026, 10, 11, 12).toUtc(),
      );

      await notifier().load();

      final state = container.read(todayJournalNotifierProvider);
      expect(state.meals, 2);
      expect(state.symptoms, 1);
    });

    test('pide una pagina por tipo desde el inicio del dia local', () async {
      await notifier().load();

      final desde = DateTime(2026, 10, 11)
          .subtract(SymptomDraft.clockSkewTolerance)
          .toUtc();
      expect(meals.calls, hasLength(1));
      expect(symptoms.calls, hasLength(1));
      expect(meals.calls.single.from, desde);
      expect(symptoms.calls.single.from, desde);
      expect(meals.calls.single.pageSize, 100);
    });
  });

  group('TodayJournalNotifier · ventana de frescura', () {
    test('al volver a Inicio dentro de 30 s no recarga; pasados 30 s, si',
        () async {
      await notifier().load();

      now = tarde.add(const Duration(seconds: 29));
      await notifier().load(onlyIfStale: true);
      expect(meals.calls, hasLength(1));

      now = tarde.add(const Duration(seconds: 30));
      await notifier().load(onlyIfStale: true);
      expect(meals.calls, hasLength(2));
    });

    test('una carga en curso cuenta como fresca al volver a Inicio', () async {
      meals.gate = Completer<void>();
      final first = notifier().load();
      for (var i = 0; i < 20; i++) {
        await Future<void>.delayed(Duration.zero);
      }

      final second = notifier().load(onlyIfStale: true);
      meals.gate!.complete();
      await Future.wait(<Future<void>>[first, second]);

      expect(meals.calls, hasLength(1));
    });

    test('tras una carga con error, volver a Inicio dentro de 30 s recarga',
        () async {
      meals.failOnPage = 1;
      await notifier().load();
      meals.failOnPage = null;
      now = tarde.add(const Duration(seconds: 1));

      await notifier().load(onlyIfStale: true);

      expect(meals.calls, hasLength(2));
    });

    test('volver de un formulario recarga aunque no pasaron 30 s', () async {
      await notifier().load();
      now = tarde.add(const Duration(seconds: 1));

      await notifier().load();

      expect(meals.calls, hasLength(2));
    });
  });
}
