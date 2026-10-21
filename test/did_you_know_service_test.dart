import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_numbers/models/life_event.dart';
import 'package:life_in_numbers/services/did_you_know_service.dart';

void main() {
  const service = DidYouKnowService();

  LifeEvent event(String id, String activityId) {
    return LifeEvent(
      id: id,
      activityId: activityId,
      occurredAt: DateTime(2026, 10, 20),
    );
  }

  test('Returns no fact without recorded activities', () {
    expect(service.factsForEvents([]), isEmpty);
    expect(service.factOfTheDay([]), isNull);
  });

  test('Only returns facts for recorded activities', () {
    final events = [event('1', 'walking')];
    final facts = service.factsForEvents(events);

    expect(facts, isNotEmpty);
    expect(facts.every((fact) => fact.activityId == 'walking'), isTrue);
  });

  test('Every available fact has a source', () {
    for (final fact in DidYouKnowService.facts) {
      expect(fact.title, isNotEmpty);
      expect(fact.message, isNotEmpty);
      expect(fact.sourceName, isNotEmpty);
      expect(Uri.parse(fact.sourceUrl).hasScheme, isTrue);
    }
  });

  test('Fact selection stays stable during the same day', () {
    final events = [event('1', 'walking'), event('2', 'social')];

    final morning = service.factOfTheDay(
      events,
      now: DateTime(2026, 10, 20, 8),
    );

    final evening = service.factOfTheDay(
      events,
      now: DateTime(2026, 10, 20, 21),
    );

    expect(morning?.id, evening?.id);
  });
}
