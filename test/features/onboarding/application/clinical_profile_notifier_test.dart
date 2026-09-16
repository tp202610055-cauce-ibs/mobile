import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/onboarding/application/clinical_profile_notifier.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/allergy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

({ProviderContainer container, FakePatientsRepository repository}) _harness([
  FakePatientsRepository? repository,
]) {
  final patients = repository ?? FakePatientsRepository();
  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(patients),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
    ],
  );
  addTearDown(container.dispose);
  return (container: container, repository: patients);
}

Future<void> _authenticate(ProviderContainer container) async {
  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  await container.read(onboardingNotifierProvider.future);
}

const List<AllergyDeclarationDraft> _twoAllergies = <AllergyDeclarationDraft>[
  AllergyDeclarationDraft(
    allergyId: 'aaaaaaaa-0000-4000-8000-000000000001',
    severity: AllergySeverityLevel.moderate,
  ),
  AllergyDeclarationDraft(
    allergyId: 'aaaaaaaa-0000-4000-8000-000000000002',
    severity: AllergySeverityLevel.severe,
    notes: 'Reaccion fuerte',
  ),
];

void main() {
  group('ClinicalProfileNotifier · envio exitoso (US03 CA01)', () {
    test('crea el perfil y avanza el onboarding al paso 2', () async {
      final h = _harness();
      await _authenticate(h.container);

      final ok = await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft);

      expect(ok, isTrue);
      expect(
        h.container.read(clinicalProfileNotifierProvider),
        isA<ClinicalProfileSuccess>(),
      );
      expect(h.repository.createdProfiles, hasLength(1));
      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.pending(OnboardingStep.ibsSssBaseline),
      );
    });

    test('declara las alergias despues del perfil, en orden', () async {
      final h = _harness();
      await _authenticate(h.container);

      await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft, allergies: _twoAllergies);

      expect(h.repository.declaredAllergies, hasLength(2));
      expect(
        h.repository.declaredAllergies.first.allergyId,
        'aaaaaaaa-0000-4000-8000-000000000001',
      );
      expect(h.repository.declaredAllergies.last.notes, 'Reaccion fuerte');
    });

    test('sin alergias marcadas no se declara ninguna', () async {
      final h = _harness();
      await _authenticate(h.container);

      await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft);

      expect(h.repository.declaredAllergies, isEmpty);
    });
  });

  group('ClinicalProfileNotifier · reintentos idempotentes', () {
    test('un 409 de perfil duplicado no bloquea el paso', () async {
      // Significa que el envio anterior si entro y el dispositivo no vio la
      // respuesta. Fallar aca dejaria al paciente sin salida: el perfil existe
      // y volver a enviarlo dara 409 siempre.
      final repository = FakePatientsRepository()
        ..createProfileError = const CauceApiError.duplicateProfile();
      final h = _harness(repository);
      await _authenticate(h.container);

      final ok = await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft, allergies: _twoAllergies);

      expect(ok, isTrue);
      // Las alergias igual se declaran: el perfil ya estaba.
      expect(h.repository.declaredAllergies, hasLength(2));
    });

    test('un 409 de alergia duplicada se salta y sigue con la siguiente',
        () async {
      final repository = FakePatientsRepository();
      repository.declareAllergyErrors['aaaaaaaa-0000-4000-8000-000000000001'] =
          const CauceApiError.duplicateAllergy();
      final h = _harness(repository);
      await _authenticate(h.container);

      final ok = await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft, allergies: _twoAllergies);

      expect(ok, isTrue);
      // La primera ya estaba declarada; solo entra la segunda.
      expect(h.repository.declaredAllergies, hasLength(1));
      expect(
        h.repository.declaredAllergies.single.allergyId,
        'aaaaaaaa-0000-4000-8000-000000000002',
      );
    });
  });

  group('ClinicalProfileNotifier · fallos', () {
    test('un error del perfil corta antes de tocar las alergias', () async {
      final repository = FakePatientsRepository()
        ..createProfileError = const CauceApiError.invalidBiometricValue();
      final h = _harness(repository);
      await _authenticate(h.container);

      final ok = await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft, allergies: _twoAllergies);

      expect(ok, isFalse);
      expect(h.repository.declaredAllergies, isEmpty);
      expect(
        h.container.read(clinicalProfileNotifierProvider).error,
        isA<InvalidBiometricValueError>(),
      );
    });

    test('un allergy_not_found interrumpe y llega a la pantalla', () async {
      // La entrada del catalogo se desactivo entre que se cargo la lista y se
      // envio el formulario. El paciente la desmarca y reintenta.
      final repository = FakePatientsRepository();
      repository.declareAllergyErrors['aaaaaaaa-0000-4000-8000-000000000002'] =
          const CauceApiError.allergyNotFound();
      final h = _harness(repository);
      await _authenticate(h.container);

      final ok = await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft, allergies: _twoAllergies);

      expect(ok, isFalse);
      expect(
        h.container.read(clinicalProfileNotifierProvider).error,
        isA<AllergyNotFoundError>(),
      );
      // La primera si entro: el paso 1 no es atomico y el reintento la saltea
      // por el 409.
      expect(h.repository.declaredAllergies, hasLength(1));
    });

    test('un 409 de perfil duplicado relee el estado del onboarding', () async {
      // La vista local quedo vieja. Si el perfil ya existia desde antes, el
      // paso que de verdad falta puede ser el 2.
      final repository = FakePatientsRepository(
        profile: demoProfile.copyWith(onboardingCompleted: true),
      )..createProfileError = const CauceApiError.duplicateProfile();
      // Para forzar el camino de fallo, la primera alergia tambien revienta.
      repository.declareAllergyErrors['aaaaaaaa-0000-4000-8000-000000000001'] =
          const CauceApiError.allergyNotFound();
      final h = _harness(repository);
      await _authenticate(h.container);
      final callsBefore = repository.fetchProfileCalls;

      await h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft, allergies: _twoAllergies);

      // No relee: el error que llego no fue el de perfil duplicado.
      expect(repository.fetchProfileCalls, callsBefore);
    });

    test('clearError vuelve a idle', () async {
      final repository = FakePatientsRepository()
        ..createProfileError = const CauceApiError.network();
      final h = _harness(repository);
      await _authenticate(h.container);
      final notifier =
          h.container.read(clinicalProfileNotifierProvider.notifier);

      await notifier.submit(draft: demoDraft);
      expect(
        h.container.read(clinicalProfileNotifierProvider),
        isA<ClinicalProfileFailure>(),
      );

      notifier.clearError();

      expect(
        h.container.read(clinicalProfileNotifierProvider),
        isA<ClinicalProfileIdle>(),
      );
    });
  });

  group('ClinicalProfileNotifier · guarda contra el doble envio', () {
    test('un segundo toque mientras envia no dispara otra peticion', () async {
      // El perfil es unico por paciente: el segundo envio solo chocaria contra
      // un 409 que no aporta nada.
      final h = _harness(
        FakePatientsRepository(delay: const Duration(milliseconds: 50)),
      );
      await _authenticate(h.container);
      final notifier =
          h.container.read(clinicalProfileNotifierProvider.notifier);

      final first = notifier.submit(draft: demoDraft);
      final second = await notifier.submit(draft: demoDraft);

      expect(second, isFalse);
      expect(await first, isTrue);
      expect(h.repository.createdProfiles, hasLength(1));
    });

    test('expone isSubmitting mientras la peticion esta en vuelo', () async {
      final h = _harness(
        FakePatientsRepository(delay: const Duration(milliseconds: 50)),
      );
      await _authenticate(h.container);

      final pending = h.container
          .read(clinicalProfileNotifierProvider.notifier)
          .submit(draft: demoDraft);

      expect(
        h.container.read(clinicalProfileNotifierProvider).isSubmitting,
        isTrue,
      );

      await pending;

      expect(
        h.container.read(clinicalProfileNotifierProvider).isSubmitting,
        isFalse,
      );
    });
  });
}
