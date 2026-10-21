import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_category.dart';
import 'package:life_in_numbers/models/default_categories.dart';

void main() {
  test('Category converts to and from JSON', () {
    const category = LifeCategory(id: 'hobbies', name: 'Hobbies');

    final restored = LifeCategory.fromJson(category.toJson());

    expect(restored.id, 'hobbies');
    expect(restored.name, 'Hobbies');
    expect(restored.isActive, isTrue);
  });

  test('Renaming preserves category ID', () {
    const category = LifeCategory(id: 'hobbies', name: 'Hobbies');

    final updated = category.copyWith(name: 'Free Time');

    expect(updated.id, 'hobbies');
    expect(updated.name, 'Free Time');
  });

  test('Category can be deactivated', () {
    const category = LifeCategory(id: 'hobbies', name: 'Hobbies');

    final updated = category.copyWith(isActive: false);

    expect(updated.isActive, isFalse);
    expect(updated.id, 'hobbies');
  });

  test('Default categories have unique IDs', () {
    final ids = DefaultCategories.all.map((category) => category.id).toList();

    expect(ids.toSet().length, ids.length);
  });

  test('Default categories match existing activity categories', () {
    const existingIds = {
      'consumption',
      'experiences',
      'hobbies',
      'wellness',
      'social',
      'fitness',
    };

    final categoryIds = DefaultCategories.all
        .map((category) => category.id)
        .toSet();

    expect(categoryIds, existingIds);
  });
}
