import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/life_mood_entry.dart';

class MoodRepository {
  static const String _storageKey = 'life_mood_entries';

  final SharedPreferencesAsync _preferences;

  MoodRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  Future<List<LifeMoodEntry>> loadEntries() async {
    final storedData = await _preferences.getString(_storageKey);

    if (storedData == null) {
      return [];
    }

    final decoded = jsonDecode(storedData) as List<dynamic>;

    return decoded
        .map((item) => LifeMoodEntry.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveEntries(List<LifeMoodEntry> entries) async {
    final data = jsonEncode(entries.map((entry) => entry.toJson()).toList());

    await _preferences.setString(_storageKey, data);
  }
}
