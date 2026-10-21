class LifeMoodEntry {
  final String id;
  final String primaryEmotionId;
  final String? secondaryEmotionId;
  final DateTime occurredAt;
  final String source;

  const LifeMoodEntry({
    required this.id,
    required this.primaryEmotionId,
    required this.occurredAt,
    this.secondaryEmotionId,
    this.source = 'manual',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'primaryEmotionId': primaryEmotionId,
      'secondaryEmotionId': secondaryEmotionId,
      'occurredAt': occurredAt.toIso8601String(),
      'source': source,
    };
  }

  factory LifeMoodEntry.fromJson(Map<String, dynamic> json) {
    return LifeMoodEntry(
      id: json['id'] as String,
      primaryEmotionId: json['primaryEmotionId'] as String,
      secondaryEmotionId: json['secondaryEmotionId'] as String?,
      occurredAt: DateTime.parse(json['occurredAt'] as String),
      source: json['source'] as String? ?? 'manual',
    );
  }
}
