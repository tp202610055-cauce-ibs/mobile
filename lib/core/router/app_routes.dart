/// Rutas de la aplicacion, en un solo lugar.
///
/// Se declaran como constantes y no como strings sueltos para que el guard,
/// los tests y las pantallas compartan la misma verdad. Un typo en un literal
/// de navegacion no falla en compilacion; una constante ausente si.
abstract final class AppRoutes {
  /// Pantalla de arranque. Resuelve el bootstrap de sesion y no es navegable
  /// a mano.
  static const String splash = '/splash';

  /// Raiz autenticada.
  static const String home = '/home';

  /// Prefijo de todo el arbol de identidad. El guard lo usa para decidir si
  /// una ubicacion pertenece al flujo publico.
  static const String authBranch = '/auth';

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String passwordRecovery = '/auth/password-recovery';
  static const String passwordRecoverySent = '/auth/password-recovery/sent';

  /// Alcanzada por deep link `cauce://auth/password-reset?token=xxx`.
  static const String passwordReset = '/auth/password-reset';

  static const String verifyEmailPending = '/auth/verify-email-pending';

  /// Prefijo del wizard de onboarding clinico (US03 y US04).
  static const String onboardingBranch = '/onboarding';

  /// Paso 1: perfil clinico y alergias.
  static const String onboardingProfile = '/onboarding/clinical-profile';

  /// Paso 2: cuestionario IBS-SSS de linea base.
  static const String onboardingBaseline = '/onboarding/ibs-sss';

  /// Perfil del paciente. Raiz de la rama de consulta y ajustes.
  static const String profile = '/profile';

  /// Privacidad y derechos del paciente bajo la Ley N° 29733. Desde aca se
  /// descarga el consentimiento aceptado (HU0001 escenario 4, CP004).
  static const String profilePrivacy = '/profile/privacy';

  /// Nombre del parametro de consulta que trae el token de recuperacion.
  static const String tokenQueryParam = 'token';
}
