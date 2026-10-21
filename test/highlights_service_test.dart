
import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_event.dart';
import 'package:life_in_numbers/services/highlights_service.dart';

void main() {
  final service = HighlightsService();
  final now = DateTime(2026, 10, 20, 12);

  LifeEvent event(String id, String activityId, DateTime date) {
    return LifeEvent(
      id: id,
      activityId: activityId,
      occurredAt: date,
    );
  }

  test('Shows a starting message when there are no events', () {
    final highlights = service.getHighlights([], [], now: now);

    expect(highlights, hasLength(1));
    expect(highlights.first.title, 'Your story starts here');
  });

  test('Recognizes a tie instead of inventing a winner', () {
    final events = [
      event('1', 'restaurant', DateTime(2026, 10, 18)),
      event('2', 'restaurant', DateTime(2026, 10, 19)),
      event('3', 'cinema', DateTime(2026, 10, 18)),
      event('4', 'cinema', DateTime(2026, 10, 19)),
      event('5', 'walking', DateTime(2026, 10, 18)),
      event('6', 'walking', DateTime(2026, 10, 19)),
    ];

    final highlights = service.getHighlights(events, [], now: now);
    final top = highlights.firstWhere(
      (highlight) => highlight.title == 'A shared first place',
    );

    expect(top.message, contains('restaurant'));
    expect(top.message, contains('cinema'));
    expect(top.message, contains('walking'));
    expect(top.message, contains('2 records each'));
  });

  test('Recognizes activity variety', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 10, 18)),
      event('2', 'walking', DateTime(2026, 10, 19)),
    ];

    final highlights = service.getHighlights(events, [], now: now);

    expect(
      highlights.any((highlight) => highlight.title == 'A little variety'),
      isTrue,
    );
  });

  test('Does not invent a weekly trend without previous data', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 10, 20)),
    ];

    final highlights = service.getHighlights(events, [], now: now);

    expect(
      highlights.any((highlight) =>
          highlight.title == 'More moments recorded'),
      isFalse,
    );
  });

  test('Highlights a milestone after 10 records', () {
    final events = List.generate(
      10,
      (index) => event(
        '$index',
        'coffee',
        DateTime(2026, 10, 20),
      ),
    );

    final highlights = service.getHighlights(events, [], now: now);

    expect(
      highlights.any(
        (highlight) => highlight.title == 'A personal milestone',
      ),
      isTrue,
    );
  });

  test('Keeps the daily highlight stable on the same day', () {
    final events = [
      event('1', 'coffee', DateTime(2026, 10, 18)),
      event('2', 'walking', DateTime(2026, 10, 19)),
    ];

    final morning = service.highlightOfTheDay(
      events,
      [],
      now: DateTime(2026, 10, 20, 8),
    );
    final evening = service.highlightOfTheDay(
      events,
      [],
      now: DateTime(2026, 10, 20, 21),
    );

    expect(morning.title, evening.title);
    expect(morning.message, evening.message);
  });
}
