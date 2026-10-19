
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/life_activity.dart';
import '../models/default_activities.dart';

class ActivityRepository {
  static const String _storageKey = 'life_activities';
  final SharedPreferencesAsync _preferences;

  ActivityRepository({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  Future<List<LifeActivity>> loadActivities() async {
    final storedData = await _preferences.getString(_storageKey);

    if (storedData == null) {
      final defaults = List<LifeActivity>.of(DefaultActivities.all);
      await saveActivities(defaults);
      return defaults;
    }

    final decoded = jsonDecode(storedData) as List<dynamic>;
    return decoded
        .map((item) => LifeActivity.fromJson(item as Map<String, dynamic>))
        .toList();
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
    final index = activities.indexWhere((item) => item.id == updatedActivity.id);

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
