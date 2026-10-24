import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PushMessaging · arranque', () {
    test('sin claves de Firebase devuelve el push apagado, sin lanzar',
        () async {
      final push = await FirebasePushMessaging.initialize(null);

      expect(push, isA<DisabledPushMessaging>());
      expect(push.isEnabled, isFalse);
    });

    test('el push apagado no hace nada y no emite eventos', () async {
      const push = DisabledPushMessaging();

      expect(await push.getToken(), isNull);
      expect(await push.initialMessage(), isNull);
      await push.deleteToken();
      await push.requestPermission();
      expect(await push.onTokenRefresh.isEmpty, isTrue);
      expect(await push.onMessage.isEmpty, isTrue);
      expect(await push.onMessageOpenedApp.isEmpty, isTrue);
    });

    test('sin sustituir el provider, la app arranca con el push apagado', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(pushMessagingProvider).isEnabled, isFalse);
    });
  });
}
