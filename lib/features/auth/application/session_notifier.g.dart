// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionNotifierHash() => r'ddeec21ae379c976486d2a49f4f91a58c70f7aa6';

/// Gobierna la sesion del paciente y alimenta el guard del router.
///
/// `keepAlive` porque la sesion sobrevive a cualquier pantalla. Es el unico
/// punto que escribe [SessionState]; las pantallas leen y disparan acciones.
///
/// Copied from [SessionNotifier].
@ProviderFor(SessionNotifier)
final sessionNotifierProvider =
    NotifierProvider<SessionNotifier, SessionState>.internal(
  SessionNotifier.new,
  name: r'sessionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionNotifier = Notifier<SessionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
