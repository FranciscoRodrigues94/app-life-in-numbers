
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_event.dart';
import 'package:life_in_numbers/services/activity_migration_service.dart';

void main() {
  const migration = ActivityMigrationService();

  test('Migrates legacy activity IDs', () {
    final events = [
      LifeEvent(id: '1', activityId: 'Coffee', occurredAt: DateTime(2026, 10, 19)),
      LifeEvent(id: '2', activityId: 'Cinema', occurredAt: DateTime(2026, 10, 19)),
    ];

    final migrated = migration.migrateEvents(events);

    expect(migrated[0].activityId, 'coffee');
    expect(migrated[1].activityId, 'cinema');
    expect(migrated[0].id, '1');
    expect(migrated[0].occurredAt, events[0].occurredAt);
  });

  test('Preserves custom activity IDs', () {
    final events = [
      LifeEvent(id: '1', activityId: 'gym', occurredAt: DateTime(2026, 10, 19)),
    ];

    final migrated = migration.migrateEvents(events);

    expect(migrated[0].activityId, 'gym');
    expect(migration.needsMigration(migrated), isFalse);
  });

  test('Migration is idempotent', () {
    final events = [
      LifeEvent(id: '1', activityId: 'Coffee', occurredAt: DateTime(2026, 10, 19)),
    ];

    final first = migration.migrateEvents(events);
    final second = migration.migrateEvents(first);

    expect(second[0].activityId, first[0].activityId);
    expect(migration.needsMigration(second), isFalse);
  });

  test('Preserves event values and sources', () {
    final events = [
      LifeEvent(id: '1', activityId: 'Walking', occurredAt: DateTime(2026, 10, 19), source: 'manual', value: 2.5),
    ];

    final migrated = migration.migrateEvents(events);

    expect(migrated[0].value, 2.5);
    expect(migrated[0].source, 'manual');
  });
}
