
enum AppFeature {
  detailedEntries,
  advancedStatistics,
  healthImport,
  advancedInsights,
}

class FeatureAccess {
  final bool isPremium;

  const FeatureAccess({required this.isPremium});

  bool canUse(AppFeature feature) {
    switch (feature) {
      case AppFeature.detailedEntries:
      case AppFeature.advancedStatistics:
      case AppFeature.healthImport:
      case AppFeature.advancedInsights:
        return isPremium;
    }
  }
}
