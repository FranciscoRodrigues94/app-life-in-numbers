
import 'package:life_in_numbers/l10n/app_localizations.dart';
import 'package:life_in_numbers/l10n/app_localizations_en.dart';
import '../models/life_activity.dart';
import '../models/life_event.dart';
import 'display_name_service.dart';
import 'statistics_service.dart';

class LifeHighlight {
  final String title;
  final String message;

  const LifeHighlight({required this.title, required this.message});
}

class HighlightsService {
  final StatisticsService _statistics = const StatisticsService();

  List<LifeHighlight> getHighlights(
    List<LifeEvent> events,
    List<LifeActivity> activities, {
    AppLocalizations? l10n,
    DateTime? now,
  }) {
    final translations = l10n ?? AppLocalizationsEn();
    final today = now ?? DateTime.now();

    if (events.isEmpty) {
      return [
        LifeHighlight(
          title: translations.highlightStartTitle,
          message: translations.highlightStartMessage,
        ),
      ];
    }

    final results = <LifeHighlight>[];
    final activityNames = {
      for (final activity in activities)
        activity.id: DisplayNameService.activity(activity, translations),
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
            title: translations.highlightTopTitle,
            message: translations.highlightTopMessage(
              leaders.first,
              highestCount,
            ),
          ),
        );
      } else {
        results.add(
          LifeHighlight(
            title: translations.highlightTieTitle,
            message: leaders.length <= 3
                ? translations.highlightTieMessage(
                    leaders.join(', '),
                    highestCount,
                  )
                : translations.highlightMultipleTieMessage(
                    leaders.length,
                    highestCount,
                  ),
          ),
        );
      }

      if (monthlyCounts.length >= 2) {
        results.add(
          LifeHighlight(
            title: translations.highlightVarietyTitle,
            message: translations.highlightVarietyMessage(
              monthlyCounts.length,
              monthEvents.length,
            ),
          ),
        );
      }
    }

    if (events.length >= 5) {
      final weekdayCounts = _statistics.eventsByWeekday(events);

      if (weekdayCounts.isNotEmpty) {
        final highestCount = weekdayCounts.values.reduce(
          (a, b) => a > b ? a : b,
        );
        final leadingDays = weekdayCounts.entries
            .where((entry) => entry.value == highestCount)
            .toList();

        if (leadingDays.length == 1 && highestCount >= 2) {
          final weekdays = [
            translations.weekdayMonday,
            translations.weekdayTuesday,
            translations.weekdayWednesday,
            translations.weekdayThursday,
            translations.weekdayFriday,
            translations.weekdaySaturday,
            translations.weekdaySunday,
          ];

          final dayName = weekdays[leadingDays.first.key - 1];

          results.add(
            LifeHighlight(
              title: translations.highlightWeekdayTitle,
              message: translations.highlightWeekdayMessage(
                dayName,
                highestCount,
              ),
            ),
          );
        }
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
            title: translations.highlightMoreTitle,
            message: translations.highlightMoreMessage(
              currentCount,
              previousCount,
            ),
          ),
        );
      } else if (currentCount < previousCount) {
        results.add(
          LifeHighlight(
            title: translations.highlightRecentTitle,
            message: translations.highlightRecentMessage(
              currentCount,
              previousCount,
            ),
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
          title: translations.highlightMilestoneTitle,
          message: translations.highlightMilestoneMessage(milestone),
        ),
      );
    }

    if (results.isEmpty) {
      results.add(
        LifeHighlight(
          title: translations.highlightGrowingTitle,
          message: translations.highlightGrowingMessage(events.length),
        ),
      );
    }

    return results;
  }

  LifeHighlight highlightOfTheDay(
    List<LifeEvent> events,
    List<LifeActivity> activities, {
    AppLocalizations? l10n,
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    final highlights = getHighlights(
      events,
      activities,
      l10n: l10n,
      now: today,
    );

    final dayIndex = DateTime.utc(
      today.year,
      today.month,
      today.day,
    ).difference(DateTime.utc(2020, 1, 1)).inDays;

    return highlights[dayIndex % highlights.length];
  }
}
