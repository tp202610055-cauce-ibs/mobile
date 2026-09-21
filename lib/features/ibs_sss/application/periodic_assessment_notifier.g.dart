// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periodic_assessment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ibsSssEvolutionHash() => r'08363795f87604f16bebd3369deeff54c2c2e7db';

/// Serie de evolucion del paciente, de la linea base en adelante.
///
/// La consume la tarjeta de Inicio para mostrar el cambio contra la linea
/// base. No es un endpoint nuevo: `GET /ibs-sss/evolution` ya se consumia
/// desde el cuestionario periodico (US12 CA03). El grafico grande con eje
/// temporal llega en Mobile-4 con HU0023.
///
/// Copied from [ibsSssEvolution].
@ProviderFor(ibsSssEvolution)
final ibsSssEvolutionProvider =
    AutoDisposeFutureProvider<List<IbsSssEvolutionPoint>>.internal(
  ibsSssEvolution,
  name: r'ibsSssEvolutionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ibsSssEvolutionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IbsSssEvolutionRef
    = AutoDisposeFutureProviderRef<List<IbsSssEvolutionPoint>>;
String _$latestIbsSssAssessmentHash() =>
    r'1f51c19f644f8f5dcd533e0736ae79f13c55522d';

/// Evaluacion IBS-SSS mas reciente del paciente.
///
/// Alimenta el aviso de la home: su `nextAssessmentDate` dice cuando vence el
/// ciclo de catorce dias que agenda el backend.
///
/// Copied from [latestIbsSssAssessment].
@ProviderFor(latestIbsSssAssessment)
final latestIbsSssAssessmentProvider =
    AutoDisposeFutureProvider<IbsSssAssessmentSummaryData?>.internal(
  latestIbsSssAssessment,
  name: r'latestIbsSssAssessmentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestIbsSssAssessmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestIbsSssAssessmentRef
    = AutoDisposeFutureProviderRef<IbsSssAssessmentSummaryData?>;
String _$periodicAssessmentNotifierHash() =>
    r'f3cf5e2644e496daee28f2bb0fc93aa011608a08';

/// Gobierna las respuestas y el envio de una evaluacion periodica.
///
/// **CA04 no necesita logica nueva.** El cliente nunca calcula el puntaje: manda
/// las cinco dimensiones y recibe `totalScore` y la categoria ya resueltos por
/// el servidor. No exponerlo antes del envio no es una regla de pantalla que
/// haya que respetar, es la forma en que esta construido el flujo entero: el
/// numero no existe de este lado hasta que el servidor lo devuelve.
///
/// Copied from [PeriodicAssessmentNotifier].
@ProviderFor(PeriodicAssessmentNotifier)
final periodicAssessmentNotifierProvider = AutoDisposeNotifierProvider<
    PeriodicAssessmentNotifier, PeriodicAssessmentState>.internal(
  PeriodicAssessmentNotifier.new,
  name: r'periodicAssessmentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$periodicAssessmentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PeriodicAssessmentNotifier
    = AutoDisposeNotifier<PeriodicAssessmentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
