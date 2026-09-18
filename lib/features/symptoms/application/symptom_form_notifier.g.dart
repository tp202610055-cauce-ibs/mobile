// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$symptomFormNotifierHash() =>
    r'7ec71b5a937f93affbe4ecbb9c8edf528fcb8d04';

/// Gobierna el armado y el envio de un sintoma.
///
/// Mismo patron que el registro de comidas: con conexion o sin ella el sintoma
/// se guarda siempre en el dispositivo, y con red se manda ademas al servidor.
///
/// Copied from [SymptomFormNotifier].
@ProviderFor(SymptomFormNotifier)
final symptomFormNotifierProvider =
    AutoDisposeNotifierProvider<SymptomFormNotifier, SymptomFormState>.internal(
  SymptomFormNotifier.new,
  name: r'symptomFormNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$symptomFormNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SymptomFormNotifier = AutoDisposeNotifier<SymptomFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
