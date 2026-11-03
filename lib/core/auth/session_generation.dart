import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_generation.g.dart';

/// Contador que avanza cada vez que la sesion se cierra.
///
/// Una renovacion que empezo en una generacion y termina en otra descarta sus
/// tokens: guardarlos reabriria una sesion ya cerrada.
class SessionGeneration {
  int _value = 0;

  int get value => _value;

  void advance() => _value++;
}

@Riverpod(keepAlive: true)
SessionGeneration sessionGeneration(Ref ref) => SessionGeneration();
