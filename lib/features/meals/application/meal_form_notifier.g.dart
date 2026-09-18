// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealFormNotifierHash() => r'e1c0720dffdc6b733e666dc62dddf1eb34e8bdb2';

/// Gobierna el armado y el envio de una comida.
///
/// **Con conexion o sin ella, la comida se guarda siempre en el dispositivo.**
/// Con red se manda ademas al servidor y la fila local queda como sincronizada;
/// sin red queda pendiente y la sube el worker. Asi el historial local muestra
/// lo mismo en los dos casos y el paciente no ve sus registros aparecer y
/// desaparecer segun la cobertura.
///
/// Copied from [MealFormNotifier].
@ProviderFor(MealFormNotifier)
final mealFormNotifierProvider =
    AutoDisposeNotifierProvider<MealFormNotifier, MealFormState>.internal(
  MealFormNotifier.new,
  name: r'mealFormNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mealFormNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MealFormNotifier = AutoDisposeNotifier<MealFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
