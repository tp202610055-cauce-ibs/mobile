import '../router/app_routes.dart';

/// Pantalla que abre el toque sobre un push.
///
/// [stacked] en `true` cuando la ruta se apila sobre el shell, como los
/// formularios: se abre con `push` para que la flecha vuelva atras.
typedef PushDestination = ({String location, bool stacked});

final RegExp _uuid = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);

/// Traduce los datos del push a un destino. Pura: no lee estado ni navega.
///
/// Una recomendacion nueva abre Inicio, donde aparece marcada como nueva
/// (CP036). Un `info` de recomendacion va a la lista: en revision no es visible.
PushDestination resolvePushDestination(Map<String, String> data) {
  final entityType = data['entityType']?.trim() ?? '';
  final entityId = data['entityId']?.trim() ?? '';
  final type = data['type']?.trim() ?? '';

  return switch (entityType) {
    'recommendation' when type == 'recommendation' => (
        location: AppRoutes.home,
        stacked: false,
      ),
    'recommendation' when type != 'info' && _uuid.hasMatch(entityId) => (
        location: AppRoutes.recommendationDetailPath(entityId),
        stacked: false,
      ),
    'recommendation' => (location: AppRoutes.recommendations, stacked: false),
    'ibs_sss_schedule' => (location: AppRoutes.ibsSssPeriodic, stacked: true),
    '' => (location: AppRoutes.history, stacked: false),
    _ => (location: AppRoutes.home, stacked: false),
  };
}
