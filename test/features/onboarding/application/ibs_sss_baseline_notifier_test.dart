import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_baseline.dart';
import 'package:cauce_mobile/features/onboarding/application/ibs_sss_baseline_notifier.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_ibs_sss_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

({
  ProviderContainer container,
  FakeIbsSssRepository ibsSss,
  FakePatientsRepository patients,
}) _harness({FakeIbsSssRepository? ibsSss, FakePatientsRepository? patients}) {
  final ibs = ibsSss ?? FakeIbsSssRepository();
  // El paso 2 solo se alcanza con perfil ya creado.
  final pat = patients ?? FakePatientsRepository(profile: demoProfile);
  final container = ProviderContainer(
    overrides: <Override>[
      ibsSssRepositoryProvider.overrideWithValue(ibs),
      patientsRepositoryProvider.overrideWithValue(pat),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
    ],
  );
  addTearDown(container.dispose);
  return (container: container, ibsSss: ibs, patients: pat);
}

Future<void> _authenticate(ProviderContainer container) async {
  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  await container.read(onboardingNotifierProvider.future);
}

/// Responde las cinco dimensiones a traves del notifier.
void _answerAll(ProviderContainer container) {
  final notifier = container.read(ibsSssBaselineNotifierProvider.notifier);
  notifier
    ..answer(IbsSssDimension.painSeverity, 60)
    ..answer(IbsSssDimension.painFrequency, 40)
    ..answer(IbsSssDimension.bloatingSeverity, 55)
    ..answer(IbsSssDimension.bowelHabitsDissatisfaction, 35)
    ..answer(IbsSssDimension.lifeInterference, 30);
}

void main() {
  group('IbsSssBaselineNotifier · respuestas', () {
    test('nace vacio y sin poder enviar', () async {
      final h = _harness();
      await _authenticate(h.container);

      final state = h.container.read(ibsSssBaselineNotifierProvider);

      expect(state.answers.isComplete, isFalse);
      expect(state.canSubmit, isFalse);
      expect(state.result, isNull);
    });

    test('con cuatro de cinco sigue sin poder enviar (CA02)', () async {
      final h = _harness();
      await _authenticate(h.container);
      final notifier =
          h.container.read(ibsSssBaselineNotifierProvider.notifier);

      notifier
        ..answer(IbsSssDimension.painSeverity, 60)
        ..answer(IbsSssDimension.painFrequency, 40)
        ..answer(IbsSssDimension.bloatingSeverity, 55)
        ..answer(IbsSssDimension.bowelHabitsDissatisfaction, 35);

      expect(
        h.container.read(ibsSssBaselineNotifierProvider).canSubmit,
        isFalse,
      );
    });

    test('con las cinco ya puede enviar', () async {
      final h = _harness();
      await _authenticate(h.container);

      _answerAll(h.container);

      expect(
        h.container.read(ibsSssBaselineNotifierProvider).canSubmit,
        isTrue,
      );
    });

    test('responder de nuevo reemplaza el valor anterior', () async {
      final h = _harness();
      await _authenticate(h.container);
      final notifier =
          h.container.read(ibsSssBaselineNotifierProvider.notifier);

      notifier
        ..answer(IbsSssDimension.painSeverity, 20)
        ..answer(IbsSssDimension.painSeverity, 90);

      expect(
        h.container
            .read(ibsSssBaselineNotifierProvider)
            .answers
            .valueFor(IbsSssDimension.painSeverity),
        90,
      );
    });
  });

  group('IbsSssBaselineNotifier · envio (US04 CA01)', () {
    test('un envio incompleto no llega al repositorio', () async {
      // La linea base es irrepetible: un cuestionario a medias gastaria la
      // unica que el paciente puede registrar.
      final h = _harness();
      await _authenticate(h.container);

      final ok = await h.container
          .read(ibsSssBaselineNotifierProvider.notifier)
          .submit();

      expect(ok, isFalse);
      expect(h.ibsSss.submitted, isEmpty);
    });

    test('con las cinco envia, pero todavia no cierra el onboarding', () async {
      // El servidor si lo cerro. Publicarlo aca haria que el guard llevara a
      // la home en el acto y el paciente nunca veria su resultado.
      final h = _harness();
      await _authenticate(h.container);
      _answerAll(h.container);

      final ok = await h.container
          .read(ibsSssBaselineNotifierProvider.notifier)
          .submit();

      expect(ok, isTrue);
      expect(h.ibsSss.submitted, hasLength(1));
      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.pending(OnboardingStep.ibsSssBaseline),
      );
    });

    test('acknowledgeResult cierra el onboarding', () async {
      final h = _harness();
      await _authenticate(h.container);
      _answerAll(h.container);
      final notifier =
          h.container.read(ibsSssBaselineNotifierProvider.notifier);

      await notifier.submit();
      notifier.acknowledgeResult();

      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.completed(),
      );
    });

    test('acknowledgeResult sin resultado no hace nada', () async {
      // Un toque repetido, o un estado reconstruido, no debe cerrar un
      // onboarding que nunca se envio.
      final h = _harness();
      await _authenticate(h.container);

      h.container
          .read(ibsSssBaselineNotifierProvider.notifier)
          .acknowledgeResult();

      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.pending(OnboardingStep.ibsSssBaseline),
      );
    });

    test('guarda el resultado que devolvio el servidor', () async {
      // El puntaje y la categoria los calcula el backend; la app los muestra.
      final h = _harness();
      await _authenticate(h.container);
      _answerAll(h.container);

      await h.container.read(ibsSssBaselineNotifierProvider.notifier).submit();

      final state = h.container.read(ibsSssBaselineNotifierProvider);
      expect(state.result!.totalScore, 220);
      expect(state.result!.severity, IbsSssSeverity.moderate);
      expect(state.result!.triggeredOnboardingCompletion, isTrue);
    });

    test('un segundo toque mientras envia no duplica la peticion', () async {
      final h = _harness(
        ibsSss: FakeIbsSssRepository(delay: const Duration(milliseconds: 50)),
      );
      await _authenticate(h.container);
      _answerAll(h.container);
      final notifier =
          h.container.read(ibsSssBaselineNotifierProvider.notifier);

      final first = notifier.submit();
      final second = await notifier.submit();

      expect(second, isFalse);
      expect(await first, isTrue);
      expect(h.ibsSss.submitted, hasLength(1));
    });
  });

  group('IbsSssBaselineNotifier · errores y reconciliacion', () {
    test('un 409 de linea base duplicada relee el estado del onboarding',
        () async {
      // El envio anterior si entro. Reintentar solo repetiria el 409.
      final patients = FakePatientsRepository(
        profile: demoProfile.copyWith(onboardingCompleted: true),
      );
      final h = _harness(
        ibsSss: FakeIbsSssRepository(
          error: const CauceApiError.duplicateBaselineAssessment(),
        ),
        patients: patients,
      );
      await _authenticate(h.container);
      _answerAll(h.container);
      final callsBefore = patients.fetchProfileCalls;

      final ok = await h.container
          .read(ibsSssBaselineNotifierProvider.notifier)
          .submit();

      expect(ok, isFalse);
      expect(patients.fetchProfileCalls, greaterThan(callsBefore));
      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.completed(),
      );
    });

    test('el 404 sin perfil tambien relee, porque el backend ya guardo',
        () async {
      // El backend persiste la evaluacion antes de intentar cerrar el
      // onboarding, de modo que este 404 llega con la linea base ya guardada.
      final patients = FakePatientsRepository(profile: demoProfile);
      final h = _harness(
        ibsSss: FakeIbsSssRepository(
          error: const CauceApiError.patientProfileNotFound(),
        ),
        patients: patients,
      );
      await _authenticate(h.container);
      _answerAll(h.container);
      final callsBefore = patients.fetchProfileCalls;

      await h.container.read(ibsSssBaselineNotifierProvider.notifier).submit();

      expect(patients.fetchProfileCalls, greaterThan(callsBefore));
    });

    test('un 429 no relee: no dice nada sobre el estado del onboarding',
        () async {
      final patients = FakePatientsRepository(profile: demoProfile);
      final h = _harness(
        ibsSss: FakeIbsSssRepository(
          error: const CauceApiError.rateLimited(retryAfterSeconds: 45),
        ),
        patients: patients,
      );
      await _authenticate(h.container);
      _answerAll(h.container);
      final callsBefore = patients.fetchProfileCalls;

      final ok = await h.container
          .read(ibsSssBaselineNotifierProvider.notifier)
          .submit();

      expect(ok, isFalse);
      expect(patients.fetchProfileCalls, callsBefore);
      expect(
        h.container.read(ibsSssBaselineNotifierProvider).error,
        isA<RateLimitedError>(),
      );
    });

    test('las respuestas sobreviven a un envio fallido', () async {
      // Volver a pedir las cinco tras un 429 seria castigar al paciente por
      // un limite que no depende de el.
      final h = _harness(
        ibsSss: FakeIbsSssRepository(error: const CauceApiError.network()),
      );
      await _authenticate(h.container);
      _answerAll(h.container);

      await h.container.read(ibsSssBaselineNotifierProvider.notifier).submit();

      final state = h.container.read(ibsSssBaselineNotifierProvider);
      expect(state.answers.isComplete, isTrue);
      expect(state.canSubmit, isTrue);
    });

    test('corregir una respuesta limpia el error pendiente', () async {
      final h = _harness(
        ibsSss: FakeIbsSssRepository(error: const CauceApiError.network()),
      );
      await _authenticate(h.container);
      _answerAll(h.container);
      final notifier =
          h.container.read(ibsSssBaselineNotifierProvider.notifier);

      await notifier.submit();
      expect(h.container.read(ibsSssBaselineNotifierProvider).error, isNotNull);

      notifier.answer(IbsSssDimension.painSeverity, 70);

      expect(h.container.read(ibsSssBaselineNotifierProvider).error, isNull);
    });

    test('clearError limpia sin tocar las respuestas', () async {
      final h = _harness(
        ibsSss: FakeIbsSssRepository(error: const CauceApiError.network()),
      );
      await _authenticate(h.container);
      _answerAll(h.container);
      final notifier =
          h.container.read(ibsSssBaselineNotifierProvider.notifier);

      await notifier.submit();
      notifier.clearError();

      final state = h.container.read(ibsSssBaselineNotifierProvider);
      expect(state.error, isNull);
      expect(state.answers.isComplete, isTrue);
    });
  });
}
