// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periodic_assessment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
