import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../data/auth_repository.dart';
import '../../data/dtos/login_request_dto.dart';
import '../../data/dtos/register_request_dto.dart';
import 'auth_state.dart';

// --- Providers de infraestructura ---

final secureStorageProvider = Provider<SecureStorageService>(
      (ref) => SecureStorageService(),
);

final dioClientProvider = Provider<DioClient>(
      (ref) => DioClient(ref.watch(secureStorageProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
      (ref) => AuthRepository(ref.watch(dioClientProvider).dio),
);

// --- Notifier principal ---

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repository;
  late final SecureStorageService _storage;

  @override
  AuthState build() {
    _repository = ref.read(authRepositoryProvider);
    _storage = ref.read(secureStorageProvider);
    return const AuthInitial();
  }

  /// Verifica si hay un token guardado y lo valida contra /users/me.
  Future<void> restoreSession() async {
    state = const AuthLoading();
    final token = await _storage.readAccessToken();
    if (token == null || token.isEmpty) {
      state = const AuthUnauthenticated();
      return;
    }
    try {
      final user = await _repository.getCurrentUser();
      state = AuthAuthenticated(user);
    } on ApiException {
      await _storage.clearAll();
      state = const AuthUnauthenticated();
    }
  }

  /// Ejecuta el registro y persiste el token en caso de éxito.
  Future<void> register(RegisterRequestDto request) async {
    state = const AuthLoading();
    try {
      final auth = await _repository.register(request);
      await _persistAuth(auth.accessToken, auth.userId, auth.role);
      final user = await _repository.getCurrentUser();
      state = AuthAuthenticated(user);
    } on ApiException catch (e) {
      state = AuthError(e.message);
    }
  }

  /// Ejecuta el login y persiste el token en caso de éxito.
  Future<void> login(LoginRequestDto request) async {
    state = const AuthLoading();
    try {
      final auth = await _repository.login(request);
      await _persistAuth(auth.accessToken, auth.userId, auth.role);
      final user = await _repository.getCurrentUser();
      state = AuthAuthenticated(user);
    } on ApiException catch (e) {
      state = AuthError(e.message);
    }
  }

  /// Cierra sesión y limpia almacenamiento.
  Future<void> logout() async {
    await _storage.clearAll();
    state = const AuthUnauthenticated();
  }

  /// Limpia el estado de error pero mantiene unauthenticated.
  void clearError() {
    if (state is AuthError) {
      state = const AuthUnauthenticated();
    }
  }

  Future<void> _persistAuth(String token, String userId, String role) async {
    await _storage.saveAccessToken(token);
    await _storage.saveUserId(userId);
    await _storage.saveUserRole(role);
  }
}