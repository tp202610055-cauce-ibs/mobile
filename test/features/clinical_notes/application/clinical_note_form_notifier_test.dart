import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/clinical_notes/application/clinical_note_form_notifier.dart';
import 'package:cauce_mobile/features/clinical_notes/data/clinical_notes_repository.dart';
import 'package:cauce_mobile/features/clinical_notes/domain/clinical_note_draft.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockClinicalNotesRepository extends Mock
    implements ClinicalNotesRepository {}

class _FakeDraft extends Fake implements ClinicalNoteDraft {}

void main() {
  setUpAll(() => registerFallbackValue(_FakeDraft()));

  late _MockClinicalNotesRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _MockClinicalNotesRepository();
    container = ProviderContainer(
      overrides: <Override>[
        clinicalNotesRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });

  tearDown(() => container.dispose());

  ClinicalNoteFormNotifier notifier() =>
      container.read(clinicalNoteFormNotifierProvider.notifier);
  ClinicalNoteFormState state() =>
      container.read(clinicalNoteFormNotifierProvider);

  group('ClinicalNoteFormNotifier · asociacion (CA01, CP034)', () {
    test('sin asociacion no se puede guardar', () {
      notifier().setContent('Comi apurado');

      expect(state().issues, contains(ClinicalNoteIssue.noAssociation));
      expect(state().canSubmit, isFalse);
    });

    test('con una comida se puede guardar', () {
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Comi apurado, en la calle');

      expect(state().canSubmit, isTrue);
      expect(state().issues, isEmpty);
    });

    test('con un sintoma tambien', () {
      notifier()
        ..attachTo(symptomId: 'server-symptom')
        ..setContent('Empezo despues del almuerzo');

      expect(state().canSubmit, isTrue);
    });

    test('con los dos a la vez no', () {
      // El backend responde 400 `invalid_clinical_note_association`: una nota
      // va con una comida **o** con un sintoma.
      notifier()
        ..attachTo(mealId: 'server-meal', symptomId: 'server-symptom')
        ..setContent('Nota');

      expect(state().issues, contains(ClinicalNoteIssue.ambiguousAssociation));
      expect(state().canSubmit, isFalse);
    });
  });

  group('ClinicalNoteFormNotifier · tope de 500 caracteres (CA02, CP035)', () {
    test('el contador arranca en 500', () {
      expect(state().remaining, 500);
    });

    test('el contador baja con lo escrito', () {
      notifier().setContent('a' * 80);

      expect(state().remaining, 420);
    });

    test('exactamente 500 caracteres entra', () {
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('a' * 500);

      expect(state().remaining, 0);
      expect(state().canSubmit, isTrue);
    });

    test('501 lo bloquea y el contador se vuelve negativo', () {
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('a' * 501);

      expect(state().remaining, -1);
      expect(state().issues, contains(ClinicalNoteIssue.tooLong));
      expect(state().canSubmit, isFalse);
    });

    test('el texto no se recorta: se conserva entero', () {
      // Truncar en silencio le borraria al paciente lo que acaba de escribir
      // sin decirle por que.
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('a' * 600);

      expect(state().draft.content.length, 600);
    });

    test('un texto de solo espacios cuenta como vacio', () {
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('     ');

      expect(state().issues, contains(ClinicalNoteIssue.empty));
    });

    test('el tope se cuenta en unidades UTF-16, igual que el backend', () {
      // `ClinicalNote.Create` usa `content.Length` de C#, que cuenta unidades
      // UTF-16. Contar racimos de grafemas daria un numero distinto del que
      // aplica el servidor y el contador mentiria cerca del tope.
      const emoji = '\u{1F600}'; // Un emoji: 2 unidades UTF-16.
      notifier().setContent(emoji * 250);

      expect(state().draft.content.length, 500);
      expect(state().remaining, 0);
    });
  });

  group('ClinicalNoteFormNotifier · envio', () {
    test('guarda y expone el identificador', () async {
      when(() => repository.create(any(), clientGuid: any(named: 'clientGuid')))
          .thenAnswer((_) async => 'note-1');
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Comi apurado');

      expect(await notifier().submit(), isTrue);

      expect(state().createdId, 'note-1');
      expect(state().error, isNull);
    });

    test('un borrador invalido ni siquiera se envia', () async {
      notifier().setContent('Sin asociacion');

      expect(await notifier().submit(), isFalse);
      verifyNever(
        () => repository.create(any(), clientGuid: any(named: 'clientGuid')),
      );
    });

    test('un rechazo conserva el texto escrito', () async {
      // El paciente ya lo redacto: perderlo por un fallo del servidor lo
      // obligaria a escribirlo de nuevo.
      when(() => repository.create(any(), clientGuid: any(named: 'clientGuid')))
          .thenThrow(const CauceApiError.mealNotFound());
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Comi apurado, en la calle');

      expect(await notifier().submit(), isFalse);

      expect(state().error, isA<MealNotFoundError>());
      expect(state().draft.content, 'Comi apurado, en la calle');
      expect(state().createdId, isNull);
    });

    test('traduce el error de asociacion invalida del servidor', () async {
      when(() => repository.create(any(), clientGuid: any(named: 'clientGuid')))
          .thenThrow(const CauceApiError.invalidClinicalNoteAssociation());
      notifier()
        ..attachTo(symptomId: 'server-symptom')
        ..setContent('Nota');

      await notifier().submit();

      expect(state().error, isA<InvalidClinicalNoteAssociationError>());
    });

    test('escribir de nuevo limpia el error anterior', () async {
      when(() => repository.create(any(), clientGuid: any(named: 'clientGuid')))
          .thenThrow(const CauceApiError.forbidden());
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Nota');
      await notifier().submit();

      notifier().setContent('Nota corregida');

      expect(state().error, isNull);
    });
  });

  group('ClinicalNoteFormNotifier · clientGuid (acta M48)', () {
    /// Claves con las que el repositorio fue llamado, en orden.
    List<String> sentKeys() => verify(
          () => repository.create(
            any(),
            clientGuid: captureAny(named: 'clientGuid'),
          ),
        ).captured.cast<String>();

    test('se genera al enviar, como UUID v4', () async {
      when(
        () => repository.create(any(), clientGuid: any(named: 'clientGuid')),
      ).thenAnswer((_) async => 'note-1');
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Comi apurado');

      expect(state().clientGuid, isNull);
      await notifier().submit();

      final key = sentKeys().single;
      expect(key, state().clientGuid);
      expect(
        key,
        matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab]')),
      );
    });

    test('un reintento tras un fallo de red repite la misma clave', () async {
      // Si el primer envio llego y se perdio la respuesta, repetir la clave
      // hace que el servidor devuelva la nota ya creada en vez de otra.
      var calls = 0;
      when(
        () => repository.create(any(), clientGuid: any(named: 'clientGuid')),
      ).thenAnswer((_) async {
        calls++;
        if (calls == 1) {
          throw const CauceApiError.network();
        }
        return 'note-1';
      });
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Comi apurado');

      expect(await notifier().submit(), isFalse);
      expect(await notifier().submit(), isTrue);

      final keys = sentKeys();
      expect(keys, hasLength(2));
      expect(keys.last, keys.first);
    });

    test('corregir el texto antes de reintentar no renueva la clave', () async {
      // Alcance de pantalla: se prefiere el 409 idempotency_mismatch a una
      // segunda nota con el texto corregido si el primer envio si llego.
      when(
        () => repository.create(any(), clientGuid: any(named: 'clientGuid')),
      ).thenThrow(const CauceApiError.network());
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Comi apurado');

      await notifier().submit();
      notifier().setContent('Comi apurado, en la calle');
      await notifier().submit();

      final keys = sentKeys();
      expect(keys, hasLength(2));
      expect(keys.last, keys.first);
    });

    test('otra pantalla, otra nota: la clave no se hereda', () async {
      when(
        () => repository.create(any(), clientGuid: any(named: 'clientGuid')),
      ).thenAnswer((_) async => 'note-1');
      notifier()
        ..attachTo(mealId: 'server-meal')
        ..setContent('Primera nota');
      await notifier().submit();
      final first = state().clientGuid;

      // Al salir de la pantalla el provider se libera y se reconstruye.
      container.invalidate(clinicalNoteFormNotifierProvider);
      notifier()
        ..attachTo(symptomId: 'server-symptom')
        ..setContent('Segunda nota');
      await notifier().submit();

      expect(state().clientGuid, isNotNull);
      expect(state().clientGuid, isNot(first));
    });
  });
}
