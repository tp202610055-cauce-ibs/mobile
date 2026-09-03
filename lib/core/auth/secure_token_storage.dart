import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'authenticated_user_snapshot.dart';
import 'token_storage.dart';

/// Persistencia de la sesion sobre `flutter_secure_storage`.
///
/// Tres keys separadas por acta M11. La separacion no es estetica: el
/// `RefreshInterceptor` rota los dos tokens sin tocar el snapshot del usuario,
/// y con un blob unico cada rotacion obligaria a leer, deserializar, mutar y
/// reescribir la identidad completa del paciente.
///
/// Los tokens JWT y el correo del paciente son datos personales bajo la Ley
/// N° 29733, de modo que nunca salen de almacenamiento cifrado por la
/// plataforma. No van a `SharedPreferences` ni a drift.
class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage(this._storage);

  /// Construye la instancia de produccion, con las opciones mas estrictas que
  /// cada plataforma soporta sin degradar la experiencia.
  factory SecureTokenStorage.withDefaults() {
    return SecureTokenStorage(
      const FlutterSecureStorage(
        // EncryptedSharedPreferences respalda las claves en el Keystore de
        // Android. Requiere API 23; el proyecto exige 26 (CLAUDE.md §3).
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        // `first_unlock` y no `unlocked`: el refresh silencioso del arranque
        // necesita leer los tokens antes de que el paciente desbloquee la
        // pantalla. `_this_device` evita que la sesion viaje en un backup de
        // iCloud a un telefono distinto.
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      ),
    );
  }

  final FlutterSecureStorage _storage;

  @visibleForTesting
  static const String accessTokenKey = 'auth_access_token';
  @visibleForTesting
  static const String refreshTokenKey = 'auth_refresh_token';
  @visibleForTesting
  static const String userSnapshotKey = 'auth_user_snapshot';

  @override
  Future<String?> readAccessToken() => _storage.read(key: accessTokenKey);

  @override
  Future<String?> readRefreshToken() => _storage.read(key: refreshTokenKey);

  @override
  Future<AuthenticatedUserSnapshot?> readUserSnapshot() async {
    final raw = await _storage.read(key: userSnapshotKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        await clearSession();
        return null;
      }
      return AuthenticatedUserSnapshot.fromJson(decoded);
    } on FormatException {
      // El snapshot quedo corrupto, por una escritura interrumpida o por un
      // cambio de forma del modelo entre versiones de la app. Se descarta la
      // sesion entera en vez de arrastrar una identidad a medias: el paciente
      // vuelve a iniciar sesion, que es molesto pero correcto.
      await clearSession();
      return null;
    }
  }

  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required AuthenticatedUserSnapshot user,
  }) async {
    await Future.wait<void>(<Future<void>>[
      _storage.write(key: accessTokenKey, value: accessToken),
      _storage.write(key: refreshTokenKey, value: refreshToken),
      _storage.write(key: userSnapshotKey, value: jsonEncode(user.toJson())),
    ]);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait<void>(<Future<void>>[
      _storage.write(key: accessTokenKey, value: accessToken),
      _storage.write(key: refreshTokenKey, value: refreshToken),
    ]);
  }

  @override
  Future<void> clearSession() async {
    // Borra las tres, siempre. Omitir una deja sesion fantasma: un snapshot
    // sin tokens haria que el bootstrap del splash crea que hay sesion.
    await Future.wait<void>(<Future<void>>[
      _storage.delete(key: accessTokenKey),
      _storage.delete(key: refreshTokenKey),
      _storage.delete(key: userSnapshotKey),
    ]);
  }
}
