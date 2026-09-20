// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyNotifierHash() => r'e0bc6c6a61c254cd560a1a2e89c5ecbccd9268f9';

/// Arma el historial unificado de comidas y sintomas.
///
/// **No usa `GET /api/v1/history`.** El contrato aplana su jerarquia
/// polimorfica y el cliente generado descarta el payload en silencio, asi que
/// el historial se compone desde `/meals` y `/symptoms`, que si devuelven tipos
/// completos, mas lo que todavia esta en la cola local.
///
/// Lo local va primero en el merge para que una fila que ya sincronizo no
/// aparezca dos veces: se deduplica por `clientGuid`.
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
