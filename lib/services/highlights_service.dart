
import '../models/life_activity.dart';
import '../models/life_event.dart';
import 'statistics_service.dart';

class LifeHighlight {
  final String title;
  final String message;

  const LifeHighlight({
    required this.title,
    required this.message,
  });
}

class HighlightsService {
  final StatisticsService _statistics = const StatisticsService();

  List<LifeHighlight> getHighlights(
    List<LifeEvent> events,
    List<LifeActivity> activities, {
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();

    if (events.isEmpty) {
      return [
        const LifeHighlight(
          title: 'Your story starts here',
          message: 'Record your first moment to start discovering your patterns.',
        ),
      ];
    }

    final results = <LifeHighlight>[];
    final activityNames = {
      for (final activity in activities) activity.id: activity.name,
    };

    final monthStart = DateTime(today.year, today.month);
    final nextMonth = DateTime(today.year, today.month + 1);
    final monthEvents = events.where((event) {
      return !event.occurredAt.isBefore(monthStart) &&
          event.occurredAt.isBefore(nextMonth);
    }).toList();

    final monthlyCounts = _statistics.eventsByActivity(monthEvents);

    if (monthlyCounts.isNotEmpty) {
      final highestCount = monthlyCounts.values.reduce(
        (a, b) => a > b ? a : b,
      );

      final leaders = monthlyCounts.entries
          .where((entry) => entry.value == highestCount)
          .map((entry) => activityNames[entry.key] ?? entry.key)
          .toList();

      if (leaders.length == 1) {
        results.add(
          LifeHighlight(
            title: 'Your top activity',
            message: '${leaders.first} leads your recorded moments this month, with $highestCount ${highestCount == 1 ? 'record' : 'records'}.',
          ),
        );
      } else {
        results.add(
          LifeHighlight(
            title: 'A shared first place',
            message: leaders.length <= 3
                ? '${leaders.join(', ')} are tied this month, with $highestCount ${highestCount == 1 ? 'record' : 'records'} each.'
                : '${leaders.length} activities share first place this month, with $highestCount records each.',
          ),
        );
      }

      if (monthlyCounts.length >= 2) {
        results.add(
          LifeHighlight(
            title: 'A little variety',
            message: "You've recorded ${monthlyCounts.length} different activities this month, across ${monthEvents.length} moments.",
          ),
        );
      }
    }

    if (events.length >= 5) {
      final weekdayCounts = _statistics.eventsByWeekday(events);
      final highestCount = weekdayCounts.values.reduce(
        (a, b) => a > b ? a : b,
      );
      final leadingDays = weekdayCounts.entries
          .where((entry) => entry.value == highestCount)
          .toList();

      if (leadingDays.length == 1 && highestCount >= 2) {
        const weekdays = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ];
        final dayName = weekdays[leadingDays.first.key - 1];
        results.add(
          LifeHighlight(
            title: 'Your most recorded day',
            message: "$dayName leads your recorded moments so far, with $highestCount ${highestCount == 1 ? 'record' : 'records'}.",
          ),
        );
      }
    }

    final currentStart = DateTime(today.year, today.month, today.day - 6);
    final currentEnd = DateTime(today.year, today.month, today.day + 1);
    final previousStart = DateTime(today.year, today.month, today.day - 13);

    final currentCount = _statistics.totalBetween(
      events,
      currentStart,
      currentEnd,
    );
    final previousCount = _statistics.totalBetween(
      events,
      previousStart,
      currentStart,
    );

    if (currentCount > 0 && previousCount > 0) {
      if (currentCount > previousCount) {
        results.add(
          LifeHighlight(
            title: 'More moments recorded',
            message: "You've logged $currentCount moments in the last 7 days, compared with $previousCount in the 7 days before that.",
          ),
        );
      } else if (currentCount < previousCount) {
        results.add(
          LifeHighlight(
            title: 'Your recent activity',
            message: "You've logged $currentCount moments in the last 7 days, compared with $previousCount in the previous 7 days.",
          ),
        );
      }
    }

    const milestones = [10, 25, 50, 100, 250, 500, 1000];
    final reachedMilestones = milestones
        .where((milestone) => events.length >= milestone)
        .toList();

    if (reachedMilestones.isNotEmpty) {
      final milestone = reachedMilestones.last;
      results.add(
        LifeHighlight(
          title: 'A personal milestone',
          message: "You've passed $milestone recorded moments. Your personal history is growing, one moment at a time.",
        ),
      );
    }

    if (results.isEmpty) {
      results.add(
        LifeHighlight(
          title: 'Your story is growing',
          message: "You've recorded ${events.length} ${events.length == 1 ? 'moment' : 'moments'} so far. Keep building your personal timeline.",
        ),
      );
    }

    return results;
  }

  LifeHighlight highlightOfTheDay(
    List<LifeEvent> events,
    List<LifeActivity> activities, {
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    final highlights = getHighlights(events, activities, now: today);
    final dayIndex = DateTime.utc(
      today.year,
      today.month,
      today.day,
    ).difference(DateTime.utc(2020, 1, 1)).inDays;

    return highlights[dayIndex % highlights.length];
  }
}
