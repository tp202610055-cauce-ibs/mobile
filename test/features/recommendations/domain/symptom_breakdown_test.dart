import 'package:cauce_mobile/features/recommendations/domain/symptom_breakdown.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_test/flutter_test.dart';

final DateTime _to = DateTime.utc(2026, 9, 24, 12);
final DateTime _from = _to.subtract(const Duration(days: 14));

int _seq = 0;

/// [count] registros de [type], uno por dia hacia atras desde ayer.
List<SymptomRecord> _records(SymptomTypeOption? type, int count) {
  return <SymptomRecord>[
    for (var i = 0; i < count; i++)
      SymptomRecord(
        symptomId: 'symptom-${_seq++}',
        occurredAt: _to.subtract(Duration(days: i + 1)),
        intensity: 60,
        symptomType: type,
      ),
  ];
}

SymptomBreakdown _tally(Iterable<SymptomRecord> records) =>
    SymptomBreakdown.tally(records, from: _from, to: _to);

void main() {
  group('SymptomBreakdown.tally', () {
    test('un solo tipo queda nombrado con su cantidad', () {
      final breakdown = _tally(_records(SymptomTypeOption.abdominalPain, 4));

      expect(breakdown.leading, <SymptomTypeCount>[
        (type: SymptomTypeOption.abdominalPain, count: 4),
      ]);
      expect(breakdown.others, 0);
      expect(breakdown.total, 4);
    });

    test('varios tipos van de mayor a menor y desde el cuarto se agrupan', () {
      final breakdown = _tally(<SymptomRecord>[
        ..._records(SymptomTypeOption.bloating, 2),
        ..._records(SymptomTypeOption.abdominalPain, 5),
        ..._records(SymptomTypeOption.diarrhea, 3),
        ..._records(SymptomTypeOption.nausea, 1),
        ..._records(SymptomTypeOption.reflux, 1),
      ]);

      expect(breakdown.leading, <SymptomTypeCount>[
        (type: SymptomTypeOption.abdominalPain, count: 5),
        (type: SymptomTypeOption.diarrhea, count: 3),
        (type: SymptomTypeOption.bloating, count: 2),
      ]);
      expect(breakdown.others, 2);
      expect(breakdown.total, 12);
    });

    test('el tipo otro y el tipo desconocido van siempre al grupo', () {
      final breakdown = _tally(<SymptomRecord>[
        ..._records(SymptomTypeOption.abdominalPain, 1),
        ..._records(SymptomTypeOption.other, 3),
        ..._records(null, 1),
      ]);

      expect(breakdown.leading, <SymptomTypeCount>[
        (type: SymptomTypeOption.abdominalPain, count: 1),
      ]);
      expect(breakdown.others, 4);
    });

    test('a igual cantidad manda el orden del contrato', () {
      final breakdown = _tally(<SymptomRecord>[
        ..._records(SymptomTypeOption.nausea, 2),
        ..._records(SymptomTypeOption.abdominalPain, 2),
      ]);

      expect(
        breakdown.leading.map((entry) => entry.type),
        <SymptomTypeOption>[
          SymptomTypeOption.abdominalPain,
          SymptomTypeOption.nausea,
        ],
      );
    });

    test('cuenta por occurredAt en [desde, hasta), como el servidor', () {
      SymptomRecord at(DateTime when) => SymptomRecord(
            symptomId: 'symptom-${_seq++}',
            occurredAt: when,
            intensity: 50,
            symptomType: SymptomTypeOption.abdominalPain,
          );

      final breakdown = _tally(<SymptomRecord>[
        at(_from),
        at(_from.subtract(const Duration(seconds: 1))),
        at(_to.subtract(const Duration(seconds: 1))),
        at(_to),
      ]);

      expect(breakdown.total, 2);
    });

    test('sin registros no nombra nada', () {
      final breakdown = _tally(const <SymptomRecord>[]);

      expect(breakdown.leading, isEmpty);
      expect(breakdown.total, 0);
    });
  });
}
