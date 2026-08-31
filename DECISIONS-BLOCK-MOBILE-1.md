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
Alternativas consideradas. i18next-flutter descartado por ser una capa adicional sin valor claro sobre arb. Solo español sin l10n descartado por generar deuda inmediata para expansión

---

Acta M9: Anulación del acta M5 (PKCE directo contra Keycloak)

Estado: Aprobada Fecha: 22 de agosto de 2026 Aprobado por: Flavio Eduardo Trigueros Chumacero Aplicabilidad: Arquitectura de autenticación del cliente móvil Cauce.

Contexto

El acta M5 (10 de julio de 2026) estableció que el móvil autenticaría vía Authorization Code + PKCE directo contra Keycloak, usando flutter_appauth. Esa decisión se tomó antes de verificar el diseño completo del backend.

La verificación posterior de contrato (documentada en docs/traceability/MATRIZ-IDENTIDAD.md y backend/docs/api/CONTRACT-IDENTITY-v1.md, ambos del 13 de julio de 2026) reveló una incompatibilidad crítica: el AuditingMiddleware del backend registra el evento de login en audit_logs únicamente cuando la petición pasa por la ruta POST /api/v1/auth/login (backend/src/Cauce.Api/Middleware/AuditingMiddleware.cs:46), y LoginCommandHandler es el único punto que actualiza users.last_login_at. Con PKCE directo contra Keycloak, el evento de acceso no llegaría al backend y audit_logs quedaría vacía en la operación de identidad más crítica.

Esto contradice el registro de accesos exigido por la Ley N° 29733 de Protección de Datos Personales y por la RM 688-2020/MINSA para el manejo de historia clínica electrónica en el piloto del Complejo Hospitalario Guillermo Kaelín de la Fuente.

Decisión

Se anula el acta M5. El móvil autenticará contra POST /api/v1/auth/login del backend Cauce (patrón "backend passthrough"). El backend delega la validación de credenciales a Keycloak internamente vía IKeycloakTokenClient.LoginAsync (grant_type=password), pero es el backend el que expone el endpoint público, escribe la fila en audit_logs y actualiza users.last_login_at.

Consecuencias
El paquete flutter_appauth deja de ser necesario para el flujo de login. Se retira de pubspec.yaml durante el bloque Mobile-1b, salvo que se identifique otro uso.
La capa de red del móvil (dio + interceptores) asume la responsabilidad completa de gestionar tokens: guardado en flutter_secure_storage, refresh explícito vía POST /api/v1/auth/refresh, y logout vía POST /api/v1/auth/logout.
Los tokens siguen siendo JWT emitidos por Keycloak. Toda la validación de firma, audiencia (cauce-backend) y expiración en el backend se mantiene sin cambios.
El móvil no llamará directamente a /protocol/openid-connect/token ni a ningún endpoint de Keycloak.
Se solicitará el scope offline_access en el login del móvil para que el refresh token quede desacoplado del ssoSessionIdleTimeout de 30 minutos y viva 30 días. La implementación es responsabilidad del backend (endpoint POST /api/v1/auth/login y POST /api/v1/auth/refresh), no del móvil.
Referencias
Acta M5 (anulada): mobile/DECISIONS-BLOCK-MOBILE-1.md, sección "Acta M5".
docs/traceability/MATRIZ-IDENTIDAD.md, sección "Decisión de arquitectura vigente".
backend/docs/api/CONTRACT-IDENTITY-v1.md.
backend/src/Cauce.Api/Middleware/AuditingMiddleware.cs:46.
backend/src/Cauce.Application/Identity/UseCases/Login/LoginCommandHandler.cs:45.
Ley N° 29733 de Protección de Datos Personales.
RM 688-2020/MINSA sobre historia clínica electrónica.

---

DECISIONS-BLOCK-MOBILE-1B
Actas M10 a M22. Decisiones vinculantes del bloque Mobile-1b (capa de identidad).
Alcance: US01 CA01/CA02/CA03, US05, US07, US08, TS05 setup base.
Fecha del bloque: 2026-08-30.
Autores: Trigo (decisión), Kiwicha (redacción M10-M19), Quinua (redacción M20-M22 tras el preflight de Fase 0).
Estado global: aprobadas.

Acta M10: Nombre estable del snapshot OpenAPI
Contexto. El backend evolucionó su contrato de v1.0 a v1.1 sin cambiar el campo info.version del documento OpenAPI, que sigue siendo "v1". El snapshot local del mobile se llama openapi-v1.0.0.json y renombrarlo en cada sincronización de contenido generaría churn en los scripts de generación y en las rutas del toolchain.
Decisión. El snapshot mantiene el nombre openapi-v1.0.0.json mientras los cambios del backend sean retrocompatibles. Cuando el backend publique cambios incompatibles, el snapshot se regenera con el nombre incrementado y el cambio se documenta en un acta nueva.
Justificación. El nombre del archivo es una ruta de build, no un identificador semántico de versión. Acoplarlo al contenido obliga a tocar package.json, scripts npm y CI en cada sync menor. La trazabilidad real de qué contrato está vigente vive en CONTRACT-IDENTITY-v1.md y en el historial de git del snapshot, no en el nombre del archivo.
Consecuencias. El nombre del archivo no indica su contenido. Quien audite el contrato debe leer CONTRACT-IDENTITY-v1.md y el git log del snapshot, nunca asumir por el nombre. Cada sync de contenido requiere un commit explícito con mensaje descriptivo de qué trae.
Alternativas consideradas. Renombrar en cada sync descartado por el churn en toolchain. Versionar por hash de contenido descartado por ilegibilidad.

Acta M11: Cache de sesión en tres keys separadas de flutter_secure_storage
Contexto. Tras el login el móvil debe persistir el access token, el refresh token y el objeto user que devuelve POST /api/v1/auth/login. Puede guardarlos como un único blob JSON o como entradas independientes.
Decisión. Tres keys separadas en flutter_secure_storage: auth_access_token, auth_refresh_token y auth_user_snapshot, este último con el AuthenticatedUser serializado a JSON.
Justificación. El RefreshInterceptor rota el access token y el refresh token en cada renovación pero no toca el snapshot del usuario. Con un blob único cada rotación obliga a leer, deserializar, mutar y reescribir todo, con riesgo de corromper el snapshot si la escritura se interrumpe. Con keys separadas la rotación escribe solo lo que cambia. El bootstrap del SplashScreen también lee solo lo que necesita en cada rama de decisión.
Consecuencias. clearSession debe borrar las tres keys de forma explícita; olvidar una deja sesión fantasma. Las escrituras y borrados se agrupan con Future.wait para minimizar la ventana de inconsistencia, sin garantía transaccional real, que la plataforma no ofrece.
Alternativas consideradas. Blob JSON único descartado por el costo de la rotación. Guardar el snapshot en drift descartado porque contiene correo y nombre del paciente, dato personal que debe ir cifrado por la Ley N° 29733.

Acta M12: Umbrales de calidad de tests para Mobile-1b
Contexto. El bloque construye la capa de identidad completa, que es la superficie más sensible del sistema en términos legales y de seguridad. Se necesita un umbral explícito y no negociable de calidad de tests.
Decisión. Pass rate 100% al cierre de cada fase, sin excepción y sin tests skipped. Cobertura de código superior al 80% medida sobre las capas domain/ y application/ de cada feature al cierre del bloque.
Justificación. Un test rojo tolerado se normaliza y deja de leerse. Excluir data/ e infrastructure/ del umbral de cobertura es deliberado: su comportamiento se verifica indirectamente por los integration tests y perseguir cobertura sobre adaptadores de red produce tests que solo verifican mocks.
Consecuencias. Una fase con un test rojo no cierra. Skipear un test requiere justificación en el reporte de fase y un acta nueva. La Fase Final valida el umbral con flutter test --coverage y análisis de lcov.info.
Alternativas consideradas. Umbral global de cobertura sin distinguir capas descartado por incentivar tests de bajo valor sobre adaptadores. Umbral del 90% descartado por desproporcionado para el tamaño del bloque.

Acta M13: Diferimiento completo de Firebase a Mobile-4
Contexto. El backend expone PUT /api/v1/users/me/fcm-token y el backlog contempla notificaciones push. Integrar Firebase Core en Mobile-1b implicaría google-services.json, configuración nativa en Android e iOS, y una dependencia pesada sin uso funcional en este bloque.
Decisión. Cero configuración de Firebase en Mobile-1b. Firebase Core y Firebase Cloud Messaging se difieren completamente a Mobile-4.
Justificación. Ninguna de las user stories del bloque (US01, US05, US07, US08) requiere push. Introducir Firebase ahora agrega superficie de build nativa que puede romper la compilación por razones ajenas al alcance, y obliga a gestionar credenciales de Firebase antes de necesitarlas.
Consecuencias. El endpoint de FCM token queda sin consumir hasta Mobile-4. google-services.json y GoogleService-Info.plist siguen en .gitignore por prevención.
Alternativas consideradas. Integrar Firebase Core sin FCM descartado porque el costo de configuración es el mismo y el beneficio es nulo.

Acta M14: Estrategia conservadora de dependencias
Contexto. El pubspec.lock resuelto tiene varias dependencias con majors más recientes disponibles. Actualizarlas durante el bloque de identidad mezcla riesgo de upgrade con riesgo de implementación.
Decisión. Eliminar flutter_appauth y sus derivados por acta M9. Mantener las demás dependencias dentro de su major actual. Diferir el upgrade agresivo de majors a un bloque Mobile-1.5 dedicado. flutter pub get es libre; flutter pub upgrade dentro del mismo major también; flutter pub upgrade --major-versions requiere acta.
Justificación. Un bump de major que rompe la compilación durante la Fase 6 es indistinguible, a primera vista, de un bug de implementación. Separar los dos tipos de riesgo en bloques distintos hace que cada falla tenga una causa única y localizable.
Consecuencias. El proyecto acumula deuda de dependencias durante todo Mobile-1b, que se paga completa en Mobile-1.5 antes de arrancar Mobile-2.
Alternativas consideradas. Upgrade agresivo al inicio del bloque descartado por costo de estabilización desconocido antes de tener tests. Congelar todo con pins exactos descartado por impedir parches de seguridad.

Acta M15: Alcance de US01 en Mobile-1b y diferimiento de CA04
Contexto. US01 tiene cuatro criterios de aceptación. CA04 es la descarga del PDF del consentimiento aceptado, que consume GET /api/v1/patients/me/consent/pdf y requiere manejo de archivos, permisos de almacenamiento y un visor.
Decisión. CA01, CA02 y CA03 se implementan completos en Mobile-1b. CA04 se difiere a Mobile-3, donde vivirá en la sección de perfil del paciente.
Justificación. CA04 no pertenece funcionalmente al flujo de registro sino a la consulta posterior del expediente. Implementarlo en la pantalla de registro sería forzarlo a un lugar donde el usuario no lo busca. Además arrastra permisos de almacenamiento y manejo de PDF, ajenos al alcance de identidad.
Consecuencias. El paciente no puede descargar su consentimiento hasta Mobile-3. La matriz de trazabilidad debe reflejar US01 CA04 como diferido, no como pendiente sin fecha.
Alternativas consideradas. Implementar CA04 en VerifyEmailPendingScreen descartado porque en ese momento el consentimiento aún no está confirmado en el backend.

Acta M16: Toolchain de generación OpenAPI vía npm con versión pinneada
Contexto. El acta M4 estableció openapi_generator 6.0+ como paquete Dart. Ese paquete es un wrapper sobre el generador Java oficial que descarga el jar en tiempo de build, lo que ata la generación al ciclo de build_runner y hace opaca la versión efectiva del generador.
Decisión. La generación se ejecuta con @openapitools/openapi-generator-cli vía npm, con versión pinneada explícita en mobile/tools/openapi/package.json. Se pinnea 2.13.4. Esto reemplaza el mecanismo de generación del acta M4; la elección de dio y del template dart-dio de M4 se mantiene intacta.
Justificación. Pinnear el generador hace la generación reproducible: la misma entrada produce la misma salida en cualquier máquina y en CI. Sacarla de build_runner separa la generación del contrato, que ocurre cuando cambia el backend, de la generación de freezed y riverpod, que ocurre en cada cambio de código.
Consecuencias. El entorno de desarrollo requiere Node y Java, además de Flutter. node_modules/ va a .gitignore. La regeneración es un paso manual explícito, nunca implícito en build_runner.
Alternativas consideradas. Mantener openapi_generator de M4 descartado por versión efectiva opaca. Instalar el generador global descartado por no ser reproducible entre máquinas.

Acta M17: Claude Code no ejecuta comandos git de modificación
Contexto. El 29 de agosto de 2026 Claude Code commiteó CLAUDE.md al repositorio sin autorización, documento que por decisión de Trigo debe permanecer local. El incidente reveló que la regla R2 de reportar y esperar no cubría explícitamente las operaciones de git.
Decisión. Claude Code tiene prohibido absoluto ejecutar git add, git commit, git push, git tag, git merge, git rebase, git reset, git checkout -b, abrir Pull Requests, o cualquier comando que modifique el árbol git o el estado de las ramas. Se permiten git status, git diff y git log para diagnóstico. Todos los commits, merges y tags los ejecuta Trigo vía GitHub Desktop.
Justificación. Un commit no autorizado es difícil de revertir limpiamente una vez empujado, y en el caso de CLAUDE.md expone a un repositorio remoto un documento que contiene contexto operativo que Trigo quiere mantener fuera de la nube. La barrera correcta es prohibir la categoría entera de comandos, no confiar en el criterio caso por caso.
Consecuencias. Claude Code entrega mensajes de commit sugeridos al cierre de cada fase y Trigo decide si los usa. El ciclo de trabajo tiene un paso manual por fase. Como refuerzo, CLAUDE.md se agrega a .gitignore en la Fase 0 de Mobile-1b.
Alternativas consideradas. Permitir git add y git commit pero no push descartado porque un commit local ya ensucia el árbol y se empuja por inercia. Confiar en el criterio del agente descartado: es exactamente lo que falló.

Acta M18: Un solo golden test, para SplashScreen
Contexto. Los golden tests comparan la salida renderizada contra una imagen de referencia. Son sensibles a la versión del engine de Flutter, al sistema operativo y al renderizado de fuentes, lo que los vuelve frágiles en CI multiplataforma.
Decisión. Un único golden test, para SplashScreen. Todos los demás widget tests son de comportamiento: interacción, transiciones de estado y presencia de widgets.
Justificación. SplashScreen es puramente visual, sin interacción, y su composición es estable, así que un golden aporta valor real detectando regresiones de theme. Las demás pantallas son formularios cuyo valor está en la lógica de validación y en el manejo de errores, que los tests de comportamiento cubren sin fragilidad. Con fuentes Inter y JetBrains Mono empaquetadas como assets, el renderizado es determinista y no depende de las fuentes del sistema.
Consecuencias. Un cambio deliberado en el theme obliga a regenerar el golden de SplashScreen con --update-goldens. Las regresiones visuales de las demás pantallas no se detectan automáticamente y dependen de revisión manual.
Alternativas consideradas. Goldens para las ocho pantallas descartado por costo de mantenimiento y fragilidad en CI. Cero goldens descartado por perder toda verificación de que el theme se aplica.

Acta M19: Verificación del estado real de sqlite3_flutter_libs
Contexto. sqlite3_flutter_libs es la dependencia que provee las bibliotecas nativas de SQLite sobre las que corre drift. Circulaban señales de que el paquete podía estar descontinuado y hacía falta verificar su estado real antes de construir sobre él.
Decisión. Verificar el estado del paquete en pub.dev durante la Fase 0 del bloque y actuar en consecuencia. Pin explícito a 0.5.42 si se confirma EOL sin sucesor estable.
Justificación. La persistencia local es la base del diseño offline-first de Cauce. Construir sobre una dependencia abandonada sin saberlo genera deuda que se descubre en el peor momento, cuando ya hay tablas de dominio y datos de pacientes encima.
Consecuencias. El resultado de la verificación queda documentado y condiciona el pin de la dependencia. Ver acta M22, que registra el hallazgo y resuelve la rama que esta acta no anticipó.
Alternativas consideradas. Asumir que el paquete está sano descartado por ser exactamente el riesgo a mitigar.

Acta M20: El cliente OpenAPI generado vive en su propio package
Contexto. La sección 3.1 del prompt Mobile-1b indicaba generar el cliente dart-dio dentro de lib/core/api/generated/. El preflight de Fase 0 verificó que el generador dart-dio no emite un conjunto de archivos sueltos sino un package Dart completo, con su propio pubspec.yaml, analysis_options.yaml y README.
Decisión. El cliente generado vive en mobile/packages/cauce_api_client/, como package independiente. El pubspec.yaml de la app lo declara como path dependency. El script npm de mobile/tools/openapi/package.json apunta a ese destino. Esto enmienda la sección 3.1 del prompt Mobile-1b.
Justificación. Anidar un package con su propio pubspec.yaml dentro de lib/ rompe la resolución de dependencias, confunde al analyzer y hace que build_runner intente procesar el package generado junto con el código de la app. Como package hermano, el codegen de built_value queda aislado del de freezed y riverpod, y regenerar el cliente no dispara una regeneración completa de la app.
Consecuencias. El pubspec.yaml de la app gana una path dependency. La regeneración borra y reescribe el directorio entero del package sin tocar lib/. El paso de verificación de formato de CI debe excluir packages/cauce_api_client o formatearlo dentro del script de generación, porque la salida del generador no siempre respeta dart format.
Alternativas consideradas. Generar y luego borrar el pubspec y el analysis_options del package descartado porque el paso de limpieza hay que repetirlo en cada regeneración y el codegen de built_value quedaría corriendo sobre toda la app. Escribir los DTOs a mano con freezed descartado por contradecir las actas M4 y M16.

Acta M21: Cuatro capas por feature y widgets atómicos en core
Contexto. El acta M2 fijó feature-first con capas data, domain y presentation, y ubicó los widgets reutilizables cross-feature en features/shared/widgets/. El bloque Mobile-1b introduce notifiers de Riverpod y casos de uso, que no encajan en ninguna de las tres capas: no son entidades ni reglas de dominio, no son adaptadores de infraestructura, y no son widgets.
Decisión. Se enmienda el acta M2. Cada feature tiene cuatro capas: data/, domain/, application/ y presentation/. Los notifiers de Riverpod y los casos de uso viven en application/. Los widgets atómicos del design system, que son transversales a todas las features, viven en lib/core/widgets/ y no en features/shared/widgets/.
Justificación. Cuatro capas es la correspondencia exacta con la Clean Architecture del backend .NET, donde Cauce.Application es un proyecto propio y separado de Cauce.Domain. Mantener la simetría entre ambos repositorios reduce la carga cognitiva de saltar entre backend y móvil. Sobre los widgets, el acta M2 ya preveía promoverlos a core cuando aplicara; CauceButton y CauceTextField son infraestructura de presentación transversal, no código compartido entre dos features concretas.
Consecuencias. Los directorios core/routing/ y core/storage/ se renombran a core/router/ y core/database/ para alinearse con la nomenclatura del prompt. Se crean core/widgets/ y features/auth/application/. features/shared/ queda sin uso en Mobile-1b y se elimina. El árbol de test/ pasa a espejar lib/ en vez de agrupar por tipo de test.
Alternativas consideradas. Poner los notifiers en presentation/ descartado por mezclar estado con UI y dificultar testearlos sin widget tree. Ponerlos en domain/ descartado porque dependen de Riverpod, un detalle de framework que el dominio no debe conocer.

Acta M22: Pin de sqlite3_flutter_libs en 0.5.42 para Mobile-1b
Contexto. La verificación exigida por el acta M19 se ejecutó en la Fase 0 del 30 de agosto de 2026. Resultado: el paquete está efectivamente en fin de vida. Su última versión publicada es 0.6.0+eol, que no aporta funcionalidad y existe solo para impedir que las apps arrastren scripts de build obsoletos. El aviso en pub.dev dirige a package:sqlite3 3.x, que absorbe las bibliotecas nativas y es un sucesor estable y mantenido. El proyecto resuelve hoy en 0.5.42, que funciona con drift 2.28.2.
Decisión. Pin exacto en 0.5.42 durante todo Mobile-1b. La migración a package:sqlite3 3.x se difiere al bloque Mobile-1.5.
Justificación. El acta M19 condicionaba el pin a que no existiera sucesor estable, y sí existe, de modo que su condición literal no se cumple. La decisión se resuelve por el acta M14: migrar a sqlite3 3.x es un cambio de major que arrastra a drift y a la capa de persistencia entera, y Mobile-1b no tiene tablas de dominio ni datos que justifiquen asumir ese riesgo ahora. El pin exacto, en lugar del rango ^0.5.24, evita que una resolución futura arrastre el shim vacío 0.6.0+eol y rompa la compilación de forma desconcertante.
Consecuencias. El proyecto queda sobre una dependencia en fin de vida durante todo el bloque, con el riesgo acotado porque 0.5.42 es funcional y AppDatabase arranca en esquema v1 sin tablas. Mobile-1.5 debe migrar a package:sqlite3 3.x antes de que Mobile-3 introduzca meals_local, symptoms_local y sync_operations, para no migrar con datos de pacientes encima.
Alternativas consideradas. Migrar ahora a sqlite3 3.x descartado por contradecir M14 y mezclar riesgo de upgrade con riesgo de implementación en el bloque más sensible del proyecto. Mantener el rango ^0.5.24 descartado por el riesgo de resolver a 0.6.0+eol. Sustituir drift por otra solución de persistencia descartado por contradecir el acta M7.