import 'dart:convert';

import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/secure_token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Doble en memoria del plugin.
///
/// El plugin real habla por canal de plataforma y no existe en la VM del
/// host, asi que se sustituye por un mapa. Lo que se verifica aca es el
/// contrato del acta M11: que keys se tocan y cuando.
class _FakeSecureStorage extends Mock implements FlutterSecureStorage {
  final Map<String, String> values = <String, String>{};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      values[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    values.remove(key);
  }
}

const AuthenticatedUserSnapshot _demoUser = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

void main() {
  late _FakeSecureStorage plugin;
  late SecureTokenStorage storage;

  setUp(() {
    plugin = _FakeSecureStorage();
    storage = SecureTokenStorage(plugin);
  });

  group('SecureTokenStorage · escritura de sesion', () {
    test('guarda las tres keys separadas del acta M11', () async {
      await storage.saveSession(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _demoUser,
      );

      expect(plugin.values.keys, hasLength(3));
      expect(plugin.values[SecureTokenStorage.accessTokenKey], 'access-1');
      expect(plugin.values[SecureTokenStorage.refreshTokenKey], 'refresh-1');
      expect(
        jsonDecode(plugin.values[SecureTokenStorage.userSnapshotKey]!),
        isA<Map<String, dynamic>>().having(
          (json) => json['email'],
          'email',
          'paciente.demo@cauce.local',
        ),
      );
    });

    test('el snapshot sobrevive un ciclo de escritura y lectura', () async {
      await storage.saveSession(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _demoUser,
      );

      expect(await storage.readUserSnapshot(), _demoUser);
    });
  });

  group('SecureTokenStorage · rotacion de tokens', () {
    test('saveTokens reemplaza el par y conserva el snapshot', () async {
      await storage.saveSession(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _demoUser,
      );

      await storage.saveTokens(
        accessToken: 'access-2',
        refreshToken: 'refresh-2',
      );

      expect(await storage.readAccessToken(), 'access-2');
      expect(await storage.readRefreshToken(), 'refresh-2');
      // La razon de ser de las tres keys: la rotacion no toca la identidad.
      expect(await storage.readUserSnapshot(), _demoUser);
    });
  });

  group('SecureTokenStorage · limpieza', () {
    test('clearSession borra las tres keys, sin dejar fantasmas', () async {
      await storage.saveSession(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _demoUser,
      );

      await storage.clearSession();

      expect(plugin.values, isEmpty);
      expect(await storage.readAccessToken(), isNull);
      expect(await storage.readRefreshToken(), isNull);
      expect(await storage.readUserSnapshot(), isNull);
    });
  });

  group('SecureTokenStorage · lecturas degradadas', () {
    test('sin sesion devuelve null en las tres lecturas', () async {
      expect(await storage.readAccessToken(), isNull);
      expect(await storage.readRefreshToken(), isNull);
      expect(await storage.readUserSnapshot(), isNull);
    });

    test('un snapshot corrupto descarta la sesion entera', () async {
      await storage.saveSession(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _demoUser,
      );
      plugin.values[SecureTokenStorage.userSnapshotKey] = '{no es json';

      expect(await storage.readUserSnapshot(), isNull);
      // Arrastrar tokens sin identidad haria que el bootstrap del splash crea
      // que hay sesion valida.
      expect(plugin.values, isEmpty);
    });

    test('un snapshot con forma inesperada tambien limpia', () async {
      plugin.values[SecureTokenStorage.userSnapshotKey] =
          '["no","es","objeto"]';

      expect(await storage.readUserSnapshot(), isNull);
      expect(plugin.values, isEmpty);
    });

    test('un snapshot vacio se trata como ausencia de sesion', () async {
      plugin.values[SecureTokenStorage.userSnapshotKey] = '';

      expect(await storage.readUserSnapshot(), isNull);
    });
  });
}
