import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_activity.dart';
import 'package:life_in_numbers/services/activity_repository.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('Existing installation receives missing default activities', () async {
    final repository = ActivityRepository();

    await repository.saveActivities(const [
      LifeActivity(
        id: 'coffee',
        name: 'Coffee',
        categoryId: 'consumption',
        iconName: 'coffee',
        isActive: false,
      ),
      LifeActivity(
        id: 'cinema',
        name: 'Cinema',
        categoryId: 'experiences',
        iconName: 'movie',
      ),
    ]);

    final activities = await repository.loadActivities();

    expect(activities.length, 10);
    expect(activities.any((activity) => activity.id == 'sport'), isTrue);
    expect(activities.any((activity) => activity.id == 'meditation'), isTrue);

    final coffee = activities.firstWhere((activity) => activity.id == 'coffee');
    expect(coffee.isActive, isFalse);

    final cinema = activities.firstWhere((activity) => activity.id == 'cinema');
    expect(cinema.name, 'TV / Cinema');
    expect(cinema.id, 'cinema');

    final reloaded = await ActivityRepository().loadActivities();
    expect(reloaded.length, 10);
  });
}
