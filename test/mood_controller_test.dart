import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/controllers/mood_controller.dart';
import 'package:life_in_numbers/models/life_mood_entry.dart';
import 'package:life_in_numbers/services/mood_repository.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

class FakeMoodRepository extends MoodRepository {
  List<LifeMoodEntry> savedEntries = [];

  @override
  Future<List<LifeMoodEntry>> loadEntries() async {
    return List<LifeMoodEntry>.of(savedEntries);
  }

  @override
  Future<void> saveEntries(List<LifeMoodEntry> entries) async {
    savedEntries = List<LifeMoodEntry>.of(entries);
  }
}

void main() {
  late FakeMoodRepository repository;
  late MoodController controller;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();

    repository = FakeMoodRepository();
    controller = MoodController(repository: repository);
  });

  tearDown(() {
    controller.dispose();
  });

  test('Starts with no saved feelings', () async {
    await controller.loadEntries();

    expect(controller.entries, isEmpty);
    expect(controller.emotionCounts, isEmpty);
    expect(controller.error, isNull);
  });

  test('Adds and saves a primary emotion', () async {
    await controller.loadEntries();

    final entry = controller.addFeeling('happiness');
    await controller.waitForPendingSaves();

    expect(controller.entries.length, 1);
    expect(entry.primaryEmotionId, 'happiness');
    expect(entry.secondaryEmotionId, isNull);
    expect(repository.savedEntries.length, 1);
    expect(repository.savedEntries.first.id, entry.id);
  });

  test('Counts feelings by primary emotion', () async {
    await controller.loadEntries();

    controller.addFeeling('happiness');
    controller.addFeeling('happiness');
    controller.addFeeling('sadness');

    await controller.waitForPendingSaves();

    expect(controller.emotionCounts['happiness'], 2);
    expect(controller.emotionCounts['sadness'], 1);
    expect(controller.entries.length, 3);
  });

  test('Loads previously saved feelings', () async {
    await controller.loadEntries();

    controller.addFeeling('fear');
    await controller.waitForPendingSaves();

    final restoredController = MoodController(repository: repository);

    try {
      await restoredController.loadEntries();

      expect(restoredController.entries.length, 1);
      expect(restoredController.entries.first.primaryEmotionId, 'fear');
    } finally {
      restoredController.dispose();
    }
  });

  test('Removes a specific feeling without deleting others', () async {
    await controller.loadEntries();

    final first = controller.addFeeling('happiness');
    final second = controller.addFeeling('anger');

    await controller.waitForPendingSaves();

    final removed = controller.removeFeeling(first.id);
    await controller.waitForPendingSaves();

    expect(removed, isTrue);
    expect(controller.entries.length, 1);
    expect(controller.entries.first.id, second.id);
    expect(repository.savedEntries.length, 1);
    expect(repository.savedEntries.first.id, second.id);
  });

  test('Rejects an unknown primary emotion', () async {
    await controller.loadEntries();

    expect(() => controller.addFeeling('unknown_emotion'), throwsArgumentError);

    expect(controller.entries, isEmpty);
  });

  test('Removing a nonexistent feeling does not change records', () async {
    await controller.loadEntries();

    final removed = controller.removeFeeling('missing_id');

    expect(removed, isFalse);
    expect(controller.entries, isEmpty);
  });
}
