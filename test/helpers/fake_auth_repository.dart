import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';

const AuthenticatedUserSnapshot demoUser = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

const LoginSession demoSession = LoginSession(
  accessToken: 'access-1',
  refreshToken: 'refresh-1',
  user: demoUser,
);

/// [AuthRepository] controlable para tests de los notifiers.
///
/// Cada metodo devuelve lo que se le configure, o lanza el [CauceApiError] que
/// se le pase. Cuenta invocaciones, que es como se verifica que un doble toque
/// no dispare dos peticiones.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({
    this.loginResult,
    this.error,
    this.delay = Duration.zero,
  });

  /// Sesion a devolver en un login exitoso.
  LoginSession? loginResult;

  /// Si esta presente, todos los metodos lanzan este error.
  CauceApiError? error;

  /// Demora artificial, para observar el estado intermedio de envio.
  Duration delay;

  int loginCalls = 0;
  int requestPasswordResetCalls = 0;
  int confirmPasswordResetCalls = 0;

  String? lastEmail;
  String? lastPassword;
  String? lastToken;
  String? lastNewPassword;

  Future<void> _run() async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final failure = error;
    if (failure != null) {
      throw failure;
    }
  }

  @override
  Future<LoginSession> login({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    lastEmail = email;
    lastPassword = password;
    await _run();
    return loginResult ?? demoSession;
  }

  @override
  Future<void> requestPasswordReset({required String email}) async {
    requestPasswordResetCalls++;
    lastEmail = email;
    await _run();
  }

  @override
  Future<void> confirmPasswordReset({
    required String token,
    required String newPassword,
  }) async {
    confirmPasswordResetCalls++;
    lastToken = token;
    lastNewPassword = newPassword;
    await _run();
  }
}
