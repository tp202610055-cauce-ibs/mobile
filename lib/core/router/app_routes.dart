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

  /// Configuracion de la cuenta (mockup 12b, P12-B).
  ///
  /// Hermana de [profilePrivacy] y no su reemplazo: Privacidad conserva su
  /// ruta y su pantalla, y Configuracion la enlaza desde "Sobre la app".
  static const String profileSettings = '/profile/settings';

  /// Reporte clinico personal en PDF (HU0024).
  ///
  /// Hermana de [profileSettings] bajo Perfil, y no una seccion suya: CP062
  /// paso 2 y CP063 paso 1 describen el recorrido como "acceder a la seccion
  /// Perfil y seleccionar la opcion para generar su reporte".
  static const String profileReport = '/profile/report';

  /// Glosario clinico-nutricional (HU0027).
  ///
  /// Hermana de las demas rutas bajo Perfil. Se alcanza desde la seccion
  /// "Sobre la app" de Configuracion de cuenta.
  static const String profileGlossary = '/profile/glossary';

  /// Registro de una comida (US09).
  static const String mealNew = '/meals/new';

  /// Constructor de platos personalizados (US10).
  static const String customFoodNew = '/custom-foods/new';

  /// Registro de un sintoma (US11).
  static const String symptomNew = '/symptoms/new';

  /// Historial unificado de comidas y sintomas.
  static const String history = '/history';

  /// Nota de contexto sobre un registro del historial (US13).
  ///
  /// Recibe la `HistoryEntry` por `extra`: la nota se asocia al identificador
  /// **del servidor**, que solo tiene una entrada ya sincronizada.
  static const String clinicalNoteNew = '/history/note';

  /// Cuestionario IBS-SSS periodico (US12).
  static const String ibsSssPeriodic = '/ibs-sss/periodic';

  /// Evolucion del puntaje IBS-SSS (HU0023).
  ///
  /// Se apila sobre el navigator raiz, como los formularios: es una vista de
  /// detalle a la que se llega desde la tarjeta de Perfil, no una raiz de
  /// pestana.
  static const String ibsSssEvolution = '/ibs-sss/evolution';

  /// Recomendaciones aprobadas por la nutricionista (EP0003).
  ///
  /// La pestana existe desde Mobile-3.1 y Mobile-5 la llena. La ruta se llama
  /// como el modulo del backend (`RecommendationsApi`) y como las historias;
  /// "Consejos" es solo la etiqueta que ve el paciente, en el arb.
  static const String recommendations = '/recommendations';

  /// Detalle de una recomendacion (HU0015), dentro de la rama de Consejos.
  ///
  /// Se queda en la rama, como Privacidad bajo Perfil, y no sube al navigator
  /// raiz: es una vista de consulta y conservar la barra deja al paciente
  /// saltar a otra pestana y volver donde estaba. Se llega tocando una
  /// tarjeta, en Consejos o en Inicio.
  static String recommendationDetailPath(String id) => '$recommendations/$id';

  /// Nombre del parametro de consulta que trae el token de recuperacion.
  static const String tokenQueryParam = 'token';
}
