import '../../symptoms/domain/symptom_draft.dart';

/// Cantidad de registros de un tipo de sintoma.
typedef SymptomTypeCount = ({SymptomTypeOption type, int count});

/// Sintomas del paciente por tipo, en la ventana de los datos de respaldo.
/// Nombra los tipos mas frecuentes y agrupa el resto con el tipo "otro".
class SymptomBreakdown {
  const SymptomBreakdown({required this.leading, required this.others});

  /// Cuenta los registros con `occurredAt` en `[from, to)`, como el servidor.
  factory SymptomBreakdown.tally(
    Iterable<SymptomRecord> records, {
    required DateTime from,
    required DateTime to,
  }) {
    final counts = <SymptomTypeOption, int>{};
    var others = 0;
    for (final record in records) {
      final at = record.occurredAt;
      if (at.isBefore(from) || !at.isBefore(to)) {
        continue;
      }
      final type = record.symptomType;
      if (type == null || type == SymptomTypeOption.other) {
        others++;
        continue;
      }
      counts[type] = (counts[type] ?? 0) + 1;
    }

    // A igual cantidad manda el orden del enum, para que no cambie entre cargas.
    final sorted = counts.entries.toList()
      ..sort((a, b) {
        final byCount = b.value.compareTo(a.value);
        return byCount != 0 ? byCount : a.key.index.compareTo(b.key.index);
      });
    return SymptomBreakdown(
      leading: <SymptomTypeCount>[
        for (final entry in sorted.take(maxNamedTypes))
          (type: entry.key, count: entry.value),
      ],
      others: sorted
          .skip(maxNamedTypes)
          .fold(others, (sum, entry) => sum + entry.value),
    );
  }

  static const int maxNamedTypes = 3;

  /// Tipos nombrados, de mayor a menor cantidad.
  final List<SymptomTypeCount> leading;

  /// Registros de los demas tipos, del tipo "otro" y sin tipo reconocido.
  final int others;

  int get total => leading.fold(others, (sum, entry) => sum + entry.count);
}
