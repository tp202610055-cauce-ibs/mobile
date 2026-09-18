// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_note_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clinicalNoteFormNotifierHash() =>
    r'16313345f107355a6ec9616de748702cb0e157c9';

/// Gobierna la escritura y el envio de una nota de contexto.
///
/// **Exige conexion.** El endpoint no es idempotente, asi que la nota no entra
/// a la cola offline: reintentarla sin una clave de deduplicacion crearia una
/// segunda nota sobre el mismo registro clinico.
///
/// Copied from [ClinicalNoteFormNotifier].
@ProviderFor(ClinicalNoteFormNotifier)
final clinicalNoteFormNotifierProvider = AutoDisposeNotifierProvider<
    ClinicalNoteFormNotifier, ClinicalNoteFormState>.internal(
  ClinicalNoteFormNotifier.new,
  name: r'clinicalNoteFormNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clinicalNoteFormNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClinicalNoteFormNotifier = AutoDisposeNotifier<ClinicalNoteFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
