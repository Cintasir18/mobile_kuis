// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:kuis_124240011/main.dart';

void main() {
  testWidgets('Aplikasi dapat dijalankan', (WidgetTester tester) async {
    await tester.pumpWidget(const ShapeTimeApp());

    expect(find.text('ShapeTime'), findsOneWidget);
    expect(find.text('Menu Utama'), findsOneWidget);
  });
}