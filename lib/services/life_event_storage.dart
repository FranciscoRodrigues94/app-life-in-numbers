
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/life_event.dart';

class LifeEventStorage {
  static const String _storageKey = 'life_events';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<List<LifeEvent>> loadEvents() async {
    final storedData = await _preferences.getString(_storageKey);
    if (storedData == null) return [];

    final decodedData = jsonDecode(storedData) as List<dynamic>;
    return decodedData
        .map((item) => LifeEvent.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveEvents(List<LifeEvent> events) async {
    final encodedData = jsonEncode(
      events.map((event) => event.toJson()).toList(),
    );
    await _preferences.setString(_storageKey, encodedData);
  }
}
