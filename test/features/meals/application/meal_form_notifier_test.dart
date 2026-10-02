import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/application/meal_form_notifier.dart';
import 'package:cauce_mobile/features/meals/data/meals_repository.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/meals/domain/meal_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/sync_fixtures.dart';

class _MockMealsRepository extends Mock implements MealsRepository {}

class _FakeMealDraft extends Fake implements MealDraft {}

const FoodItem _arroz = FoodItem(
  foodId: 'f1',
  name: 'Arroz blanco cocido',
  category: 'cereales',
  isPeruvian: true,
);

const MealItemDraft _item = MealItemDraft(
  quantity: 150,
  unit: MeasurementUnitOption.grams,
  food: _arroz,
);

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeMealDraft());
    registerFallbackValue(DateTime.utc(2026));
  });

  late AppDatabase database;
  late _MockMealsRepository repository;
  late FakeConnectivityMonitor connectivity;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase.memory();
    repository = _MockMealsRepository();
    connectivity = FakeConnectivityMonitor();
    container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(database),
        mealsRepositoryProvider.overrideWithValue(repository),
        connectivityMonitorProvider.overrideWithValue(connectivity),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await connectivity.dispose();
    await database.close();
  });

  MealFormNotifier notifier() =>
      container.read(mealFormNotifierProvider.notifier);
  MealFormState state() => container.read(mealFormNotifierProvider);

  void fillValidDraft() {
    notifier()
      ..selectMealTime(MealTimeOption.lunch)
      ..addItem(_item);
  }

  group('MealFormNotifier · CA04, bloqueo del envio (CP076)', () {
    test('arranca sin poder enviar', () {
      expect(state().canSubmit, isFalse);
      expect(state().issues, contains(MealDraftIssue.missingMealTime));
      expect(state().issues, contains(MealDraftIssue.noItems));
    });

    test('con el formulario incompleto el envio ni se intenta', () async {
      notifier().selectMealTime(MealTimeOption.lunch);

      expect(await notifier().submit(), isFalse);
      verifyNever(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      );
      expect(await database.select(database.mealsLocal).get(), isEmpty);
    });

    test('quitar un alimento conserva el momento del dia', () async {
      fillValidDraft();

      notifier().removeItemAt(0);

      expect(state().draft.mealTime, MealTimeOption.lunch);
      expect(state().draft.items, isEmpty);
      expect(state().issues, contains(MealDraftIssue.noItems));
    });

    test('completar el formulario habilita el envio', () {
      fillValidDraft();

      expect(state().canSubmit, isTrue);
      expect(state().issues, isEmpty);
    });
  });

  group('MealFormNotifier · registro con conexion (CA01, CP022)', () {
    test('manda al servidor y cierra la fila local', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer(
        (_) async => const CreatedMeal(
          mealId: 'server-1',
          aggregatedFodmap: FodmapLoad.moderate,
        ),
      );
      fillValidDraft();

      expect(await notifier().submit(), isTrue);

      expect(state().outcome, MealSubmitOutcome.registered);
      expect(state().aggregatedFodmap, FodmapLoad.moderate);

      final meal = await database.select(database.mealsLocal).getSingle();
      expect(meal.syncStatus, LocalSyncStatus.completed);
      expect(meal.serverId, 'server-1');
    });

    test('el clientGuid que viaja es el de la fila local', () async {
      // Si la respuesta se pierde, el reintento repite ese UUID y el backend
      // deduplica en vez de crear una segunda comida.
      String? enviado;
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer((invocation) async {
        enviado = invocation.namedArguments[#clientGuid] as String;
        return const CreatedMeal(mealId: 'server-1');
      });
      fillValidDraft();

      await notifier().submit();

      final meal = await database.select(database.mealsLocal).getSingle();
      expect(enviado, meal.clientGuid);
    });
  });

  group('MealFormNotifier · registro sin conexion (CA02, CP023)', () {
    test('guarda en el dispositivo y no llama al servidor', () async {
      connectivity.online = false;
      fillValidDraft();

      expect(await notifier().submit(), isTrue);

      expect(state().outcome, MealSubmitOutcome.queuedOffline);
      verifyNever(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      );

      final meal = await database.select(database.mealsLocal).getSingle();
      expect(meal.syncStatus, LocalSyncStatus.pending);
      expect(meal.serverId, isNull);
    });

    test('quedar en la cola cuenta como exito, no como error', () async {
      // El dato esta guardado y el worker lo sube en cuanto vuelva la red.
      // Decirle otra cosa al paciente lo llevaria a anotar la comida dos veces.
      connectivity.online = false;
      fillValidDraft();

      expect(await notifier().submit(), isTrue);
      expect(state().error, isNull);
    });

    test('el item offline conserva su referencia al alimento', () async {
      connectivity.online = false;
      fillValidDraft();
      await notifier().submit();

      final item = await database.select(database.mealItemsLocal).getSingle();
      expect(item.foodId, 'f1');
      expect(item.unit, 'Grams');
      expect(item.quantity, 150);
    });
  });

  group('MealFormNotifier · rechazo del servidor', () {
    test('conserva la fila local como pendiente', () async {
      // El paciente ya anoto lo que comio: perder eso por un fallo del servidor
      // seria lo peor que puede pasar en un registro clinico.
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenThrow(const CauceApiError.rateLimited(retryAfterSeconds: 30));
      fillValidDraft();

      expect(await notifier().submit(), isFalse);

      expect(state().outcome, MealSubmitOutcome.rejected);
      expect(state().error, isA<RateLimitedError>());

      final meal = await database.select(database.mealsLocal).getSingle();
      expect(meal.syncStatus, LocalSyncStatus.pending);
    });

    test('el formulario conserva lo cargado', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenThrow(const CauceApiError.forbidden());
      fillValidDraft();

      await notifier().submit();

      expect(state().draft.mealTime, MealTimeOption.lunch);
      expect(state().draft.items, hasLength(1));
    });

    test('elegir otro momento limpia el error anterior', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenThrow(const CauceApiError.forbidden());
      fillValidDraft();
      await notifier().submit();

      notifier().selectMealTime(MealTimeOption.dinner);

      expect(state().error, isNull);
    });
  });

  group('MealFormNotifier · una comida, una clave (acta M50)', () {
    // La revision manual del 28-sep: con el backend inalcanzable y la radio
    // encendida, tres toques de "Registrar" dejaron tres comidas, cada una con
    // su propia clave, que el servidor no podia reconocer como la misma.

    // La pantalla montada escucha el notifier. Sin un oyente, el `autoDispose`
    // lo descartaria entre dos envios y el segundo arrancaria de cero.
    setUp(() => container.listen(mealFormNotifierProvider, (_, __) {}));

    void answerInOrder(List<Object> outcomes) {
      var call = 0;
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer((_) async {
        final outcome = outcomes[call++];
        if (outcome is CauceApiError) {
          throw outcome;
        }
        return outcome as CreatedMeal;
      });
    }

    List<dynamic> sent() => verify(
          () => repository.create(
            any(),
            clientGuid: captureAny(named: 'clientGuid'),
            clientCreatedAt: captureAny(named: 'clientCreatedAt'),
          ),
        ).captured;

    test('un fallo de red deja la fila pendiente, no rechazada', () async {
      answerInOrder(<Object>[const CauceApiError.network()]);
      fillValidDraft();

      expect(await notifier().submit(), isTrue);

      expect(state().outcome, MealSubmitOutcome.queuedOffline);
      expect(state().error, isNull);
      final meal = await database.select(database.mealsLocal).getSingle();
      expect(meal.syncStatus, LocalSyncStatus.pending);
    });

    test('un segundo envio tras un fallo de red repite la clave y la carga',
        () async {
      answerInOrder(<Object>[
        const CauceApiError.network(),
        const CreatedMeal(mealId: 'server-1'),
      ]);
      fillValidDraft();

      await notifier().submit();
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await notifier().submit();

      // [clave 1, momento 1, clave 2, momento 2]
      final captured = sent();
      expect(captured[2], captured[0]);
      expect(captured[3], captured[1]);

      final meals = await database.select(database.mealsLocal).get();
      expect(meals, hasLength(1));
      expect(meals.single.clientGuid, captured[0]);
      expect(meals.single.clientCreatedAt, captured[1]);
      expect(meals.single.syncStatus, LocalSyncStatus.completed);
    });

    test(
        'un rechazo real sigue siendo un rechazo, y el reintento conserva '
        'la clave', () async {
      answerInOrder(<Object>[
        const CauceApiError.invalidMealRegistration(),
        const CreatedMeal(mealId: 'server-1'),
      ]);
      fillValidDraft();

      expect(await notifier().submit(), isFalse);
      expect(state().outcome, MealSubmitOutcome.rejected);
      expect(state().error, isA<InvalidMealRegistrationError>());

      // El paciente corrige y vuelve a enviar: misma comida, misma clave, y la
      // fila local pasa a tener lo corregido.
      notifier().selectMealTime(MealTimeOption.dinner);
      expect(await notifier().submit(), isTrue);

      final captured = sent();
      expect(captured[2], captured[0]);
      final meals = await database.select(database.mealsLocal).get();
      expect(meals, hasLength(1));
      expect(meals.single.mealTime, MealTimeOption.dinner.wireValue);
      expect(
        await database.select(database.mealItemsLocal).get(),
        hasLength(1),
      );
    });

    test('dos toques seguidos registran una sola comida', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const CreatedMeal(mealId: 'server-1');
      });
      fillValidDraft();

      final results = await Future.wait(<Future<bool>>[
        notifier().submit(),
        notifier().submit(),
      ]);

      expect(results, <bool>[true, false]);
      expect(sent(), hasLength(2));
      expect(await database.select(database.mealsLocal).get(), hasLength(1));
    });

    test('registrar otra comida estrena una clave nueva', () async {
      answerInOrder(<Object>[
        const CreatedMeal(mealId: 'server-1'),
        const CreatedMeal(mealId: 'server-2'),
      ]);
      fillValidDraft();
      await notifier().submit();

      notifier().reset();
      fillValidDraft();
      await notifier().submit();

      final captured = sent();
      expect(captured[2], isNot(captured[0]));
      expect(await database.select(database.mealsLocal).get(), hasLength(2));
    });
  });

  group('MealFormNotifier · registrar otra', () {
    test('reset vacia el formulario', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer((_) async => const CreatedMeal(mealId: 'server-1'));
      fillValidDraft();
      await notifier().submit();

      notifier().reset();

      expect(state().outcome, isNull);
      expect(state().draft.mealTime, isNull);
      expect(state().draft.items, isEmpty);
    });

    test('lo ya registrado sigue en el historial local', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer((_) async => const CreatedMeal(mealId: 'server-1'));
      fillValidDraft();
      await notifier().submit();

      notifier().reset();

      expect(await database.select(database.mealsLocal).get(), hasLength(1));
    });
  });
}
