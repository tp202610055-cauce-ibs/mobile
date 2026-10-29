import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SecureOnboardingDraftStore', () {
    test('el borrador va y vuelve con su dueño, su paso y sus datos', () {
      const draft = OnboardingDraft(
        ownerUserId: 'patient-1',
        page: 1,
        fields: <String, Object?>{'weightKg': '62', 'noneKnown': true},
      );

      final back = SecureOnboardingDraftStore.decode(
        SecureOnboardingDraftStore.encode(draft),
      )!;

      expect(back.ownerUserId, 'patient-1');
      expect(back.page, 1);
      expect(
        back.fields,
        <String, Object?>{'weightKg': '62', 'noneKnown': true},
      );
    });

    test('un valor corrupto se lee como que no hay borrador', () {
      expect(SecureOnboardingDraftStore.decode('{no es json'), isNull);
      expect(SecureOnboardingDraftStore.decode('{"page": "uno"}'), isNull);
    });

    test('sin plataforma no lanza: lee nada y escribir no falla', () async {
      final store = SecureOnboardingDraftStore(const FlutterSecureStorage());

      expect(await store.read(), isNull);
      await store.write(const OnboardingDraft(ownerUserId: 'p', page: 0));
      await store.clear();
    });
  });
}
