import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'push_messaging.dart';

part 'push_permission.g.dart';

/// Marca de que el permiso de notificaciones ya se pidio en esta instalacion.
abstract interface class PushPermissionStore {
  Future<bool> wasAsked();

  Future<void> markAsked();
}

/// Marca en `flutter_secure_storage`, aparte de las tres claves de la sesion.
///
/// Cerrar sesion no la borra: el permiso se pide una vez por instalacion.
class SecurePushPermissionStore implements PushPermissionStore {
  SecurePushPermissionStore([FlutterSecureStorage? storage])
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  static const String askedKey = 'push_permission_asked';

  final FlutterSecureStorage _storage;

  @override
  Future<bool> wasAsked() async => await _storage.read(key: askedKey) != null;

  @override
  Future<void> markAsked() => _storage.write(key: askedKey, value: 'true');
}

/// Pide el permiso de notificaciones una sola vez por instalacion.
class PushPermissionPrompter {
  PushPermissionPrompter({
    required PushMessaging messaging,
    required PushPermissionStore store,
  })  : _messaging = messaging,
        _store = store;

  final PushMessaging _messaging;
  final PushPermissionStore _store;

  /// Marca antes de preguntar: si el paciente cierra la app con el dialogo
  /// abierto, no se le vuelve a insistir. Nunca lanza.
  Future<void> askOnce() async {
    if (!_messaging.isEnabled) {
      return;
    }
    try {
      if (await _store.wasAsked()) {
        return;
      }
      await _store.markAsked();
      await _messaging.requestPermission();
    } on Object {
      // Sin permiso la app funciona igual; solo no muestra los push.
    }
  }
}

@Riverpod(keepAlive: true)
PushPermissionStore pushPermissionStore(Ref ref) => SecurePushPermissionStore();

@Riverpod(keepAlive: true)
PushPermissionPrompter pushPermissionPrompter(Ref ref) {
  return PushPermissionPrompter(
    messaging: ref.watch(pushMessagingProvider),
    store: ref.watch(pushPermissionStoreProvider),
  );
}
