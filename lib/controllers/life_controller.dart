import 'package:flutter/foundation.dart';
import '../models/life_event.dart';
import '../services/activity_migration_service.dart';
import '../services/life_event_storage.dart';

class LifeController extends ChangeNotifier {
  final LifeEventStorage _storage;
  final List<LifeEvent> _events = [];
  Future<void> _saveQueue = Future<void>.value();
  bool _isLoading = false;
  bool _disposed = false;
  String? _error;
  String? _saveError;

  LifeController({LifeEventStorage? storage})
      : _storage = storage ?? LifeEventStorage();

  List<LifeEvent> get events => List.unmodifiable(_events);
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get saveError => _saveError;

  Map<String, int> get records {
    final counts = <String, int>{};
    for (final event in _events) {
      counts[event.activityId] = (counts[event.activityId] ?? 0) + 1;
    }
    return counts;
  }

  void _notifyIfActive() {
    if (!_disposed) notifyListeners();
  }

  Future<void> loadEvents() async {
    if (_disposed) return;
    _isLoading = true;
    _error = null;
    _notifyIfActive();

    try {
      await _saveQueue;
      if (_disposed) return;

      final savedEvents = await _storage.loadEvents();
      if (_disposed) return;

      const migration = ActivityMigrationService();
      final needsMigration = migration.needsMigration(savedEvents);
      final loadedEvents = needsMigration
          ? migration.migrateEvents(savedEvents)
          : savedEvents;

      if (needsMigration) {
        await _storage.saveEvents(loadedEvents);
        if (_disposed) return;
      }

      _events
        ..clear()
        ..addAll(loadedEvents);
    } catch (error) {
      if (!_disposed) {
        _error = 'Unable to load your saved records.';
      }
    } finally {
      if (!_disposed) {
        _isLoading = false;
        _notifyIfActive();
      }
    }
  }

  LifeEvent addEvent(String activityId) {
    if (_disposed) throw StateError('LifeController is disposed.');

    final now = DateTime.now();
    final event = LifeEvent(
      id: '${now.microsecondsSinceEpoch}_${_events.length}',
      activityId: activityId,
      occurredAt: now,
    );

    _events.add(event);
    _notifyIfActive();
    _queueSave();
    return event;
  }

  bool addWidgetEvent({
    required String id,
    required String activityId,
    required DateTime occurredAt,
  }) {
    if (_disposed) throw StateError('LifeController is disposed.');
    if (_isLoading || _error != null) {
      throw StateError('Moments are not ready to be recorded.');
    }
    if (_events.any((event) => event.id == id)) return false;

    _events.add(LifeEvent(
      id: id,
      activityId: activityId,
      occurredAt: occurredAt,
    ));
    _notifyIfActive();
    _queueSave();
    return true;
  }

  bool removeEvent(String eventId) {
    if (_disposed) throw StateError('LifeController is disposed.');

    final index = _events.indexWhere((event) => event.id == eventId);
    if (index == -1) return false;

    _events.removeAt(index);
    _notifyIfActive();
    _queueSave();
    return true;
  }

  void _queueSave() {
    final snapshot = List<LifeEvent>.of(_events);

    _saveQueue = _saveQueue.then((_) async {
      try {
        await _storage.saveEvents(snapshot);
        if (_disposed) return;

        if (_saveError != null) {
          _saveError = null;
          _notifyIfActive();
        }
      } catch (error) {
        if (_disposed) return;
        _saveError = 'Could not save your records. Please try again.';
        _notifyIfActive();
      }
    });
  }

  Future<void> waitForPendingSaves() => _saveQueue;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
