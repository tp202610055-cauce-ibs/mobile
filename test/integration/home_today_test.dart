import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_token_storage.dart';
import '../helpers/sync_fixtures.dart';

const AuthenticatedUserSnapshot _verified = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

/// La tarjeta "Hoy" de Inicio al abrir la app (acta M49).
///
/// Hasta este bloque el historial solo lo cargaba el Diario, asi que Inicio
/// decia "Todavia no registraste nada hoy" aunque el paciente hubiera
/// registrado, hasta que pasaba por la otra pestana. Lo encontro el recorrido
/// en el celular despues de un login.
void main() {
  testWidgets('cuenta lo registrado hoy sin pasar por el Diario',
      (tester) async {
    final storage = FakeTokenStorage(
      accessToken: 'access-1',
      refreshToken: 'refresh-1',
      userSnapshot: _verified,
    );
    final borders = appBorders(storage: storage);
    // Mediodia local de hoy y no "ahora": el fixture resta cinco minutos, y
    // corriendo justo despues de medianoche la comida caia en el dia anterior.
    final now = DateTime.now();
    await insertPendingMeal(
      borders.database,
      'dddddddd-dddd-4ddd-8ddd-dddddddddddd',
      clientCreatedAt: DateTime(now.year, now.month, now.day, 12).toUtc(),
    );

    final container = ProviderContainer(
      overrides: <Override>[
        tokenStorageProvider.overrideWithValue(storage),
        ...borders.overrides,
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const CauceApp(),
      ),
    );
    await tester.pumpAndSettle();

    final summary = find.byKey(const Key('home_today_summary'));
    expect(summary, findsOneWidget);
    expect(tester.widget<Text>(summary).data, startsWith('1 comida'));
  });
}
