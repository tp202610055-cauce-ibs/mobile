import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/periodic_assessment_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/widgets/ibs_sss_evolution_chart.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
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
import '../helpers/fake_recommendations_repository.dart';
import '../helpers/fake_token_storage.dart';

/// Casos del cuestionario y de Evolución que se recorren desde la raíz (R10).
final AppLocalizations l10n = AppLocalizationsEs();

Future<void> _pumpApp(WidgetTester tester, FakeIbsSssRepository ibsSss) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );
  final container = ProviderContainer(
    overrides: <Override>[
      ...appBorders(storage: storage).overrides,
      tokenStorageProvider.overrideWithValue(storage),
      onboardingDraftStoreProvider
          .overrideWithValue(FakeOnboardingDraftStore()),
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      ),
      ibsSssRepositoryProvider.overrideWithValue(ibsSss),
      recommendationsRepositoryProvider.overrideWithValue(
        FakeRecommendationsRepository()
          ..generationError = const CauceApiError.insufficientClinicalHistory(),
      ),
      recommendationRequestStoreProvider.overrideWithValue(
        InMemoryRecommendationRequestStore(),
      ),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

DateTime _daysAgo(int days) =>
    DateTime.now().toUtc().subtract(Duration(days: days));

IbsSssEvolutionPoint _point(
  int score,
  int daysAgo, {
  int? delta,
  DateTime? next,
}) =>
    IbsSssEvolutionPoint(
      assessmentId: 'a-$score',
      totalScore: score,
      assessmentType: delta == null
          ? IbsSssAssessmentType.baseline
          : IbsSssAssessmentType.periodic,
      completedAt: _daysAgo(daysAgo),
      deltaFromBaseline: delta,
      nextAssessmentDate: next,
    );

List<int> _chartScores(WidgetTester tester) => tester
    .widget<IbsSssEvolutionChart>(find.byType(IbsSssEvolutionChart))
    .points
    .map((point) => point.totalScore)
    .toList();

/// Elige un rango propio en el selector real, escribiendo las dos fechas.
Future<void> _pickRange(WidgetTester tester, DateTime from, DateTime to) async {
  await _tap(tester, find.byKey(const Key('evolution_pick_dates')));
  final material = MaterialLocalizations.of(
    tester.element(find.byType(DateRangePickerDialog)),
  );
  await _tap(tester, find.byIcon(Icons.edit_outlined));
  final fields = find.descendant(
    of: find.byType(DateRangePickerDialog),
    matching: find.byType(TextField),
  );
  await tester.enterText(fields.at(0), material.formatCompactDate(from));
  await tester.enterText(fields.at(1), material.formatCompactDate(to));
  await tester.pumpAndSettle();
  await _tap(tester, find.text(material.okButtonLabel));
}

void main() {
  group('CP030 · el cuestionario pendiente desde Inicio', () {
    testWidgets('con el ciclo vencido, el aviso de Inicio abre la pregunta 1',
        (tester) async {
      final ibsSss = FakeIbsSssRepository()
        ..latest = IbsSssAssessmentSummaryData(
          assessmentId: 'a-320',
          totalScore: 320,
          assessmentType: IbsSssAssessmentType.baseline,
          completedAt: _daysAgo(14),
          nextAssessmentDate: _daysAgo(0).subtract(const Duration(hours: 1)),
        );
      await _pumpApp(tester, ibsSss);

      expect(find.byKey(const Key('home_ibs_sss_reminder')), findsOneWidget);
      await _tap(tester, find.byKey(const Key('home_ibs_sss_resume')));

      expect(find.byType(PeriodicAssessmentScreen), findsOneWidget);
      expect(find.byKey(const Key('ibs_sss_painSeverity')), findsOneWidget);
    });
  });

  group('CP060 · gráfico con datos suficientes', () {
    final points = <IbsSssEvolutionPoint>[
      _point(320, 42),
      _point(280, 28, delta: -40),
      _point(260, 14, delta: -60),
      _point(245, 0, delta: -75),
    ];

    testWidgets('320, 280, 260 y 245 en orden y 23.4 % menos', (tester) async {
      await _pumpApp(tester, FakeIbsSssRepository()..evolutionPoints = points);
      await _tap(tester, find.byKey(const Key('nav_evolution')));

      expect(_chartScores(tester), <int>[320, 280, 260, 245]);
      expect(find.text(l10n.evolutionPercentDown('23.4')), findsOneWidget);
    });

    testWidgets('el rango de 20 días deja 260 y 245, y el de 60 los cuatro',
        (tester) async {
      await _pumpApp(tester, FakeIbsSssRepository()..evolutionPoints = points);
      await _tap(tester, find.byKey(const Key('nav_evolution')));
      final today = DateTime.now();

      await _pickRange(tester, today.subtract(const Duration(days: 20)), today);
      expect(_chartScores(tester), <int>[260, 245]);

      await _pickRange(tester, today.subtract(const Duration(days: 60)), today);
      expect(_chartScores(tester), <int>[320, 280, 260, 245]);
    });
  });

  group('CP061 · solo la línea base', () {
    testWidgets('muestra 310, el motivo y la próxima evaluación a 9 días',
        (tester) async {
      final next = _daysAgo(5).add(const Duration(days: 14));
      await _pumpApp(
        tester,
        FakeIbsSssRepository()
          ..evolutionPoints = <IbsSssEvolutionPoint>[
            _point(310, 5, next: next),
          ],
      );
      await _tap(tester, find.byKey(const Key('nav_evolution')));

      expect(find.byKey(const Key('evolution_baseline_only')), findsOneWidget);
      expect(find.text(l10n.evolutionScore(310)), findsOneWidget);
      expect(find.text(l10n.evolutionBaselineOnlyBody), findsOneWidget);
      expect(
        find.text(
          l10n.evolutionNextAssessment(OnboardingLabels.date(next.toLocal())),
        ),
        findsOneWidget,
      );
      expect(find.byKey(evolutionChartKey), findsNothing);
    });
  });
}
