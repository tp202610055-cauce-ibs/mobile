import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

/// Arma el contenedor con la sesion ya autenticada.
///
/// El notifier observa [sessionNotifierProvider], asi que sin sesion valida no
/// consulta nada. Se autentica a mano con `loginSucceeded` en vez de simular
/// el bootstrap, que es mas ruido del necesario para lo que se prueba aca.
({ProviderContainer container, FakePatientsRepository repository}) _harness({
  required FakePatientsRepository repository,
}) {
  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(repository),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
    ],
  );
  addTearDown(container.dispose);
  return (container: container, repository: repository);
}

Future<void> _authenticate(ProviderContainer container) {
  return container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
}

void main() {
  group('OnboardingNotifier · resolucion contra el servidor', () {
    test('sin sesion no consulta el perfil', () async {
      final repository = FakePatientsRepository();
      final h = _harness(repository: repository);

      final state = await h.container.read(onboardingNotifierProvider.future);

      expect(state, isA<OnboardingUnavailable>());
      // Consultar un endpoint protegido sin Bearer solo gastaria un 401.
      expect(repository.fetchProfileCalls, 0);
    });

    test('sin perfil, el paso pendiente es el clinico', () async {
      // `fetchProfile` devuelve null porque el repositorio real traduce asi el
      // 404 patient_profile_not_found.
      final h = _harness(repository: FakePatientsRepository());
      await _authenticate(h.container);

      final state = await h.container.read(onboardingNotifierProvider.future);

      expect(
        state,
        const OnboardingState.pending(OnboardingStep.clinicalProfile),
      );
      expect(state.requiresWizard, isTrue);
    });

    test('con perfil y onboardingCompleted en false, falta la linea base',
        () async {
      final h = _harness(
        repository: FakePatientsRepository(profile: demoProfile),
      );
      await _authenticate(h.container);

      final state = await h.container.read(onboardingNotifierProvider.future);

      expect(
        state,
        const OnboardingState.pending(OnboardingStep.ibsSssBaseline),
      );
    });

    test('con onboardingCompleted en true, no hay wizard', () async {
      final h = _harness(
        repository: FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      );
      await _authenticate(h.container);

      final state = await h.container.read(onboardingNotifierProvider.future);

      expect(state, const OnboardingState.completed());
      expect(state.requiresWizard, isFalse);
      expect(state.step, isNull);
    });

    test('un fallo de red deja el estado en error, no en un paso inventado',
        () async {
      // Es lo que sostiene el diseno offline-first: sin poder consultar, el
      // guard no redirige y el paciente sigue usando el resto de la app.
      final repository = FakePatientsRepository()
        ..fetchProfileError = const CauceApiError.network();
      final h = _harness(repository: repository);
      await _authenticate(h.container);

      await expectLater(
        h.container.read(onboardingNotifierProvider.future),
        throwsA(isA<CauceApiError>()),
      );
      expect(
        h.container.read(resolvedOnboardingProvider),
        isA<OnboardingUnavailable>(),
      );
    });
  });

  group('OnboardingNotifier · aplazar y reanudar (CA05)', () {
    test('aplazar conserva el paso pendiente', () async {
      final h = _harness(repository: FakePatientsRepository());
      await _authenticate(h.container);
      await h.container.read(onboardingNotifierProvider.future);

      h.container.read(onboardingNotifierProvider.notifier).defer();

      final state = h.container.read(resolvedOnboardingProvider);
      expect(
        state,
        const OnboardingState.deferred(OnboardingStep.clinicalProfile),
      );
      expect(state.requiresWizard, isFalse);
      expect(state.showsReminder, isTrue);
      expect(state.step, OnboardingStep.clinicalProfile);
    });

    test('aplazar no avisa al backend', () async {
      // No hay endpoint para "aplazado" y no hace falta: el servidor ya sabe
      // que el onboarding esta incompleto.
      final repository = FakePatientsRepository();
      final h = _harness(repository: repository);
      await _authenticate(h.container);
      await h.container.read(onboardingNotifierProvider.future);
      final callsBefore = repository.fetchProfileCalls;

      h.container.read(onboardingNotifierProvider.notifier).defer();

      expect(repository.fetchProfileCalls, callsBefore);
    });

    test('reanudar vuelve al mismo paso', () async {
      final h = _harness(
        repository: FakePatientsRepository(profile: demoProfile),
      );
      await _authenticate(h.container);
      await h.container.read(onboardingNotifierProvider.future);
      final notifier = h.container.read(onboardingNotifierProvider.notifier);

      notifier.defer();
      notifier.resume();

      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.pending(OnboardingStep.ibsSssBaseline),
      );
    });

    test('aplazar un onboarding ya completo no hace nada', () async {
      final h = _harness(
        repository: FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      );
      await _authenticate(h.container);
      await h.container.read(onboardingNotifierProvider.future);

      h.container.read(onboardingNotifierProvider.notifier).defer();

      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.completed(),
      );
    });
  });

  group('OnboardingNotifier · avance del wizard', () {
    test('profileCreated mueve al paso 2 sin releer el perfil', () async {
      // Releer agregaria latencia entre los dos pasos, y la respuesta del POST
      // ya confirmo que el perfil existe.
      final repository = FakePatientsRepository();
      final h = _harness(repository: repository);
      await _authenticate(h.container);
      await h.container.read(onboardingNotifierProvider.future);
      final callsBefore = repository.fetchProfileCalls;

      h.container.read(onboardingNotifierProvider.notifier).profileCreated();

      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.pending(OnboardingStep.ibsSssBaseline),
      );
      expect(repository.fetchProfileCalls, callsBefore);
    });

    test('baselineSubmitted cierra el onboarding', () async {
      final h = _harness(
        repository: FakePatientsRepository(profile: demoProfile),
      );
      await _authenticate(h.container);
      await h.container.read(onboardingNotifierProvider.future);

      h.container.read(onboardingNotifierProvider.notifier).baselineSubmitted();

      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.completed(),
      );
    });

    test('refresh vuelve a preguntarle al servidor', () async {
      final repository = FakePatientsRepository();
      final h = _harness(repository: repository);
      await _authenticate(h.container);
      await h.container.read(onboardingNotifierProvider.future);

      // El servidor cambia por debajo: otro dispositivo completo el perfil.
      repository.profile = demoProfile.copyWith(onboardingCompleted: true);
      await h.container.read(onboardingNotifierProvider.notifier).refresh();

      expect(repository.fetchProfileCalls, 2);
      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.completed(),
      );
    });
  });

  group('resolvedOnboardingProvider · valor sincronico para el guard', () {
    test('mientras resuelve devuelve unavailable y no redirige', () async {
      final h = _harness(
        repository: FakePatientsRepository(
          delay: const Duration(milliseconds: 50),
        ),
      );
      await _authenticate(h.container);

      // Sin esperar el future: es lo que ve el guard en la primera navegacion.
      expect(
        h.container.read(resolvedOnboardingProvider),
        isA<OnboardingUnavailable>(),
      );

      await h.container.read(onboardingNotifierProvider.future);

      expect(
        h.container.read(resolvedOnboardingProvider),
        isA<OnboardingPending>(),
      );
    });
  });
}
