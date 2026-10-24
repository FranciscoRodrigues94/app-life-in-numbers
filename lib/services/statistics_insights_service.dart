import '../models/default_emotions.dart';
import '../models/life_activity.dart';
import '../models/life_event.dart';
import '../models/life_mood_entry.dart';

class StatisticsInsight {
  final String title;
  final String message;
  final String label;

  const StatisticsInsight({required this.title, required this.message, required this.label});
}

class StatisticsInsightsService {
  const StatisticsInsightsService();

  List<StatisticsInsight> generate({
    required List<LifeEvent> events,
    required List<LifeMoodEntry> feelings,
    required List<LifeActivity> activities,
  }) {
    if (events.isEmpty || feelings.isEmpty) return const [];

    final activityNames = {for (final activity in activities) activity.id: activity.name};
    final emotionNames = {for (final emotion in DefaultEmotions.primary) emotion.id: emotion.name};
    final momentsByDay = <DateTime, Set<String>>{};
    final feelingsByDay = <DateTime, Set<String>>{};

    DateTime dayOf(DateTime date) {
      final local = date.toLocal();
      return DateTime(local.year, local.month, local.day);
    }

    for (final event in events) {
      momentsByDay.putIfAbsent(dayOf(event.occurredAt), () => <String>{}).add(event.activityId);
    }
    for (final feeling in feelings) {
      feelingsByDay.putIfAbsent(dayOf(feeling.occurredAt), () => <String>{}).add(feeling.primaryEmotionId);
    }

    final sharedDays = momentsByDay.keys.where(feelingsByDay.containsKey).toList();
    if (sharedDays.length < 3) return const [];

    final insights = <StatisticsInsight>[];
    final pairCounts = <(String, String), int>{};
    for (final day in sharedDays) {
      for (final activityId in momentsByDay[day]!) {
        for (final emotionId in feelingsByDay[day]!) {
          final key = (activityId, emotionId);
          pairCounts[key] = (pairCounts[key] ?? 0) + 1;
        }
      }
    }

    final pairs = pairCounts.entries.where((entry) => entry.value >= 3).toList()
      ..sort((a, b) {
        final byCount = b.value.compareTo(a.value);
        if (byCount != 0) return byCount;
        return '${a.key.$1}:${a.key.$2}'.compareTo('${b.key.$1}:${b.key.$2}');
      });

    if (pairs.isNotEmpty) {
      final best = pairs.first;
      final activity = activityNames[best.key.$1] ?? best.key.$1;
      final emotion = emotionNames[best.key.$2] ?? best.key.$2;
      insights.add(StatisticsInsight(
        label: 'SAME-DAY PATTERN',
        title: '$activity & $emotion',
        message: 'You logged $activity and $emotion on ${best.value} different days. These entries were made on the same dates, not necessarily at the same time.',
      ));
    }

    // Compare an emotion's presence on days with and without a particular activity.
    // Only compare dates on which a feeling was actually logged; otherwise missing
    // mood data could be mistaken for absence of the emotion.
    final observedDays = feelingsByDay.keys.toList();
    ({String activityId, String emotionId, int withCount, int withTotal, int withoutCount, int withoutTotal, double gap})? bestDifference;
    final activityIds = momentsByDay.values.expand((ids) => ids).toSet();
    final emotionIds = feelingsByDay.values.expand((ids) => ids).toSet();
    for (final activityId in activityIds) {
      final withActivity = observedDays.where((day) => momentsByDay[day]?.contains(activityId) ?? false).toList();
      final withoutActivity = observedDays.where((day) => !(momentsByDay[day]?.contains(activityId) ?? false)).toList();
      if (withActivity.length < 5 || withoutActivity.length < 5) continue;
      for (final emotionId in emotionIds) {
        final withEmotion = withActivity.where((day) => feelingsByDay[day]!.contains(emotionId)).length;
        final withoutEmotion = withoutActivity.where((day) => feelingsByDay[day]!.contains(emotionId)).length;
        if (withEmotion < 3) continue;
        final gap = withEmotion / withActivity.length - withoutEmotion / withoutActivity.length;
        if (gap < 0.20) continue;
        if (bestDifference == null || gap > bestDifference.gap) {
          bestDifference = (
            activityId: activityId, emotionId: emotionId,
            withCount: withEmotion, withTotal: withActivity.length,
            withoutCount: withoutEmotion, withoutTotal: withoutActivity.length,
            gap: gap,
          );
        }
      }
    }
    if (bestDifference != null) {
      final item = bestDifference;
      final activity = activityNames[item.activityId] ?? item.activityId;
      final emotion = emotionNames[item.emotionId] ?? item.emotionId;
      insights.add(StatisticsInsight(
        label: 'POSSIBLE ASSOCIATION',
        title: '$emotion on $activity days',
        message: 'Among days with a mood check-in, you logged $emotion on ${item.withCount} of ${item.withTotal} days with $activity, versus ${item.withoutCount} of ${item.withoutTotal} days without it. This is an observation, not evidence that $activity caused the feeling.',
      ));
    }

    // Show the most common weekday for dates that have both kinds of records.
    final weekdayCounts = List<int>.filled(7, 0);
    for (final day in sharedDays) {
      weekdayCounts[day.weekday - 1]++;
    }
    final maxCount = weekdayCounts.reduce((a, b) => a > b ? a : b);
    final winners = [for (var index = 0; index < 7; index++) if (weekdayCounts[index] == maxCount) index];
    if (maxCount >= 3 && winners.length == 1) {
      const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      insights.add(StatisticsInsight(
        label: 'CHECK-IN RHYTHM',
        title: '${weekdays[winners.first]} stands out',
        message: 'You logged both a moment and a feeling on $maxCount different ${weekdays[winners.first]}s. This reflects your logging habits, not necessarily your entire routine.',
      ));
    }

    return insights.take(3).toList();
  }
}
