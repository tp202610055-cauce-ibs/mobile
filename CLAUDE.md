CLAUDE.md · Cauce Mobile
Documento operativo para Claude cuando trabaja sobre este repositorio. Fuente de verdad de arquitectura, convenciones y coordinación con el backend Cauce.
Versión: 1.0.0
Última actualización: 2026-07-10
Repositorio: github.com/TP202610055-cauce-health/mobile (polyrepo)
1. Overview del producto
Cauce Mobile es la aplicación Flutter para pacientes participantes del piloto clínico en el Complejo Hospitalario Guillermo Kaelín de la Fuente (EsSalud Lima Sur). El paciente registra comidas y síntomas, recibe recomendaciones dietéticas validadas por su nutricionista, y responde cuestionarios IBS-SSS periódicos. El diseño es offline-first porque los pacientes usan la app durante y fuera de consulta, incluso sin conectividad estable.
El backend Cauce API es el sistema autoritativo. Este cliente es un consumidor tipado del contrato OpenAPI publicado por el backend. Nunca debe inventar endpoints, campos o enums.
2. Roles operativos
Este repositorio es manipulado por tres roles con responsabilidades distintas:
Trigo (Flavio Trigueros) es el responsable de producto y arquitectura. Toma decisiones vinculantes. Autoriza cada plan antes de que Claude Quinua ejecute.
Claude Kiwicha opera en la interfaz web de chat de Claude. Rol: arquitectura, redacción de prompts, revisión crítica, actas de decisión. Autor de este documento.
Claude Quinua opera dentro de VS Code vía Claude Code. Rol: implementación con plan mode obligatorio. Nunca aplica fixes sin luz verde explícita de Trigo o Kiwicha, incluso si el fix parece obvio y seguro. Reporta y espera.
Cualquier mensaje que se refiera a "el otro Claude" o "el chat" apunta a Kiwicha. Cualquier referencia a "Claude Code" o "el IDE" apunta a Quinua.
3. Stack tecnológico confirmado
Framework: Flutter 3.24+ stable, Dart null-safety.
Plataformas: Android (API 26+) e iOS (13+) desde Mobile-1.
State management: flutter_riverpod 2.5+ con riverpod_generator.
HTTP client: dio 5.7+ con interceptors JWT.
Cliente API tipado: openapi_generator con dart-dio (consume backend/docs/api/openapi-v1.0.0.json).
Auth: flutter_appauth 8.0+ (Authorization Code + PKCE contra Keycloak directo, sin passthrough).
Almacenamiento seguro: flutter_secure_storage 9.2+ para tokens JWT.
Persistencia local: drift 2.20+ sobre sqflite. Todas las tablas offline-critical llevan client_guid y sync_status.
Modelos inmutables: freezed + json_serializable.
Routing: go_router 14+.
Localización: flutter_localizations + intl con arb files. Default es_PE, fallback es.
Charts: fl_chart 0.69+ (para IBS-SSS en Mobile-4 en adelante).
Push: firebase_messaging (integración recién en Mobile-4).
Utilitarios: uuid, flutter_dotenv, connectivity_plus, path_provider.
Testing: flutter_test, mocktail, integration_test.
4. Estructura de carpetas
Feature-first con capas por feature. Core transversal aparte.
mobile/
├── .github/workflows/       # CI (flutter analyze + flutter test)
├── android/                 # Config Android generada por flutter create
├── ios/                     # Config iOS generada por flutter create
├── lib/
│   ├── core/                # Cross-cutting concerns
│   │   ├── config/          # Env, base URLs, constants
│   │   ├── theme/           # ThemeData, tokens, tipografía
│   │   ├── network/         # Dio setup, interceptors, ApiClient
│   │   ├── auth/            # AppAuth wrapper, secure storage, token store
│   │   ├── routing/         # go_router config
│   │   ├── errors/          # Excepciones y mapeo RFC 7807
│   │   ├── storage/         # Drift database, DAOs base
│   │   └── utils/           # Helpers, extensions, formatters
│   ├── features/            # Un folder por feature
│   │   ├── splash/
│   │   ├── auth/
│   │   │   ├── data/        # Repository impl, DTOs, data sources
│   │   │   ├── domain/      # Entities, repository interfaces, use cases
│   │   │   └── presentation/# Widgets, screens, Riverpod providers
│   │   └── shared/          # Widgets reutilizables entre features
│   ├── l10n/                # Archivos arb generados
│   ├── app.dart             # MaterialApp con theme + router
│   └── main.dart            # Entry point
├── test/
│   ├── unit/                # Espeja lib/ (features/<f>/, core/<c>/)
│   ├── widget/              # Widget tests por feature
│   └── integration/         # Flujos end to end
├── openapi/
│   └── openapi-v1.0.0.json  # Copia del contrato del backend
├── docs/
│   └── decisions/           # Actas M1, M2, ...
├── analysis_options.yaml    # flutter_lints estricto
├── build.yaml               # Config para build_runner
├── pubspec.yaml
├── CLAUDE.md                # Este archivo
├── CONVENTIONS.md
└── DECISIONS-BLOCK-MOBILE-1.md
Correspondencia con Clean Architecture del backend:
Backend .NETMobile FlutterCauce.Domainfeatures/<f>/domain/Cauce.Applicationfeatures/<f>/domain/use_cases/ + Riverpod providers en presentation/Cauce.Infrastructurefeatures/<f>/data/ + core/network/ + core/storage/ + core/auth/Cauce.Api (controllers)features/<f>/presentation/screens/ + core/routing/
5. Setup del entorno de desarrollo local
Prerequisitos verificados

Flutter 3.24+ stable en C:\fsrc\flutter\ con flutter doctor sin issues.
Android Studio con SDK API 36.1.0, cmdline-tools, licencias aceptadas.
VS Code con extensiones Dart-Code, Flutter, Claude Code.
Backend Cauce corriendo local en http://localhost:5074 con Docker Compose de infraestructura arriba (Postgres, Keycloak, KeyDB, MinIO).

Levantar el mobile localmente
powershellcd C:\Users\ACER\Documents\github_flavio_trigueros\academicos\proyecto_final\mobile

# Instalar dependencies
flutter pub get

# Generar código (freezed, riverpod, drift, openapi)
dart run build_runner build --delete-conflicting-outputs

# Correr en emulator Android
flutter run
Variables de entorno
El archivo .env en la raíz del mobile define los endpoints. Nunca commitear. Ejemplo:
API_BASE_URL_ANDROID=http://10.0.2.2:5074/api/v1
API_BASE_URL_IOS=http://localhost:5074/api/v1
KEYCLOAK_ISSUER_ANDROID=http://10.0.2.2:8081/realms/cauce
KEYCLOAK_ISSUER_IOS=http://localhost:8081/realms/cauce
KEYCLOAK_CLIENT_ID=cauce-mobile
REDIRECT_SCHEME=cauce
El template va en .env.example sí commiteado.
6. Coordinación con el backend Cauce
Sección crítica. Leer y respetar antes de tocar cualquier código que interactúe con la API.
El backend Cauce está cerrado en tag v0.6.2-dev-seed. Los siguientes recursos son fuente de verdad y viven en el repositorio backend:
RecursoRutaUsoOverview backendbackend/CLAUDE.mdLectura obligatoria antes de tocar auth, sync, errores.Contrato OpenAPIbackend/docs/api/openapi-v1.0.0.jsonFuente para generar el cliente dio con openapi_generator.Endpoints humanosbackend/ENDPOINTS.mdReferencia rápida de rutas, métodos, códigos.
Reglas de comunicación con la API
Base URLs por plataforma:

Android emulator: http://10.0.2.2:5074/api/v1/
iOS simulator: http://localhost:5074/api/v1/

Keycloak OIDC (para flutter_appauth):

Android: http://10.0.2.2:8081/realms/cauce/
iOS: http://localhost:8081/realms/cauce/
Cliente: cauce-mobile (público con Direct Access Grants ON).
Redirect scheme: cauce://login-callback.
Scopes: openid, profile, email.

Auth JWT:

Access token vida útil 15 min. Refresh 30 días en móvil.
Authorization: Bearer {jwt} en todo endpoint protegido.
Claims verificados en runtime: aud incluye cauce-backend, sub es el keycloak_id, realm_access.roles incluye patient para pacientes.
Almacenamiento SOLO en flutter_secure_storage. Nunca en SharedPreferences, nunca en variables globales sin cifrar.

Idempotencia:

Header Idempotency-Key: {uuid} en todo POST de creación (meals, symptoms, sync/batch, recommendations/*).
El UUID v4 se genera en el dispositivo. Reintentos usan el mismo UUID.
El backend deduplica por client_guid.

Enums en JSON: siempre PascalCase, nunca snake_case. Ejemplos válidos: "PendingReview", "AbdominalPain", "IbsD". Deserialización con @JsonEnum(fieldRename: FieldRename.pascal) de json_serializable.
Errores RFC 7807: el backend responde application/problem+json con errorCode semántico estable. El cliente hace switch sobre errorCode, nunca sobre mensajes. Ejemplos: duplicate_email, unconfirmed_allergens, active_pilot_retention, invalid_credentials, account_locked.
Rate limits: auth-register 5/h por IP, auth-login 10/min por IP, auth-pwreset 3/h por IP, default-auth 60/min por usuario, sync 120/min por usuario. En Development el toggle RateLimiting:Enabled = false está activo. El mobile debe implementar backoff en 429 igual porque el piloto y prod lo tienen encendido.
Sync offline batch: POST /api/v1/sync/batch acepta arrays de operaciones con client_guid únicos. Backend deduplica.
CORS: solo aplica a browsers. El mobile Flutter es cliente nativo, no le pega CORS. No necesita configuración adicional.
Paciente demo para desarrollo local
Credenciales seeded en cada arranque del backend local:

Email: paciente.demo@cauce.local
Password: Paciente.Demo2026!
keycloak_id (sub): b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd
user_id interno: 79974080-cfbb-4ce8-b003-4e80e7e9e84f
Perfil: IbsD, 36 años, Female, BMI 23.81, sin alergias, IsInActivePilot=true.
Historial: 5 meals seeded, 3 síntomas, IBS-SSS baseline 220 Moderate.

Este usuario es exclusivo para desarrollo. Nunca hardcodear en producción.
7. Reglas críticas de trabajo
Plan mode obligatorio para Quinua: antes de crear archivos, modificar dependencies, correr scripts o hacer commits, Quinua presenta el plan y espera aprobación explícita.
Reportar y esperar: si Quinua encuentra un bug, gap o supuesto no cubierto por el prompt, reporta el hallazgo con contexto y opciones. NO aplica fix por su cuenta. Esta regla se estableció formalmente el 2026-07-09 tras un incidente con el user-secret de KeyDB.
Commits granulares: Conventional Commits en inglés con scope claro. Ejemplos:

chore(scaffold): reset to clean flutter create baseline
feat(auth): add flutter_appauth wrapper with keycloak discovery
test(auth): add unit tests for token storage

Trigo commitea con GitHub Desktop. Quinua nunca ejecuta git push ni operaciones destructivas de git sin pedirlo explícito y recibir OK.
Sin secretos en el repo: .env en .gitignore. Nunca commitear API keys, tokens, credenciales, keycloak client secrets.
Idioma: todos los strings de UI van al sistema de l10n en es_PE. Cero strings hardcodeados en widgets.
Sin em dashes en documentación o mensajes. Frases prohibidas de estilo: "Asimismo", "No obstante", "Cabe destacar", "En consecuencia", "Es importante mencionar". Preferir listas y tablas sobre prosa densa.
8. Referencias

Design System: 00-design-system.html (fuente visual de verdad, en el repositorio raíz de docs)
Product Backlog: Product_Backlog_v_050726.pdf (US y CAs vigentes)
Diagramas C4: diagramas_c4_v_2.dsl (arquitectura del sistema)
Diagrama lógico: diagrama_logico.drawio
ERD: diagrama_erd_total.dbml
TI (documento maestro de tesis): TI_TP1_V_210626.docx