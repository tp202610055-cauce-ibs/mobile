import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage.dart';

/// [TokenStorage] en memoria para tests.
///
/// Lleva la cuenta de escrituras y borrados, que es lo que permite verificar
/// la rotacion obligatoria del refresh token y la limpieza de sesion sin
/// depender de `flutter_secure_storage` ni de un canal de plataforma.
class FakeTokenStorage implements TokenStorage {
  FakeTokenStorage({
    this.accessToken,
    this.refreshToken,
    this.userSnapshot,
  });

  String? accessToken;
  String? refreshToken;
  AuthenticatedUserSnapshot? userSnapshot;

  int saveSessionCalls = 0;
  int saveTokensCalls = 0;
  int clearSessionCalls = 0;

  @override
  Future<String?> readAccessToken() async => accessToken;

  @override
  Future<String?> readRefreshToken() async => refreshToken;

  @override
  Future<AuthenticatedUserSnapshot?> readUserSnapshot() async => userSnapshot;

  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required AuthenticatedUserSnapshot user,
  }) async {
    saveSessionCalls++;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    userSnapshot = user;
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    saveTokensCalls++;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  @override
  Future<void> clearSession() async {
    clearSessionCalls++;
    accessToken = null;
    refreshToken = null;
    userSnapshot = null;
  }
}
