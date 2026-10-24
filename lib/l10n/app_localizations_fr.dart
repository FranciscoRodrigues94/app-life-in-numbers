// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get welcomeHello => 'Bonjour !';

  @override
  String get welcomeTitle => 'Bienvenue sur Life in Numbers.';

  @override
  String get welcomeDescription =>
      'Chaque petit moment compte.\nFais de cet espace le tien.';

  @override
  String get welcomeNameHint => 'Comment souhaites-tu qu\'on t\'appelle ?';

  @override
  String get welcomeContinue => 'Continuer';

  @override
  String get welcomeNameRequired => 'Saisis ton prénom.';

  @override
  String get welcomeSaveError =>
      'Impossible d\'enregistrer ton prénom. Réessaie.';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageDescription =>
      'Choisis la langue de Life in Numbers.';

  @override
  String get settingsSystemDefault => 'Automatique (Système)';

  @override
  String get dashboardGoodMorning => 'Bonjour';

  @override
  String get dashboardGoodAfternoon => 'Bon après-midi';

  @override
  String get dashboardGoodEvening => 'Bonsoir';

  @override
  String get dashboardSubtitle => 'Tes moments. Tes émotions. Ton histoire.';

  @override
  String dashboardMomentsRecorded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'moments enregistrés',
      one: 'moment enregistré',
    );
    return '$_temp0';
  }

  @override
  String get dashboardActivitiesTracked => 'Activités suivies';

  @override
  String get dashboardAllTimeMoments => 'Moments au total';

  @override
  String get dashboardFeelingsThisMonth => 'Émotions ce mois-ci';

  @override
  String get dashboardAllTimeFeelings => 'Émotions au total';

  @override
  String get dashboardYourActivities => 'TES ACTIVITÉS';

  @override
  String get dashboardYourFeelings => 'TES ÉMOTIONS';

  @override
  String get dashboardSeeAll => 'Tout voir';

  @override
  String get dashboardActivitiesSubtitle => 'Un geste. Un moment de plus.';

  @override
  String get dashboardFeelingsSubtitle =>
      'Un petit instant pour faire le point.';

  @override
  String get dashboardNoFeelings =>
      'Aucune émotion enregistrée. Appuie sur « Tout voir » pour enregistrer la première.';

  @override
  String get dashboardHighlights => 'TEMPS FORTS';

  @override
  String dashboardSource(String source) {
    return 'Source : $source';
  }

  @override
  String get dashboardPreviousHighlight => 'Temps fort précédent';

  @override
  String get dashboardNextHighlight => 'Temps fort suivant';

  @override
  String dashboardRecorded(int count) {
    return '$count enregistrés';
  }

  @override
  String get dashboardManageMoments => 'Gérer les moments enregistrés';

  @override
  String get dashboardNoActivities =>
      'Aucun moment enregistré. Appuie sur « Tout voir » pour enregistrer ta première activité.';

  @override
  String get dashboardLifeInNumbersLabel => 'TA VIE EN CHIFFRES';

  @override
  String dashboardDidYouKnow(String activity) {
    return 'LE SAVAIS-TU ? · $activity';
  }

  @override
  String get dashboardEmotionJoy => 'Joie';

  @override
  String get dashboardEmotionHappiness => 'Bonheur';

  @override
  String get dashboardEmotionSadness => 'Tristesse';

  @override
  String get dashboardEmotionAnger => 'Colère';

  @override
  String get dashboardEmotionFear => 'Peur';

  @override
  String get dashboardEmotionDisgust => 'Dégoût';

  @override
  String get dashboardEmotionSurprise => 'Surprise';

  @override
  String get addMomentTitle => 'AJOUTER UN MOMENT';

  @override
  String get addMomentSubtitle => 'Qu\'as-tu fait récemment ?';

  @override
  String get addSearchHint => 'Rechercher des activités...';

  @override
  String get addAllCategories => 'Toutes';

  @override
  String addActivityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count activités · Appuie pour enregistrer',
      one: '1 activité · Appuie pour enregistrer',
      zero: 'Aucune activité · Appuie pour enregistrer',
    );
    return '$_temp0';
  }

  @override
  String get addClosingMessage =>
      'Chaque petit moment fait partie de ton histoire.';

  @override
  String get addNothingFound => 'Aucun résultat.';

  @override
  String get addStoryStartsHere => 'Ton histoire commence ici.';

  @override
  String get addTryAnotherSearch => 'Essaie une autre recherche ou catégorie.';

  @override
  String get addNoActivitiesAvailable =>
      'Aucune activité disponible pour le moment.';

  @override
  String get moodTitle => 'NOTER UNE ÉMOTION';

  @override
  String get moodSubtitle => 'Comment te sens-tu en ce moment ?';

  @override
  String moodFeelingRecorded(String name) {
    return 'Émotion enregistrée : $name';
  }

  @override
  String get moodUndo => 'ANNULER';

  @override
  String get moodDeleteTitle => 'Supprimer cette émotion ?';

  @override
  String get moodDeleteDescription =>
      'Cette émotion sera supprimée de ton historique.';

  @override
  String get moodCancel => 'Annuler';

  @override
  String get moodDelete => 'Supprimer';

  @override
  String moodRecordedCount(int count) {
    return '$count enregistrements';
  }

  @override
  String get moodDeleteTooltip => 'Supprimer une émotion';

  @override
  String get moodTapHint => 'Touche une émotion pour l’enregistrer.';

  @override
  String moodHistoryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count émotions enregistrées',
      one: '1 émotion enregistrée',
      zero: 'Aucune émotion enregistrée',
    );
    return '$_temp0';
  }

  @override
  String get moodEmptyTitle => 'Ton histoire émotionnelle commence ici.';

  @override
  String get moodEmptyDescription =>
      'Note une émotion pour commencer à découvrir tes habitudes.';

  @override
  String get statisticsTitle => 'STATISTIQUES';

  @override
  String get statisticsSubtitle => 'Ta vie vue à travers les chiffres.';

  @override
  String get statisticsOverview => 'Ta vie en un coup d’œil';

  @override
  String get statisticsAllTime => 'TOTAL';

  @override
  String get statisticsThisMonth => 'CE MOIS';

  @override
  String get statisticsLast7 => '7 DERNIERS JOURS';

  @override
  String get statisticsToday => 'AUJOURD’HUI';

  @override
  String get statisticsTotalMoments => 'Total des moments';

  @override
  String get statisticsMomentsRecorded => 'Moments enregistrés';

  @override
  String get statisticsMomentsToday => 'Moments aujourd’hui';

  @override
  String get statisticsMoments => 'MOMENTS';

  @override
  String get statisticsMomentsHint =>
      'Fais glisser pour explorer tes habitudes.';

  @override
  String get statisticsEmptyMoments =>
      'Aucun moment enregistré pour le moment.';

  @override
  String get statisticsEmptyMomentWeekdays =>
      'Enregistre des moments pour découvrir tes activités selon les jours.';

  @override
  String get statisticsEmptyMomentMonths =>
      'Enregistre des moments pour découvrir tes activités selon les mois.';

  @override
  String get statisticsFeelingsHint =>
      'Les émotions enregistrées indépendamment des moments.';

  @override
  String get statisticsFeelingsRecorded => 'Émotions enregistrées';

  @override
  String get statisticsFeelingsToday => 'Émotions aujourd’hui';

  @override
  String get statisticsFeelingsMonth => 'Émotions ce mois-ci';

  @override
  String get statisticsEmptyFeelings =>
      'Enregistre ta première émotion pour découvrir tes tendances.';

  @override
  String get statisticsEmptyFeelingWeekdays =>
      'Enregistre des émotions pour découvrir leur répartition hebdomadaire.';

  @override
  String get statisticsEmptyFeelingMonths =>
      'Enregistre des émotions pour découvrir leur répartition mensuelle.';

  @override
  String get statisticsMomentsFeelings => 'MOMENTS ET ÉMOTIONS';

  @override
  String get statisticsInsightHint =>
      'Tendances observées dans tes moments et tes émotions.';

  @override
  String get statisticsInsufficientTitle => 'Tes tendances prennent forme.';

  @override
  String get statisticsInsufficientMessage =>
      'Enregistre des moments et des émotions sur davantage de jours pour repérer des tendances le même jour. Nous ne tirons pas de conclusions avec trop peu de données.';

  @override
  String get statisticsPreviousChart => 'Graphique précédent';

  @override
  String get statisticsNextChart => 'Graphique suivant';

  @override
  String get statisticsCompareHint =>
      'Choisis une ou plusieurs options à comparer. Touche un jour ou un mois pour plus de détails.';

  @override
  String get statisticsTop3 => 'Top 3';

  @override
  String get statisticsEmptyPeriod => 'Aucune donnée pour cette période.';

  @override
  String get statisticsBreakdown => 'Répartition';

  @override
  String get statisticsWeekdays => 'Jours de la semaine';

  @override
  String get statisticsOverTime => 'Au fil du temps';

  @override
  String get statisticsMon => 'Lun';

  @override
  String get statisticsTue => 'Mar';

  @override
  String get statisticsWed => 'Mer';

  @override
  String get statisticsThu => 'Jeu';

  @override
  String get statisticsFri => 'Ven';

  @override
  String get statisticsSat => 'Sam';

  @override
  String get statisticsSun => 'Dim';

  @override
  String statisticsPeriodCount(String period, int count) {
    return '$period · $count enregistrements';
  }

  @override
  String statisticsMonthsShort(int count) {
    return '$count mois';
  }

  @override
  String get activityCoffee => 'Café';

  @override
  String get activityShopping => 'Achats';

  @override
  String get activityReading => 'Lecture';

  @override
  String get activitySport => 'Sport';

  @override
  String get activityGaming => 'Jeux vidéo';

  @override
  String get activityMeditation => 'Méditation';

  @override
  String get activityRestaurant => 'Restaurant';

  @override
  String get activityCinema => 'TV / Cinéma';

  @override
  String get activityWalking => 'Marche';

  @override
  String get activitySocial => 'Vie sociale';

  @override
  String get categoryConsumption => 'Consommation';

  @override
  String get categoryExperiences => 'Expériences';

  @override
  String get categoryHobbies => 'Loisirs';

  @override
  String get categoryWellness => 'Bien-être';

  @override
  String get categorySocial => 'Vie sociale';

  @override
  String get categoryFitness => 'Activité physique';

  @override
  String get weekdayMonday => 'lundi';

  @override
  String get weekdayTuesday => 'mardi';

  @override
  String get weekdayWednesday => 'mercredi';

  @override
  String get weekdayThursday => 'jeudi';

  @override
  String get weekdayFriday => 'vendredi';

  @override
  String get weekdaySaturday => 'samedi';

  @override
  String get weekdaySunday => 'dimanche';

  @override
  String get highlightStartTitle => 'Ton histoire commence ici';

  @override
  String get highlightStartMessage =>
      'Enregistre ton premier moment pour commencer à découvrir tes habitudes.';

  @override
  String get highlightTopTitle => 'Ton activité la plus fréquente';

  @override
  String highlightTopMessage(String activity, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'enregistrements',
      one: 'enregistrement',
    );
    return '$activity arrive en tête de tes enregistrements ce mois-ci, avec $count $_temp0.';
  }

  @override
  String get highlightTieTitle => 'Une première place partagée';

  @override
  String highlightTieMessage(String activities, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'enregistrements',
      one: 'enregistrement',
    );
    return '$activities sont à égalité ce mois-ci, avec $count $_temp0 chacune.';
  }

  @override
  String highlightMultipleTieMessage(int activitiesCount, int count) {
    return '$activitiesCount activités se partagent la première place ce mois-ci, avec $count enregistrements chacune.';
  }

  @override
  String get highlightVarietyTitle => 'Un peu de variété';

  @override
  String highlightVarietyMessage(int activitiesCount, int momentsCount) {
    return 'Tu as enregistré $activitiesCount activités différentes ce mois-ci, sur un total de $momentsCount moments.';
  }

  @override
  String get highlightWeekdayTitle => 'Ton jour le plus enregistré';

  @override
  String highlightWeekdayMessage(String day, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'enregistrements',
      one: 'enregistrement',
    );
    return '$day est le jour qui compte le plus de moments enregistrés à ce jour : $count $_temp0.';
  }

  @override
  String get highlightMoreTitle => 'Plus de moments enregistrés';

  @override
  String highlightMoreMessage(int currentCount, int previousCount) {
    return 'Tu as enregistré $currentCount moments au cours des 7 derniers jours, contre $previousCount pendant les 7 jours précédents.';
  }

  @override
  String get highlightRecentTitle => 'Ton activité récente';

  @override
  String highlightRecentMessage(int currentCount, int previousCount) {
    return 'Tu as enregistré $currentCount moments au cours des 7 derniers jours, contre $previousCount pendant les 7 jours précédents.';
  }

  @override
  String get highlightMilestoneTitle => 'Une étape personnelle';

  @override
  String highlightMilestoneMessage(int count) {
    return 'Tu as dépassé les $count moments enregistrés. Ton histoire personnelle grandit, un moment à la fois.';
  }

  @override
  String get highlightGrowingTitle => 'Ton histoire grandit';

  @override
  String highlightGrowingMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'moments',
      one: 'moment',
    );
    return 'Tu as enregistré $count $_temp0 jusqu’à présent. Continue à construire ton histoire.';
  }

  @override
  String get dashboardHighlightsLifeLabel => 'TA VIE EN CHIFFRES';

  @override
  String dashboardHighlightsFactLabel(String activity) {
    return 'LE SAVAIS-TU ? · $activity';
  }

  @override
  String dashboardHighlightSource(String source) {
    return 'Source : $source';
  }

  @override
  String get factWalking01Title => 'Chaque pas compte';

  @override
  String get factWalking01Message =>
      'Pas besoin d’un entraînement parfait pour profiter des bienfaits du mouvement. L’Organisation mondiale de la Santé souligne qu’un peu d’activité physique vaut mieux que pas du tout, et marcher est une façon de rester actif.';

  @override
  String get factWalking02Title => 'Les petits débuts comptent';

  @override
  String get factWalking02Message =>
      'Les personnes inactives peuvent commencer par de petites quantités d’activité physique et augmenter progressivement la durée et l’intensité. La régularité peut commencer simplement.';

  @override
  String get factSocial01Title => 'Les liens comptent';

  @override
  String get factSocial01Message =>
      'Des relations sociales bienveillantes sont associées à une meilleure santé physique et mentale. Se sentir connecté aux autres participe au bien-être.';

  @override
  String get factSocial02Title => 'Les petits liens comptent aussi';

  @override
  String get factSocial02Message =>
      'Des liens sociaux significatifs ne nécessitent pas toujours de grands projets. De petits gestes, comme prendre des nouvelles, peuvent renforcer les relations.';

  @override
  String get manageTitle => 'Gérer les activités';

  @override
  String get manageNewActivity => 'Nouvelle activité';

  @override
  String get manageEditActivity => 'Modifier l’activité';

  @override
  String get manageActivityName => 'Nom de l’activité';

  @override
  String get manageCategory => 'Catégorie';

  @override
  String get manageCancel => 'Annuler';

  @override
  String get manageSave => 'Enregistrer';

  @override
  String get manageDescription =>
      'Choisissez ce que vous souhaitez suivre. Les activités désactivées conservent leur historique.';

  @override
  String get manageLoadError => 'Impossible de charger les activités.';

  @override
  String get manageCreated => 'Activité créée.';

  @override
  String get manageUpdated => 'Activité mise à jour.';

  @override
  String get manageSaveError => 'Impossible d’enregistrer l’activité.';

  @override
  String get navHome => 'Accueil';

  @override
  String get navAdd => 'Ajouter';

  @override
  String get navMood => 'Émotions';

  @override
  String get navStatistics => 'Statistiques';
}
