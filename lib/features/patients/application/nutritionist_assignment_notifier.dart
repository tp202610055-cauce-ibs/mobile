import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/patients_repository.dart';

part 'nutritionist_assignment_notifier.freezed.dart';
part 'nutritionist_assignment_notifier.g.dart';

/// Estado del canje de un código de invitación desde el Perfil (HU0020).
@freezed
abstract class NutritionistAssignmentState with _$NutritionistAssignmentState {
  const factory NutritionistAssignmentState({
    @Default(false) bool submitting,
    NutritionistAssignment? assignment,
    CauceApiError? error,
  }) = _NutritionistAssignmentState;
}

/// Canjea el código y recarga el resumen, que pasa a mostrar al nutricionista.
@riverpod
class NutritionistAssignmentNotifier extends _$NutritionistAssignmentNotifier {
  @override
  NutritionistAssignmentState build() => const NutritionistAssignmentState();

  /// Devuelve `true` si el servidor confirmó la vinculación.
  Future<bool> redeem(String invitationCode) async {
    if (state.submitting) {
      return false;
    }
    state = state.copyWith(submitting: true, error: null);

    try {
      final assignment = await ref
          .read(patientsRepositoryProvider)
          .assignNutritionist(invitationCode: invitationCode);
      state = state.copyWith(submitting: false, assignment: assignment);
      ref.invalidate(patientSummaryProvider);
      return true;
    } on CauceApiError catch (error) {
      state = state.copyWith(submitting: false, error: error);
      return false;
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}

/// `false` solo si el resumen confirmó que el paciente no tiene nutricionista.
@riverpod
Future<bool> hasAssignedNutritionist(Ref ref) async =>
    (await ref.watch(patientSummaryProvider.future)).hasNutritionist;
