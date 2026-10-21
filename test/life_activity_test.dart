
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_activity.dart';
import 'package:life_in_numbers/models/default_activities.dart';

void main() {
  test('Activity converts to JSON and back', () {
    const activity = LifeActivity(
      id: 'coffee',
      name: 'Coffee',
      categoryId: 'consumption',
      iconName: 'coffee',
    );

    final restored = LifeActivity.fromJson(activity.toJson());

    expect(restored.id, 'coffee');
    expect(restored.name, 'Coffee');
    expect(restored.categoryId, 'consumption');
    expect(restored.isActive, isTrue);
  });

  test('copyWith preserves the activity ID', () {
    const activity = LifeActivity(
      id: 'coffee',
      name: 'Coffee',
      categoryId: 'consumption',
      iconName: 'coffee',
    );

    final updated = activity.copyWith(name: 'Espresso');

    expect(updated.id, 'coffee');
    expect(updated.name, 'Espresso');
    expect(activity.name, 'Coffee');
  });

  test('Default activities have unique IDs', () {
    final ids = DefaultActivities.all.map((activity) => activity.id).toSet();

    expect(ids.length, DefaultActivities.all.length);
    expect(DefaultActivities.all.length, 10);
  });
}
