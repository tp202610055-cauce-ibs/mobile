import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../symptoms/data/symptoms_repository.dart';
import '../../symptoms/domain/symptom_draft.dart';
import '../domain/symptom_breakdown.dart';
import 'recommendation_detail_providers.dart';

part 'recommendation_symptom_breakdown.g.dart';

const int _pageSize = 100;
const int _maxPages = 5;

/// Sintomas por tipo en la ventana de respaldo, contados sobre `GET /symptoms`.
/// `null` si no se pueden leer o si no suman el total que dio el servidor.
@riverpod
Future<SymptomBreakdown?> recommendationSymptomBreakdown(
  Ref ref,
  String id,
) async {
  final detail = await ref.watch(recommendationDetailProvider(id).future);
  final data = detail.supportingData;
  if (data == null || data.symptomCount == 0) {
    return null;
  }

  // El servidor filtra la lista por `clientCreatedAt` y cuenta por
  // `occurredAt`: se pide con margen y se recorta en la cuenta.
  final repository = ref.watch(symptomsRepositoryProvider);
  final byId = <String, SymptomRecord>{};
  try {
    for (var page = 1; page <= _maxPages; page++) {
      final result = await repository.history(
        from: data.windowFrom.subtract(SymptomsRepository.forwardMargin),
        to: data.windowTo.add(SymptomsRepository.forwardMargin),
        page: page,
        pageSize: _pageSize,
      );
      for (final record in result.items) {
        byId.putIfAbsent(record.symptomId, () => record);
      }
      if (result.items.isEmpty || !result.hasMore) {
        break;
      }
    }
  } on CauceApiError {
    return null;
  }

  final breakdown = SymptomBreakdown.tally(
    byId.values,
    from: data.windowFrom,
    to: data.windowTo,
  );
  return breakdown.total == data.symptomCount ? breakdown : null;
}
