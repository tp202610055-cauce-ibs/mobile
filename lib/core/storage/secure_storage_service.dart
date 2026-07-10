import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio de almacenamiento seguro para tokens y datos sensibles del usuario.
/// Usa Keychain en iOS y EncryptedSharedPreferences en Android.
class SecureStorageService {
  static const _accessTokenKey = 'cauce.access_token';
  static const _userIdKey = 'cauce.user_id';
  static const _userRoleKey = 'cauce.user_role';

  static const _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static const _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: _androidOptions,
    iOptions: _iosOptions,
  );

  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  Future<String?> readAccessToken() =>
      _storage.read(key: _accessTokenKey);

  Future<void> saveUserId(String userId) =>
      _storage.write(key: _userIdKey, value: userId);

  Future<String?> readUserId() =>
      _storage.read(key: _userIdKey);

  Future<void> saveUserRole(String role) =>
      _storage.write(key: _userRoleKey, value: role);

  Future<String?> readUserRole() =>
      _storage.read(key: _userRoleKey);

  /// Elimina todos los datos sensibles. Se llama en logout o tras refresh fallido.
  Future<void> clearAll() => _storage.deleteAll();
}