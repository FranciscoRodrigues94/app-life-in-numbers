
import '../models/life_event.dart';

class ActivityMigrationService {
  static const Map<String, String> _legacyIds = {
    'Coffee': 'coffee',
    'Restaurant': 'restaurant',
    'Cinema': 'cinema',
    'Reading': 'reading',
    'Gaming': 'gaming',
    'Walking': 'walking',
    'Shopping': 'shopping',
    'Social': 'social',
  };

  const ActivityMigrationService();

  List<LifeEvent> migrateEvents(List<LifeEvent> events) {
    return events.map((event) {
      final newId = _legacyIds[event.activityId];
      if (newId == null) return event;

      return LifeEvent(
        id: event.id,
        activityId: newId,
        occurredAt: event.occurredAt,
        source: event.source,
        value: event.value,
      );
    }).toList();
  }

  bool needsMigration(List<LifeEvent> events) {
    return events.any((event) => _legacyIds.containsKey(event.activityId));
  }
}
