import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:cauce_mobile/core/push/push_navigation.dart';
import 'package:cauce_mobile/core/push/push_permission.dart';
import 'package:cauce_mobile/core/widgets/cauce_toast.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/history/presentation/history_screen.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/periodic_assessment_screen.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendation_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_push_messaging.dart';
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

typedef _Harness = ({ProviderContainer container, FakePushMessaging push});

Future<_Harness> _pumpApp(
  WidgetTester tester, {
  bool session = true,
  PushMessage? initial,
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
    testWidgets('una recomendacion abre su detalle', (tester) async {
      final h = await _pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);

      h.push.openedApp.add(_approved);
      await tester.pumpAndSettle();

      final detail = tester.widget<RecommendationDetailScreen>(
        find.byType(RecommendationDetailScreen),
      );
      expect(detail.recommendationId, _recommendationId);
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
    testWidgets('con sesion, pasa el splash y abre el detalle', (tester) async {
      await _pumpApp(tester, initial: _approved);

      expect(find.byType(RecommendationDetailScreen), findsOneWidget);
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
