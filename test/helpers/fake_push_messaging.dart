import 'dart:async';

import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:cauce_mobile/core/push/push_permission.dart';

/// Marca del permiso en memoria, en vez del Keystore.
class MemoryPushPermissionStore implements PushPermissionStore {
  bool asked = false;

  @override
  Future<bool> wasAsked() async => asked;

  @override
  Future<void> markAsked() async => asked = true;
}

/// Push en memoria, encendido, que anota cada llamada en [calls].
class FakePushMessaging implements PushMessaging {
  FakePushMessaging({this.token = 'token-del-telefono', this.initial});

  String? token;
  PushMessage? initial;

  /// Llamadas en orden: `getToken`, `deleteToken`, `requestPermission`.
  final List<String> calls = <String>[];

  final StreamController<String> refreshes =
      StreamController<String>.broadcast();
  final StreamController<PushMessage> openedApp =
      StreamController<PushMessage>.broadcast();
  final StreamController<PushMessage> foreground =
      StreamController<PushMessage>.broadcast();

  @override
  bool get isEnabled => true;

  @override
  Future<String?> getToken() async {
    calls.add('getToken');
    return token;
  }

  @override
  Stream<String> get onTokenRefresh => refreshes.stream;

  @override
  Future<void> deleteToken() async {
    calls.add('deleteToken');
  }

  @override
  Future<void> requestPermission() async {
    calls.add('requestPermission');
  }

  @override
  Future<PushMessage?> initialMessage() async => initial;

  @override
  Stream<PushMessage> get onMessageOpenedApp => openedApp.stream;

  @override
  Stream<PushMessage> get onMessage => foreground.stream;

  Future<void> dispose() async {
    await refreshes.close();
    await openedApp.close();
    await foreground.close();
  }
}
