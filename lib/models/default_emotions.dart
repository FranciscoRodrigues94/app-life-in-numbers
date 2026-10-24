class LifeEmotion {
  final String id;
  final String name;
  final String iconName;

  const LifeEmotion({
    required this.id,
    required this.name,
    required this.iconName,
  });
}

class DefaultEmotions {
  static const List<LifeEmotion> primary = [
    LifeEmotion(id: 'happiness', name: 'Happiness', iconName: 'sun'),
    LifeEmotion(id: 'sadness', name: 'Sadness', iconName: 'cloud'),
    LifeEmotion(id: 'anger', name: 'Anger', iconName: 'flame'),
    LifeEmotion(id: 'fear', name: 'Fear', iconName: 'shield'),
    LifeEmotion(id: 'disgust', name: 'Disgust', iconName: 'dislike'),
    LifeEmotion(id: 'surprise', name: 'Surprise', iconName: 'sparkles'),
  ];

  static bool isPrimaryEmotion(String emotionId) {
    return primary.any((emotion) => emotion.id == emotionId);
  }
}
