import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_event.dart';
import 'package:life_in_numbers/services/statistics_service.dart';

void main() {
  const statistics = StatisticsService();
  final reference = DateTime(2026, 10, 19, 15);

  LifeEvent event(String id, String activityId, DateTime date) {
    return LifeEvent(id: id, activityId: activityId, occurredAt: date);
  }

  test('Returns seven consecutive days including empty days', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 10, 19, 9)),
      event('2', 'coffee', DateTime(2026, 10, 19, 14)),
      event('3', 'gaming', DateTime(2026, 10, 17, 20)),
    ];

    final result = statistics.eventsPerDay(events, 7, now: reference);

    expect(result.length, 7);
    expect(result.first.date, DateTime(2026, 10, 13));
    expect(result.last.date, DateTime(2026, 10, 19));
    expect(result.last.count, 2);
    expect(result[4].count, 1);
    expect(result[1].count, 0);
  });

  test('Daily timeline filters by activity', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 10, 19, 9)),
      event('2', 'gaming', DateTime(2026, 10, 19, 10)),
    ];

    final result = statistics.eventsPerDay(
      events,
      7,
      activityId: 'coffee',
      now: reference,
    );

    expect(result.last.count, 1);
    expect(result.fold<int>(0, (sum, day) => sum + day.count), 1);
  });

  test('Returns twelve months including empty months', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 10, 4)),
      event('2', 'cinema', DateTime(2026, 1, 12)),
    ];

    final result = statistics.eventsPerMonth(events, 12, now: reference);

    expect(result.length, 12);
    expect(result.first.date, DateTime(2025, 11));
    expect(result.last.date, DateTime(2026, 10));
    expect(result.last.count, 1);
    expect(result[2].count, 1);
    expect(result[0].count, 0);
  });

  test('Monthly timeline filters by activity', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 10, 4)),
      event('2', 'cinema', DateTime(2026, 10, 5)),
    ];

    final result = statistics.eventsPerMonth(
      events,
      12,
      activityId: 'cinema',
      now: reference,
    );

    expect(result.last.count, 1);
  });

  test('Invalid period lengths return empty lists', () {
    expect(statistics.eventsPerDay([], 0), isEmpty);
    expect(statistics.eventsPerMonth([], -1), isEmpty);
  });

  test('Daily timeline handles month boundaries', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 9, 30, 23, 59)),
      event('2', 'coffee', DateTime(2026, 10, 1, 0, 1)),
    ];

    final result = statistics.eventsPerDay(
      events,
      2,
      now: DateTime(2026, 10, 1),
    );

    expect(result[0].date, DateTime(2026, 9, 30));
    expect(result[0].count, 1);
    expect(result[1].date, DateTime(2026, 10, 1));
    expect(result[1].count, 1);
  });
}
