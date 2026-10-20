import '../models/life_event.dart';

class StatisticsService {
  const StatisticsService();

  int totalEvents(List<LifeEvent> events) {
    return events.length;
  }

  int totalByActivity(List<LifeEvent> events, String activityId) {
    return events.where((event) => event.activityId == activityId).length;
  }

  int totalToday(List<LifeEvent> events, {String? activityId, DateTime? now}) {
    final today = now ?? DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = DateTime(today.year, today.month, today.day + 1);
    return totalBetween(events, start, end, activityId: activityId);
  }

  int totalThisMonth(
    List<LifeEvent> events, {
    String? activityId,
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    final start = DateTime(today.year, today.month);
    final end = DateTime(today.year, today.month + 1);
    return totalBetween(events, start, end, activityId: activityId);
  }

  int totalBetween(
    List<LifeEvent> events,
    DateTime start,
    DateTime end, {
    String? activityId,
  }) {
    if (!end.isAfter(start)) return 0;
    return events.where((event) {
      final matchesDate =
          !event.occurredAt.isBefore(start) && event.occurredAt.isBefore(end);
      final matchesActivity =
          activityId == null || event.activityId == activityId;
      return matchesDate && matchesActivity;
    }).length;
  }

  double dailyAverage(
    List<LifeEvent> events,
    DateTime start,
    DateTime end, {
    String? activityId,
  }) {
    if (!end.isAfter(start)) return 0;
    final days = end.difference(start).inHours / 24;
    if (days <= 0) return 0;
    return totalBetween(events, start, end, activityId: activityId) / days;
  }

  double averageLastDays(
    List<LifeEvent> events,
    int days, {
    String? activityId,
    DateTime? now,
  }) {
    if (days <= 0) return 0;
    final today = now ?? DateTime.now();
    final end = DateTime(today.year, today.month, today.day + 1);
    final start = DateTime(today.year, today.month, today.day - days + 1);
    return totalBetween(events, start, end, activityId: activityId) / days;
  }

  Map<int, int> eventsByWeekday(List<LifeEvent> events, {String? activityId}) {
    final results = {for (var day = 1; day <= 7; day++) day: 0};
    for (final event in events) {
      if (activityId != null && event.activityId != activityId) continue;
      results[event.occurredAt.weekday] =
          results[event.occurredAt.weekday]! + 1;
    }
    return results;
  }

  Map<String, int> eventsByActivity(List<LifeEvent> events) {
    final results = <String, int>{};
    for (final event in events) {
      results[event.activityId] = (results[event.activityId] ?? 0) + 1;
    }
    return results;
  }

  String? mostFrequentActivity(List<LifeEvent> events) {
    final counts = eventsByActivity(events);
    if (counts.isEmpty) return null;
    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  double percentageChange(int previous, int current) {
    if (previous == 0) return current == 0 ? 0 : double.nan;
    return ((current - previous) / previous) * 100;
  }

  double? weekOverWeekChange(
    List<LifeEvent> events, {
    String? activityId,
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final currentStart = DateTime(
      startOfToday.year,
      startOfToday.month,
      startOfToday.day - 6,
    );
    final currentEnd = DateTime(
      startOfToday.year,
      startOfToday.month,
      startOfToday.day + 1,
    );
    final previousStart = DateTime(
      startOfToday.year,
      startOfToday.month,
      startOfToday.day - 13,
    );
    final current = totalBetween(
      events,
      currentStart,
      currentEnd,
      activityId: activityId,
    );
    final previous = totalBetween(
      events,
      previousStart,
      currentStart,
      activityId: activityId,
    );
    if (previous == 0) return current == 0 ? 0 : null;
    return percentageChange(previous, current);
  }

  List<({DateTime date, int count})> eventsPerDay(
    List<LifeEvent> events,
    int days, {
    String? activityId,
    DateTime? now,
  }) {
    if (days <= 0) return [];

    final reference = now ?? DateTime.now();
    final results = <({DateTime date, int count})>[];

    for (var i = days - 1; i >= 0; i--) {
      final start = DateTime(
        reference.year,
        reference.month,
        reference.day - i,
      );
      final end = DateTime(start.year, start.month, start.day + 1);

      results.add((
        date: start,
        count: totalBetween(events, start, end, activityId: activityId),
      ));
    }

    return results;
  }

  List<({DateTime date, int count})> eventsPerMonth(
    List<LifeEvent> events,
    int months, {
    String? activityId,
    DateTime? now,
  }) {
    if (months <= 0) return [];

    final reference = now ?? DateTime.now();
    final results = <({DateTime date, int count})>[];

    for (var i = months - 1; i >= 0; i--) {
      final start = DateTime(reference.year, reference.month - i);
      final end = DateTime(start.year, start.month + 1);

      results.add((
        date: start,
        count: totalBetween(events, start, end, activityId: activityId),
      ));
    }

    return results;
  }
}
