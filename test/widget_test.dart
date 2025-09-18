import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/main.dart'; // هنا MyApp

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Home()); // احذف const إذا MyApp مش const
    expect(find.text('Profile'), findsOneWidget); // أو 'Materials' حسب شاشتك
  });
}
