import 'package:cauce_mobile/core/push/push_destination.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

const String _id = '3f6c1a2e-7b4d-4e1a-9c2b-1a2b3c4d5e6f';

void main() {
  group('resolvePushDestination', () {
    test('una recomendacion aprobada abre su detalle', () {
      expect(
        resolvePushDestination(<String, String>{
          'type': 'recommendation',
          'entityType': 'recommendation',
          'entityId': _id,
        }),
        (location: AppRoutes.recommendationDetailPath(_id), stacked: false),
      );
    });

    test('el recordatorio de feedback tambien abre el detalle', () {
      expect(
        resolvePushDestination(<String, String>{
          'type': 'reminder',
          'entityType': 'recommendation',
          'entityId': _id,
        }).location,
        AppRoutes.recommendationDetailPath(_id),
      );
    });

    test('un info de recomendacion va a la lista y no al detalle', () {
      expect(
        resolvePushDestination(<String, String>{
          'type': 'info',
          'entityType': 'recommendation',
          'entityId': _id,
        }),
        (location: AppRoutes.recommendations, stacked: false),
      );
    });

    test('una recomendacion sin id valido va a la lista', () {
      for (final id in <String>['', 'no-es-un-uuid', '../perfil']) {
        expect(
          resolvePushDestination(<String, String>{
            'type': 'recommendation',
            'entityType': 'recommendation',
            'entityId': id,
          }).location,
          AppRoutes.recommendations,
          reason: id,
        );
      }
    });

    test('el aviso y el recordatorio del cuestionario abren el cuestionario',
        () {
      for (final type in <String>['info', 'reminder']) {
        expect(
          resolvePushDestination(<String, String>{
            'type': type,
            'entityType': 'ibs_sss_schedule',
            'entityId': _id,
          }),
          (location: AppRoutes.ibsSssPeriodic, stacked: true),
          reason: type,
        );
      }
    });

    test('el recordatorio semanal, sin entidad, abre el Diario', () {
      expect(
        resolvePushDestination(<String, String>{
          'type': 'reminder',
          'entityType': '',
          'entityId': '',
        }),
        (location: AppRoutes.history, stacked: false),
      );
      expect(
        resolvePushDestination(const <String, String>{}).location,
        AppRoutes.history,
      );
    });

    test('una entidad desconocida cae en Inicio', () {
      expect(
        resolvePushDestination(<String, String>{
          'type': 'info',
          'entityType': 'algo_nuevo',
          'entityId': _id,
        }),
        (location: AppRoutes.home, stacked: false),
      );
    });
  });
}
