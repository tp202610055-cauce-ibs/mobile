CONVENTIONS.md · Cauce Mobile
Convenciones vinculantes de código, arquitectura, testing y colaboración para Cauce Mobile.
Versión: 1.0.0
Última actualización: 2026-07-10
1. Convenciones de código Dart
Formato: dart format con línea máxima de 100 caracteres. Ejecutar antes de commit.
Análisis: analysis_options.yaml extiende flutter_lints/flutter.yaml con reglas estrictas adicionales. Ninguna warning tolerada.
Null safety: siempre. Prohibido usar ! en producción salvo casos justificados con comentario. Preferir if (x != null) o el operador ?..
Naming
ElementoConvenciónEjemploClases, enums, mixins, typedefsUpperCamelCasePatientProfile, MealStatusMétodos, variables, parámetros, camposlowerCamelCasecreateMeal, patientIdConstantes top-level y estáticaslowerCamelCaseapiBaseUrl, defaultTimeoutArchivos, directoriossnake_casepatient_profile.dart, meal_repository.dartPackage namessnake_caseflutter_riverpodEnums (valores)lowerCamelCaseMealStatus.pendingSync
Imports
Orden obligatorio, separados por línea en blanco:
dart// 1. Dart core
import 'dart:async';
import 'dart:convert';

// 2. Flutter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 3. Package third-party
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 4. Package interno del proyecto
import 'package:cauce_mobile/core/network/api_client.dart';
import 'package:cauce_mobile/features/auth/domain/entities/user.dart';

// 5. Relativos (solo dentro del mismo feature)
import '../domain/repositories/auth_repository.dart';
Preferir imports por package sobre imports relativos, salvo dentro del mismo directorio inmediato de feature.
2. Arquitectura por feature
Cada feature en lib/features/<nombre>/ sigue el patrón data / domain / presentation.
Domain (más interno)

entities/: modelos de dominio inmutables construidos con freezed. No dependen de nada externo.
repositories/: interfaces abstractas. Contrato sin implementación.
use_cases/: una clase por caso de uso. Método call() que retorna Future<T> o Stream<T>. Recibe dependencias por constructor.

Data

data_sources/: implementa acceso a orígenes concretos. Suele haber uno remoto (dio + OpenAPI client) y uno local (drift DAO).
dtos/: modelos con anotaciones json_serializable. Nunca escapan de la capa data.
repositories/: implementación de las interfaces del domain. Orquesta data sources, maneja cache, mapea DTOs a entities.
mappers/: funciones puras que convierten DTO a Entity y viceversa. Aisladas y testeables.

Presentation

providers/: providers de Riverpod que exponen estado y casos de uso.
screens/: widgets de pantalla completa que consumen providers.
widgets/: widgets reutilizables dentro de la feature.
controllers/: notifiers de Riverpod para estado complejo con lógica.

Reglas de dependencia
Domain no depende de nada.
Data depende de Domain.
Presentation depende de Domain.
Presentation NO depende de Data. El acoplamiento se hace vía Riverpod inyectando la implementación en el provider.
3. State management con Riverpod
Usar codegen siempre. Nada de Provider, StateProvider, FutureProvider legacy. Sí @riverpod con riverpod_generator.
Ejemplo canónico:
dart@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthState> build() async {
    final tokenStore = ref.watch(tokenStoreProvider);
    final hasSession = await tokenStore.hasValidSession();
    return hasSession ? const AuthState.authenticated() : const AuthState.unauthenticated();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(loginUseCaseProvider);
      await useCase(email: email, password: password);
      return const AuthState.authenticated();
    });
  }
}
Reglas de Riverpod:

ref.watch() para dependencias reactivas.
ref.read() para acciones puntuales (dentro de métodos).
Nunca ref.read() en el build().
AsyncValue para todo estado que dependa de IO.
keepAlive: true solo cuando esté justificado. Default es autoDispose.

4. Async patterns

Future<T> para operaciones únicas.
Stream<T> solo cuando el consumidor necesita varios valores en el tiempo.
Nunca .then() encadenado. Usar async / await.
Nunca .catchError() suelto. Usar try / catch explícito.
Cancelación de operaciones: usar CancelToken de dio cuando el usuario abandona la pantalla.

5. Error handling
Excepciones tipadas por dominio:
dartsealed class AuthException implements Exception {
  const AuthException();
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException();
}

class AccountLockedException extends AuthException {
  final DateTime lockedUntil;
  const AccountLockedException(this.lockedUntil);
}
Mapeo desde RFC 7807: el interceptor de dio parsea application/problem+json y lanza la excepción tipada correspondiente según errorCode.
Reglas:

Nunca capturar Exception genérico salvo en el borde de UI.
Los use cases lanzan excepciones de dominio.
Los widgets usan AsyncValue.when(error: ...) para renderizar.
Los mensajes al usuario vienen de l10n, mapeados desde el tipo de excepción.

6. Localization
Todo string visible al usuario va a lib/l10n/app_es.arb. Cero excepciones. Cero strings literales en widgets.
Ejemplo:
arb{
  "loginTitle": "Ingresa a tu cuenta",
  "loginEmailLabel": "Correo electrónico",
  "loginPasswordLabel": "Contraseña",
  "loginSubmitButton": "Ingresar",
  "loginErrorInvalidCredentials": "Correo o contraseña incorrectos"
}
Uso:
dartText(AppLocalizations.of(context)!.loginTitle)
Regla dura: si en code review aparece un Text('cualquier cosa') con string literal, se rechaza. Solo excepción: strings puramente técnicos que nunca se muestran (logs internos).
7. Widget conventions

const siempre que sea posible. Widgets sin estado ni dependencias reactivas van con constructor const.
Key explícita en listas y widgets reordenables.
Widgets privados (_MyWidget) para descomposición dentro del mismo archivo cuando no se reutilizan.
Widgets reutilizables en features/<f>/presentation/widgets/ o en features/shared/widgets/ si son cross-feature.
Sin lógica de negocio en widgets. La lógica va en providers o use cases.
Sin setState en widgets nuevos. Usar Riverpod.
Máximo 200 líneas por widget file. Si crece más, descomponer.

8. Testing conventions
Estructura de tests:
test/
├── unit/
│   ├── core/
│   │   └── network/
│   │       └── api_client_test.dart
│   └── features/
│       └── auth/
│           ├── data/
│           │   └── repositories/
│           │       └── auth_repository_impl_test.dart
│           └── domain/
│               └── use_cases/
│                   └── login_use_case_test.dart
├── widget/
│   └── features/
│       └── auth/
│           └── screens/
│               └── login_screen_test.dart
└── integration/
    └── auth_flow_test.dart
Naming de tests: descripcionCorta_condicion_resultado. Ejemplos:

login_withValidCredentials_returnsAuthenticatedState
login_withLockedAccount_throwsAccountLockedException

Mocking: mocktail. Nunca mockito.
Cobertura mínima por PR: los archivos nuevos deben tener test correspondiente. No hay umbral cuantitativo pero sí regla cualitativa: cada use case debe tener test unitario, cada screen debe tener widget test, cada happy path crítico debe tener integration test.
9. Conventional Commits
En inglés. Scopes por feature o por área.
Tipos permitidos:
TipoUsofeatFeature nuevafixBug fixchoreTareas de mantenimiento sin cambio funcionaldocsSolo documentacióntestSolo testsrefactorRefactor sin cambio funcional ni test nuevostyleSolo formato (dart format, no dart fix)perfOptimizaciónciCambios en workflowsbuildCambios en pubspec o build
Scopes esperados: auth, onboarding, clinical-log, recommendations, profile, core, theme, network, storage, routing, l10n, ci, scaffold, deps.
Ejemplos válidos:
chore(scaffold): reset to clean flutter create baseline
feat(auth): add flutter_appauth wrapper with keycloak discovery
fix(network): handle 429 with exponential backoff
test(auth): add unit tests for token storage
docs(root): update CLAUDE.md with backend v0.6.2 references
10. Estrategia de branches
Trunk-based con feature branches cortas.

develop: línea principal. Base de todas las features. Recibe merges vía PR con self-review.
feature/mobile-<N>-<slug>: rama por sub-prompt Mobile-N. Ejemplos: feature/mobile-1-identity, feature/mobile-2-onboarding.
fix/<slug>: hotfixes específicos.
archive/*: snapshots inmutables de estados previos. No se tocan.

Ninguna rama vive más de 10 días. Si la feature crece, se parte.
11. Historial de versiones
VersiónFechaCambios1.0.02026-07-10Versión inicial post-nuke