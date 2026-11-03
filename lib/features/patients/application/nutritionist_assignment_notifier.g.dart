// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_assignment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasAssignedNutritionistHash() =>
    r'f653f63f2df7813a57f243497b889c3b508c5db0';

/// `false` solo si el resumen confirmó que el paciente no tiene nutricionista.
///
/// Copied from [hasAssignedNutritionist].
@ProviderFor(hasAssignedNutritionist)
final hasAssignedNutritionistProvider =
    AutoDisposeFutureProvider<bool>.internal(
  hasAssignedNutritionist,
  name: r'hasAssignedNutritionistProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasAssignedNutritionistHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasAssignedNutritionistRef = AutoDisposeFutureProviderRef<bool>;
String _$nutritionistAssignmentNotifierHash() =>
    r'89910ed291c2eed90e3c256333298d13981b24c4';

/// Canjea el código y recarga el resumen, que pasa a mostrar al nutricionista.
///
/// Copied from [NutritionistAssignmentNotifier].
@ProviderFor(NutritionistAssignmentNotifier)
final nutritionistAssignmentNotifierProvider = AutoDisposeNotifierProvider<
    NutritionistAssignmentNotifier, NutritionistAssignmentState>.internal(
  NutritionistAssignmentNotifier.new,
  name: r'nutritionistAssignmentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nutritionistAssignmentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NutritionistAssignmentNotifier
    = AutoDisposeNotifier<NutritionistAssignmentState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
