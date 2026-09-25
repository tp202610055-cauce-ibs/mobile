// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendations_feed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recommendationsClockHash() =>
    r'ef863475a36b602ee850405913d09882408e36e3';

/// Reloj de la feature, sobreescribible en los tests.
///
/// El vencimiento del marcador se compara contra la hora actual, y un test
/// que dependiera del reloj real se volveria inestable cerca de un borde.
///
/// Copied from [recommendationsClock].
@ProviderFor(recommendationsClock)
final recommendationsClockProvider = Provider<DateTime Function()>.internal(
  recommendationsClock,
  name: r'recommendationsClockProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendationsClockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecommendationsClockRef = ProviderRef<DateTime Function()>;
String _$pendingRecommendationRequestHash() =>
    r'9675fe49b5fd9c904e5c34904c59e7adb5e677f4';

/// Recomendacion propia en revision, para el aviso de Inicio (decision 1).
///
/// Lee el marcador local y no depende de la red: sin conexion el aviso sigue
/// en pie. Observa la lista para retirarlo en cuanto la recomendacion aparece
/// aprobada, sin esperar a que alguien borre el marcador.
///
/// Copied from [pendingRecommendationRequest].
@ProviderFor(pendingRecommendationRequest)
final pendingRecommendationRequestProvider =
    FutureProvider<PendingRecommendationRequest?>.internal(
  pendingRecommendationRequest,
  name: r'pendingRecommendationRequestProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingRecommendationRequestHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingRecommendationRequestRef
    = FutureProviderRef<PendingRecommendationRequest?>;
String _$recommendationsFeedNotifierHash() =>
    r'b43fab681dc4b18d4ef3a8f7a05182477bc4c546';

/// Listado de Consejos y disparo silencioso de la generacion (decision 2).
///
/// `keepAlive` porque lo leen dos pestanas, Inicio y Consejos, y cada una lo
/// pediria de nuevo al cambiar entre ellas. Observa al paciente de la sesion:
/// otra cuenta en el mismo dispositivo nunca ve la lista de la anterior.
///
/// **Solo la pestana de Consejos genera.** Inicio lee el mismo estado pero no
/// llama a [openAdviceTab]: el paciente "recibe" la recomendacion al entrar a
/// Consejos, no al abrir la app.
///
/// Copied from [RecommendationsFeedNotifier].
@ProviderFor(RecommendationsFeedNotifier)
final recommendationsFeedNotifierProvider = AsyncNotifierProvider<
    RecommendationsFeedNotifier, RecommendationsFeed>.internal(
  RecommendationsFeedNotifier.new,
  name: r'recommendationsFeedNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendationsFeedNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecommendationsFeedNotifier = AsyncNotifier<RecommendationsFeed>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
