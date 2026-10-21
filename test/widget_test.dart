
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/main.dart';
import 'package:life_in_numbers/pages/dashboard_page.dart';
import 'package:life_in_numbers/pages/quick_add_page.dart';
import 'package:life_in_numbers/pages/mood_page.dart';
import 'package:life_in_numbers/services/mood_repository.dart';
import 'package:life_in_numbers/services/life_event_storage.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

Future<int> coffeeRecordCount() async {
  final events = await LifeEventStorage().loadEvents();
  return events.where((event) => event.activityId == 'coffee').length;
}

Future<void> dismissSnackBar(WidgetTester tester) async {
  final messenger = tester.state<ScaffoldMessengerState>(
    find.byType(ScaffoldMessenger),
  );
  messenger.removeCurrentSnackBar();
  await tester.pumpAndSettle();
}

Future<void> addCoffee(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('nav_add')));
  await tester.pumpAndSettle();

  final coffeeCard = find.byKey(const Key('quick_add_coffee'));
  await tester.ensureVisible(coffeeCard);
  await tester.pumpAndSettle();
  await tester.tap(coffeeCard);
  await tester.pumpAndSettle();

  await dismissSnackBar(tester);
}

Future<void> scrollHomeTo(WidgetTester tester, Key key) async {
  final homeScrollable = find.descendant(
    of: find.byType(DashboardPage),
    matching: find.byType(Scrollable),
  );
  await tester.scrollUntilVisible(
    find.byKey(key),
    220,
    scrollable: homeScrollable.first,
  );
  await tester.pumpAndSettle();
}

Future<void> openCoffeeHistory(WidgetTester tester) async {
  final removeButton = find.byKey(const Key('remove_activity_coffee'));
  expect(removeButton, findsOneWidget);

  await tester.ensureVisible(removeButton);
  await tester.pumpAndSettle();
  await tester.tap(removeButton);
  await tester.pumpAndSettle();

  expect(find.text('Select a record to remove.'), findsOneWidget);
}

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('Dashboard displays initial statistics', (tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('dashboard_greeting')), findsOneWidget);
    expect(find.byKey(const Key('dashboard_monthly_card')), findsOneWidget);
    expect(find.byKey(const Key('main_navigation')), findsOneWidget);
  });

  testWidgets('Navigation opens Quick Add', (tester) async {
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
  });

  testWidgets('Mood navigation records a feeling and updates Dashboard', (tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('nav_mood')));
    await tester.pumpAndSettle();
    expect(find.byType(MoodPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('mood_joy')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('1 recorded'), findsWidgets);

    final saved = await MoodRepository().loadEntries();
    expect(saved.where((entry) => entry.primaryEmotionId == 'joy'), hasLength(1));
    await dismissSnackBar(tester);

    await tester.tap(find.byKey(const Key('nav_home')));
    await tester.pumpAndSettle();
    await scrollHomeTo(tester, const Key('dashboard_feeling_joy'));
    expect(find.byKey(const Key('dashboard_feeling_joy')), findsOneWidget);
  });

  testWidgets('Light Add does not offer activity management', (tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('nav_add')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('manage_activities_button')), findsNothing);
    expect(find.byKey(const Key('category_other')), findsNothing);
    expect(find.byKey(const Key('category_activity')), findsNothing);
    expect(find.byKey(const Key('category_wellness')), findsOneWidget);
  });

  testWidgets('Undo removes the recorded event', (tester) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('nav_add')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('quick_add_coffee')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byKey(const Key('record_added_snackbar')), findsOneWidget);
    expect(find.text('Undo'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    expect(await coffeeRecordCount(), 0);
  });

  testWidgets('Search and category filters narrow visible activities', (
    tester,
  ) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('nav_add')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('activity_search')), 'cof');
    await tester.pump();

    expect(find.byKey(const Key('quick_add_coffee')), findsOneWidget);
    expect(find.byKey(const Key('quick_add_gaming')), findsNothing);

    await tester.enterText(find.byKey(const Key('activity_search')), '');
    await tester.pump();

    final hobbies = find.byKey(const Key('category_hobbies'));
    await tester.ensureVisible(hobbies);
    await tester.pumpAndSettle();
    await tester.tap(hobbies);
    await tester.pump();

    expect(find.byKey(const Key('quick_add_gaming')), findsOneWidget);
    expect(find.byKey(const Key('quick_add_coffee')), findsNothing);

    final all = find.byKey(const Key('category_all'));
    await tester.ensureVisible(all);
    await tester.pumpAndSettle();
    await tester.tap(all);
    await tester.pump();

    expect(find.byKey(const Key('quick_add_coffee')), findsOneWidget);
  });

  testWidgets('Remove button on Add opens history without adding', (
    tester,
  ) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    await addCoffee(tester);

    expect(await coffeeRecordCount(), 1);

    await openCoffeeHistory(tester);

    expect(await coffeeRecordCount(), 1);
    expect(find.byTooltip('Delete record'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete record'));
    await tester.pumpAndSettle();

    expect(find.text('Delete this record?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Select a record to remove.'), findsOneWidget);
    expect(await coffeeRecordCount(), 1);
  });

  testWidgets('Remove button on Home opens history without adding', (
    tester,
  ) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    await addCoffee(tester);

    expect(await coffeeRecordCount(), 1);

    await tester.tap(find.byKey(const Key('nav_home')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('dashboard_greeting')), findsOneWidget);
    await scrollHomeTo(tester, const Key('quick_add_coffee'));
    expect(find.byKey(const Key('quick_add_coffee')), findsOneWidget);
    expect(find.byKey(const Key('remove_activity_coffee')), findsOneWidget);

    await openCoffeeHistory(tester);

    expect(find.text('Select a record to remove.'), findsOneWidget);
    expect(await coffeeRecordCount(), 1);
  });

  testWidgets('Deleting a recorded moment updates both pages', (
    tester,
  ) async {
    await tester.pumpWidget(const LifeInNumbersApp());
    await tester.pumpAndSettle();

    await addCoffee(tester);

    expect(await coffeeRecordCount(), 1);

    await openCoffeeHistory(tester);

    await tester.tap(find.byTooltip('Delete record'));
    await tester.pumpAndSettle();

    expect(find.text('Delete this record?'), findsOneWidget);

    await tester.tap(find.byKey(const Key('confirm_delete_record')));
    await tester.pumpAndSettle();

    expect(await coffeeRecordCount(), 0);
    expect(find.byKey(const Key('remove_activity_coffee')), findsNothing);

    await dismissSnackBar(tester);

    await tester.tap(find.byKey(const Key('nav_home')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('remove_activity_coffee')), findsNothing);
    expect(find.byKey(const Key('quick_add_coffee')), findsNothing);

    await tester.tap(find.byKey(const Key('nav_add')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('quick_add_coffee')), findsOneWidget);
    expect(find.byKey(const Key('remove_activity_coffee')), findsNothing);
    expect(await coffeeRecordCount(), 0);
  });
}
