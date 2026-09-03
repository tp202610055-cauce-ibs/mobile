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

  /// Consentimiento a devolver. El de por defecto alcanza para los tests que
  /// no lo inspeccionan.
  CurrentConsent consent = const CurrentConsent(
    version: '1.0.0',
    text: 'Texto del consentimiento informado del piloto Kaelin.',
    hash: 'sha256:0000000000000000000000000000000000000000000000000000000000',
  );

  /// Error especifico para la carga del consentimiento.
  ///
  /// Separado de [error] porque la pantalla de registro tiene dos fallos
  /// distintos: no poder cargar el consentimiento, y que el registro sea
  /// rechazado.
  CauceApiError? consentError;

  int loginCalls = 0;
  int requestPasswordResetCalls = 0;
  int confirmPasswordResetCalls = 0;
  int currentConsentCalls = 0;
  int registerCalls = 0;
  int logoutCalls = 0;

  String? lastEmail;
  String? lastPassword;
  String? lastToken;
  String? lastNewPassword;
  String? lastFullName;
  String? lastConsentVersion;
  String? lastConsentHash;
  String? lastInvitationCode;
  String? lastRefreshToken;

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

  @override
  Future<CurrentConsent> currentConsent() async {
    currentConsentCalls++;
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final failure = consentError;
    if (failure != null) {
      throw failure;
    }
    return consent;
  }

  @override
  Future<RegistrationResult> register({
    required String email,
    required String fullName,
    required String password,
    required String consentDocumentVersion,
    required String consentTextHash,
    String? invitationCode,
  }) async {
    registerCalls++;
    lastEmail = email;
    lastFullName = fullName;
    lastPassword = password;
    lastConsentVersion = consentDocumentVersion;
    lastConsentHash = consentTextHash;
    lastInvitationCode = invitationCode;
    await _run();
    return RegistrationResult(
      userId: 'e1f2a3b4-0000-0000-0000-000000000000',
      email: email,
      emailVerificationRequired: true,
    );
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    logoutCalls++;
    lastRefreshToken = refreshToken;
    await _run();
  }
}
