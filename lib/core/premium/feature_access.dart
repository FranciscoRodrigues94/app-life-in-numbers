enum AppFeature {
  basicActivityTracking,
  basicStatistics,
  basicMoodTracking,
  moodHistory,
  customActivities,
  customCategories,
  detailedMoodTracking,
  moodOnActivity,
  hourlyStatistics,
  detailedEntries,
  advancedStatistics,
  healthImport,
  advancedInsights,
  journaling,
}

class FeatureAccess {
  final bool isPremium;

  const FeatureAccess({required this.isPremium});

  bool canUse(AppFeature feature) {
    switch (feature) {
      case AppFeature.basicActivityTracking:
      case AppFeature.basicStatistics:
      case AppFeature.basicMoodTracking:
      case AppFeature.moodHistory:
        return true;

      case AppFeature.customActivities:
      case AppFeature.customCategories:
      case AppFeature.detailedMoodTracking:
      case AppFeature.moodOnActivity:
      case AppFeature.hourlyStatistics:
      case AppFeature.detailedEntries:
      case AppFeature.advancedStatistics:
      case AppFeature.healthImport:
      case AppFeature.advancedInsights:
      case AppFeature.journaling:
        return isPremium;
    }
  }
}
