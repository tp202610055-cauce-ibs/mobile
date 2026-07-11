DECISIONS-BLOCK-MOBILE-01
Actas M1 a M8. Decisiones arquitectónicas vinculantes tomadas antes del arranque de Mobile-1a.
Alcance: foundations del cliente Flutter.
Fecha del bloque: 2026-07-10.
Autores: Trigo (decisión), Kiwicha (redacción).
Estado global: aprobadas.

Acta M1: State management con Riverpod codegen
Contexto. El cliente Flutter necesita un mecanismo de gestión de estado que soporte async, dependencias reactivas entre proveedores, y sea testeable de forma aislada. Las opciones actuales del ecosistema son Provider legacy, Bloc, GetX, Riverpod (con y sin codegen), y state management manual con InheritedWidget.
Decisión. Adoptar flutter_riverpod 2.5+ con riverpod_generator para todo el estado del cliente. Prohibido usar Provider, StateProvider, FutureProvider legacy.
Justificación. Riverpod con codegen ofrece type safety completa en tiempo de compilación, soporte nativo de async con AsyncValue, testeabilidad con ProviderContainer sin necesidad de wrappers, e integración limpia con freezed. La generación de código elimina errores comunes de configuración manual.
Consecuencias. El proyecto requiere build_runner en dev dependencies. Los desarrolladores deben ejecutar dart run build_runner build tras cambios en archivos anotados. Curva de aprendizaje inicial mayor que Provider clásico, compensada por menor superficie de bugs a mediano plazo.
Alternativas consideradas. Bloc fue evaluado y descartado por su verbosidad para casos simples. GetX descartado por su acoplamiento con navegación y su reputación de anti-patrones. Provider legacy descartado por la ausencia de codegen y la fricción con async.

Acta M2: Arquitectura feature-first con capas data/domain/presentation
Contexto. La organización de carpetas condiciona la escalabilidad del proyecto. Las opciones habituales son layer-first (data/, domain/, presentation/ en el top level, con features distribuidas dentro) o feature-first (una carpeta por feature con sus propias capas internas).
Decisión. Feature-first bajo lib/features/<nombre>/{data,domain,presentation}/. Core transversal en lib/core/ separado.
Justificación. Feature-first permite localizar todo el código relacionado con un dominio funcional en una sola carpeta, facilita el trabajo en paralelo entre desarrolladores sobre features distintas, y hace más fácil eliminar o extraer una feature entera si cambia el alcance. La separación core/features aísla concerns cross-cutting sin ensuciar las features.
Consecuencias. La estructura tiene más profundidad (más directorios). Los widgets reutilizables cross-feature deben vivir en features/shared/widgets/ o promoverse a core/ cuando aplique.
Alternativas consideradas. Layer-first descartado porque en proyectos con más de 5 features tiende a generar carpetas gigantes por capa donde es difícil ubicar código de una feature específica.

Acta M3: Routing con go_router 14+
Contexto. Flutter ofrece dos APIs de navegación: Navigator 1.0 (imperativa, basada en stack) y Navigator 2.0 (declarativa, basada en URL). Sobre Navigator 2.0 hay abstracciones como go_router, auto_route, y beamer.
Decisión. go_router 14.2.7+ como router único de la aplicación.
Justificación. go_router es mantenido oficialmente por el equipo de Flutter, tiene type-safe routes, soporte nativo de deep linking (crítico para el callback OIDC cauce://login-callback), integración limpia con Riverpod, y curva de aprendizaje razonable.
Consecuencias. Todas las rutas deben declararse en lib/core/routing/app_router.dart. Los widgets no reciben argumentos de navegación por constructor sino por GoRouterState.
Alternativas consideradas. auto_route descartado por su dependencia de codegen adicional que suma complejidad. Navigator 1.0 descartado por no soportar bien deep linking (requerido para el flujo de auth con Keycloak).

Acta M4: HTTP con dio y cliente OpenAPI generado
Contexto. El backend expone un contrato OpenAPI en openapi-v1.0.0.json. Escribir clientes HTTP a mano es propenso a errores y desincronizaciones con el backend.
Decisión. Usar dio 5.7+ como HTTP client de base, más openapi_generator 6.0+ con template dart-dio para generar el cliente tipado a partir del contrato OpenAPI del backend. Nunca escribir requests a endpoints a mano.
Justificación. El cliente generado incluye modelos, endpoints, y serialización automática desde el contrato. Elimina la posibilidad de tipos, rutas, o enums desalineados con el backend. dio provee interceptors, cancelación con CancelToken, y manejo de timeouts que integran limpio con el cliente generado.
Consecuencias. Cada cambio en el contrato del backend requiere regenerar el cliente en el mobile con dart run build_runner build. El equipo debe respetar el flujo: cambio en backend → re-export de openapi.json → copia al mobile → regeneración.
Alternativas consideradas. Chopper descartado porque el ecosistema OpenAPI dart-dio es más maduro. Requests a mano con http descartadas por el costo de mantenimiento y el riesgo de drift con el backend.

Acta M5: Auth con flutter_appauth y PKCE directo a Keycloak
Contexto. El backend expone endpoints de auth passthrough (/api/v1/auth/login), pero el cliente cauce-mobile en Keycloak está configurado como público con Direct Access Grants ON, y también soporta Authorization Code + PKCE. El paciente puede autenticarse contra Keycloak directamente o vía backend.
Decisión. El mobile implementa Authorization Code + PKCE con flutter_appauth 8.0+ contra Keycloak directamente. NO usar el flujo passthrough del backend para login.
Justificación. PKCE es el estándar OIDC para clientes públicos. flutter_appauth lo implementa correctamente en Android e iOS con manejo del redirect scheme cauce://login-callback. Evita que el backend maneje credenciales de usuario. Simplifica la superficie de auth del backend (que solo valida JWTs).
Consecuencias. El registro nuevo sigue yendo por backend (POST /api/v1/auth/register) porque incluye lógica de consentimiento y perfil. Login, refresh, y logout van directo a Keycloak. Los tokens vienen firmados por Keycloak y validados por backend en cada request.
Alternativas consideradas. Direct Access Grants (username/password directo al token endpoint) descartado por no ser recomendado en clientes públicos. Passthrough por backend descartado por acoplar el backend a la responsabilidad de auth interactiva.

Acta M6: Almacenamiento seguro de tokens con flutter_secure_storage
Contexto. Los tokens JWT deben persistir entre reinicios de la app. Flutter ofrece SharedPreferences (sin cifrado), flutter_secure_storage (cifrado con Keychain en iOS y KeyStore en Android), y almacenamiento en memoria (sin persistencia).
Decisión. flutter_secure_storage 9.2+ para access token, refresh token, y cualquier identificador sensible del usuario. Prohibido usar SharedPreferences para datos de auth.
Justificación. Los JWT permiten acceso completo a datos clínicos sensibles del paciente. Guardar tokens en almacenamiento sin cifrar viola principios básicos de seguridad y compromete Ley 29733. flutter_secure_storage usa Keychain e iOS y KeyStore en Android, ambos soportados por el sistema operativo con cifrado a nivel de hardware cuando está disponible.
Consecuencias. Los tests que involucran secure storage requieren mocking explícito. La primera lectura post-instalación puede ser ligeramente más lenta que SharedPreferences.
Alternativas consideradas. Ninguna. La decisión es no negociable por compliance.

Acta M7: Persistencia local con drift 2.20+ sobre sqflite
Contexto. TS05 exige persistencia local para operación offline. El paciente registra comidas y síntomas sin conectividad, y sincroniza al recuperar red. La persistencia debe garantizar idempotencia (client_guid) y estado de sincronización.
Decisión. drift 2.20+ como ORM tipado sobre sqflite. Todas las tablas offline-critical llevan columnas client_guid (UUID v4 generado en dispositivo) y sync_status (enum: pending, syncing, synced, failed).
Justificación. drift genera código Dart tipado a partir de definiciones declarativas en Dart, ofrece migraciones versionadas, queries tipadas en compile-time, y streams reactivos que integran con Riverpod. sqflite es la implementación estándar de SQLite en Flutter.
Consecuencias. El proyecto requiere drift_dev en dev dependencies. Las migraciones deben versionarse cuidadosamente. El schema local no replica todo el schema del backend, solo las tablas necesarias para operación offline.
Alternativas consideradas. Hive descartado por no soportar queries SQL complejas y por su reputación de bugs no resueltos. Isar evaluado pero descartado por su curva de aprendizaje y por depender de bindings nativos menos maduros.

Acta M8: Localización con arb files y default es_PE
Contexto. La app se despliega en el piloto Kaelín, EsSalud Lima Sur. Los pacientes son hispanohablantes de Lima. El sistema debe soportar futura expansión a otras regiones sin refactor mayor.
Decisión. flutter_localizations con archivos .arb en lib/l10n/. Locale default es_PE, fallback es. Cero strings hardcodeados en widgets. Todos los strings visibles al usuario van a arb.
Justificación. arb es el formato estándar de Flutter para l10n. Soporta plurales, género, y variables interpoladas. La generación de código produce clases tipadas que evitan errores de keys inexistentes. Preparar la arquitectura para multi-locale desde el arranque cuesta poco y evita refactor doloroso post-piloto.
Consecuencias. Cada string nuevo requiere agregarlo al arb correspondiente y regenerar con flutter gen-l10n. Los code reviews rechazan strings hardcodeados salvo strings puramente técnicos que nunca se muestran.
Alternativas consideradas. i18next-flutter descartado por ser una capa adicional sin valor claro sobre arb. Solo español sin l10n descartado por generar deuda inmediata para expansión.