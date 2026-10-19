
import 'package:flutter/material.dart';
import 'package:life_in_numbers/pages/quick_add_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/main.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('Dashboard displays initial statistics', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('dashboard_greeting')), findsOneWidget);
    expect(find.byKey(const Key('dashboard_monthly_card')), findsOneWidget);
    expect(find.byKey(const Key('main_navigation')), findsOneWidget);
  });

  testWidgets('Navigation opens Quick Add', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('dashboard_greeting')), findsOneWidget);

    await tester.tap(find.byKey(const Key('nav_add')));
    await tester.pumpAndSettle();

    final navigation = tester.widget<NavigationBar>(
      find.byKey(const Key('main_navigation')),
    );
    expect(navigation.selectedIndex, 1);
    expect(find.byType(QuickAddPage), findsOneWidget);
    expect(find.byKey(const Key('quick_add_coffee')), findsOneWidget);

    expect(find.byType(QuickAddPage), findsOneWidget);
    expect(find.byKey(const Key('quick_add_coffee')), findsOneWidget);
  });
}
