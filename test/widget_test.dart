
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

    expect(find.text('My Life'), findsOneWidget);
    expect(find.text('Total records'), findsOneWidget);
    expect(find.text('Activities'), findsOneWidget);
  });

  testWidgets('Navigation opens Quick Add', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    expect(find.text('My Life'), findsOneWidget);

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Quick Add'), findsOneWidget);
    expect(find.text('Coffee'), findsOneWidget);
  });
}
