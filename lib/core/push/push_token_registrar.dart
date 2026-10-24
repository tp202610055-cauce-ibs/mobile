import 'dart:async';

import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/dio_provider.dart';
import 'push_messaging.dart';
import 'push_permission.dart';

part 'push_token_registrar.g.dart';

/// `PUT /api/v1/users/me/fcm-token`. Con `null` desvincula el telefono.
class PushTokenApi {
  PushTokenApi(this._usersApi);

  /// Se resuelve al usarse: armar el cliente exige el entorno cargado.
  final UsersApi Function() _usersApi;

  Future<void> update(String? token) async {
    await _usersApi().apiV1UsersMeFcmTokenPut(
      updateFcmTokenRequest: UpdateFcmTokenRequest(
        (b) => b..fcmToken = token,
      ),
    );
  }
}

/// Liga el token de FCM del telefono a la cuenta con sesion.
///
/// Lo enciende y lo apaga `BackgroundServices` con la sesion. Ningun fallo sale
/// de aca, y el token nunca se registra en un log.
class PushTokenRegistrar {
  PushTokenRegistrar({
    required PushMessaging messaging,
    required PushTokenApi api,
    required PushPermissionPrompter permission,
    Duration logoutTimeout = const Duration(seconds: 5),
  })  : _messaging = messaging,
        _api = api,
        _permission = permission,
        _logoutTimeout = logoutTimeout;

  final PushMessaging _messaging;
  final PushTokenApi _api;
  final PushPermissionPrompter _permission;
  final Duration _logoutTimeout;

  StreamSubscription<String>? _refreshes;
  bool _running = false;

  /// `true` mientras escucha los refrescos del token. Para los tests.
  bool get isRunning => _running;

  /// Registra el token actual, escucha sus refrescos y pide el permiso una vez.
  ///
  /// Idempotente. Un registro que falla se repite en el proximo arranque.
  void start() {
    if (_running || !_messaging.isEnabled) {
      return;
    }
    _running = true;
    _refreshes = _messaging.onTokenRefresh.listen(
      (token) => unawaited(_send(token)),
    );
    unawaited(_registerCurrent());
    unawaited(_permission.askOnce());
  }

  /// Deja de escuchar sin tocar el servidor. Idempotente.
  Future<void> stop() async {
    _running = false;
    await _refreshes?.cancel();
    _refreshes = null;
  }

  /// Desvincula el telefono antes de cerrar la sesion, en el mejor esfuerzo.
  ///
  /// Primero deja de escuchar: un refresco a mitad del cierre volveria a ligar
  /// el token. Despues `PUT null` y el borrado local, cada uno con su tope.
  Future<void> unregister() async {
    await stop();
    if (!_messaging.isEnabled) {
      return;
    }
    try {
      await _api.update(null).timeout(_logoutTimeout);
    } on Object {
      // Si no llega, el servidor desliga el token cuando otra cuenta lo use.
    }
    try {
      await _messaging.deleteToken().timeout(_logoutTimeout);
    } on Object {
      // El cierre de sesion sigue igual.
    }
  }

  Future<void> _registerCurrent() async {
    final String? token;
    try {
      token = await _messaging.getToken();
    } on Object {
      return;
    }
    if (token != null && token.isNotEmpty) {
      await _send(token);
    }
  }

  Future<void> _send(String token) async {
    if (!_running) {
      return;
    }
    try {
      await _api.update(token);
    } on Object {
      // Sin red o con el servidor caido: se reintenta en el proximo arranque.
    }
  }
}

@Riverpod(keepAlive: true)
PushTokenApi pushTokenApi(Ref ref) {
  return PushTokenApi(() => ref.read(apiClientProvider).getUsersApi());
}

@Riverpod(keepAlive: true)
PushTokenRegistrar pushTokenRegistrar(Ref ref) {
  final registrar = PushTokenRegistrar(
    messaging: ref.watch(pushMessagingProvider),
    api: ref.watch(pushTokenApiProvider),
    permission: ref.watch(pushPermissionPrompterProvider),
  );
  ref.onDispose(registrar.stop);
  return registrar;
}
