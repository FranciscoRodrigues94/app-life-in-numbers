
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/default_categories.dart';
import '../models/life_category.dart';

class CategoryRepository {
  static const String _storageKey = 'life_categories';
  static const String _defaultsVersionKey = 'life_categories_defaults_version';
  static const int _currentDefaultsVersion = 3;

  final SharedPreferencesAsync _preferences;

  CategoryRepository({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  Future<List<LifeCategory>> loadCategories() async {
    final storedData = await _preferences.getString(_storageKey);

    if (storedData == null) {
      final defaults = List<LifeCategory>.of(DefaultCategories.all);
      await saveCategories(defaults);
      await _preferences.setInt(_defaultsVersionKey, _currentDefaultsVersion);
      return defaults;
    }

    final decoded = jsonDecode(storedData) as List<dynamic>;
    final categories = decoded
        .map((item) => LifeCategory.fromJson(item as Map<String, dynamic>))
        .toList();

    final currentVersion = await _preferences.getInt(_defaultsVersionKey) ?? 0;

    if (currentVersion < _currentDefaultsVersion) {
      var hasChanges = false;
      final existingIds = categories.map((category) => category.id).toSet();

      for (final defaultCategory in DefaultCategories.all) {
        if (existingIds.add(defaultCategory.id)) {
          categories.add(defaultCategory);
          hasChanges = true;
        }
      }

      final activityIndex = categories.indexWhere(
        (category) => category.id == 'activity',
      );

      if (activityIndex != -1 && categories[activityIndex].isActive) {
        categories[activityIndex] = categories[activityIndex].copyWith(
          isActive: false,
        );
        hasChanges = true;
      }

      final otherIndex = categories.indexWhere(
        (category) => category.id == 'other',
      );

      if (otherIndex != -1 && categories[otherIndex].isActive) {
        categories[otherIndex] = categories[otherIndex].copyWith(
          isActive: false,
        );
        hasChanges = true;
      }

      if (hasChanges) {
        await saveCategories(categories);
      }

      await _preferences.setInt(_defaultsVersionKey, _currentDefaultsVersion);
    }

    return categories;
  }

  Future<void> saveCategories(List<LifeCategory> categories) async {
    final data = jsonEncode(
      categories.map((category) => category.toJson()).toList(),
    );
    await _preferences.setString(_storageKey, data);
  }

  Future<void> addCategory(LifeCategory category) async {
    final categories = await loadCategories();

    if (categories.any((item) => item.id == category.id)) {
      throw StateError('Category ID already exists: ${category.id}');
    }

    activitiesCheck(categories, category);
    categories.add(category);
    await saveCategories(categories);
  }

  void activitiesCheck(
    List<LifeCategory> categories,
    LifeCategory category,
  ) {}

  Future<void> updateCategory(LifeCategory updatedCategory) async {
    final categories = await loadCategories();
    final index = categories.indexWhere(
      (item) => item.id == updatedCategory.id,
    );

    if (index == -1) {
      throw StateError('Category not found: ${updatedCategory.id}');
    }

    categories[index] = updatedCategory;
    await saveCategories(categories);
  }

  Future<void> deactivateCategory(String categoryId) async {
    final categories = await loadCategories();
    final index = categories.indexWhere(
      (item) => item.id == categoryId,
    );

    if (index == -1) {
      throw StateError('Category not found: $categoryId');
    }

    categories[index] = categories[index].copyWith(isActive: false);
    await saveCategories(categories);
  }
}
