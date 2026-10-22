import 'dart:async';
import 'dart:math' as math;

import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/meals/data/meals_repository.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/meals/domain/meal_record.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:mocktail/mocktail.dart';

/// Argumentos de una llamada de historial que recibio un repositorio falso.
typedef HistoryCall = ({DateTime? from, DateTime? to, int page, int pageSize});

/// Pagina de [all] como lo hace el servidor, o la pagina fija de [pages].
List<T> _slice<T>(List<T> all, List<List<T>>? pages, int page, int pageSize) {
  if (pages != null) {
    return page <= pages.length ? pages[page - 1] : <T>[];
  }
  final start = (page - 1) * pageSize;
  if (start >= all.length) {
    return <T>[];
  }
  return all.sublist(start, math.min(start + pageSize, all.length));
}

/// `GET /meals` paginado en memoria.
///
/// [totalCount] reemplaza al conteo real y [failOnPage] responde un fallo de
/// red en esa pagina. Con [gate] cada llamada espera a que se complete.
class PagedMealsRepository extends Fake implements MealsRepository {
  PagedMealsRepository(
    this.all, {
    this.totalCount,
    this.failOnPage,
    this.pages,
  });

  final List<MealRecord> all;
  final int? totalCount;
  int? failOnPage;
  final List<List<MealRecord>>? pages;
  final List<HistoryCall> calls = <HistoryCall>[];
  Completer<void>? gate;

  @override
  Future<MealHistoryPage> history({
    DateTime? from,
    DateTime? to,
    int page = 1,
    int pageSize = 50,
    DateTime? now,
  }) async {
    calls.add((from: from, to: to, page: page, pageSize: pageSize));
    await gate?.future;
    if (page == failOnPage) {
      throw const CauceApiError.network();
    }
    return MealHistoryPage(
      items: _slice(all, pages, page, pageSize),
      page: page,
      pageSize: pageSize,
      totalCount: totalCount ?? all.length,
    );
  }
}

/// `GET /symptoms` paginado en memoria, con las mismas opciones.
class PagedSymptomsRepository extends Fake implements SymptomsRepository {
  PagedSymptomsRepository(this.all, {this.totalCount, this.failOnPage});

  final List<SymptomRecord> all;
  final int? totalCount;
  int? failOnPage;
  final List<HistoryCall> calls = <HistoryCall>[];

  @override
  Future<SymptomHistoryPage> history({
    DateTime? from,
    DateTime? to,
    int page = 1,
    int pageSize = 50,
    DateTime? now,
  }) async {
    calls.add((from: from, to: to, page: page, pageSize: pageSize));
    if (page == failOnPage) {
      throw const CauceApiError.network();
    }
    return SymptomHistoryPage(
      items: _slice(all, null, page, pageSize),
      page: page,
      pageSize: pageSize,
      totalCount: totalCount ?? all.length,
    );
  }
}

/// [count] comidas del servidor, una cada [step] hacia atras desde [newest].
List<MealRecord> mealRecords(
  int count, {
  required DateTime newest,
  Duration step = const Duration(hours: 4),
}) {
  return <MealRecord>[
    for (var i = 0; i < count; i++)
      MealRecord(
        mealId: 'meal-$i',
        clientGuid: 'meal-guid-$i',
        consumedAt: newest.subtract(step * i),
        mealTime: MealTimeOption.lunch,
        items: const <MealRecordItem>[
          MealRecordItem(
            foodId: 'food-1',
            quantity: 150,
            unit: MeasurementUnitOption.grams,
          ),
        ],
      ),
  ];
}

/// [count] sintomas del servidor, uno cada [step] hacia atras desde [newest].
List<SymptomRecord> symptomRecords(
  int count, {
  required DateTime newest,
  Duration step = const Duration(hours: 12),
}) {
  return <SymptomRecord>[
    for (var i = 0; i < count; i++)
      SymptomRecord(
        symptomId: 'symptom-$i',
        clientGuid: 'symptom-guid-$i',
        occurredAt: newest.subtract(step * i),
        intensity: 40,
        symptomType: SymptomTypeOption.bloating,
      ),
  ];
}
