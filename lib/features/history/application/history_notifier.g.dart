// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyNotifierHash() => r'65941897e9e6467c168f55f9e0878dfde2a5f2b0';

/// Historial del Diario: los 90 dias completos, mas lo que no llego al
/// servidor. Se compone desde `/meals` y `/symptoms`, no desde `/history`.
///
/// Copied from [HistoryNotifier].
@ProviderFor(HistoryNotifier)
final historyNotifierProvider =
    AutoDisposeNotifierProvider<HistoryNotifier, HistoryState>.internal(
  HistoryNotifier.new,
  name: r'historyNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historyNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HistoryNotifier = AutoDisposeNotifier<HistoryState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
