import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/controllers/life_controller.dart';
import 'package:life_in_numbers/models/life_event.dart';
import 'package:life_in_numbers/services/life_event_storage.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'dart:async';


class FailingLifeEventStorage extends LifeEventStorage {
  @override
  Future<void> saveEvents(List<LifeEvent> events) async {
    throw StateError('Simulated storage failure');
  }
}

class DelayedLifeEventStorage extends LifeEventStorage {
  final Completer<void> saveCompleter = Completer<void>();

  @override
  Future<void> saveEvents(List<LifeEvent> events) async {
    await saveCompleter.future;
  }
}

void main() {
  late LifeController controller;
  late LifeEventStorage storage;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    storage = LifeEventStorage();
    controller = LifeController(storage: storage);
  });

  tearDown(() {
    controller.dispose();
  });

  test('Loads empty records on first launch', () async {
    await controller.loadEvents();

    expect(controller.events, isEmpty);
    expect(controller.records, isEmpty);
    expect(controller.isLoading, isFalse);
    expect(controller.error, isNull);
  });

  test('Adding an event updates records', () async {
    await controller.loadEvents();

    final event = controller.addEvent('coffee');
    await controller.waitForPendingSaves();

    expect(event.activityId, 'coffee');
    expect(controller.events.length, 1);
    expect(controller.records['coffee'], 1);
  });

  test('Events remain saved after creating a new controller', () async {
    await controller.loadEvents();
    controller.addEvent('gaming');
    await controller.waitForPendingSaves();

    final restoredController = LifeController(storage: LifeEventStorage());
    addTearDown(restoredController.dispose);
    await restoredController.loadEvents();

    expect(restoredController.events.length, 1);
    expect(restoredController.records['gaming'], 1);
  });

  test('Removing an event preserves other events', () async {
    await controller.loadEvents();

    final coffee = controller.addEvent('coffee');
    controller.addEvent('gaming');
    await controller.waitForPendingSaves();

    final removed = controller.removeEvent(coffee.id);
    await controller.waitForPendingSaves();

    expect(removed, isTrue);
    expect(controller.records['coffee'], isNull);
    expect(controller.records['gaming'], 1);

    final saved = await storage.loadEvents();
    expect(saved.length, 1);
    expect(saved.single.activityId, 'gaming');
  });

  test('Undo immediately after adding persists the removal', () async {
    await controller.loadEvents();

    final event = controller.addEvent('coffee');
    final removed = controller.removeEvent(event.id);
    await controller.waitForPendingSaves();

    expect(removed, isTrue);
    expect(controller.events, isEmpty);
    expect(await storage.loadEvents(), isEmpty);
  });

  test('Removing an unknown event does not change records', () async {
    await controller.loadEvents();

    final removed = controller.removeEvent('unknown');

    expect(removed, isFalse);
    expect(controller.events, isEmpty);
  });

  test('Loads and migrates legacy activity identifiers', () async {
    await storage.saveEvents([
      LifeEvent(
        id: 'legacy_1',
        activityId: 'Coffee',
        occurredAt: DateTime(2026, 10, 19),
      ),
    ]);

    await controller.loadEvents();

    expect(controller.events.single.activityId, 'coffee');
    expect(controller.records['coffee'], 1);

    final saved = await storage.loadEvents();
    expect(saved.single.activityId, 'coffee');
    expect(saved.single.id, 'legacy_1');
  });

  test('Notifies listeners when events change', () async {
    await controller.loadEvents();

    var notifications = 0;
    controller.addListener(() => notifications++);

    final event = controller.addEvent('coffee');
    controller.removeEvent(event.id);
    await controller.waitForPendingSaves();

    expect(notifications, 2);
  });

  test('Reload preserves an event with a pending save', () async {
    await controller.loadEvents();

    controller.addEvent('coffee');
    await controller.loadEvents();

    expect(controller.records['coffee'], 1);
    expect(controller.events.length, 1);

    final saved = await storage.loadEvents();
    expect(saved.single.activityId, 'coffee');
  });

  
  test('Reports a storage failure without crashing', () async {
    final failingController = LifeController(
      storage: FailingLifeEventStorage(),
    );
    addTearDown(failingController.dispose);

    await failingController.loadEvents();
    failingController.addEvent('coffee');
    await failingController.waitForPendingSaves();

    expect(failingController.saveError, isNotNull);
    expect(failingController.records['coffee'], 1);
  });

  test('Does not notify listeners after disposal', () async {
    final delayedStorage = DelayedLifeEventStorage();
    final delayedController = LifeController(storage: delayedStorage);

    await delayedController.loadEvents();

    var notifications = 0;
    delayedController.addListener(() => notifications++);

    delayedController.addEvent('coffee');
    final notificationsBeforeDispose = notifications;
    final pendingSave = delayedController.waitForPendingSaves();

    delayedController.dispose();
    delayedStorage.saveCompleter.complete();
    await pendingSave;

    expect(notifications, notificationsBeforeDispose);
  });
}
