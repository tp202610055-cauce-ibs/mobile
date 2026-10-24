import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:cauce_mobile/core/push/push_permission.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_push_messaging.dart';

class _MemoryPermissionStore implements PushPermissionStore {
  _MemoryPermissionStore({this.failing = false});

  bool asked = false;
  final bool failing;

  @override
  Future<bool> wasAsked() async {
    if (failing) {
      throw StateError('Keystore no disponible');
    }
    return asked;
  }

  @override
  Future<void> markAsked() async {
    asked = true;
  }
}

void main() {
  group('PushPermissionPrompter', () {
    late FakePushMessaging push;

    setUp(() => push = FakePushMessaging());
    tearDown(() => push.dispose());

    test('la primera sesion pide el permiso y deja la marca', () async {
      final store = _MemoryPermissionStore();
      final prompter = PushPermissionPrompter(messaging: push, store: store);

      await prompter.askOnce();

      expect(push.calls, <String>['requestPermission']);
      expect(store.asked, isTrue);
    });

    test('no insiste: con la marca puesta no vuelve a preguntar', () async {
      final store = _MemoryPermissionStore();
      final prompter = PushPermissionPrompter(messaging: push, store: store);

      await prompter.askOnce();
      await prompter.askOnce();

      expect(push.calls, <String>['requestPermission']);
    });

    test('con el push apagado no pregunta ni toca la marca', () async {
      final store = _MemoryPermissionStore();
      final prompter = PushPermissionPrompter(
        messaging: const DisabledPushMessaging(),
        store: store,
      );

      await prompter.askOnce();

      expect(store.asked, isFalse);
    });

    test('un fallo del almacenamiento no rompe nada ni pregunta', () async {
      final prompter = PushPermissionPrompter(
        messaging: push,
        store: _MemoryPermissionStore(failing: true),
      );

      await expectLater(prompter.askOnce(), completes);
      expect(push.calls, isEmpty);
    });
  });
}
