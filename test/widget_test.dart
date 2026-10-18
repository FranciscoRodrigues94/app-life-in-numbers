
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/main.dart';

void main() {
  testWidgets('Dashboard displays initial statistics', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());

    expect(find.text('My Life'), findsOneWidget);
    expect(find.text('Total records'), findsOneWidget);
    expect(find.text('Activities'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsWidgets);
  });

  testWidgets('Navigation opens Quick Add', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Quick Add'), findsOneWidget);
    expect(find.text('Coffee'), findsOneWidget);
  });
}
