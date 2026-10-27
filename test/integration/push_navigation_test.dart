import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:cauce_mobile/core/push/push_navigation.dart';
import 'package:cauce_mobile/core/push/push_permission.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/widgets/cauce_toast.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/history/presentation/history_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/periodic_assessment_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendation_detail_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_ibs_sss_repository.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_push_messaging.dart';
import '../helpers/fake_recommendations_repository.dart';
import '../helpers/fake_token_storage.dart';

/// El toque sobre un push, desde la raiz de la app (R10).

const AuthenticatedUserSnapshot _verified = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

const String _recommendationId = '3f6c1a2e-7b4d-4e1a-9c2b-1a2b3c4d5e6f';

const PushMessage _approved = PushMessage(
  data: <String, String>{
    'type': 'recommendation',
    'entityType': 'recommendation',
    'entityId': _recommendationId,
  },
  title: 'Cauce',
  body: 'Tienes una recomendación nueva.',
);

/// La recomendacion que anuncia [_approved], aprobada y sin abrir.
final _newRecommendation = approvedDetail.copyWith(id: _recommendationId);

/// Consejos sin recomendaciones, que responde el 422 silencioso si pide una.
FakeRecommendationsRepository _emptyAdvice() => FakeRecommendationsRepository()
  ..generationError = const CauceApiError.insufficientClinicalHistory();

typedef _Harness = ({ProviderContainer container, FakePushMessaging push});

Future<_Harness> _pumpApp(
  WidgetTester tester, {
  bool session = true,
  PushMessage? initial,
  FakeRecommendationsRepository? recommendations,
}) async {
  final storage = session
      ? FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: _verified,
        )
      : FakeTokenStorage();
  final borders = appBorders(storage: storage);
  final push = FakePushMessaging(initial: initial);
  addTearDown(push.dispose);

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      pushMessagingProvider.overrideWithValue(push),
      pushPermissionStoreProvider
          .overrideWithValue(MemoryPushPermissionStore()),
      if (recommendations != null) ...<Override>[
        patientsRepositoryProvider.overrideWithValue(
          FakePatientsRepository(
            profile: demoProfile.copyWith(onboardingCompleted: true),
          ),
        ),
        ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
        recommendationsRepositoryProvider.overrideWithValue(recommendations),
        recommendationRequestStoreProvider.overrideWithValue(
          InMemoryRecommendationRequestStore(),
        ),
      ],
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (container: container, push: push);
}

void main() {
  group('Toque sobre un push con la app en segundo plano', () {
    testWidgets('una recomendacion nueva abre Inicio con su tarjeta (CP036)',
        (tester) async {
      final recommendations = _emptyAdvice();
      final h = await _pumpApp(tester, recommendations: recommendations);
      await tester.tap(find.byKey(const Key('nav_journal')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(HistoryScreen), findsOneWidget);

      // Se aprueba mientras la app esta en segundo plano.
      recommendations.put(_newRecommendation);
      h.push.openedApp.add(_approved);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(RecommendationDetailScreen), findsNothing);
      final badge =
          find.byKey(const Key('recommendation_new_$_recommendationId'));
      expect(badge, findsOneWidget);

      final card =
          find.byKey(const Key('recommendation_card_$_recommendationId'));
      await tester.ensureVisible(card);
      await tester.pumpAndSettle();
      await tester.tap(card);
      await tester.pumpAndSettle();

      final detail = tester.widget<RecommendationDetailScreen>(
        find.byType(RecommendationDetailScreen),
      );
      expect(detail.recommendationId, _recommendationId);
      // Abrir el detalle la entrega, y con eso deja de ser nueva.
      expect(recommendations.deliveredIds, <String>[_recommendationId]);
      expect(
        recommendations.detailOf(_recommendationId)!.isNew,
        isFalse,
      );
    });

    testWidgets('el recordatorio de responder sigue abriendo el detalle',
        (tester) async {
      final h = await _pumpApp(tester);

      h.push.openedApp.add(
        const PushMessage(
          data: <String, String>{
            'type': 'reminder',
            'entityType': 'recommendation',
            'entityId': _recommendationId,
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RecommendationDetailScreen), findsOneWidget);
    });

    testWidgets('el recordatorio del cuestionario lo abre desde la pregunta 1',
        (tester) async {
      final h = await _pumpApp(tester);

      h.push.openedApp.add(
        const PushMessage(
          data: <String, String>{
            'type': 'reminder',
            'entityType': 'ibs_sss_schedule',
            'entityId': '',
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PeriodicAssessmentScreen), findsOneWidget);
    });

    testWidgets('el recordatorio semanal abre el Diario', (tester) async {
      final h = await _pumpApp(tester);

      h.push.openedApp.add(
        const PushMessage(
          data: <String, String>{
            'type': 'reminder',
            'entityType': '',
            'entityId': '',
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HistoryScreen), findsOneWidget);
    });
  });

  group('Toque sobre un push con la app cerrada', () {
    testWidgets('con sesion, pasa el splash y abre Inicio con la nueva',
        (tester) async {
      await _pumpApp(
        tester,
        initial: _approved,
        recommendations: _emptyAdvice()..put(_newRecommendation),
      );

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(RecommendationDetailScreen), findsNothing);
      expect(
        find.byKey(const Key('recommendation_new_$_recommendationId')),
        findsOneWidget,
      );
    });

    testWidgets('sin sesion va al login y no recuerda el destino',
        (tester) async {
      final h = await _pumpApp(tester, session: false, initial: _approved);

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(h.container.read(pendingPushDestinationProvider), isNull);
    });
  });

  group('Push con la app en primer plano', () {
    testWidgets('muestra un aviso con el cuerpo y no navega', (tester) async {
      final h = await _pumpApp(tester);

      h.push.foreground.add(_approved);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byKey(cauceToastKey), findsOneWidget);
      expect(find.text('Tienes una recomendación nueva.'), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(RecommendationDetailScreen), findsNothing);

      // Deja correr el reloj para que el aviso no deje timers vivos.
      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });
}
