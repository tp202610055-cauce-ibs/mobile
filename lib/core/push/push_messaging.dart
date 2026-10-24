import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/env.dart';

part 'push_messaging.g.dart';

/// Push recibido, reducido a lo que la app usa.
///
/// Vive solo en memoria: su contenido no se guarda ni se registra.
@immutable
class PushMessage {
  const PushMessage({required this.data, this.title, this.body});

  /// Claves `type`, `entityType` y `entityId` que manda el servidor.
  final Map<String, String> data;
  final String? title;
  final String? body;
}

/// Borde con Firebase Cloud Messaging.
///
/// La app habla con esta interfaz y no con el plugin, que usa canales de
/// plataforma y no existe en las pruebas.
abstract interface class PushMessaging {
  /// `false` cuando faltan las claves de Firebase o no se pudo inicializar.
  bool get isEnabled;

  Future<String?> getToken();

  Stream<String> get onTokenRefresh;

  Future<void> deleteToken();

  /// Pide el permiso de notificaciones (Android 13+).
  Future<void> requestPermission();

  /// Push cuyo toque abrio la app estando cerrada, si lo hubo.
  Future<PushMessage?> initialMessage();

  /// Toques sobre un push con la app en segundo plano.
  Stream<PushMessage> get onMessageOpenedApp;

  /// Push que llega con la app en primer plano, donde FCM no muestra nada.
  Stream<PushMessage> get onMessage;
}

/// Push apagado: todo es una operacion vacia.
class DisabledPushMessaging implements PushMessaging {
  const DisabledPushMessaging();

  @override
  bool get isEnabled => false;

  @override
  Future<String?> getToken() async => null;

  @override
  Stream<String> get onTokenRefresh => const Stream<String>.empty();

  @override
  Future<void> deleteToken() async {}

  @override
  Future<void> requestPermission() async {}

  @override
  Future<PushMessage?> initialMessage() async => null;

  @override
  Stream<PushMessage> get onMessageOpenedApp =>
      const Stream<PushMessage>.empty();

  @override
  Stream<PushMessage> get onMessage => const Stream<PushMessage>.empty();
}

/// Push sobre el plugin de Firebase.
class FirebasePushMessaging implements PushMessaging {
  FirebasePushMessaging(this._messaging);

  final FirebaseMessaging _messaging;

  /// Inicializa Firebase con las claves del entorno.
  ///
  /// Nunca lanza: sin claves, o si la inicializacion falla, devuelve el push
  /// apagado y la app sigue arrancando.
  static Future<PushMessaging> initialize(FirebaseConfig? config) async {
    if (config == null) {
      return const DisabledPushMessaging();
    }
    try {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: config.apiKey,
          appId: config.appId,
          messagingSenderId: config.messagingSenderId,
          projectId: config.projectId,
        ),
      );
      return FirebasePushMessaging(FirebaseMessaging.instance);
    } on Object {
      return const DisabledPushMessaging();
    }
  }

  @override
  bool get isEnabled => true;

  // El servidor envia al token de registro de FCM. `register()` entrega el
  // FID, otro identificador, asi que se usan los metodos marcados obsoletos.
  @override
  // ignore: deprecated_member_use
  Future<String?> getToken() => _messaging.getToken();

  @override
  // ignore: deprecated_member_use
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  @override
  // ignore: deprecated_member_use
  Future<void> deleteToken() => _messaging.deleteToken();

  @override
  Future<void> requestPermission() async {
    await _messaging.requestPermission();
  }

  @override
  Future<PushMessage?> initialMessage() async {
    final message = await _messaging.getInitialMessage();
    return message == null ? null : _toPush(message);
  }

  @override
  Stream<PushMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp.map(_toPush);

  @override
  Stream<PushMessage> get onMessage => FirebaseMessaging.onMessage.map(_toPush);

  static PushMessage _toPush(RemoteMessage message) {
    return PushMessage(
      data: <String, String>{
        for (final entry in message.data.entries)
          if (entry.value is String) entry.key: entry.value as String,
      },
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }
}

/// Push de la app. `main()` lo sustituye por el que inicializo Firebase.
@Riverpod(keepAlive: true)
PushMessaging pushMessaging(Ref ref) => const DisabledPushMessaging();
