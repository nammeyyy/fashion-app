// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:fashion_app/app/app.dart';

void main() {
  testWidgets('shows the welcome screen for signed-out users', (tester) async {
    await tester.pumpWidget(const MyApp(initialRoute: '/welcome'));

    expect(find.text('Buy Less, Choose Well,\nMake it last.'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });
}
