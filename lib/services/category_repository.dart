import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/default_categories.dart';
import '../models/life_category.dart';

class CategoryRepository {
  static const String _storageKey = 'life_categories';
  final SharedPreferencesAsync _preferences;

  CategoryRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  Future<List<LifeCategory>> loadCategories() async {
    final storedData = await _preferences.getString(_storageKey);
    if (storedData == null) {
      final defaults = List<LifeCategory>.of(DefaultCategories.all);
      await saveCategories(defaults);
      return defaults;
    }

    final decoded = jsonDecode(storedData) as List<dynamic>;
    return decoded
        .map((item) => LifeCategory.fromJson(item as Map<String, dynamic>))
        .toList();
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
    categories.add(category);
    await saveCategories(categories);
  }

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
    final index = categories.indexWhere((item) => item.id == categoryId);
    if (index == -1) {
      throw StateError('Category not found: $categoryId');
    }
    categories[index] = categories[index].copyWith(isActive: false);
    await saveCategories(categories);
  }
}
