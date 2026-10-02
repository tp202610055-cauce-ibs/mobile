import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/features/symptoms/application/symptom_form_notifier.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/sync_fixtures.dart';

class _MockSymptomsRepository extends Mock implements SymptomsRepository {}

class _FakeSymptomDraft extends Fake implements SymptomDraft {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeSymptomDraft());
    registerFallbackValue(DateTime.utc(2026));
  });

  late AppDatabase database;
  late _MockSymptomsRepository repository;
  late FakeConnectivityMonitor connectivity;
  late ProviderContainer container;

  setUp(() {
    database = AppDatabase.memory();
    repository = _MockSymptomsRepository();
    connectivity = FakeConnectivityMonitor();
    container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(database),
        symptomsRepositoryProvider.overrideWithValue(repository),
        connectivityMonitorProvider.overrideWithValue(connectivity),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await connectivity.dispose();
    await database.close();
  });

  SymptomFormNotifier notifier() =>
      container.read(symptomFormNotifierProvider.notifier);
  SymptomFormState state() => container.read(symptomFormNotifierProvider);

  void fillValidDraft() {
    notifier()
      ..selectType(SymptomTypeOption.bloating)
      ..setIntensity(40);
  }

  void stubCreate(CreatedSymptom created) {
    when(
      () => repository.create(
        any(),
        clientGuid: any(named: 'clientGuid'),
        clientCreatedAt: any(named: 'clientCreatedAt'),
      ),
    ).thenAnswer((_) async => created);
  }

  group('SymptomFormNotifier · validacion previa', () {
    test('arranca sin poder enviar', () {
      expect(state().canSubmit, isFalse);
      expect(state().issues, contains(SymptomDraftIssue.missingType));
      expect(state().issues, contains(SymptomDraftIssue.missingIntensity));
    });

    test('la intensidad cero queda fuera de rango', () {
      // El backend acepta de 1 a 100 (`Symptom.MinIntensity`). Por eso el
      // slider se instancia con `min: 1`: ofrecer el cero seria ofrecer un
      // valor que termina en un 400.
      notifier()
        ..selectType(SymptomTypeOption.diarrhea)
        ..setIntensity(0);

      expect(
        state().issues,
        contains(SymptomDraftIssue.intensityOutOfRange),
      );
      expect(state().canSubmit, isFalse);
    });

    test('la intensidad 1 es valida', () {
      notifier()
        ..selectType(SymptomTypeOption.diarrhea)
        ..setIntensity(1);

      expect(state().canSubmit, isTrue);
    });

    test('la intensidad 100 es valida', () {
      notifier()
        ..selectType(SymptomTypeOption.diarrhea)
        ..setIntensity(100);

      expect(state().canSubmit, isTrue);
    });
  });

  group('SymptomFormNotifier · registro con conexion (CA01, CP028)', () {
    test(
        'el cliente no calcula la ventana: muestra lo que confirma el servidor',
        () async {
      // DEC-B3-06 deja el calculo del lado del servidor como autoridad. El
      // cliente solo envia occurredAt y clientCreatedAt.
      stubCreate(
        const CreatedSymptom(
          symptomId: 'server-1',
          associatedMealId: 'meal-1',
          hasMealAssociation: true,
        ),
      );
      fillValidDraft();

      expect(await notifier().submit(), isTrue);

      expect(state().outcome, SymptomSubmitOutcome.registered);
      expect(state().result?.hasMealAssociation, isTrue);
      expect(state().result?.associatedMealId, 'meal-1');
    });

    test('guarda la asociacion en la fila local', () async {
      stubCreate(
        const CreatedSymptom(
          symptomId: 'server-1',
          associatedMealId: 'meal-1',
          hasMealAssociation: true,
        ),
      );
      fillValidDraft();
      await notifier().submit();

      final row = await database.select(database.symptomsLocal).getSingle();
      expect(row.syncStatus, LocalSyncStatus.completed);
      expect(row.serverId, 'server-1');
      expect(row.associatedMealId, 'meal-1');
      expect(row.hasMealAssociation, isTrue);
    });

    test('el clientGuid que viaja es el de la fila local', () async {
      String? enviado;
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer((invocation) async {
        enviado = invocation.namedArguments[#clientGuid] as String;
        return const CreatedSymptom(symptomId: 'server-1');
      });
      fillValidDraft();

      await notifier().submit();

      final row = await database.select(database.symptomsLocal).getSingle();
      expect(enviado, row.clientGuid);
    });
  });

  group('SymptomFormNotifier · sin comida asociada (CA02, CP029)', () {
    test('se guarda igual y sin error', () async {
      // Que no haya una comida en la ventana es un dato clinico mas, no una
      // falla del paciente ni de la app.
      stubCreate(
        const CreatedSymptom(symptomId: 'server-1', hasMealAssociation: false),
      );
      fillValidDraft();

      expect(await notifier().submit(), isTrue);

      expect(state().outcome, SymptomSubmitOutcome.registered);
      expect(state().error, isNull);
      expect(state().result?.hasMealAssociation, isFalse);
      expect(state().result?.associatedMealId, isNull);
    });

    test('la fila local distingue el false del servidor de no preguntar aun',
        () async {
      stubCreate(
        const CreatedSymptom(symptomId: 'server-1', hasMealAssociation: false),
      );
      fillValidDraft();
      await notifier().submit();

      final row = await database.select(database.symptomsLocal).getSingle();
      // `false` porque el servidor ya dijo que no hay comida. `null` habria
      // significado que todavia no se pregunto.
      expect(row.hasMealAssociation, isFalse);
    });
  });

  group('SymptomFormNotifier · registro sin conexion', () {
    test('guarda en el dispositivo y no llama al servidor', () async {
      connectivity.online = false;
      fillValidDraft();

      expect(await notifier().submit(), isTrue);

      expect(state().outcome, SymptomSubmitOutcome.queuedOffline);
      verifyNever(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      );

      final row = await database.select(database.symptomsLocal).getSingle();
      expect(row.syncStatus, LocalSyncStatus.pending);
    });

    test('la asociacion queda sin resolver hasta sincronizar', () async {
      // La calcula el servidor: sin sincronizar no hay nada que afirmar en
      // ningun sentido.
      connectivity.online = false;
      fillValidDraft();
      await notifier().submit();

      expect(state().result, isNull);

      final row = await database.select(database.symptomsLocal).getSingle();
      expect(row.hasMealAssociation, isNull);
      expect(row.associatedMealId, isNull);
    });
  });

  group('SymptomFormNotifier · rechazo del servidor', () {
    test('conserva la fila local como pendiente', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenThrow(const CauceApiError.rateLimited(retryAfterSeconds: 30));
      fillValidDraft();

      expect(await notifier().submit(), isFalse);

      expect(state().outcome, SymptomSubmitOutcome.rejected);
      final row = await database.select(database.symptomsLocal).getSingle();
      expect(row.syncStatus, LocalSyncStatus.pending);
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

      expect(state().draft.symptomType, SymptomTypeOption.bloating);
      expect(state().draft.intensity, 40);
    });
  });

  group('SymptomFormNotifier · un sintoma, una clave (acta M50)', () {
    // La pantalla montada escucha el notifier; sin oyente, el `autoDispose`
    // lo descartaria entre dos envios.
    setUp(() => container.listen(symptomFormNotifierProvider, (_, __) {}));

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
        return outcome as CreatedSymptom;
      });
    }

    List<dynamic> sent() => verify(
          () => repository.create(
            any(),
            clientGuid: captureAny(named: 'clientGuid'),
            clientCreatedAt: captureAny(named: 'clientCreatedAt'),
          ),
        ).captured;

    const created = CreatedSymptom(
      symptomId: 'symptom-1',
      hasMealAssociation: false,
    );

    test('un fallo de red deja la fila pendiente, no rechazada', () async {
      answerInOrder(<Object>[const CauceApiError.network()]);
      fillValidDraft();

      expect(await notifier().submit(), isTrue);

      expect(state().outcome, SymptomSubmitOutcome.queuedOffline);
      expect(state().error, isNull);
      final symptom = await database.select(database.symptomsLocal).getSingle();
      expect(symptom.syncStatus, LocalSyncStatus.pending);
    });

    test('un segundo envio tras un fallo de red repite la clave y la carga',
        () async {
      answerInOrder(<Object>[const CauceApiError.network(), created]);
      fillValidDraft();

      await notifier().submit();
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await notifier().submit();

      final captured = sent();
      expect(captured[2], captured[0]);
      expect(captured[3], captured[1]);

      final symptoms = await database.select(database.symptomsLocal).get();
      expect(symptoms, hasLength(1));
      expect(symptoms.single.clientGuid, captured[0]);
      expect(symptoms.single.syncStatus, LocalSyncStatus.completed);
    });

    test(
        'un rechazo real sigue siendo un rechazo, y el reintento conserva '
        'la clave', () async {
      answerInOrder(<Object>[const CauceApiError.forbidden(), created]);
      fillValidDraft();

      expect(await notifier().submit(), isFalse);
      expect(state().outcome, SymptomSubmitOutcome.rejected);
      expect(state().error, isA<ForbiddenError>());

      notifier().setIntensity(70);
      expect(await notifier().submit(), isTrue);

      final captured = sent();
      expect(captured[2], captured[0]);
      final symptoms = await database.select(database.symptomsLocal).get();
      expect(symptoms, hasLength(1));
      expect(symptoms.single.intensity, 70);
    });

    test('dos toques seguidos registran un solo sintoma', () async {
      when(
        () => repository.create(
          any(),
          clientGuid: any(named: 'clientGuid'),
          clientCreatedAt: any(named: 'clientCreatedAt'),
        ),
      ).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return created;
      });
      fillValidDraft();

      final results = await Future.wait(<Future<bool>>[
        notifier().submit(),
        notifier().submit(),
      ]);

      expect(results, <bool>[true, false]);
      expect(sent(), hasLength(2));
      expect(await database.select(database.symptomsLocal).get(), hasLength(1));
    });
  });

  group('SymptomTypeOption · valores de contrato', () {
    test('los nueve valores van y vuelven por su valor de contrato', () {
      for (final option in SymptomTypeOption.values) {
        expect(SymptomTypeOption.fromWire(option.wireValue), option);
      }
    });

    test('son exactamente nueve, con otro incluido', () {
      expect(SymptomTypeOption.values, hasLength(9));
      expect(SymptomTypeOption.values, contains(SymptomTypeOption.other));
    });

    test('un valor desconocido devuelve null', () {
      expect(SymptomTypeOption.fromWire('Heartburn'), isNull);
      expect(SymptomTypeOption.fromWire(null), isNull);
    });
  });
}
