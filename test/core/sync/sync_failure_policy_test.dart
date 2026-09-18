import 'package:cauce_mobile/core/sync/sync_failure_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SyncFailurePolicy', () {
    test('los cuatro codigos de forma del payload son permanentes', () {
      for (final code in <String>[
        'food_item_not_found',
        'custom_food_not_found',
        'validation_error',
        'invalid_meal_registration',
      ]) {
        expect(SyncFailurePolicy.isPermanent(code), isTrue, reason: code);
      }
    });

    test('un 500 o un rate limit se reintentan', () {
      for (final code in <String>[
        'internal_server_error',
        'domain_rule_violation',
        'idempotency_mismatch',
      ]) {
        expect(SyncFailurePolicy.isPermanent(code), isFalse, reason: code);
      }
    });

    test('un codigo desconocido se reintenta', () {
      // Si el backend agrega un codigo nuevo, la fila espera en vez de
      // descartarse sola. Ante la duda conviene reintentar de mas: esta lista
      // es la que decide perder un registro clinico.
      expect(SyncFailurePolicy.isPermanent('codigo_del_futuro'), isFalse);
    });

    test('un codigo ausente se reintenta', () {
      expect(SyncFailurePolicy.isPermanent(null), isFalse);
      expect(SyncFailurePolicy.isPermanent(''), isFalse);
    });

    test('la lista de permanentes se mantiene corta a proposito', () {
      // Si crece, conviene revisar caso por caso: cada entrada nueva es una
      // forma mas de que un registro del paciente termine descartado.
      expect(SyncFailurePolicy.permanentCodes, hasLength(4));
    });
  });
}
