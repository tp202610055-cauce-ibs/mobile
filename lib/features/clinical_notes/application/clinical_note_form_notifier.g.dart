// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_note_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clinicalNoteFormNotifierHash() =>
    r'74f6725595da201f0bc42500e658b9564fafd360';

/// Gobierna la escritura y el envio de una nota de contexto.
///
/// **Exige conexion.** La nota no entra a la cola offline ni se guarda en el
/// dispositivo: sin red, el envio falla y el paciente reintenta desde la misma
/// pantalla.
///
/// **La idempotencia vive aca, en el alcance de la pantalla** (acta M48). El
/// `clientGuid` se genera en el primer envio, cuando el borrador ya paso
/// `canSubmit`, y se repite en cada reintento. Si un envio llego al servidor
/// pero la respuesta se perdio, el reintento devuelve la misma nota en vez de
/// crear otra. El provider se libera al salir de la pantalla, y con el la
/// clave: una nota nueva es una clave nueva.
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
