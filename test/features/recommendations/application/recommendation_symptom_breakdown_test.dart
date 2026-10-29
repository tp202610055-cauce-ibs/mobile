import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendation_symptom_breakdown.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/symptom_breakdown.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/fake_token_storage.dart';
import '../../../helpers/paged_history_fakes.dart';

final RecommendationSupportingData _data = approvedDetail.supportingData!;

/// Historial como lo siembra el servidor: dolor abdominal 2 h despues de una
/// comida, un dia por registro desde ayer hacia atras.
List<SymptomRecord> seededPain(int count, {int offset = 0}) {
  return <SymptomRecord>[
    for (var i = 0; i < count; i++)
      SymptomRecord(
        symptomId: 'seed-${i + offset}',
        occurredAt: _data.windowTo
            .subtract(Duration(days: i + 1))
            .add(const Duration(hours: 2)),
        intensity: 65,
        symptomType: SymptomTypeOption.abdominalPain,
        hasMealAssociation: true,
      ),
  ];
}

Future<SymptomBreakdown?> _breakdown(
  SymptomsRepository symptoms, {
  RecommendationDetail? detail,
}) async {
  final shown = detail ?? approvedDetail;
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      recommendationsRepositoryProvider.overrideWithValue(
        FakeRecommendationsRepository(details: [shown]),
      ),
      symptomsRepositoryProvider.overrideWithValue(symptoms),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  container.listen(
    recommendationSymptomBreakdownProvider(shown.id),
    (_, __) {},
  );
  return container
      .read(recommendationSymptomBreakdownProvider(shown.id).future);
}

void main() {
  group('recommendationSymptomBreakdownProvider', () {
    test('cuenta el historial sembrado por el servidor (CP042, CP077)',
        () async {
      final symptoms = PagedSymptomsRepository(seededPain(4));

      final breakdown = await _breakdown(symptoms);

      expect(breakdown?.leading, <SymptomTypeCount>[
        (type: SymptomTypeOption.abdominalPain, count: 4),
      ]);
      // Pide la ventana del detalle con un dia de margen a cada lado, porque
      // el servidor filtra la lista por clientCreatedAt.
      final call = symptoms.calls.first;
      expect(call.from, _data.windowFrom.subtract(const Duration(days: 1)));
      expect(call.to, _data.windowTo.add(const Duration(days: 1)));
    });

    test('recorre todas las paginas y no repite registros', () async {
      final symptoms = PagedSymptomsRepository(<SymptomRecord>[
        ...seededPain(2),
        ...symptomRecords(
          150,
          newest: _data.windowTo.subtract(const Duration(hours: 1)),
          step: const Duration(minutes: 30),
        ),
      ]);

      final breakdown = await _breakdown(
        symptoms,
        detail: approvedDetail.copyWith(
          supportingData: _data.copyWith(symptomCount: 152),
        ),
      );

      expect(symptoms.calls.map((call) => call.page), <int>[1, 2]);
      expect(breakdown?.total, 152);
      expect(breakdown?.leading.first.type, SymptomTypeOption.bloating);
    });

    test('si no suma el total del servidor devuelve null', () async {
      final breakdown =
          await _breakdown(PagedSymptomsRepository(seededPain(3)));

      expect(breakdown, isNull);
    });

    test('un fallo de red devuelve null para mostrar el total', () async {
      final breakdown = await _breakdown(
        PagedSymptomsRepository(seededPain(4), failOnPage: 1),
      );

      expect(breakdown, isNull);
    });

    test('con cero sintomas ni siquiera sale a la red', () async {
      final symptoms = PagedSymptomsRepository(const <SymptomRecord>[]);

      final breakdown = await _breakdown(
        symptoms,
        detail: approvedDetail.copyWith(
          supportingData: _data.copyWith(symptomCount: 0),
        ),
      );

      expect(breakdown, isNull);
      expect(symptoms.calls, isEmpty);
    });

    test('lo que quedo fuera de la ventana no se cuenta', () async {
      final breakdown = await _breakdown(
        PagedSymptomsRepository(<SymptomRecord>[
          ...seededPain(4),
          ...seededPain(1, offset: 20).map(
            (record) => record.copyWith(
              occurredAt: _data.windowFrom.subtract(const Duration(hours: 3)),
            ),
          ),
        ]),
      );

      expect(breakdown?.total, 4);
    });
  });
}
