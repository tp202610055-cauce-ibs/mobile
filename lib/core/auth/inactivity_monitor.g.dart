// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inactivity_monitor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inactivityClockHash() => r'632bf0ca7c918f389b1cc3f5db206715b07afb15';

/// Reloj del monitor. Se sustituye en las pruebas.
///
/// Copied from [inactivityClock].
@ProviderFor(inactivityClock)
final inactivityClockProvider = Provider<DateTime Function()>.internal(
  inactivityClock,
  name: r'inactivityClockProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inactivityClockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InactivityClockRef = ProviderRef<DateTime Function()>;
String _$sessionInactivityMonitorHash() =>
    r'c1f017816f8ae2e5750747cf46061f4af69eaca2';

/// Se enciende con la sesion y se apaga al cerrarla. Lo lee
/// `InactivityListener`, que le pasa los toques desde la raiz.
///
/// Copied from [sessionInactivityMonitor].
@ProviderFor(sessionInactivityMonitor)
final sessionInactivityMonitorProvider = Provider<InactivityMonitor>.internal(
  sessionInactivityMonitor,
  name: r'sessionInactivityMonitorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionInactivityMonitorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionInactivityMonitorRef = ProviderRef<InactivityMonitor>;
String _$inactivityNoticeHash() => r'0330de9e8b61cb3a1037be7c3bbf5802f4ab3481';

/// La ultima sesion termino por inactividad. Lo lee el login para avisarlo.
///
/// Copied from [InactivityNotice].
@ProviderFor(InactivityNotice)
final inactivityNoticeProvider =
    NotifierProvider<InactivityNotice, bool>.internal(
  InactivityNotice.new,
  name: r'inactivityNoticeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inactivityNoticeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InactivityNotice = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
