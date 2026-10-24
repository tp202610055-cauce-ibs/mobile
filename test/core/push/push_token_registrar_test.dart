import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:cauce_mobile/core/push/push_permission.dart';
import 'package:cauce_mobile/core/push/push_token_registrar.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_push_messaging.dart';

/// API que anota cada `PUT` en la misma lista que el push falso.
class _RecordingTokenApi implements PushTokenApi {
  _RecordingTokenApi(this.log);

  final List<String> log;
  bool failing = false;

  @override
  Future<void> update(String? token) async {
    log.add('put:$token');
    if (failing) {
      throw StateError('sin red');
    }
  }
}

class _AskedStore implements PushPermissionStore {
  bool asked = false;

  @override
  Future<bool> wasAsked() async => asked;

  @override
  Future<void> markAsked() async => asked = true;
}

void main() {
  late FakePushMessaging push;
  late _RecordingTokenApi api;

  PushTokenRegistrar registrarFor(PushMessaging messaging) {
    return PushTokenRegistrar(
      messaging: messaging,
      api: api,
      permission:
          PushPermissionPrompter(messaging: messaging, store: _AskedStore()),
    );
  }

  setUp(() {
    push = FakePushMessaging();
    api = _RecordingTokenApi(push.calls);
  });
  tearDown(() => push.dispose());

  group('PushTokenRegistrar · registro', () {
    test('al arrancar con sesion registra el token y pide el permiso',
        () async {
      registrarFor(push).start();
      await pumpEventQueue();

      expect(push.calls, contains('put:token-del-telefono'));
      expect(push.calls, contains('requestPermission'));
    });

    test('cada refresco del token se vuelve a registrar', () async {
      registrarFor(push).start();
      await pumpEventQueue();

      push.refreshes.add('token-nuevo');
      await pumpEventQueue();

      expect(push.calls.last, 'put:token-nuevo');
    });

    test('un fallo de red no lanza y el siguiente refresco reintenta',
        () async {
      api.failing = true;
      final registrar = registrarFor(push)..start();
      await pumpEventQueue();

      api.failing = false;
      push.refreshes.add('token-nuevo');
      await pumpEventQueue();

      expect(registrar.isRunning, isTrue);
      expect(push.calls.last, 'put:token-nuevo');
    });

    test('arrancar dos veces no duplica el registro', () async {
      registrarFor(push)
        ..start()
        ..start();
      await pumpEventQueue();

      expect(
        push.calls.where((call) => call == 'put:token-del-telefono'),
        hasLength(1),
      );
    });

    test('con el push apagado no sale nada a la red', () async {
      final registrar = registrarFor(const DisabledPushMessaging())..start();
      await pumpEventQueue();
      await registrar.unregister();

      expect(registrar.isRunning, isFalse);
      expect(push.calls, isEmpty);
    });
  });

  group('PushTokenRegistrar · cierre de sesion', () {
    test('desliga con PUT null y luego borra el token local', () async {
      final registrar = registrarFor(push)..start();
      await pumpEventQueue();
      push.calls.clear();

      await registrar.unregister();

      expect(push.calls, <String>['put:null', 'deleteToken']);
    });

    test('despues de desligar, un refresco no vuelve a ligar el token',
        () async {
      final registrar = registrarFor(push)..start();
      await pumpEventQueue();
      await registrar.unregister();
      push.calls.clear();

      push.refreshes.add('token-tardio');
      await pumpEventQueue();

      expect(push.calls, isEmpty);
    });

    test('si el PUT null falla, igual borra el token local', () async {
      final registrar = registrarFor(push)..start();
      await pumpEventQueue();
      api.failing = true;
      push.calls.clear();

      await registrar.unregister();

      expect(push.calls, <String>['put:null', 'deleteToken']);
    });
  });
}
