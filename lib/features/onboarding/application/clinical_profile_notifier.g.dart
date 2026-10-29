// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clinicalProfileNotifierHash() =>
    r'e1c4c7af9cd8f7c606285015c7de580360745c6f';

/// Gobierna el envio del perfil clinico y sus alergias.
///
/// El paso 1 no es una peticion sino una secuencia: primero el perfil y
/// despues una declaracion por alergia marcada, porque el contrato no expone
/// un endpoint de lote para alergias. El orden es obligatorio en el sentido de
/// que el perfil tiene que existir antes de que el paso 2 pueda enviarse.
///
/// Copied from [ClinicalProfileNotifier].
@ProviderFor(ClinicalProfileNotifier)
final clinicalProfileNotifierProvider = AutoDisposeNotifierProvider<
    ClinicalProfileNotifier, ClinicalProfileState>.internal(
  ClinicalProfileNotifier.new,
  name: r'clinicalProfileNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clinicalProfileNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClinicalProfileNotifier = AutoDisposeNotifier<ClinicalProfileState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
