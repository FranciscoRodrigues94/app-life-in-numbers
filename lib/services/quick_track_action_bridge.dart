import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../controllers/life_controller.dart';
import '../controllers/mood_controller.dart';

class QuickTrackActionBridge {
  static const MethodChannel _channel = MethodChannel(
    'com.lifeinnumbers.app/quick_track',
  );

  static Future<int> importPending({
    required LifeController lifeController,
    required MoodController moodController,
  }) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return 0;

    final pending = await _channel.invokeMethod<List<dynamic>>('getPendingActions') ?? [];
    var imported = 0;

    for (final raw in pending) {
      if (raw is! Map) continue;

      final id = raw['id'];
      final kind = raw['kind'];
      final targetId = raw['targetId'];
      final timestamp = raw['timestamp'];

      if (id is! String || targetId is! String || timestamp is! int) continue;
      if (id.isEmpty || targetId.isEmpty) continue;

      final occurredAt = DateTime.fromMillisecondsSinceEpoch(
        timestamp,
        isUtc: true,
      ).toLocal();

      if (kind == 'moment') {
        lifeController.addWidgetEvent(
          id: id,
          activityId: targetId,
          occurredAt: occurredAt,
        );
        await lifeController.waitForPendingSaves();
        if (lifeController.saveError != null) break;
      } else if (kind == 'feeling') {
        moodController.addWidgetFeeling(
          id: id,
          primaryEmotionId: targetId,
          occurredAt: occurredAt,
        );
        await moodController.waitForPendingSaves();
        if (moodController.saveError != null) break;
      } else {
        continue;
      }

      final acknowledged = await _channel.invokeMethod<bool>(
        'acknowledgeAction',
        {'id': id},
      );

      if (acknowledged != true) break;
      imported++;
    }

    return imported;
  }
}
