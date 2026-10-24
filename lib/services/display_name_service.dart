
import 'package:life_in_numbers/l10n/app_localizations.dart';
import '../models/life_activity.dart';
import '../models/life_category.dart';
import '../models/default_activities.dart';
import '../models/default_categories.dart';

class DisplayNameService {
  static String activity(LifeActivity activity, AppLocalizations l10n) {
    final defaultActivity = DefaultActivities.all
        .where((item) => item.id == activity.id)
        .firstOrNull;

    if (defaultActivity == null) return activity.name;

    final isOriginalName = activity.name == defaultActivity.name ||
        (activity.id == 'cinema' && activity.name == 'Cinema');

    if (!isOriginalName) return activity.name;

    switch (activity.id) {
      case 'coffee': return l10n.activityCoffee;
      case 'shopping': return l10n.activityShopping;
      case 'reading': return l10n.activityReading;
      case 'sport': return l10n.activitySport;
      case 'gaming': return l10n.activityGaming;
      case 'meditation': return l10n.activityMeditation;
      case 'restaurant': return l10n.activityRestaurant;
      case 'cinema': return l10n.activityCinema;
      case 'walking': return l10n.activityWalking;
      case 'social': return l10n.activitySocial;
      default: return activity.name;
    }
  }

  static String category(LifeCategory category, AppLocalizations l10n) {
    final defaultCategory = DefaultCategories.all
        .where((item) => item.id == category.id)
        .firstOrNull;

    if (defaultCategory == null || category.name != defaultCategory.name) {
      return category.name;
    }

    switch (category.id) {
      case 'consumption': return l10n.categoryConsumption;
      case 'experiences': return l10n.categoryExperiences;
      case 'hobbies': return l10n.categoryHobbies;
      case 'wellness': return l10n.categoryWellness;
      case 'social': return l10n.categorySocial;
      case 'fitness': return l10n.categoryFitness;
      default: return category.name;
    }
  }
}