import '../models/life_event.dart';

class DidYouKnowFact {
  final String id;
  final String activityId;
  final String title;
  final String message;
  final String sourceName;
  final String sourceUrl;

  const DidYouKnowFact({
    required this.id,
    required this.activityId,
    required this.title,
    required this.message,
    required this.sourceName,
    required this.sourceUrl,
  });
}

class DidYouKnowService {
  const DidYouKnowService();

  static const List<DidYouKnowFact> facts = [
    DidYouKnowFact(
      id: 'walking_01',
      activityId: 'walking',
      title: 'Every step counts',
      message:
          "You don't need a perfect workout to benefit from movement. "
          'The World Health Organization emphasizes that some physical '
          'activity is better than none, and walking is one way to be active.',
      sourceName: 'World Health Organization',
      sourceUrl: 'https://www.who.int/health-topics/noncommunicable-diseases/physical-activity',
    ),
    DidYouKnowFact(
      id: 'walking_02',
      activityId: 'walking',
      title: 'Small beginnings matter',
      message:
          'People who are inactive can begin with small amounts of physical '
          'activity and gradually increase their time and intensity. '
          'Consistency can start with something simple.',
      sourceName: 'World Health Organization',
      sourceUrl: 'https://www.who.int/health-topics/ageing/physical-activity',
    ),
    DidYouKnowFact(
      id: 'social_01',
      activityId: 'social',
      title: 'Connection matters',
      message:
          'Supportive social relationships are associated with better '
          'physical and mental health. Feeling connected is an important '
          'part of wellbeing.',
      sourceName: 'CDC',
      sourceUrl: 'https://www.cdc.gov/social-connectedness/about/',
    ),
    DidYouKnowFact(
      id: 'social_02',
      activityId: 'social',
      title: 'Little connections count',
      message:
          'Meaningful social connections do not always require big plans. '
          'Small gestures, such as checking in with someone, can help '
          'strengthen relationships.',
      sourceName: 'CDC',
      sourceUrl: 'https://www.cdc.gov/social-connectedness/improving/',
    ),
  ];

  List<DidYouKnowFact> factsForEvents(List<LifeEvent> events) {
    final trackedIds = events.map((event) => event.activityId).toSet();

    return facts.where((fact) => trackedIds.contains(fact.activityId)).toList();
  }

  DidYouKnowFact? factOfTheDay(List<LifeEvent> events, {DateTime? now}) {
    final availableFacts = factsForEvents(events);
    if (availableFacts.isEmpty) return null;

    final today = now ?? DateTime.now();
    final dayIndex = DateTime.utc(
      today.year,
      today.month,
      today.day,
    ).difference(DateTime.utc(2020, 1, 1)).inDays;

    return availableFacts[dayIndex % availableFacts.length];
  }
}
