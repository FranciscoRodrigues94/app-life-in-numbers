
class LifeEvent {
  final String id;
  final String activityId;
  final DateTime occurredAt;
  final String source;
  final double value;

  const LifeEvent({
    required this.id,
    required this.activityId,
    required this.occurredAt,
    this.source = 'manual',
    this.value = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activityId': activityId,
      'occurredAt': occurredAt.toIso8601String(),
      'source': source,
      'value': value,
    };
  }

  factory LifeEvent.fromJson(Map<String, dynamic> json) {
    return LifeEvent(
      id: json['id'] as String,
      activityId: json['activityId'] as String,
      occurredAt: DateTime.parse(json['occurredAt'] as String),
      source: json['source'] as String? ?? 'manual',
      value: (json['value'] as num?)?.toDouble() ?? 1,
    );
  }
}
