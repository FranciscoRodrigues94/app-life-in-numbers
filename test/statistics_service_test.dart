
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_event.dart';
import 'package:life_in_numbers/services/statistics_service.dart';

void main() {
  const statistics = StatisticsService();

  final events = [
    LifeEvent(id: '1', activityId: 'Coffee', occurredAt: DateTime(2026, 10, 17, 9)),
    LifeEvent(id: '2', activityId: 'Coffee', occurredAt: DateTime(2026, 10, 18, 11)),
    LifeEvent(id: '3', activityId: 'Coffee', occurredAt: DateTime(2026, 10, 19, 8)),
    LifeEvent(id: '4', activityId: 'Cinema', occurredAt: DateTime(2026, 10, 19, 18)),
  ];

  test('Counts all events correctly', () {
    expect(statistics.totalEvents(events), 4);
    expect(statistics.totalByActivity(events, 'Coffee'), 3);
  });

  test('Counts events for a specific day', () {
    expect(statistics.totalToday(events, now: DateTime(2026, 10, 19)), 2);
    expect(statistics.totalToday(events, activityId: 'Coffee', now: DateTime(2026, 10, 19)), 1);
  });

  test('Calculates a seven-day average', () {
    final average = statistics.averageLastDays(events, 7, activityId: 'Coffee', now: DateTime(2026, 10, 19));
    expect(average, closeTo(3 / 7, 0.0001));
  });

  test('Identifies the most frequent activity', () {
    expect(statistics.mostFrequentActivity(events), 'Coffee');
  });

  test('Calculates percentage change', () {
    expect(statistics.percentageChange(10, 15), 50);
    expect(statistics.percentageChange(10, 5), -50);
    expect(statistics.percentageChange(0, 0), 0);
  });

  test('Handles comparison without previous records', () {
    expect(statistics.percentageChange(0, 5).isNaN, isTrue);
  });
}
