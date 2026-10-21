import 'package:flutter/foundation.dart';

import '../models/default_emotions.dart';
import '../models/life_mood_entry.dart';
import '../services/mood_repository.dart';

class MoodController extends ChangeNotifier {
  final MoodRepository _repository;
  final List<LifeMoodEntry> _entries = [];
  Future<void> _saveQueue = Future<void>.value();
  bool _isLoading = false;
  bool _disposed = false;
  int _nextId = 0;
  String? _error;
  String? _saveError;

  MoodController({MoodRepository? repository})
    : _repository = repository ?? MoodRepository();

  List<LifeMoodEntry> get entries => List.unmodifiable(_entries);
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get saveError => _saveError;

  Map<String, int> get emotionCounts {
    final counts = <String, int>{};
    for (final entry in _entries) {
      counts[entry.primaryEmotionId] =
          (counts[entry.primaryEmotionId] ?? 0) + 1;
    }
    return counts;
  }

  void _notifyIfActive() {
    if (!_disposed) notifyListeners();
  }

  Future<void> loadEntries() async {
    if (_disposed) return;

    _isLoading = true;
    _error = null;
    _notifyIfActive();

    try {
      await _saveQueue;
      if (_disposed) return;

      final savedEntries = await _repository.loadEntries();
      if (_disposed) return;

      _entries
        ..clear()
        ..addAll(savedEntries);
    } catch (error) {
      if (!_disposed) {
        _error = 'Unable to load your saved feelings.';
      }
    } finally {
      if (!_disposed) {
        _isLoading = false;
        _notifyIfActive();
      }
    }
  }

  LifeMoodEntry addFeeling(String primaryEmotionId) {
    if (_disposed) throw StateError('MoodController is disposed.');

    if (_isLoading || _error != null) {
      throw StateError('Feelings are not ready to be recorded.');
    }

    if (!DefaultEmotions.isPrimaryEmotion(primaryEmotionId)) {
      throw ArgumentError.value(
        primaryEmotionId,
        'primaryEmotionId',
        'Unknown primary emotion.',
      );
    }

    final now = DateTime.now();
    final entry = LifeMoodEntry(
      id: '${now.microsecondsSinceEpoch}_${_nextId++}',
      primaryEmotionId: primaryEmotionId,
      occurredAt: now,
    );

    _entries.add(entry);
    _notifyIfActive();
    _queueSave();
    return entry;
  }

  bool removeFeeling(String entryId) {
    if (_disposed) throw StateError('MoodController is disposed.');

    if (_isLoading || _error != null) {
      throw StateError('Feelings are not ready to be modified.');
    }

    final index = _entries.indexWhere((entry) => entry.id == entryId);
    if (index == -1) return false;

    _entries.removeAt(index);
    _notifyIfActive();
    _queueSave();
    return true;
  }

  void _queueSave() {
    final snapshot = List<LifeMoodEntry>.of(_entries);

    _saveQueue = _saveQueue.then((_) async {
      try {
        await _repository.saveEntries(snapshot);
        if (_disposed) return;

        if (_saveError != null) {
          _saveError = null;
          _notifyIfActive();
        }
      } catch (error) {
        if (_disposed) return;

        _saveError = 'Could not save your feelings. Please try again.';
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
