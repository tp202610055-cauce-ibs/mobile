// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_composer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyClockHash() => r'a892119538a3d86acc3689b5bf3df4fbd528f9c4';

/// Reloj del historial, sobreescribible en las pruebas.
///
/// Copied from [historyClock].
@ProviderFor(historyClock)
final historyClockProvider = Provider<DateTime Function()>.internal(
  historyClock,
  name: r'historyClockProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$historyClockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistoryClockRef = ProviderRef<DateTime Function()>;
String _$historyComposerHash() => r'4bb4c15cc480efc2de3caa1af0e6496de2e89ac6';

/// See also [historyComposer].
@ProviderFor(historyComposer)
final historyComposerProvider = Provider<HistoryComposer>.internal(
  historyComposer,
  name: r'historyComposerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historyComposerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistoryComposerRef = ProviderRef<HistoryComposer>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
