
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_activity.dart';
import 'package:life_in_numbers/services/activity_repository.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  late ActivityRepository repository;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
    repository = ActivityRepository();
  });

  test('Loads default activities on first launch', () async {
    final activities = await repository.loadActivities();

    expect(activities.length, 8);
    expect(activities.any((activity) => activity.id == 'coffee'), isTrue);
  });

  test('Adds and persists custom activity', () async {
    const activity = LifeActivity(
      id: 'gym',
      name: 'Gym',
      categoryId: 'fitness',
      iconName: 'fitness',
    );

    await repository.addActivity(activity);

    final newRepository = ActivityRepository();
    final activities = await newRepository.loadActivities();

    expect(activities.length, 9);
    expect(activities.any((item) => item.id == 'gym'), isTrue);
  });

  test('Prevents duplicate activity IDs', () async {
    const activity = LifeActivity(
      id: 'coffee',
      name: 'Another Coffee',
      categoryId: 'consumption',
      iconName: 'coffee',
    );

    await expectLater(
      repository.addActivity(activity),
      throwsStateError,
    );
  });

  test('Updates activity without changing its ID', () async {
    final activities = await repository.loadActivities();
    final coffee = activities.firstWhere((item) => item.id == 'coffee');

    await repository.updateActivity(coffee.copyWith(name: 'Espresso'));

    final updated = await repository.loadActivities();
    final result = updated.firstWhere((item) => item.id == 'coffee');

    expect(result.name, 'Espresso');
    expect(result.id, 'coffee');
  });

  test('Deactivates activity without deleting it', () async {
    await repository.deactivateActivity('coffee');

    final activities = await repository.loadActivities();
    final coffee = activities.firstWhere((item) => item.id == 'coffee');

    expect(coffee.isActive, isFalse);
    expect(activities.length, 8);
  });

  test('Preserves an intentionally empty activity list', () async {
    await repository.saveActivities([]);

    final activities = await repository.loadActivities();

    expect(activities, isEmpty);
  });
}
