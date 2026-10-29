import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';

/// Borrador del asistente en memoria, con registro de escrituras.
class FakeOnboardingDraftStore implements OnboardingDraftStore {
  FakeOnboardingDraftStore([this.draft]);

  OnboardingDraft? draft;
  int writes = 0;
  int clears = 0;

  @override
  Future<OnboardingDraft?> read() async => draft;

  @override
  Future<void> write(OnboardingDraft value) async {
    writes++;
    draft = value;
  }

  @override
  Future<void> clear() async {
    clears++;
    draft = null;
  }
}
