import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'helpers/fake_token_storage.dart';

void main() {
  testWidgets('debug deep link', (tester) async {
    final c = ProviderContainer(overrides: [
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
    ]);
    addTearDown(c.dispose);
    await tester.pumpWidget(
        UncontrolledProviderScope(container: c, child: const CauceApp()));
    await tester.pumpAndSettle();
    final router = c.read(appRouterProvider);
    // ignore: avoid_print
    print('ANTES: ${router.state.uri}  matched=${router.state.matchedLocation}');
    router.go('/auth/password-reset?token=abc123');
    await tester.pumpAndSettle();
    // ignore: avoid_print
    print('DESPUES: ${router.state.uri}  matched=${router.state.matchedLocation}');
  });
}
