import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../auth/application/session_notifier.dart';
import '../data/recommendation_request_store.dart';
import '../data/recommendations_repository.dart';
import '../domain/pending_recommendation_request.dart';
import '../domain/recommendation.dart';
import 'recommendation_detail_providers.dart';

part 'recommendations_feed_notifier.freezed.dart';
part 'recommendations_feed_notifier.g.dart';

/// Reloj de la feature, sobreescribible en los tests.
///
/// El vencimiento del marcador se compara contra la hora actual, y un test
/// que dependiera del reloj real se volveria inestable cerca de un borde.
@Riverpod(keepAlive: true)
DateTime Function() recommendationsClock(Ref ref) => DateTime.now;

/// Lo que ve el paciente en Consejos.
@freezed
abstract class RecommendationsFeed with _$RecommendationsFeed {
  const factory RecommendationsFeed({
    /// Recomendaciones visibles, ya filtradas por el repositorio.
    @Default(<RecommendationSummary>[]) List<RecommendationSummary> summaries,

    /// Marcador vigente tras reconciliarlo con la lista: un pedido en curso
    /// o una recomendacion en revision.
    PendingRecommendationRequest? request,

    /// Hay una recomendacion propia en revision (HU0014 CA2, CP037).
    @Default(false) bool awaitingReview,

    /// Hay un `POST /recommendations` en vuelo.
    @Default(false) bool generating,

    /// Fallo del pedido que el paciente si tiene que ver: red o servidor.
    /// Los 422 de negocio no llegan aca (decision 2).
    CauceApiError? generationError,
  }) = _RecommendationsFeed;

  const RecommendationsFeed._();

  /// Aprobadas y todavia sin abrir (HU0014 CA1).
  List<RecommendationSummary> get fresh =>
      summaries.where((summary) => summary.status.isDeliverable).toList();
}

/// Listado de Consejos y disparo silencioso de la generacion (decision 2).
///
/// `keepAlive` porque lo leen dos pestanas, Inicio y Consejos, y cada una lo
/// pediria de nuevo al cambiar entre ellas. Observa al paciente de la sesion:
/// otra cuenta en el mismo dispositivo nunca ve la lista de la anterior.
///
/// **Solo la pestana de Consejos genera.** Inicio lee el mismo estado pero no
/// llama a [openAdviceTab]: el paciente "recibe" la recomendacion al entrar a
/// Consejos, no al abrir la app.
@Riverpod(keepAlive: true)
class RecommendationsFeedNotifier extends _$RecommendationsFeedNotifier {
  Future<void>? _opening;

  @override
  Future<RecommendationsFeed> build() async {
    final userId = ref.watch(
      sessionNotifierProvider.select((session) => session.user?.userId),
    );
    if (userId == null) {
      return const RecommendationsFeed();
    }

    final summaries =
        await ref.watch(recommendationsRepositoryProvider).listMine();
    final request = await _reconcile(userId, summaries);
    return RecommendationsFeed(
      summaries: summaries,
      request: request,
      awaitingReview: request?.isAwaitingReview(_now()) ?? false,
    );
  }

  /// Entrada a la pestana de Consejos.
  ///
  /// Carga, y si la lista quedo vacia y no hay nada en revision, pide una
  /// recomendacion sin que el paciente toque nada. [refresh] vuelve a pedir
  /// la lista y los detalles de las tarjetas.
  ///
  /// Corre de a una: la pantalla la dispara al montarse y el shell al tocar la
  /// pestana, y dos pedidos simultaneos podrian generar dos recomendaciones.
  Future<void> openAdviceTab({bool refresh = false}) {
    return _opening ??=
        _openAdviceTab(refresh: refresh).whenComplete(() => _opening = null);
  }

  Future<void> _openAdviceTab({required bool refresh}) async {
    if (refresh) {
      ref.invalidate(recommendationDetailProvider);
      ref.invalidateSelf();
    }

    final RecommendationsFeed feed;
    try {
      feed = await future;
    } catch (_) {
      // El fallo ya quedo en el estado del provider, y la pantalla lo muestra
      // con su reintento. Aca solo se evita que escape como error suelto.
      return;
    }
    await _requestIfNeeded(feed);
  }

  Future<void> _requestIfNeeded(RecommendationsFeed feed) async {
    final userId = ref.read(sessionNotifierProvider).user?.userId;
    if (userId == null) {
      return;
    }

    final now = _now();
    final decision = RecommendationRequestPolicy.decide(
      listIsEmpty: feed.summaries.isEmpty,
      marker: feed.request,
      now: now,
    );
    if (decision != GenerationDecision.request) {
      return;
    }

    // Un marcador que sobrevivio a la reconciliacion sin estar en revision es
    // un pedido anterior cuya respuesta no llego. Se reusa su clave: si el
    // servidor si lo habia creado, devuelve esa recomendacion y no otra.
    final started = PendingRecommendationRequest(
      ownerUserId: userId,
      idempotencyKey: feed.request?.idempotencyKey ?? const Uuid().v4(),
      requestedAt: now,
    );
    final store = ref.read(recommendationRequestStoreProvider);

    state = AsyncData(feed.copyWith(generating: true, generationError: null));
    await store.write(started);

    try {
      final result = await ref
          .read(recommendationsRepositoryProvider)
          .requestGeneration(idempotencyKey: started.idempotencyKey);

      if (result.isAlreadyVisible) {
        await store.clear();
        ref.invalidateSelf();
        return;
      }

      final marker = started.copyWith(
        recommendationId: result.id,
        requestedAt: result.generatedAt ?? now,
        expiresAt: result.expiresAt,
      );
      await store.write(marker);
      state = AsyncData(
        feed.copyWith(
          request: marker,
          awaitingReview: marker.isAwaitingReview(_now()),
          generating: false,
          generationError: null,
        ),
      );
    } on CauceApiError catch (error) {
      final keepKey = _isTransient(error);
      if (!keepKey) {
        await store.clear();
      }
      state = AsyncData(
        feed.copyWith(
          request: keepKey ? started : null,
          generating: false,
          generationError: _isQuiet(error) ? null : error,
        ),
      );
    }
  }

  /// Borra el marcador que ya no vale y devuelve el que sigue.
  Future<PendingRecommendationRequest?> _reconcile(
    String userId,
    List<RecommendationSummary> summaries,
  ) async {
    final store = ref.read(recommendationRequestStoreProvider);
    final stored = await store.read();
    final kept = RecommendationRequestPolicy.reconcile(
      marker: stored,
      currentUserId: userId,
      visibleIds: summaries.map((summary) => summary.id),
      now: _now(),
    );
    if (stored != null && kept == null) {
      await store.clear();
    }
    return kept;
  }

  DateTime _now() => ref.read(recommendationsClockProvider)();

  /// Errores del disparo automatico que no se le muestran al paciente.
  ///
  /// El paciente no pidio nada: un banner de error por un pedido que no hizo
  /// seria confuso. Consejos queda en su estado vacio, cuya copia ya cubre el
  /// caso mas comun, el historial insuficiente (decision 2).
  static bool _isQuiet(CauceApiError error) => switch (error) {
        InsufficientClinicalHistoryError() ||
        AllCandidatesFilteredByAllergiesError() ||
        NoActiveModelVersionError() ||
        PatientProfileNotFoundError() =>
          true,
        _ => false,
      };

  /// Fallos en los que el pedido pudo haber llegado sin que llegara la
  /// respuesta. Se conserva la clave para repetirla.
  static bool _isTransient(CauceApiError error) => switch (error) {
        NetworkError() || RateLimitedError() => true,
        UnknownError(:final statusCode) => statusCode == 0 || statusCode >= 500,
        _ => false,
      };
}

/// Recomendacion propia en revision, para el aviso de Inicio (decision 1).
///
/// Lee el marcador local y no depende de la red: sin conexion el aviso sigue
/// en pie. Observa la lista para retirarlo en cuanto la recomendacion aparece
/// aprobada, sin esperar a que alguien borre el marcador.
@Riverpod(keepAlive: true)
Future<PendingRecommendationRequest?> pendingRecommendationRequest(
  Ref ref,
) async {
  final userId = ref.watch(
    sessionNotifierProvider.select((session) => session.user?.userId),
  );
  if (userId == null) {
    return null;
  }

  final visibleIds = ref
          .watch(recommendationsFeedNotifierProvider)
          .valueOrNull
          ?.summaries
          .map((summary) => summary.id) ??
      const <String>[];
  final now = ref.read(recommendationsClockProvider)();

  final marker = await ref.watch(recommendationRequestStoreProvider).read();
  final kept = RecommendationRequestPolicy.reconcile(
    marker: marker,
    currentUserId: userId,
    visibleIds: visibleIds,
    now: now,
  );
  return kept != null && kept.isAwaitingReview(now) ? kept : null;
}
