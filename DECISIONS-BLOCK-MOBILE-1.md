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

Acta M23: Estrategia de ramas y tag de cierre del bloque Mobile-1b
Contexto. El prompt del bloque fija feature/mobile-1-identity como rama de trabajo, pero las Fases 0 y 1 se commitearon directo a develop y quedaron pusheadas a origin antes de que se advirtiera la desviación. Reescribir esa historia ya no es opción. Se suma que el workflow de CI solo dispara en develop y main, de modo que trabajar en una rama de feature dejaría las ocho fases restantes sin verificación automática hasta el PR de cierre.
Decisión. El bloque continúa en feature/mobile-1-identity, cortada del HEAD de develop e31e5d3, con el nombre literal que fija el prompt. Los cinco commits de las Fases 0 y 1 se quedan en develop. Desde la Fase 2 todo commitea en la rama de feature. El trigger de push del CI se amplía al patrón feature/** para cubrir esta rama y las de bloques futuros. El bloque cierra con un Pull Request de la rama hacia develop, y sobre develop se coloca el tag v0.2.0-identity una vez mergeado. El pubspec.yaml pasa de 0.1.0+1 a 0.2.0+2 durante la Fase Final, para que la versión declarada coincida con el tag.
Justificación. Lo que quedó en develop es, en su mayoría, trabajo de nivel de rama y no de feature: la restauración del snapshot repara un contrato que el PR #1 dejó roto para todos, las actas son decisiones vinculantes del proyecto entero, y las fuentes son assets que consumirá cualquier bloque futuro. Solo el commit de dependencias es trabajo de feature puro, y extraerlo de una rama ya publicada cuesta más que el beneficio. Sobre el tag, el backend etiqueta el cierre de cada bloque sobre develop y no sobre main, con el formato v-semver-slug, y su bloque de identidad fue v0.1.0-identity; el móvil replica esa convención. La versión 0.1.0 del móvil ya está tomada por el tag v0.1.0-initial-prototype-idea, de modo que el salto a 0.2.0 evita la colisión y refleja que este bloque agrega funcionalidad.
Consecuencias. El historial del bloque queda partido: las Fases 0 y 1 se leen en develop y las Fases 2 en adelante en el PR de la rama. Quien audite la trazabilidad debe mirar ambos lugares, y esta acta es el puntero que lo explica. Ampliar el CI a feature/** hace que toda rama de feature futura consuma minutos de Actions, costo asumido a cambio de detectar regresiones dentro de la fase que las introduce y no ocho fases después.
Alternativas consideradas. Reescribir develop para mover las Fases 0 y 1 a la rama descartado porque develop ya estaba pusheada y es rama compartida. Continuar todo el bloque en develop descartado porque deja la rama de integración en estado incompleto durante nueve fases y elimina el PR como superficie de revisión del bloque, que además sirve de evidencia para la memoria de tesis. Nombrar la rama feature/mobile-1b-identity, más preciso porque el bloque es 1b y no 1, descartado para no divergir del documento de prompt que ya circula.

Acta M24: Disparo del refresh por status 401, no por errorCode
Contexto. La sección 3.6 del prompt Mobile-1b indicaba disparar la renovación silenciosa ante un 401 cuyo `errorCode` fuera `invalid_credentials`. La implementación de la Fase 3 mostró que esa condición no se cumple nunca en el escenario que pretende cubrir: `invalid_credentials` es el código que devuelve `POST /auth/login` ante credenciales incorrectas, mientras que un access token vencido en un endpoint protegido lo rechaza el middleware de autenticación JWT, que responde 401 sin ese código. Con el filtro del prompt, el `RefreshInterceptor` no se activaría jamás y la sesión del paciente moriría a los quince minutos.
Decisión. El `RefreshInterceptor` intenta renovar cuando se cumplen tres condiciones simultáneas: el status es 401, la ruta no pertenece a la allowlist anónima del `AuthInterceptor`, y la petición no fue ya reintentada. El `errorCode` no participa de la decisión. Esto enmienda la sección 3.6 del prompt.
Justificación. El status y la ruta son los dos datos que el cliente sí controla y que describen el escenario con precisión: un 401 en una ruta protegida solo puede significar que la credencial adjunta no sirve, que es exactamente cuando corresponde renovar. La allowlist evita el caso patológico de reintentar un login fallido, y la marca de reintento corta cualquier ciclo si el backend vuelve a responder 401 con el token nuevo.
Consecuencias. Un 401 en ruta protegida por una causa distinta al vencimiento, por ejemplo un token revocado del lado servidor, también dispara un intento de renovación. El costo es una petición extra a `/auth/refresh` que fallará con 401 y cerrará la sesión, que es el desenlace correcto de todos modos.
Alternativas consideradas. Decidir por el campo `exp` del JWT antes de cada petición descartado porque obliga a confiar en el reloj del teléfono, que el paciente puede tener desajustado. Mantener el filtro por `errorCode` del prompt descartado porque no se cumple nunca.

Acta M25: Solo 400 y 401 en el refresh cierran la sesión
Contexto. Cuando `POST /auth/refresh` falla, el cliente debe decidir si la sesión terminó o si el fallo es transitorio. El prompt no distinguía los casos y la lectura literal llevaba a limpiar el almacenamiento ante cualquier error.
Decisión. Solo un 400 o un 401 del refresh limpian las tres keys y lanzan `SessionExpiredException`. Cualquier otro status, en particular 429 y la familia 5xx, se propaga sin tocar el almacenamiento. Un cuerpo de respuesta sin `accessToken` o sin `refreshToken` se trata como sesión terminada, porque un par incompleto no sirve para seguir.
Justificación. 400 y 401 son las respuestas que significan que ese refresh token concreto ya no vale: expiró, fue revocado o se consumió. Un 429 significa que el backend está limitando el ritmo, y un 500 que tuvo un problema propio; ninguno dice nada sobre la validez de la credencial. Cerrar la sesión de un paciente porque el servidor tuvo un hipo transitorio lo obliga a autenticarse de nuevo sin motivo real, y en el piloto eso se traduce en registros de comidas que no se hacen.
Consecuencias. Ante un 5xx sostenido, la app queda con una sesión que no puede renovar y cuyas peticiones protegidas seguirán fallando. Es el comportamiento correcto: el paciente conserva su sesión y la app se recupera sola en cuanto el backend responde.
Alternativas consideradas. Limpiar ante cualquier fallo descartado por lo anterior. Reintentar el refresh con backoff descartado para Mobile-1b por complejidad frente al beneficio; se reconsidera en Mobile-3, donde el sync offline hace más probable el choque con rate limits.

Acta M26: Endurecimiento del almacenamiento seguro de sesión
Contexto. La Fase 4 implementó `SecureTokenStorage` sobre `flutter_secure_storage`. Dos aspectos quedaron abiertos por el prompt: qué nivel de accesibilidad usar en el KeyChain de iOS, y qué hacer cuando el snapshot de usuario persistido no se puede deserializar.
Decisión. En iOS se usa `first_unlock_this_device` y no `first_unlock`. Ante un snapshot corrupto o con forma inesperada, `readUserSnapshot` descarta la sesión completa, es decir borra las tres keys, y devuelve nulo.
Justificación. Sobre la accesibilidad: `first_unlock` es necesario porque el arranque de la app lee los tokens antes de que el paciente desbloquee la pantalla, y `unlocked` rompería ese camino. El sufijo `_this_device` impide además que la sesión viaje en un backup de iCloud hasta otro teléfono, que para credenciales de una aplicación clínica bajo la Ley N° 29733 es el default correcto. Sobre el snapshot: conservar los tokens sin la identidad produce una sesión fantasma, porque el bootstrap del splash encontraría credenciales y creería que hay sesión válida, para fallar más adelante lejos de la causa. Descartar todo obliga al paciente a iniciar sesión otra vez, que es molesto pero honesto y localiza el problema.
Consecuencias. Una sesión no sobrevive a la restauración de un backup en un teléfono distinto; el paciente vuelve a autenticarse, que es lo esperable. Un cambio de forma del modelo `AuthenticatedUserSnapshot` entre versiones de la app invalida las sesiones guardadas: si en el futuro se agrega un campo requerido, hay que preverlo con una migración o con un campo opcional.
Alternativas consideradas. `unlocked_this_device` descartado porque impide el refresh silencioso del arranque. Borrar solo la key del snapshot y conservar los tokens descartado por la sesión fantasma.

Acta M27: AppDatabase arranca en esquema v1 sin tablas
Contexto. TS05 pide dejar operativa la infraestructura de persistencia local, pero Mobile-1b no tiene ninguna entidad que persistir: la sesión vive en almacenamiento cifrado por el acta M11 y las tablas de dominio pertenecen a Mobile-3.
Decisión. `AppDatabase` se crea en la Fase 4 con `schemaVersion` 1 y la lista de tablas vacía. No se difiere su creación al bloque siguiente.
Justificación. Crear la base vacía ahora fija el punto de partida del versionado de esquema. Mobile-3 escribirá entonces una migración real de v1 a v2 para introducir `meals_local`, `symptoms_local` y `sync_operations`. La alternativa, inventar un v1 que ya traiga tablas, dejaría sin ruta de migración a cualquier instalación del piloto anterior a ese cambio, y en un piloto clínico con pacientes reales eso significa pérdida de datos o reinstalación.
Consecuencias. El bloque incluye una base de datos que no almacena nada, con el coste de un archivo sqlite vacío en el dispositivo. La clase expone tres constructores: `file()` para producción, `memory()` para tests y el de inyección. Un test verifica que `allTables` está vacío, de modo que agregar una tabla sin escribir la migración correspondiente rompe la suite.
Alternativas consideradas. Diferir drift entero a Mobile-3 descartado porque incumple TS05 y traslada al bloque siguiente el riesgo de que la persistencia no arranque. Arrancar en v1 con las tablas de Mobile-3 ya declaradas descartado por crear esquema muerto y por adelantar decisiones de modelado sin los casos de uso a la vista.

Acta M28: Golden tests excluidos de CI, ejecutados solo en local
Contexto. El golden de SplashScreen, único del bloque por acta M18, pasa en Windows y falla en el Ubuntu de CI. El diagnóstico sobre los logs confirmó que es el único test que falla: 221 de 222 pasan y el resto del pipeline, formato, analyzer y demás tests, queda verde. La causa es que el rasterizador Skia de Flutter produce diferencias sutiles de antialiasing y de posicionamiento subpíxel entre plataformas, y la comparación de goldens es byte a byte. Empaquetar Inter como asset en la Fase 2 elimina la variabilidad de fuentes del sistema, pero no la del rasterizado. Es un problema conocido y documentado del framework.
Decisión. Los golden tests se marcan con `tags: ['golden']` y el pipeline de CI los excluye con `flutter test --coverage --exclude-tags golden`. Siguen ejecutándose en local, donde `flutter test` sin argumentos los incluye.
Justificación. El golden aporta valor como detector de regresiones visuales cuando alguien del equipo toca el theme y corre los tests en su máquina, que es el momento en que la regresión se introduce y donde el aviso es accionable. En CI, en cambio, solo produce un rojo permanente que enseña a ignorar el pipeline, que es el peor resultado posible para una barrera de calidad. La cobertura no se ve afectada: SplashScreen queda cubierta al 100% por los widget tests de comportamiento.
Consecuencias. CI reporta 221 tests y en local son 222. La diferencia es esperada y esta acta es su explicación. Un cambio de theme que rompa el golden se detecta al correr tests en local, y la referencia se regenera con `flutter test test/features/splash --update-goldens`. Si un bloque futuro necesita validación visual estricta en CI, se evaluará un job dedicado con imagen fija.
Alternativas consideradas. Regenerar el golden en Linux desde CI con `--update-goldens` descartado porque entonces fallaría en el Windows local, invirtiendo el problema en vez de resolverlo. Mantener dos imágenes de referencia, una por plataforma, con lógica de selección, descartado por sobreingeniería para el único golden del bloque. Correr los goldens en un job de CI aparte sobre una imagen fija de Ubuntu descartado por complejidad no justificada frente al alcance actual.

---

DECISIONS-BLOCK-MOBILE-1.5
Acta M29. Decisión vinculante del bloque Mobile-1.5 (puesta al día del cliente contra el contrato v1.3).
Alcance: US19 (reenvío de verificación de correo) y US20 CA02 (canje de código después del registro).
Fecha del bloque: 2026-09-12.
Autores: Trigo (decisión), Kiwicha (redacción del prompt de bloque), Quinua (redacción del acta).
Estado global: aprobada.

Acta M29: El canje de código post-registro vive en una feature Patients propia
Contexto. El contrato v1.2 agregó `POST /api/v1/patients/me/nutritionist-assignment`, que permite a un paciente ya registrado canjear un código de invitación y vincularse a un nutricionista (US20 CA02). El móvil tenía dos ubicaciones plausibles para el método: extender `features/auth/data/auth_repository.dart`, que ya consume el código de invitación en el registro, o abrir una feature nueva. El endpoint es el primero del móvil que pertenece al módulo Patients del backend.
Decisión. Se crea `lib/features/patients/` con una sola capa, `data/`, y el método vive en `PatientsRepository`. `auth_repository.dart` no se toca. Las otras tres capas quedan sin crear hasta que un bloque futuro las necesite. El tipo de dominio `NutritionistAssignment` se declara en el mismo archivo del repositorio, igual que `LoginSession`, `RegistrationResult` y `CurrentConsent` en `auth_repository.dart`.
Justificación. Los seis métodos de `AuthRepository` son anónimos o casi: cinco no requieren token y el sexto, el logout, solo necesita el refresh token. El canje exige un Bearer válido y la política `Patient` del backend, de modo que un 401 o un 403 ahí significan cosas distintas que en identidad. Mezclarlos obligaría a que la misma clase documente dos contratos de autorización. La correspondencia con el backend también es directa: el endpoint es del controller de Patients, no del de Auth, y el acta M21 ya fijó que el árbol del móvil espeja la separación de proyectos del backend. Abrir la feature ahora tiene coste casi nulo y le da a Mobile-2, que trae el perfil clínico completo, el lugar donde aterrizar.
Consecuencias. El árbol gana una feature con una sola de las cuatro capas del acta M21. Un lector podría leer la ausencia de `application/`, `domain/` y `presentation/` como trabajo a medias, y esta acta es su explicación: la decisión es no inventar un notifier ni una pantalla sin un caso de uso que los pida. Mobile-2 completa las capas restantes. El repositorio replica el helper `_guard()` de `AuthRepository` en vez de compartirlo, porque extraerlo a `core/` con un solo consumidor adicional sería abstracción prematura; si aparece un tercer repositorio, corresponde promoverlo.
Alternativas consideradas. Extender `AuthRepository` descartado por mezclar rutas anónimas con rutas que exigen política `Patient`, y por romper la correspondencia con los controllers del backend. Crear `features/patients/` con las cuatro capas vacías descartado porque deja carpetas sin contenido que el analyzer ignora y el lector interpreta como código faltante. Ubicar el método en `core/` descartado porque no es un concern transversal sino un caso de uso de una feature concreta.

---

DECISIONS-BLOCK-MOBILE-2
Actas del bloque Mobile-2 (onboarding clínico: US03 perfil clínico y US04 línea base IBS-SSS).
Fecha del bloque: 2026-09-15.
Autores: Trigo (decisión), Kiwicha (redacción del prompt de bloque), Quinua (redacción del acta).
Estado global: aprobadas.

Acta M30: Mobile-2 reparte el onboarding clínico en tres features y no persiste borrador local

Contexto. El acta M29 abrió `lib/features/patients/` con una sola capa y anticipó que Mobile-2 completaría las restantes. Al planificar el bloque aparecieron cuatro cuestiones que M29 no resuelve. El wizard cruza dos módulos del backend, Patients y ClinicalRegistry, que M29 usó justamente como criterio de separación. El aplazamiento del CA05 pide guardar progreso, y los datos en juego son clínicos. El enrutamiento post-login necesita un dato que el login no devuelve. Y los controles de formulario que el wizard necesita no están en el theme ni en `core/widgets/`, con el agravante de que el HTML del design system no está en el checkout actual.

Decisión.

1. Tres features. `features/patients/` cubre perfil clínico y alergias, y no IBS-SSS. `features/ibs_sss/` es nueva y cubre la línea base. `features/onboarding/` aporta `application/` y `presentation/` sin capa `data/`: compone las otras dos.
2. No se persiste borrador local del wizard. El punto de retorno lo da el servidor: 404 en `GET /patients/profile` significa paso 1 pendiente, y 200 con `onboardingCompleted` en false significa paso 2 pendiente.
3. El estado de onboarding se resuelve en un notifier propio que observa la sesión, no en el bootstrap del splash. El guard redirige cuando el estado resuelve incompleto.
4. `CauceSlider` y `CauceChoiceField` se derivan de `design_tokens.dart`, no se transcriben del HTML del design system.

Justificación.

La separación en tres features extiende el criterio de M29 en vez de contradecirlo. M29 justificó abrir `patients/` porque el endpoint pertenecía al controller de Patients y el árbol del móvil espeja la separación de proyectos del backend. `POST /ibs-sss` pertenece a ClinicalRegistry, así que el mismo argumento pide una feature aparte. Meterlo en `patients/` mantendría una carpeta menos a costa de romper la correspondencia que fue la razón de ser del acta anterior. `onboarding/` sin capa `data/` refleja lo que el wizard es: una composición de dos casos de uso que ya viven en otro lado, no un origen de datos propio. Hay además un argumento de bloque futuro: US12 trae el IBS-SSS periódico con reglas propias, y su repositorio aterriza en `ibs_sss/`, no en una feature llamada onboarding.

No persistir borrador local es, antes que una decisión de producto, una de cumplimiento. El acta M11 y el comentario de cabecera de `app_database.dart` ya establecen que los datos personales bajo la Ley N° 29733 no van al sqlite de drift, que no está cifrado. Peso, estatura, fecha de nacimiento y respuestas del IBS-SSS son exactamente eso. La alternativa viable era `flutter_secure_storage`, y se descartó por proporción: el wizard se completa una vez, el paso 2 son cinco controles que se responden en menos de un minuto, y el paso 1 ya queda guardado en el servidor en cuanto se envía. El servidor ofrece de por sí un punto de retorno de dos estados que cubre el caso real.

Resolver el onboarding fuera del splash preserva el diseño offline-first. El bootstrap de sesión lee el Keystore y no toca la red; meterle una llamada protegida le agregaría un round trip a cada arranque y un modo de fallo sin respuesta buena cuando no hay conectividad. Con un notifier aparte, un fallo de red deja el estado sin resolver, el guard no redirige y el paciente usa el resto de la app. Tampoco se amplió `SessionState`: la sesión es identidad, y el perfil clínico es otra cosa.

Derivar los átomos del design system es lo único posible hoy. `docs/02-design-system/` está vacía en el checkout, verificado el 2026-09-15. `design_tokens.dart` es la única transcripción sobreviviente del documento y no cubre slider, select ni chip. Usar widgets de Material sin envoltorio se descartó porque incumple el mínimo de área táctil de 48px y el anillo de foco de 3px que el design system sí fija, y porque el acta M21 ya ubicó los átomos en `core/widgets/`.

Consecuencias. El árbol gana dos features. `features/ibs_sss/` arranca con dos capas y `features/onboarding/` con dos, por el mismo criterio de M29: no se inventan capas sin caso de uso. Aplazar el wizard dura lo que dura la sesión de la app, y en el próximo arranque en frío vuelve a ofrecerse. Los dos widgets nuevos quedan marcados como derivados: si el HTML del design system reaparece y define esos componentes, corresponde cotejarlos y ajustar. El helper `_guard()` se promovió a `core/network/api_guard.dart` al aparecer el tercer repositorio, que es exactamente lo que M29 dejó pedido.

Tres consecuencias más, surgidas al implementar:

- **El resultado del cuestionario se muestra antes de cerrar el onboarding.** `IbsSssBaselineNotifier.submit()` guarda el resultado pero no publica el estado completo; lo hace `acknowledgeResult()` cuando el paciente toca continuar. Sin esa separación el guard llevaría a la home en el instante del envío y el paciente nunca vería su puntaje. El servidor ya cerró el onboarding en ese punto, de modo que el estado local va deliberadamente un paso atrás del servidor durante esa pantalla.
- **El puntaje y la categoría se presentan en registro clínico neutro.** Se muestra el valor sobre la escala completa, la categoría tal como la devolvió el servidor, y quién la interpreta. Sin colores de alarma ni adjetivos. Mismo criterio para el IMC. La categoría de severidad es el punto de partida de una medición, no un diagnóstico, y el IMC es un dato informativo para el paciente y su nutricionista.
- **El backend calcula, el cliente no.** El puntaje total y la categoría de severidad llegan resueltos del servidor. El cliente conoce los límites del instrumento (`IbsSssScale`) pero no replica los umbrales de clasificación: el enum `SeverityCategory` del contrato tiene tres valores, no cuatro, y no incluye una categoría de remisión.

Alternativas consideradas. Una sola feature `onboarding/` con las cuatro capas, descartada por dejar el repositorio de IBS-SSS en una feature que US12 no usa. Todo dentro de `features/patients/`, descartada por meter ClinicalRegistry dentro de Patients. Persistir el borrador en drift, descartada por datos clínicos sin cifrar y por forzar una migración v1 a v2 que el acta M27 reserva para Mobile-3. Resolver el onboarding en el splash, descartada por latencia de arranque y por el modo de fallo sin red. Agregar un estado de onboarding a `SessionState`, descartada por mezclar identidad con perfil clínico.

Acta M31: Flutter local se fija en 3.44.2 como medida temporal; la migración de Riverpod 2 a 3 es un bloque propio

Contexto. La migración a la laptop Lenovo instaló Flutter 3.47.4 con Dart 3.13.3, y el CLAUDE.md del móvil pasó a declarar esa versión en su v1.2.1. Al arrancar Mobile-2 se descubrió que con ese SDK el codegen no corre: `dart run build_runner build` aborta con `Exception: Missing implementation of visitDotShorthandPropertyAccess` dentro de `ResolutionSink._writeNode`. El `analyzer` que resuelve el lockfile es el 7.6.0, cuya versión de lenguaje es 3.9.0, y no sabe serializar los dot shorthands que el framework de Flutter 3.47 ya usa en su propio código. Los 249 tests pasaban porque los archivos generados están commiteados; nadie había vuelto a correr `build_runner` después de la migración. CI, pineado en 3.44.2, seguía verde.

Decisión. El SDK local se baja a **3.44.2**, la misma versión que pinea el workflow de CI. El checkout de `C:\fsrc\flutter` queda con HEAD desprendido sobre el tag, fuera de la rama `stable`, para que no se auto actualice. La migración del toolchain completo, que arrastra Riverpod 2 a 3, queda como **bloque propio a futuro** y explícitamente fuera de Mobile-2.

Justificación. Se verificó contra los paquetes publicados que no hay salida sin cruzar majors. El arreglo está en `analyzer` 8.0.0: la 7.7.1, máxima del major 7, parsea los dot shorthands pero tampoco los serializa, de modo que subir dentro del major no cambia nada. Y las seis piezas del stack de codegen topan por debajo de 8: `riverpod_generator` 2.6.4 en `^7.0.0`, más `freezed` 2.5.8, `source_gen` 2.0.0, `json_serializable` 6.9.5, `drift_dev` 2.28.0 y `build_resolvers` 2.5.4, todas en `<8.0.0`. El salto mínimo real es `riverpod_generator` 3.0.0 y `freezed` 3.2.1, y no las 4.x que anuncia `flutter pub outdated`; aun así `riverpod_generator` 3.0.0 arrastra `riverpod_annotation` 3.0.0 y con él `flutter_riverpod` 3.x. Esa migración toca todos los notifiers, los providers de red y el router, y está gobernada por R5 y el acta M14. Bajar el SDK cuesta cero churn de dependencias, restaura el codegen en el acto y de paso cierra el desfase local contra CI que el CLAUDE.md ya tenía anotado como abierto.

Consecuencias. El CLAUDE.md del móvil pasa a v1.2.2: secciones 3 y 5.1 vuelven a 3.44.2 / Dart 3.12.2, con el aviso completo y la tabla de verificación del analyzer. `pubspec.lock` cambia 11 líneas, que son los paquetes fijados por el SDK volviendo a lo de 3.44.2; es en efecto la reversión del commit `2de923a`. Quien clone el repo y use 3.47.4 se topará con el mismo crash, y el aviso de la sección 3 es su explicación. La deuda queda anotada en la sección 9 del CLAUDE.md.

De paso se aclaró el alcance de R3, que no estaba escrito: la regla protege los repositorios de Cauce, no el checkout del SDK de Flutter ni otras herramientas externas. Quinua puede ajustar el toolchain sin luz verde mientras no toque un repo del proyecto. También se documentó `git show HEAD:<ruta> > <ruta>` como vía para restaurar un archivo borrado sin usar comandos git de modificación y sin el riesgo de que GitHub Desktop se lleve por delante los untracked al descartar cambios, que es el accidente que ya costó una reconstrucción del CLAUDE.md en septiembre.

Alternativas consideradas. Subir el stack de codegen completo, descartado por arrastrar la migración de Riverpod 2 a 3 dentro de un bloque cuyo alcance es el onboarding clínico. Buscar una versión intermedia de `analyzer`, investigada con límite de tiempo y descartada con evidencia: el arreglo está en 8.0.0 y todo el stack topa en `<8.0.0`. Instalar un segundo SDK en paralelo o adoptar FVM, descartado por duplicar disco en una laptop donde ya se bajó el NDK por espacio (commit `ad2e567`), y por agregar configuración por proyecto que nadie más del equipo tiene.

---

DECISIONS-BLOCK-CONSENT-PDF
Actas del bloque de cierre de HU0001 escenario 4 (CP004: descarga del comprobante de consentimiento).
Fecha del bloque: 2026-09-17.
Autores: Trigo (decisión), Kiwicha (redacción del prompt de bloque), Quinua (redacción del acta).
Estado global: aprobadas.

Acta M32: Techo de versión en share_plus por conflicto con flutter_secure_storage

Contexto. La descarga del comprobante de consentimiento necesita entregarle el PDF al paciente por la hoja de compartir del sistema operativo. La dependencia propuesta y aprobada en su momento fue `share_plus: ^13.3.0`. Al resolverla, `flutter pub get` falló: la 13.x arrastra `win32` 5.15.0 y `ffi` 2.2.0, y esa cadena es incompatible con `flutter_secure_storage ^9.2.2`, que es el paquete donde viven los tres keys de sesión del acta M11.

Decisión. Se fija `share_plus: ^12.0.2` en vez de `^13.3.0`. `flutter_secure_storage` no se toca y permanece en la rama 9.x. Subirlo a la 11.x queda como cambio aparte, con su propia evaluación.

Justificación. Un salto de dos majors sobre el componente más sensible del stack no se justifica por una versión más nueva de una librería que ya cumple el requisito en la anterior. `flutter_secure_storage` custodia el access token, el refresh token y el snapshot del usuario autenticado; el acta M26 ya fija su comportamiento en iOS y qué pasa ante un snapshot corrupto. Un cambio ahí se evalúa por sí solo, mirando qué cambia en el Keystore de Android y en el llavero de iOS, y no de refilón dentro de un bloque cuyo alcance es una pantalla de privacidad. La 12.x entrega exactamente lo que el caso pide: `SharePlus.instance.share` con `ShareParams`, archivos adjuntos y nombre de archivo propio.

Consecuencias. `share_plus` queda con un techo explícito en el `pubspec.yaml` y en la tabla del stack del CLAUDE.md, con el motivo anotado, para que nadie lo suba por inercia al ver que hay una versión mayor disponible. El bloque que decida subir `flutter_secure_storage` destraba de paso este techo. R5 sigue gobernando: el salto de major sobre cualquiera de los dos necesita luz verde explícita.

Alternativas consideradas. Subir `flutter_secure_storage` de 9.x a 11.x para habilitar `share_plus` 13.x, descartado por lo dicho arriba: mezcla un cambio de riesgo alto dentro de un bloque que no lo requiere. Escribir el PDF a disco y abrirlo con un intent propio sin librería, descartado por reimplementar a mano lo que `share_plus` resuelve en las dos plataformas, incluidos los permisos y el `FileProvider` de Android.

DECISIONS-BLOCK-MOBILE-3
Actas M33 a M37. Decisiones vinculantes del bloque Mobile-3 (registro clínico diario, EP0002).
Fecha del bloque: 2026-09-18.
Autores: Trigo (decisión), Kiwicha (redacción del prompt de bloque), Quinua (redacción del acta).
Estado global: aprobadas.
Nota de procedencia: estas cinco actas se redactaron en Mobile-3.1 (2026-09-19), a partir del índice del CLAUDE.md v1.3.0 y del código ya mergeado en el PR #6, porque el texto original vivía en la descripción de ese PR y no es alcanzable desde la terminal de trabajo. Kiwicha las contrastó contra esa descripción y quedan como definitivas.

Acta M33: CauceSlider parametriza sus extremos

Contexto. `CauceSlider` nació en Mobile-2 para el cuestionario IBS-SSS, cuyas cinco dimensiones van de 0 a 100, y tenía esos extremos fijos. HU0011 necesita el mismo control para la intensidad de un síntoma, que el backend valida entre 1 y 100: `CreateSymptomCommandValidator` rechaza el cero con un 400.

Decisión. `CauceSlider` recibe `min` y `max` como parámetros, con 0 y 100 por defecto. El formulario de síntoma lo monta con `min: 1`. Las etiquetas de los extremos muestran los valores reales y no los fijos anteriores.

Justificación. Un slider que ofrece el cero cuando el servidor lo rechaza produce un rechazo que el paciente no puede anticipar: mueve el control al extremo, envía, y recibe un error por algo que la propia interfaz le ofreció. Parametrizar los extremos es la forma mínima de que el átomo sirva a los dos instrumentos sin duplicarlo ni ramificarlo por dominio, y los defaults preservan a todos los llamadores anteriores sin tocarlos.

Consecuencias. El átomo queda con dos parámetros más y con sus etiquetas derivadas de ellos. Los tests del cuestionario de línea base siguen valiendo sin cambios, porque el default es el comportamiento anterior. Ampliar un átomo compartido de `core/widgets/` es un cambio de alcance y se reportó antes de hacerlo.

Alternativas consideradas. (a) Dejar el cero y traducir el 400 del servidor, descartada porque convierte una regla conocida de antemano en un error de red. (b) Un átomo nuevo, `CauceIntensitySlider`, descartado por obligar a mantener dos controles casi idénticos: la accesibilidad, el valor semántico y el tratamiento del estado sin responder se duplicarían por una diferencia de un punto en un extremo. (c) Una guarda en la pantalla, con el botón de envío deshabilitado si el valor es menor que 1, descartada porque el paciente puede dejar el pulgar en un valor que no lo deja avanzar y la pantalla no le explica por qué.

Acta M34: Tercer estado local de sincronización, failed, que nunca viaja al servidor

Contexto. El esquema drift v2 guarda comidas y síntomas creados sin conexión, con su `sync_status`. El enum del contrato tiene dos valores, `Pending` y `Synced`. Un registro que el servidor rechaza de forma permanente, por ejemplo con `food_item_not_found` porque el alimento se retiró del catálogo, no es ninguno de los dos: reintentarlo para siempre lo deja atascado y marcarlo como sincronizado sería mentir.

Decisión. La tabla local suma un tercer valor, `failed`, que **no existe en el contrato y nunca viaja al servidor**. `SyncFailurePolicy` decide: los `errorCode` permanentes mandan la fila a terminal, y el resto la deja pendiente para el próximo intento. Una fila terminal se le muestra al paciente con su explicación y con la acción de descartarla.

Justificación. La distinción entre un fallo que se resuelve solo al reintentar y uno que no se va a resolver nunca es una propiedad del dispositivo, no del servidor: el servidor ya dijo lo suyo con su `errorCode`. Mantener el valor fuera del enum del contrato evita que un día se serialice por accidente en un lote de `POST /sync/batch`. Y una fila terminal sin salida convierte la cola en un atasco visible y sin remedio, de modo que el descarte es parte de la decisión y no un extra.

Consecuencias. `LocalSyncStatus` tiene tres valores y el mapeo hacia el contrato cubre solo dos, con la conversión explícita. El historial muestra el estado y ofrece el descarte cuando corresponde. El design system no define este estado, de modo que su badge se diseñó en Mobile-3.1 siguiendo la sección F, con icono y texto y nunca solo color.

Alternativas consideradas. (a) Borrar la fila al primer rechazo permanente, descartada porque el paciente registró algo real y perderlo sin avisar es peor que mostrarlo trabado. (b) Un contador de reintentos que pasa a terminal después de N intentos, por ejemplo cinco, descartado porque tarda en rendirse ante un error que ya se sabe permanente: `food_item_not_found` no cambia por intentarlo cinco veces, y mientras tanto la fila reaparece en cada lote. (c) Dejar todo en `pending` para siempre, descartado porque el lote crece sin techo y vuelve a fallar en cada reconexión, arrastrando también a las filas sanas que viajan con él.

Acta M35: La búsqueda del catálogo de alimentos es siempre local

Contexto. `GET /foods/search` existe y funciona. CP023 exige registrar una comida en modo avión, de punta a punta, y el buscador es parte de ese recorrido. Por separado, se verificó que el endpoint del servidor usa `ILike` sin `unaccent`, aunque la extensión está instalada y el glosario sí la usa: escribir "platano" no encontraría "Plátano de la isla maduro".

Decisión. La búsqueda por texto del catálogo corre **siempre** contra la caché local `food_catalog_cache`, nunca contra `GET /foods/search`, y normaliza las tildes en el cliente con `TextNormalizer`. El catálogo completo se refresca al abrir sesión. Las sugerencias sí son del servidor y solo están con conexión: sin red la sección se oculta, sin error, y la búsqueda por texto sigue disponible.

Justificación. Una búsqueda que depende de la red rompe el caso de prueba en el primer paso, y el diseño offline-first del producto no admite que la pieza más usada del registro sea la que primero falla sin señal. Normalizar en el cliente resuelve de paso el gap de `unaccent` del servidor sin esperar a que lo arreglen. El costo es tener el catálogo en el dispositivo, que ya hacía falta para el registro sin conexión.

Consecuencias. `food_catalog_cache` pasa a ser una dependencia dura del registro de comidas y no un acelerador opcional. El gap de `unaccent` en `GET /foods/search` queda reportado al backend y sin resolver, esquivado por esta decisión. Mobile-3.1 extendió la misma normalización a los platos personalizados del paciente.

Alternativas consideradas. Buscar en el servidor con la caché como respaldo, descartado porque duplica la lógica de coincidencia en dos lugares con reglas distintas de tildes, y el paciente vería resultados diferentes según la señal. Esperar a que el backend agregue `unaccent`, descartado porque no destraba el modo avión.

Acta M36: El historial se compone desde /meals y /symptoms, no desde GET /history

Contexto. El contrato publica `GET /api/v1/history`, pensado justamente para el historial unificado. Al generar el cliente Dart se verificó que su esquema `HistoryEvent` declara **una sola propiedad**, `occurredAt`, con `additionalProperties: false`: la jerarquía polimórfica del servidor quedó aplanada en el OpenAPI. El cliente generado descarta `eventType`, `meal`, `symptom` y `note` en silencio y devuelve una lista de fechas vacías. El servidor sí manda los datos; el problema es del contrato.

Decisión. El historial se compone en el cliente a partir de `GET /meals` y `GET /symptoms`, que sí devuelven tipos completos, más lo que todavía no salió del dispositivo. `GET /history` no se consume.

Justificación. Un endpoint que devuelve fechas vacías no es utilizable, y arreglar el contrato es trabajo del backend con su propio ciclo de publicación. Las dos consultas que sí funcionan traen todo lo necesario, incluida la carga FODMAP agregada y la asociación con la comida ya resuelta por el servidor. Componer en el cliente cuesta una consulta más y una unión por `clientGuid`, que ya existía para no duplicar las filas locales con las remotas.

Consecuencias. El historial hace dos peticiones en vez de una. `HistoryApi` queda generado y sin usar. El gap quedó reportado al backend y sin resolver. Los dos endpoints exigen un rango de fechas explícito, por el defecto que se documenta aparte.

Alternativas consideradas. Leer el `Map` crudo de la respuesta de `GET /history` sin pasar por el tipo generado, descartado por construir a mano un deserializador polimórfico que el contrato debería declarar, y que quedaría desalineado el día que el backend lo corrija.

Acta M37: Sin mecanismo de notificación para el cuestionario periódico

Contexto. HU0012 CA01 pide que el paciente llegue al cuestionario periódico cuando su ciclo de catorce días vence. El servidor ya tiene armado el camino de push: `IbsSssReminderWorker` agenda una `Notification` a las 48 horas del vencimiento. El móvil no puede recibirla sin Firebase Cloud Messaging, que el acta M13 difirió.

Decisión. Mobile-3 no integra Firebase. El acceso al cuestionario es un aviso en la home, que aparece cuando `nextAssessmentDate` ya venció, más la entrada del menú principal. Es lo que el propio CA01 contempla con "o desde el menú principal".

Justificación. Integrar FCM arrastra el plugin de Firebase, la configuración por plataforma, los certificados de APNs y el registro del token, que es un bloque propio y no una tarea dentro de EP0002. El aviso en la home cumple el criterio de aceptación tal como está redactado, y el servidor conserva la notificación agendada para cuando el canal exista.

Consecuencias. El paciente que no abre la aplicación no se entera de que le toca responder. El acta M13 sigue vigente y su destino se movió a Mobile-5, donde EP0003 necesita el canal para HU0014 CA01. Mientras el estado no resuelve, o si falla, el aviso **no** aparece: uno que apareciera por las dudas mandaría a responder un cuestionario que quizá no toca, y el ciclo es irrepetible dentro de su ventana. Mobile-3.1 sumó el ítem del menú del FAB, alcanzable desde cualquier pestaña, con sus tres estados.

Alternativas consideradas. Notificaciones locales programadas en el dispositivo, descartadas porque el vencimiento lo calcula el servidor y una copia local se desincroniza en cuanto el paciente responde desde otro lado o el ciclo se reagenda.

DECISIONS-BLOCK-MOBILE-3.1
Acta M38. Decisión vinculante del bloque Mobile-3.1 (navegación persistente y cierre real de EP0002).
Fecha del bloque: 2026-09-19.
Autores: Trigo (decisión), Kiwicha (redacción del prompt de bloque), Quinua (redacción del acta).
Estado global: aprobada.

Acta M38: Shell de navegación persistente con StatefulShellRoute, formularios sobre el navigator raíz, y dos compuertas que son del cliente

Contexto. La Fase 0 de Mobile-4 encontró que cuatro pantallas de Mobile-3 estaban registradas en el router y no eran alcanzables: nada en `lib/` navegaba a `/meals/new`, `/custom-foods/new`, `/symptoms/new` ni `/history`. El inventario completo de `context.push` y `context.go` del árbol eran nueve llamadas, ninguna a esas cuatro. Un paciente con la aplicación instalada no podía registrar una comida. La home seguía siendo la provisional de Mobile-1b, cuyo propio docstring anunciaba un reemplazo que no ocurrió. En paralelo, siete Casos de Prueba nombran literalmente un "menú inferior" con secciones, y la sección H del design system lo especifica desde la v1.0: bottom nav de cinco ítems con FAB central elevado.

Se encontró además un segundo callejón sin salida del mismo tipo: `CustomFoodsRepository.list()` se consumía en un solo lugar, la detección de nombres duplicados al crear, y no había **ninguna** vía para agregar un plato personalizado a una comida. HU0010 entera terminaba sin salida.

Decisión.

1. La navegación de las cuatro secciones se monta con `StatefulShellRoute.indexedStack` de go_router: Inicio, Diario, Consejos y Perfil, con el FAB recortado en la columna del medio. Cada rama conserva su pila y su estado al cambiar de pestaña.
2. `CauceScaffold` **no se toca**. El shell aporta su propio `Scaffold` con la barra y el botón; cada pestaña sigue montando el suyo. La alternativa de sumarle un `bottomNavigationBar` al átomo se evaluó y se descartó.
3. Los formularios de registro (comida, plato personalizado, síntoma, nota de contexto, cuestionario periódico) se apilan sobre el **navigator raíz**, a pantalla completa y sin barra inferior. Privacidad, en cambio, se queda dentro de la rama de Perfil.
4. La feature de la cuarta pestaña se llama `recommendations` y su ruta es `/recommendations`, igual que el módulo del backend y que las historias. "Consejos" es solo la etiqueta que ve el paciente, en el arb.
5. El retroceso de Android resuelve en tres escalones: primero lo apilado dentro de la rama, después vuelve a Inicio desde cualquier otra pestaña, y solo en la raíz de Inicio sale de la aplicación.
6. El buscador de alimentos encuentra también los platos del paciente, con su badge de "Plato propio · no validado", y ofrece crear uno cuando no hay coincidencias, devolviéndolo ya seleccionado. El buscador de **ingredientes** del constructor de platos no los ofrece.
7. **Dos compuertas que el servidor no impone.** Se verificó contra el backend que ni `CreateMealCommandHandler` ni `CreateSymptomCommandHandler` exigen un perfil clínico, y que un IBS-SSS periódico enviado antes de `nextAssessmentDate` **se acepta**, incrementa el ciclo y reagenda: no existe ninguna excepción de ventana en el dominio. Las dos restricciones se implementan igual, en el cliente, y quedan declaradas como decisiones de producto.

Justificación. El menú inferior no era una corrección cosmética para que calzara el enunciado de un Caso de Prueba: era la capa que faltaba para que EP0002 fuera usable, y el bloque que la construyera tenía que construirla igual. `StatefulShellRoute.indexedStack` es la forma idiomática en go_router 14 y la única que preserva el estado por rama, que es lo que evita que el Diario se recargue entero cada vez que el paciente pasa por Perfil. No tocar `CauceScaffold` mantiene intacto un átomo transversal que ya usan todas las pantallas, y evita duplicar la barra en cada raíz.

Los formularios van sobre el navigator raíz porque es lo que muestra el app bar del design system, con flecha de retroceso y título, y porque dejar las pestañas a la vista invitaría a cambiar de sección a mitad de un registro sin enviar. Privacidad no es un formulario sino una subpantalla de ajustes, y conservar la barra ahí deja al paciente saltar a otra pestaña y volver donde estaba.

Sobre el punto 7: la compuerta del diario tiene fundamento en HU0003 CA01, que dice que guardar el perfil clínico "habilita el acceso al diario", y CP011 paso 6 nombra las recomendaciones como funcionalidad restringida. La del cuestionario tiene fundamento clínico: el IBS-SSS mide sobre catorce días y responderlo antes ensucia la serie, que es la medida primaria del estudio. Las dos se declaran de forma explícita porque el servidor aceptaría igual lo que el móvil frena, y una restricción que solo vive en el cliente es exactamente el tipo de regla que se pierde en la próxima refactorización si no está escrita.

Consecuencias.

- `resolveRedirect` **no cambió**. Es una función pura sobre el string de la ruta, y un shell no cambia los paths: `session_guard_test.dart` siguió en verde sin editar una línea, lo que sirve de evidencia.
- Ninguna restricción queda muda. Una pestaña restringida explica por qué y ofrece el botón para completar el onboarding; una acción del FAB que no aplica conserva su lugar con su explicación, y cuando la salida es completar el onboarding, tocarla lleva ahí. El único caso realmente deshabilitado es el cuestionario sin vencer, que muestra la fecha en que estará disponible.
- El FAB central sobresale sobre el cuerpo de la pestaña y **tapaba** la fila de cerrar sesión de Perfil, que quedaba intocable. El shell reserva ese espacio para que ninguna pantalla futura lo repita.
- Queda **pedido al backend**, fuera del alcance de este bloque, que rechace un IBS-SSS periódico enviado antes de tiempo con la tolerancia que defina el protocolo del piloto. El IBS-SSS es la medida primaria del estudio y el servidor debería proteger la serie.
- Queda anotada como deuda una tabla local para los platos personalizados. Hoy se sostienen en memoria durante la sesión con un provider `keepAlive`, y sin conexión la sección avisa en vez de desaparecer. Con el esquema v2 recién estrenado no correspondía sumar una migración por esto.
- Dos reglas nuevas y permanentes entran al CLAUDE.md como R10 y R11: toda ruta nueva tiene un punto de entrada cubierto por un test que llega a ella tocando desde la raíz, y toda pantalla se construye contra la sección del design system que le corresponde y su mockup si existe.

Alternativas consideradas. Sumarle un `bottomNavigationBar` opcional a `CauceScaffold` y que cada raíz lo pase, descartado porque pierde la preservación de estado por rama, duplica la barra en cuatro pantallas y amplía un átomo compartido de `core/widgets/` sin necesidad. Dejar la navegación inferior para Mobile-4 junto con EP0005 y EP0006, descartado porque habría dejado EP0002 cerrado sobre el papel y sin usar durante otro bloque entero. Deshabilitar las pestañas restringidas en la barra, descartado por la regla de que nada se deshabilita sin explicar: un botón apagado en la barra no tiene dónde decir por qué.

DECISIONS-BLOCK-MOBILE-3.2
Actas M39 y M40. Decisiones vinculantes del bloque Mobile-3.2 (correcciones de la verificación en dispositivo).
Fecha del bloque: 2026-09-21.
Autores: Trigo (decisión), Kiwicha (redacción del prompt de bloque), Quinua (redacción del acta).
Estado global: aprobadas.

Acta M39: Todo servicio de fondo tiene quien lo encienda y quien lo apague

Contexto. La primera prueba de la aplicación en un celular real encontró que una comida registrada sin conexión seguía diciendo "Pendiente de sincronizar" después de recuperar la señal, y que no subía nunca. La causa, verificada con `grep` sobre todo `lib/`: **`syncWorkerProvider` no tenía un solo lector**. El objeto nunca se creaba, de modo que nadie se suscribía a las reconexiones. El mismo inventario encontró que `foodCatalogRefresherProvider` tampoco tenía lectores, y por eso `food_catalog_cache` estaba vacía en el dispositivo: la búsqueda local del acta M35 no tenía contra qué buscar, y sin conexión el buscador no devolvía nada.

Es la tercera vez que aparece el mismo patrón en el proyecto. Mobile-3.1 ya había encontrado cuatro pantallas de EP0002 registradas en el router y sin ninguna vía desde la interfaz, y un plato personalizado que se podía crear y nunca usar. Las tres veces: construido, testeado en aislamiento, nunca conectado.

**Los 842 tests no lo veían, y el motivo importa.** Los 17 tests de `SyncWorker` lo instancian a mano y le disparan la reconexión ellos mismos. Prueban que el worker hace bien su trabajo; ninguno pregunta quién lo enciende en la aplicación de verdad. Un test de unidad sobre un servicio nunca puede responder esa pregunta, por bueno que sea.

Decisión.

1. Se crea `BackgroundServices` en `lib/core/services/`, que agrupa los servicios sin pantalla: el worker de sincronización y el refresco del catálogo. Expone `start()` y `stop()`, los dos idempotentes.
2. `sessionBackgroundServicesProvider` ata su ciclo de vida al de la sesión: arranca con `SessionAuthenticated`, se detiene con `SessionUnauthenticated` y con `SessionPendingEmailVerification`, y **no toca nada** con `SessionUnknown`, que es el estado del arranque mientras se lee el Keystore.
3. **`CauceApp` lo lee.** Es la línea que faltaba, y lleva su propio comentario diciendo que no se borra sin leer esta acta.
4. `start()` además corre la sincronización una vez, sin esperar una reconexión: la aplicación pudo cerrarse con filas pendientes y arrancar con señal, en cuyo caso el evento nunca llega.
5. El catálogo se refresca al abrir sesión y en cada reconexión, que es lo que pide el acta M35.
6. `SyncWorker` expone un `Stream<SyncRunReport> completions`. `BackgroundServices` lo escucha y recarga el Diario cuando una corrida deja filas resueltas, de modo que una fila que sube sola deja de decir "pendiente" sin que el paciente tire de la lista.
7. **Regla R12 en el CLAUDE.md:** todo servicio de fondo tiene quien lo encienda y quien lo apague, cubierto por un test que arranca la composición real de la aplicación. Cada plan declara, por cada servicio nuevo, quién lo arranca.

Justificación. La sesión es la frontera natural: fuera de ella no hay cola que subir ni catálogo que traer, y un worker escuchando con el paciente deslogueado solo puede hacer daño. Agrupar los dos servicios en una pieza con nombre evita que el próximo servicio se sume como una línea suelta en `app.dart` que nadie vuelva a mirar.

La regla R12 es la lección del patrón, no de este caso. R10 ya exigía que toda ruta nueva tuviera un punto de entrada; resulta que quedaba corta, porque un servicio de fondo no tiene ruta y se escapaba por el hueco.

Consecuencias.

- `test/integration/background_services_test.dart` monta `CauceApp` entero con los providers de producción y falsea solo los bordes: transporte HTTP, conectividad, Keystore y archivo de la base. Verifica que, tras restaurar la sesión, una comida pendiente sube al volver la conexión. **Se comprobó que sirve**: al comentar el `ref.watch` de `app.dart`, tres de sus cuatro casos se ponen rojos.
- Montar `CauceApp` en un test pasa a exigir esos cuatro bordes. Se agrupan en `test/helpers/app_borders.dart` para que ningún archivo los arme a mano.
- `SyncWorker.dispose()` reemplaza a `stop()` en el `onDispose` del provider, porque ahora hay un `StreamController` que cerrar.

Alternativas consideradas. (a) Arrancar los servicios desde `main()`, descartado porque `main()` no conoce el estado de sesión y habría que apagarlos desde otro lado, partiendo el ciclo de vida en dos lugares. (b) Que `SplashScreen` los encienda al resolver el bootstrap, descartado porque el splash se desmonta y deja al servicio sin dueño, y porque un `logout` posterior no tendría cómo apagarlo. (c) Que cada pantalla arranque lo que necesita, descartado porque es justamente lo que produce servicios sin dueño: el Diario encendería el worker y la home lo apagaría al reconstruirse.

Acta M40: Escala de intensidad en tramos de diez, y cantidades con default y tope por unidad

Contexto. Dos hallazgos de la misma sesión en el celular, los dos sobre el mismo formulario.

El primero, sobre la intensidad del síntoma: la barra va de 1 a 100 de uno en uno, y el paciente que la probó dijo textualmente "no sé cómo diferenciar 64 de intensidad y 63". Es auto-reporte de una molestia, no una medición: cien valores fingen una precisión que nadie tiene, y el propio design system solo muestra el ejemplo "Intensidad 60", un número redondo.

El segundo, sobre las unidades: la cantidad arrancaba en 100 gramos, y al cambiar la unidad el número se arrastraba. El formulario ofrecía **100 tazas de brócoli** sin una sola advertencia. `MealItemRequestValidator` del backend solo exige mayor que cero, así que el servidor lo habría aceptado.

Decisión.

1. `CauceSlider` recibe `step`, con default 1. El formulario de síntoma lo instancia con `min: 10`, `max: 100` y `step: 10`: diez valores, con las anclas "Leve" y "Muy intenso" que ya existían.
2. **El IBS-SSS no se toca.** Sigue con `step: 1`, que es el default.
3. El dominio conserva `minIntensity = 1` y `maxIntensity = 100`. Lo que cambia es lo que la pantalla **ofrece**, que es un subconjunto de lo que el backend acepta.
4. Cada `MeasurementUnitOption` declara su `defaultQuantity` y su `maxQuantity`. Al cambiar de unidad, la cantidad se reinicia al default de la nueva.
5. Los valores: gramos 100 y tope 3000; onzas 4 y tope 100; tazas 1 y tope 10; unidades 1 y tope 50; cucharadas 2 y tope 30.
6. Se declara además el registro de color del badge de intensidad, que el design system no publica: tramos de la escala 1 a 100 en tercios, con **gris** de 1 a 33, ámbar de 34 a 66 y rojo de 67 a 100.

Justificación. Sobre la escala: el instrumento IBS-SSS es un cuestionario validado de escala continua y agruparlo en tramos alteraría el puntaje, mientras que la intensidad de un síntoma es una apreciación del paciente en el momento. Son dos cosas distintas aunque usen el mismo control, y por eso el parámetro va en el átomo y no una escala fija para los dos.

Sobre las unidades: el backend no valida el rango porque no puede saber qué es plausible para cada unidad sin conocer el alimento. Es una guarda del cliente contra el error de tipeo, con margen holgado para no estorbar a nadie: tres kilos de un alimento en una comida es absurdo, pero 2999 gramos pasa.

Sobre el color: el tramo bajo va en **gris y no en verde** a propósito. Verde felicitaría al paciente por un día de poco dolor, que es un juicio clínico que la aplicación no está en condiciones de hacer y que contradice el encuadre neutro con el que se dibujó la evolución del IBS-SSS. Gris registra el dato sin opinar. Ámbar y rojo sí escalan, porque escalan sobre lo que el propio paciente reportó. La carga FODMAP, en cambio, sí usa verde: ahí el color califica al alimento, no a la persona.

Consecuencias. Un valor de intensidad anterior a este bloque, o llegado por sincronización, sigue siendo válido aunque no caiga en la nueva grilla: el dominio no cambió. La pantalla de cantidad muestra el tope en su mensaje de error, de modo que el rechazo dice cuál es el límite en vez de solo negar.

Alternativas consideradas. (a) Etiquetas en vez de números para la intensidad ("leve", "moderado", "intenso"), descartada porque el backend guarda un entero y la conversión quedaría escrita en el cliente, con el mismo problema que el MCID re-derivado. (b) Tramos de cinco en vez de diez, descartada por no resolver el problema: nadie distingue 60 de 65 tampoco. (c) Para las unidades, validar contra la composición del alimento, descartada porque el catálogo no publica densidades y habría que inventarlas.
