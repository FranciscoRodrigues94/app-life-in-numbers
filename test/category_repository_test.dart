import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_category.dart';
import 'package:life_in_numbers/services/category_repository.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  late CategoryRepository repository;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    repository = CategoryRepository();
  });

  test('Loads default categories on first launch', () async {
    final categories = await repository.loadCategories();

    expect(categories.length, 6);
    expect(categories.any((category) => category.id == 'hobbies'), isTrue);
  });

  test('Adds and persists a custom category', () async {
    const category = LifeCategory(id: 'travel', name: 'Travel');

    await repository.addCategory(category);

    final restored = await CategoryRepository().loadCategories();
    expect(restored.any((item) => item.id == 'travel'), isTrue);
  });

  test('Rejects duplicate category IDs', () async {
    await repository.loadCategories();

    await expectLater(
      repository.addCategory(
        const LifeCategory(id: 'hobbies', name: 'Another Hobbies'),
      ),
      throwsStateError,
    );
  });

  test('Renaming preserves category ID', () async {
    final categories = await repository.loadCategories();
    final hobbies = categories.firstWhere((item) => item.id == 'hobbies');

    await repository.updateCategory(hobbies.copyWith(name: 'Free Time'));

    final updated = await repository.loadCategories();
    final result = updated.firstWhere((item) => item.id == 'hobbies');

    expect(result.name, 'Free Time');
    expect(result.id, 'hobbies');
  });

  test('Deactivation preserves category', () async {
    await repository.deactivateCategory('hobbies');

    final categories = await repository.loadCategories();
    final hobbies = categories.firstWhere((item) => item.id == 'hobbies');

    expect(hobbies.isActive, isFalse);
    expect(categories.length, 6);
  });

  test('Preserves an intentionally empty category list after initialization', () async {
    await repository.loadCategories();
    await repository.saveCategories([]);

    final categories = await repository.loadCategories();
    expect(categories, isEmpty);
  });
  test('Migrates saved categories: adds Wellness and hides Activity and Other', () async {
    await repository.saveCategories(const [
      LifeCategory(id: 'activity', name: 'Activity'),
      LifeCategory(id: 'other', name: 'Other'),
      LifeCategory(id: 'fitness', name: 'Fitness'),
    ]);

    final categories = await repository.loadCategories();
    expect(categories.firstWhere((item) => item.id == 'wellness').isActive, isTrue);
    expect(categories.firstWhere((item) => item.id == 'activity').isActive, isFalse);
    expect(categories.firstWhere((item) => item.id == 'other').isActive, isFalse);
    expect(categories.firstWhere((item) => item.id == 'fitness').isActive, isTrue);

    final reloaded = await CategoryRepository().loadCategories();
    expect(reloaded.firstWhere((item) => item.id == 'other').isActive, isFalse);
  });
}
