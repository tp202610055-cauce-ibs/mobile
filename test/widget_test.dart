import 'package:flutter_test/flutter_test.dart';
import 'package:cauce_mobile/main.dart';

void main() {
  testWidgets('shows version text on foundations scaffold', (tester) async {
    await tester.pumpWidget(const CauceApp());
    expect(find.text('Cauce Mobile v0.1.0-foundations'), findsOneWidget);
  });
}
