import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/onboarding/presentation/ibs_sss_baseline_screen.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_ibs_sss_repository.dart';
import '../helpers/fake_onboarding_draft_store.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_token_storage.dart';

/// CP012 y CP013 desde la raíz: perfil guardado y línea base pendiente.
final AppLocalizations l10n = AppLocalizationsEs();

typedef _Harness = ({ProviderContainer container, FakeIbsSssRepository ibsSss});

Future<_Harness> _pumpApp(
  WidgetTester tester, {
  IbsSssResult result = demoBaselineResult,
}) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );
  final borders = appBorders(storage: storage);
  final ibsSss = FakeIbsSssRepository(result: result);

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      onboardingDraftStoreProvider
          .overrideWithValue(FakeOnboardingDraftStore()),
      patientsRepositoryProvider
          .overrideWithValue(FakePatientsRepository(profile: demoProfile)),
      ibsSssRepositoryProvider.overrideWithValue(ibsSss),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (container: container, ibsSss: ibsSss);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _slider(IbsSssDimension dimension) => find.descendant(
      of: find.byKey(Key('ibs_sss_${dimension.name}')),
      matching: find.byType(Slider),
    );

/// Fija el valor del deslizador; la pregunta 2 va en días.
Future<void> _answer(
  WidgetTester tester,
  IbsSssDimension dimension,
  double value,
) async {
  await tester.ensureVisible(_slider(dimension));
  await tester.pumpAndSettle();
  tester.widget<Slider>(_slider(dimension)).onChanged!(value);
  await tester.pumpAndSettle();
}

void main() {
  group('CP012 · línea base completa', () {
    testWidgets(
        'al entrar ve la pregunta 1, envía 60, 4 días, 50, 55 y 40 y ve 245 '
        'como línea base', (tester) async {
      final next = DateTime.now().add(const Duration(days: 14));
      final h = await _pumpApp(
        tester,
        result: IbsSssResult(
          assessmentId: 'dddddddd-0000-4000-8000-000000000245',
          totalScore: 245,
          severity: IbsSssSeverity.moderate,
          triggeredOnboardingCompletion: true,
          nextAssessmentDate: next,
        ),
      );

      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
      expect(find.byKey(const Key('ibs_sss_painSeverity')), findsOneWidget);

      await _answer(tester, IbsSssDimension.painSeverity, 60);
      await _answer(tester, IbsSssDimension.painFrequency, 4);
      await _answer(tester, IbsSssDimension.bloatingSeverity, 50);
      await _answer(tester, IbsSssDimension.bowelHabitsDissatisfaction, 55);
      await _answer(tester, IbsSssDimension.lifeInterference, 40);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      final sent = h.ibsSss.submitted.single;
      expect(sent.valueFor(IbsSssDimension.painSeverity), 60);
      expect(sent.valueFor(IbsSssDimension.painFrequency), 40);
      expect(sent.valueFor(IbsSssDimension.bloatingSeverity), 50);
      expect(sent.valueFor(IbsSssDimension.bowelHabitsDissatisfaction), 55);
      expect(sent.valueFor(IbsSssDimension.lifeInterference), 40);
      expect(h.ibsSss.submittedTypes.single, IbsSssAssessmentType.baseline);
      expect(
        tester.widget<Text>(find.byKey(const Key('ibs_sss_result_score'))).data,
        l10n.ibsSssResultScore(245),
      );

      h.ibsSss.evolutionPoints = <IbsSssEvolutionPoint>[
        IbsSssEvolutionPoint(
          assessmentId: 'dddddddd-0000-4000-8000-000000000245',
          totalScore: 245,
          assessmentType: IbsSssAssessmentType.baseline,
          completedAt: DateTime.now().toUtc(),
          nextAssessmentDate: next,
        ),
      ];
      await _tap(tester, find.byKey(const Key('ibs_sss_result_continue')));
      expect(find.byType(HomeScreen), findsOneWidget);

      await _tap(tester, find.byKey(const Key('nav_evolution')));

      expect(find.byKey(const Key('evolution_baseline_only')), findsOneWidget);
      expect(find.text(l10n.evolutionScore(245)), findsOneWidget);
      expect(
        find.text(
          l10n.evolutionNextAssessment(OnboardingLabels.date(next.toLocal())),
        ),
        findsOneWidget,
      );
    });
  });

  group('CP013 · línea base incompleta', () {
    testWidgets(
        'sin la pregunta 5 no envía, la señala y conserva las respuestas 1 a 4',
        (tester) async {
      final h = await _pumpApp(tester);
      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);

      await _answer(tester, IbsSssDimension.painSeverity, 60);
      await _answer(tester, IbsSssDimension.painFrequency, 4);
      await _answer(tester, IbsSssDimension.bloatingSeverity, 50);
      await _answer(tester, IbsSssDimension.bowelHabitsDissatisfaction, 55);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      expect(
        find.byKey(const Key('ibs_sss_missing_lifeInterference')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('ibs_sss_result_title')), findsNothing);
      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
      expect(h.ibsSss.submitted, isEmpty);
      for (final (dimension, value) in <(IbsSssDimension, double)>[
        (IbsSssDimension.painSeverity, 60),
        (IbsSssDimension.painFrequency, 4),
        (IbsSssDimension.bloatingSeverity, 50),
        (IbsSssDimension.bowelHabitsDissatisfaction, 55),
      ]) {
        await tester.ensureVisible(_slider(dimension));
        expect(
          tester.widget<Slider>(_slider(dimension)).value,
          value,
          reason: dimension.name,
        );
      }
    });

    testWidgets(
        'al cerrar sesión y volver a entrar invita de nuevo, sin respuestas '
        'ni puntaje guardado', (tester) async {
      final h = await _pumpApp(tester);
      await _answer(tester, IbsSssDimension.painSeverity, 60);
      await _answer(tester, IbsSssDimension.painFrequency, 4);
      await _answer(tester, IbsSssDimension.bloatingSeverity, 50);
      await _answer(tester, IbsSssDimension.bowelHabitsDissatisfaction, 55);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      // Con reloj real: el cierre espera la red y el de la prueba es falso.
      await tester.runAsync(
        () => h.container.read(sessionNotifierProvider.notifier).logout(),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);

      await h.container.read(sessionNotifierProvider.notifier).loginSucceeded(
            accessToken: 'access-2',
            refreshToken: 'refresh-2',
            user: demoUser,
          );
      await tester.pumpAndSettle();

      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
      expect(
        tester.widget<Text>(find.byKey(const Key('ibs_sss_pending'))).data,
        l10n.ibsSssPending(5),
      );
      expect(h.ibsSss.submitted, isEmpty);
    });
  });
}
