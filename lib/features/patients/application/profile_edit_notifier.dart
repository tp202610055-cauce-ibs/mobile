import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/patients_repository.dart';
import '../domain/patient_profile.dart';

part 'profile_edit_notifier.freezed.dart';
part 'profile_edit_notifier.g.dart';

/// Estado del guardado de la edición del perfil (HU0028).
@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState({
    @Default(false) bool saving,
    CauceApiError? error,
  }) = _ProfileEditState;
}

/// Guarda peso, estatura y subtipo, y recarga lo que el Perfil dibuja.
@riverpod
class ProfileEditNotifier extends _$ProfileEditNotifier {
  @override
  ProfileEditState build() => const ProfileEditState();

  /// Devuelve `true` si el servidor aceptó los cambios.
  Future<bool> save({
    required double weightKg,
    required double heightCm,
    required IbsSubtypeOption ibsSubtype,
  }) async {
    if (state.saving) {
      return false;
    }
    state = state.copyWith(saving: true, error: null);

    try {
      await ref.read(patientsRepositoryProvider).updateProfile(
            weightKg: weightKg,
            heightCm: heightCm,
            ibsSubtype: ibsSubtype,
          );
    } on CauceApiError catch (error) {
      state = state.copyWith(saving: false, error: error);
      return false;
    }

    ref
      ..invalidate(patientProfileProvider)
      ..invalidate(patientSummaryProvider);
    state = state.copyWith(saving: false);
    return true;
  }
}

/// Perfil clínico con los valores que el formulario de edición parte.
@riverpod
Future<PatientProfile?> editableProfile(Ref ref) =>
    ref.watch(patientProfileProvider.future);
