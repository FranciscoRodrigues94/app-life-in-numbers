
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/life_activity.dart';
import '../models/default_activities.dart';

class ActivityRepository {
  static const String _storageKey = 'life_activities';
  static const String _defaultsVersionKey = 'life_activities_defaults_version';
  static const int _currentDefaultsVersion = 2;

  final SharedPreferencesAsync _preferences;

  ActivityRepository({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  Future<List<LifeActivity>> loadActivities() async {
    final storedData = await _preferences.getString(_storageKey);

    if (storedData == null) {
      final defaults = List<LifeActivity>.of(DefaultActivities.all);
      await saveActivities(defaults);
      await _preferences.setInt(_defaultsVersionKey, _currentDefaultsVersion);
      return defaults;
    }

    final decoded = jsonDecode(storedData) as List<dynamic>;
    final activities = decoded
        .map((item) => LifeActivity.fromJson(item as Map<String, dynamic>))
        .toList();

    final currentVersion = await _preferences.getInt(_defaultsVersionKey) ?? 0;

    if (currentVersion < _currentDefaultsVersion) {
      var hasChanges = false;
      final existingIds = activities.map((activity) => activity.id).toSet();

      for (final defaultActivity in DefaultActivities.all) {
        if (existingIds.add(defaultActivity.id)) {
          activities.add(defaultActivity);
          hasChanges = true;
        }
      }

      final cinemaIndex = activities.indexWhere(
        (activity) => activity.id == 'cinema',
      );

      if (cinemaIndex != -1 && activities[cinemaIndex].name == 'Cinema') {
        final cinema = activities[cinemaIndex];
        activities[cinemaIndex] = cinema.copyWith(name: 'TV / Cinema');
        hasChanges = true;
      }

      if (currentVersion < 2) {
        final walkingIndex = activities.indexWhere(
          (activity) => activity.id == 'walking',
        );

        if (walkingIndex != -1 &&
            activities[walkingIndex].categoryId == 'activity') {
          activities[walkingIndex] = activities[walkingIndex].copyWith(
            categoryId: 'fitness',
          );
          hasChanges = true;
        }

        final meditationIndex = activities.indexWhere(
          (activity) => activity.id == 'meditation',
        );

        if (meditationIndex != -1 &&
            activities[meditationIndex].categoryId == 'hobbies') {
          activities[meditationIndex] = activities[meditationIndex].copyWith(
            categoryId: 'wellness',
          );
          hasChanges = true;
        }
      }

      if (hasChanges) {
        await saveActivities(activities);
      }

      await _preferences.setInt(_defaultsVersionKey, _currentDefaultsVersion);
    }

    return activities;
  }

  Future<void> saveActivities(List<LifeActivity> activities) async {
    final data = jsonEncode(
      activities.map((activity) => activity.toJson()).toList(),
    );
    await _preferences.setString(_storageKey, data);
  }

  Future<void> addActivity(LifeActivity activity) async {
    final activities = await loadActivities();

    if (activities.any((item) => item.id == activity.id)) {
      throw StateError('Activity ID already exists: ${activity.id}');
    }

    activities.add(activity);
    await saveActivities(activities);
  }

  Future<void> updateActivity(LifeActivity updatedActivity) async {
    final activities = await loadActivities();
    final index = activities.indexWhere(
      (item) => item.id == updatedActivity.id,
    );

    if (index == -1) {
      throw StateError('Activity not found: ${updatedActivity.id}');
    }

    activities[index] = updatedActivity;
    await saveActivities(activities);
  }

  Future<void> deactivateActivity(String activityId) async {
    final activities = await loadActivities();
    final index = activities.indexWhere((item) => item.id == activityId);

    if (index == -1) {
      throw StateError('Activity not found: $activityId');
    }

    activities[index] = activities[index].copyWith(isActive: false);
    await saveActivities(activities);
  }
}