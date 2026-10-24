// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_navigation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pushTapsHash() => r'efd8eb8350487dea59582dac65dc9c5f14711021';

/// Vive con la app: lo enciende `CauceApp` y se apaga con el contenedor.
///
/// Sin sesion iniciada el toque no se recuerda: el paciente va al login y
/// despues a Inicio.
///
/// Copied from [pushTaps].
@ProviderFor(pushTaps)
final pushTapsProvider = Provider<PushTaps>.internal(
  pushTaps,
  name: r'pushTapsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pushTapsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PushTapsRef = ProviderRef<PushTaps>;
String _$pendingPushDestinationHash() =>
    r'5ed06ddeba22f32de3fd6abaf0f2fb9a4cddb25d';

/// Destino de un toque que todavia no se abrio.
///
/// Solo vive en memoria. `PushInbox` lo consume cuando el shell ya esta a la
/// vista, y se descarta si la sesion termina sin iniciarse.
///
/// Copied from [PendingPushDestination].
@ProviderFor(PendingPushDestination)
final pendingPushDestinationProvider =
    NotifierProvider<PendingPushDestination, PushDestination?>.internal(
  PendingPushDestination.new,
  name: r'pendingPushDestinationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingPushDestinationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PendingPushDestination = Notifier<PushDestination?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
