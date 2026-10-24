// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeHello => 'Hello!';

  @override
  String get welcomeTitle => 'Welcome to Life in Numbers.';

  @override
  String get welcomeDescription =>
      'Every little moment counts.\nLet\'s make this space yours.';

  @override
  String get welcomeNameHint => 'What should we call you?';

  @override
  String get welcomeContinue => 'Continue';

  @override
  String get welcomeNameRequired => 'Please enter your name.';

  @override
  String get welcomeSaveError => 'Unable to save your name. Please try again.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageDescription =>
      'Choose the language used in Life in Numbers.';

  @override
  String get settingsSystemDefault => 'Automatic (System)';

  @override
  String get dashboardGoodMorning => 'Good morning';

  @override
  String get dashboardGoodAfternoon => 'Good afternoon';

  @override
  String get dashboardGoodEvening => 'Good evening';

  @override
  String get dashboardSubtitle => 'Your moments. Your feelings. Your story.';

  @override
  String dashboardMomentsRecorded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'moments recorded',
      one: 'moment recorded',
    );
    return '$_temp0';
  }

  @override
  String get dashboardActivitiesTracked => 'Activities tracked';

  @override
  String get dashboardAllTimeMoments => 'All-time moments';

  @override
  String get dashboardFeelingsThisMonth => 'Feelings this month';

  @override
  String get dashboardAllTimeFeelings => 'All-time feelings';

  @override
  String get dashboardYourActivities => 'YOUR ACTIVITIES';

  @override
  String get dashboardYourFeelings => 'YOUR FEELINGS';

  @override
  String get dashboardSeeAll => 'See all';

  @override
  String get dashboardActivitiesSubtitle => 'One tap. One more moment.';

  @override
  String get dashboardFeelingsSubtitle => 'A little check-in with yourself.';

  @override
  String get dashboardNoFeelings =>
      'No feelings recorded yet. Tap See all to log your first feeling.';

  @override
  String get dashboardHighlights => 'HIGHLIGHTS';

  @override
  String dashboardSource(String source) {
    return 'Source: $source';
  }

  @override
  String get dashboardPreviousHighlight => 'Previous highlight';

  @override
  String get dashboardNextHighlight => 'Next highlight';

  @override
  String dashboardRecorded(int count) {
    return '$count recorded';
  }

  @override
  String get dashboardManageMoments => 'Manage recorded moments';

  @override
  String get dashboardNoActivities =>
      'No moments recorded yet. Tap See all to record your first activity.';

  @override
  String get dashboardLifeInNumbersLabel => 'YOUR LIFE IN NUMBERS';

  @override
  String dashboardDidYouKnow(String activity) {
    return 'DID YOU KNOW? · $activity';
  }

  @override
  String get dashboardEmotionJoy => 'Joy';

  @override
  String get dashboardEmotionHappiness => 'Happiness';

  @override
  String get dashboardEmotionSadness => 'Sadness';

  @override
  String get dashboardEmotionAnger => 'Anger';

  @override
  String get dashboardEmotionFear => 'Fear';

  @override
  String get dashboardEmotionDisgust => 'Disgust';

  @override
  String get dashboardEmotionSurprise => 'Surprise';

  @override
  String get addMomentTitle => 'ADD A MOMENT';

  @override
  String get addMomentSubtitle => 'What have you been up to?';

  @override
  String get addSearchHint => 'Search your activities...';

  @override
  String get addAllCategories => 'All';

  @override
  String addActivityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count activities · Tap to record',
      one: '1 activity · Tap to record',
      zero: 'No activities · Tap to record',
    );
    return '$_temp0';
  }

  @override
  String get addClosingMessage => 'Every little moment adds to your story.';

  @override
  String get addNothingFound => 'Nothing found.';

  @override
  String get addStoryStartsHere => 'Your story starts here.';

  @override
  String get addTryAnotherSearch => 'Try another search or category.';

  @override
  String get addNoActivitiesAvailable =>
      'No activities are currently available.';

  @override
  String get moodTitle => 'LOG A FEELING';

  @override
  String get moodSubtitle => 'How are you feeling right now?';

  @override
  String moodFeelingRecorded(String name) {
    return '$name recorded';
  }

  @override
  String get moodUndo => 'UNDO';

  @override
  String get moodDeleteTitle => 'Delete this feeling?';

  @override
  String get moodDeleteDescription =>
      'This feeling will be removed from your history.';

  @override
  String get moodCancel => 'Cancel';

  @override
  String get moodDelete => 'Delete';

  @override
  String moodRecordedCount(int count) {
    return '$count recorded';
  }

  @override
  String get moodDeleteTooltip => 'Delete feeling';

  @override
  String get moodTapHint => 'Tap an emotion to record it.';

  @override
  String moodHistoryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count feelings recorded',
      one: '1 feeling recorded',
      zero: 'No feelings recorded',
    );
    return '$_temp0';
  }

  @override
  String get moodEmptyTitle => 'Your emotional story starts here.';

  @override
  String get moodEmptyDescription =>
      'Record a feeling to start discovering your patterns.';

  @override
  String get statisticsTitle => 'STATISTICS';

  @override
  String get statisticsSubtitle => 'Your life, seen through numbers.';

  @override
  String get statisticsOverview => 'Your life at a glance';

  @override
  String get statisticsAllTime => 'ALL-TIME';

  @override
  String get statisticsThisMonth => 'THIS MONTH';

  @override
  String get statisticsLast7 => 'LAST 7 DAYS';

  @override
  String get statisticsToday => 'TODAY';

  @override
  String get statisticsTotalMoments => 'Total moments';

  @override
  String get statisticsMomentsRecorded => 'Moments recorded';

  @override
  String get statisticsMomentsToday => 'Moments today';

  @override
  String get statisticsMoments => 'MOMENTS';

  @override
  String get statisticsMomentsHint =>
      'Swipe to explore your activity patterns.';

  @override
  String get statisticsEmptyMoments => 'No moments recorded yet.';

  @override
  String get statisticsEmptyMomentWeekdays =>
      'Log moments to discover your weekday activity mix.';

  @override
  String get statisticsEmptyMomentMonths =>
      'Log moments to discover your monthly activity mix.';

  @override
  String get statisticsFeelingsHint =>
      'The emotions you have recorded, independently of moments.';

  @override
  String get statisticsFeelingsRecorded => 'Feelings recorded';

  @override
  String get statisticsFeelingsToday => 'Feelings today';

  @override
  String get statisticsFeelingsMonth => 'Feelings this month';

  @override
  String get statisticsEmptyFeelings =>
      'Record your first feeling to see your emotional patterns.';

  @override
  String get statisticsEmptyFeelingWeekdays =>
      'Log feelings to discover your weekday emotion mix.';

  @override
  String get statisticsEmptyFeelingMonths =>
      'Log feelings to discover your monthly emotion mix.';

  @override
  String get statisticsMomentsFeelings => 'MOMENTS & FEELINGS';

  @override
  String get statisticsInsightHint =>
      'Patterns found across your recorded moments and feelings.';

  @override
  String get statisticsInsufficientTitle => 'Your patterns are taking shape.';

  @override
  String get statisticsInsufficientMessage =>
      'Log moments and feelings on more days to reveal meaningful same-day patterns. No conclusions are generated from too little data.';

  @override
  String get statisticsPreviousChart => 'Previous chart';

  @override
  String get statisticsNextChart => 'Next chart';

  @override
  String get statisticsCompareHint =>
      'Choose one or more to compare. Tap a day or month for details.';

  @override
  String get statisticsTop3 => 'Top 3';

  @override
  String get statisticsEmptyPeriod => 'No records for this period.';

  @override
  String get statisticsBreakdown => 'Breakdown';

  @override
  String get statisticsWeekdays => 'Weekdays';

  @override
  String get statisticsOverTime => 'Over time';

  @override
  String get statisticsMon => 'Mon';

  @override
  String get statisticsTue => 'Tue';

  @override
  String get statisticsWed => 'Wed';

  @override
  String get statisticsThu => 'Thu';

  @override
  String get statisticsFri => 'Fri';

  @override
  String get statisticsSat => 'Sat';

  @override
  String get statisticsSun => 'Sun';

  @override
  String statisticsPeriodCount(String period, int count) {
    return '$period · $count recorded';
  }

  @override
  String statisticsMonthsShort(int count) {
    return '${count}M';
  }

  @override
  String get activityCoffee => 'Coffee';

  @override
  String get activityShopping => 'Shopping';

  @override
  String get activityReading => 'Reading';

  @override
  String get activitySport => 'Sport';

  @override
  String get activityGaming => 'Gaming';

  @override
  String get activityMeditation => 'Meditation';

  @override
  String get activityRestaurant => 'Restaurant';

  @override
  String get activityCinema => 'TV / Cinema';

  @override
  String get activityWalking => 'Walking';

  @override
  String get activitySocial => 'Social';

  @override
  String get categoryConsumption => 'Consumption';

  @override
  String get categoryExperiences => 'Experiences';

  @override
  String get categoryHobbies => 'Hobbies';

  @override
  String get categoryWellness => 'Wellness';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get weekdayMonday => 'Monday';

  @override
  String get weekdayTuesday => 'Tuesday';

  @override
  String get weekdayWednesday => 'Wednesday';

  @override
  String get weekdayThursday => 'Thursday';

  @override
  String get weekdayFriday => 'Friday';

  @override
  String get weekdaySaturday => 'Saturday';

  @override
  String get weekdaySunday => 'Sunday';

  @override
  String get highlightStartTitle => 'Your story starts here';

  @override
  String get highlightStartMessage =>
      'Record your first moment to start discovering your patterns.';

  @override
  String get highlightTopTitle => 'Your top activity';

  @override
  String highlightTopMessage(String activity, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'records',
      one: 'record',
    );
    return '$activity leads your recorded moments this month, with $count $_temp0.';
  }

  @override
  String get highlightTieTitle => 'A shared first place';

  @override
  String highlightTieMessage(String activities, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'records',
      one: 'record',
    );
    return '$activities are tied this month, with $count $_temp0 each.';
  }

  @override
  String highlightMultipleTieMessage(int activitiesCount, int count) {
    return '$activitiesCount activities share first place this month, with $count records each.';
  }

  @override
  String get highlightVarietyTitle => 'A little variety';

  @override
  String highlightVarietyMessage(int activitiesCount, int momentsCount) {
    return 'You\'ve recorded $activitiesCount different activities this month, across $momentsCount moments.';
  }

  @override
  String get highlightWeekdayTitle => 'Your most recorded day';

  @override
  String highlightWeekdayMessage(String day, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'records',
      one: 'record',
    );
    return '$day leads your recorded moments so far, with $count $_temp0.';
  }

  @override
  String get highlightMoreTitle => 'More moments recorded';

  @override
  String highlightMoreMessage(int currentCount, int previousCount) {
    return 'You\'ve logged $currentCount moments in the last 7 days, compared with $previousCount in the 7 days before that.';
  }

  @override
  String get highlightRecentTitle => 'Your recent activity';

  @override
  String highlightRecentMessage(int currentCount, int previousCount) {
    return 'You\'ve logged $currentCount moments in the last 7 days, compared with $previousCount in the previous 7 days.';
  }

  @override
  String get highlightMilestoneTitle => 'A personal milestone';

  @override
  String highlightMilestoneMessage(int count) {
    return 'You\'ve passed $count recorded moments. Your personal history is growing, one moment at a time.';
  }

  @override
  String get highlightGrowingTitle => 'Your story is growing';

  @override
  String highlightGrowingMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'moments',
      one: 'moment',
    );
    return 'You\'ve recorded $count $_temp0 so far. Keep building your personal timeline.';
  }

  @override
  String get dashboardHighlightsLifeLabel => 'YOUR LIFE IN NUMBERS';

  @override
  String dashboardHighlightsFactLabel(String activity) {
    return 'DID YOU KNOW? · $activity';
  }

  @override
  String dashboardHighlightSource(String source) {
    return 'Source: $source';
  }

  @override
  String get factWalking01Title => 'Every step counts';

  @override
  String get factWalking01Message =>
      'You don\'t need a perfect workout to benefit from movement. The World Health Organization emphasizes that some physical activity is better than none, and walking is one way to be active.';

  @override
  String get factWalking02Title => 'Small beginnings matter';

  @override
  String get factWalking02Message =>
      'People who are inactive can begin with small amounts of physical activity and gradually increase their time and intensity. Consistency can start with something simple.';

  @override
  String get factSocial01Title => 'Connection matters';

  @override
  String get factSocial01Message =>
      'Supportive social relationships are associated with better physical and mental health. Feeling connected is an important part of wellbeing.';

  @override
  String get factSocial02Title => 'Little connections count';

  @override
  String get factSocial02Message =>
      'Meaningful social connections do not always require big plans. Small gestures, such as checking in with someone, can help strengthen relationships.';

  @override
  String get manageTitle => 'Manage activities';

  @override
  String get manageNewActivity => 'New activity';

  @override
  String get manageEditActivity => 'Edit activity';

  @override
  String get manageActivityName => 'Activity name';

  @override
  String get manageCategory => 'Category';

  @override
  String get manageCancel => 'Cancel';

  @override
  String get manageSave => 'Save';

  @override
  String get manageDescription =>
      'Choose what you want to track. Disabled activities keep their history.';

  @override
  String get manageLoadError => 'Unable to load activities.';

  @override
  String get manageCreated => 'Activity created.';

  @override
  String get manageUpdated => 'Activity updated.';

  @override
  String get manageSaveError => 'Unable to save activity.';

  @override
  String get navHome => 'Home';

  @override
  String get navAdd => 'Add';

  @override
  String get navMood => 'Mood';

  @override
  String get navStatistics => 'Statistics';
}
