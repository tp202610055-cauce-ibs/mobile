import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../auth/application/session_notifier.dart';
import '../data/recommendations_repository.dart';
import '../domain/recommendation.dart';
import '../domain/recommendation_origin.dart';
import 'recommendations_feed_notifier.dart';

part 'recommendation_detail_providers.g.dart';

/// Origenes que este dispositivo vio antes de entregar (decision 10).
///
/// **Existe porque el contrato pierde el dato.** Una vez entregada, una
/// modificada y una aprobada sin cambios llegan con los mismos campos, y la
/// inferencia de [RecommendationOrigin.resolve] las lee a las dos como
/// "sistema". Sin esta memoria, el paciente tocaba una tarjeta que decia
/// "Modificada por Ana Gomez", el detalle la entregaba al abrirse, se
/// refrescaba, y la pildora pasaba a "Sugerencia del sistema" mientras la
/// leia.
///
/// El cliente si conoce el origen antes de la entrega: la tarjeta pide el
/// detalle cuando la recomendacion todavia esta en uno de los tres estados
/// aprobados. Se recuerda y se aplica despues.
///
/// **Dura la sesion, no mas.** Tras reiniciar la app, una modificada que ya se
/// entrego vuelve a leerse como "sistema". Lo resuelve el backend exponiendo
/// el origen en el contrato, y queda reportado (acta M47).
class RecommendationOriginMemory {
  final Map<String, RecommendationOrigin> _seen =
      <String, RecommendationOrigin>{};

  /// Recuerda el origen si el estado lo dice directo, o completa el detalle
  /// con el que se vio antes.
  RecommendationDetail apply(RecommendationDetail detail) {
    final direct = switch (detail.status) {
      RecommendationStatusOption.approved => RecommendationOrigin.system,
      RecommendationStatusOption.modifiedApproved =>
        RecommendationOrigin.modified,
      RecommendationStatusOption.manualApproved => RecommendationOrigin.manual,
      _ => null,
    };
    if (direct != null) {
      _seen[detail.id] = direct;
      return detail;
    }
    final seen = _seen[detail.id];
    return seen == null ? detail : detail.copyWith(knownOrigin: seen);
  }
}

/// Una memoria por paciente: otra cuenta en el dispositivo empieza de cero.
@Riverpod(keepAlive: true)
RecommendationOriginMemory recommendationOriginMemory(Ref ref) {
  ref.watch(sessionNotifierProvider.select((session) => session.user?.userId));
  return RecommendationOriginMemory();
}

/// Detalle de una recomendacion.
///
/// Lo leen dos: la tarjeta de la lista, que lo pide para componer su titulo y
/// su pildora porque el resumen no trae items (acta M47), y la pantalla de
/// detalle, que reusa lo ya cargado. **Leerlo no entrega la recomendacion**:
/// eso es [RecommendationDelivery], y solo lo dispara abrir el detalle.
@riverpod
Future<RecommendationDetail> recommendationDetail(Ref ref, String id) async {
  final memory = ref.watch(recommendationOriginMemoryProvider);
  final detail =
      await ref.watch(recommendationsRepositoryProvider).fetchDetail(id);
  return memory.apply(detail);
}

/// Estado de la entrega de una recomendacion (decision 7).
enum DeliveryStatus {
  /// Todavia no se intento en esta apertura del detalle.
  idle,

  /// Hay un `POST /deliver` en vuelo.
  inFlight,

  /// Resuelta: entregada ahora, ya entregada antes, o no entregable.
  settled,
}

/// Marca una recomendacion como entregada la primera vez que el paciente
/// abre su detalle.
///
/// La dispara **solo** la pantalla de detalle al montarse, nunca la tarjeta
/// de la lista: el pedido del detalle que hace la tarjeta es una lectura
/// silenciosa y no equivale a que el paciente la haya visto.
@riverpod
class RecommendationDelivery extends _$RecommendationDelivery {
  bool _disposed = false;

  @override
  DeliveryStatus build(String id) {
    ref.onDispose(() => _disposed = true);
    return DeliveryStatus.idle;
  }

  Future<void> ensureDelivered() async {
    if (state != DeliveryStatus.idle) {
      return;
    }
    state = DeliveryStatus.inFlight;

    final RecommendationDetail detail;
    try {
      detail = await ref.read(recommendationDetailProvider(id).future);
    } catch (_) {
      // La pantalla muestra el fallo de carga. Sin detalle no hay a quien
      // entregar.
      _set(DeliveryStatus.idle);
      return;
    }

    if (!detail.status.isDeliverable) {
      _set(DeliveryStatus.settled);
      return;
    }

    try {
      // `alreadySettled` (409 `conflict_state`) es un exito silencioso: ya
      // estaba entregada. El refresco de abajo trae el estado real.
      await ref.read(recommendationsRepositoryProvider).deliver(id);
    } on RecommendationExpiredError {
      // Vencio justo ahora y el propio intento la marco como vencida. El
      // refresco de abajo la trae como no disponible.
    } on CauceApiError {
      // Sin red, por lo comun. Queda sin entregar y se reintenta la proxima
      // vez que el paciente abra el detalle.
      _set(DeliveryStatus.idle);
      return;
    }

    _set(DeliveryStatus.settled);
    if (_disposed) {
      return;
    }
    ref.invalidate(recommendationDetailProvider(id));
    ref.invalidate(recommendationsFeedNotifierProvider);
  }

  void _set(DeliveryStatus value) {
    if (!_disposed) {
      state = value;
    }
  }
}
