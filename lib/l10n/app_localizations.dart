import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('es'),
    Locale('fr'),
    Locale('pt'),
    Locale('pt', 'PT'),
  ];

  /// No description provided for @welcomeHello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get welcomeHello;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Life in Numbers.'**
  String get welcomeTitle;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Every little moment counts.\nLet\'s make this space yours.'**
  String get welcomeDescription;

  /// No description provided for @welcomeNameHint.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get welcomeNameHint;

  /// No description provided for @welcomeContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get welcomeContinue;

  /// No description provided for @welcomeNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get welcomeNameRequired;

  /// No description provided for @welcomeSaveError.
  ///
  /// In en, this message translates to:
  /// **'Unable to save your name. Please try again.'**
  String get welcomeSaveError;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language used in Life in Numbers.'**
  String get settingsLanguageDescription;

  /// No description provided for @settingsSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'Automatic (System)'**
  String get settingsSystemDefault;

  /// No description provided for @dashboardGoodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get dashboardGoodMorning;

  /// No description provided for @dashboardGoodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get dashboardGoodAfternoon;

  /// No description provided for @dashboardGoodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get dashboardGoodEvening;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your moments. Your feelings. Your story.'**
  String get dashboardSubtitle;

  /// No description provided for @dashboardMomentsRecorded.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{moment recorded} other{moments recorded}}'**
  String dashboardMomentsRecorded(int count);

  /// No description provided for @dashboardActivitiesTracked.
  ///
  /// In en, this message translates to:
  /// **'Activities tracked'**
  String get dashboardActivitiesTracked;

  /// No description provided for @dashboardAllTimeMoments.
  ///
  /// In en, this message translates to:
  /// **'All-time moments'**
  String get dashboardAllTimeMoments;

  /// No description provided for @dashboardFeelingsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Feelings this month'**
  String get dashboardFeelingsThisMonth;

  /// No description provided for @dashboardAllTimeFeelings.
  ///
  /// In en, this message translates to:
  /// **'All-time feelings'**
  String get dashboardAllTimeFeelings;

  /// No description provided for @dashboardYourActivities.
  ///
  /// In en, this message translates to:
  /// **'YOUR ACTIVITIES'**
  String get dashboardYourActivities;

  /// No description provided for @dashboardYourFeelings.
  ///
  /// In en, this message translates to:
  /// **'YOUR FEELINGS'**
  String get dashboardYourFeelings;

  /// No description provided for @dashboardSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get dashboardSeeAll;

  /// No description provided for @dashboardActivitiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One tap. One more moment.'**
  String get dashboardActivitiesSubtitle;

  /// No description provided for @dashboardFeelingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A little check-in with yourself.'**
  String get dashboardFeelingsSubtitle;

  /// No description provided for @dashboardNoFeelings.
  ///
  /// In en, this message translates to:
  /// **'No feelings recorded yet. Tap See all to log your first feeling.'**
  String get dashboardNoFeelings;

  /// No description provided for @dashboardHighlights.
  ///
  /// In en, this message translates to:
  /// **'HIGHLIGHTS'**
  String get dashboardHighlights;

  /// No description provided for @dashboardSource.
  ///
  /// In en, this message translates to:
  /// **'Source: {source}'**
  String dashboardSource(String source);

  /// No description provided for @dashboardPreviousHighlight.
  ///
  /// In en, this message translates to:
  /// **'Previous highlight'**
  String get dashboardPreviousHighlight;

  /// No description provided for @dashboardNextHighlight.
  ///
  /// In en, this message translates to:
  /// **'Next highlight'**
  String get dashboardNextHighlight;

  /// No description provided for @dashboardRecorded.
  ///
  /// In en, this message translates to:
  /// **'{count} recorded'**
  String dashboardRecorded(int count);

  /// No description provided for @dashboardManageMoments.
  ///
  /// In en, this message translates to:
  /// **'Manage recorded moments'**
  String get dashboardManageMoments;

  /// No description provided for @dashboardNoActivities.
  ///
  /// In en, this message translates to:
  /// **'No moments recorded yet. Tap See all to record your first activity.'**
  String get dashboardNoActivities;

  /// No description provided for @dashboardLifeInNumbersLabel.
  ///
  /// In en, this message translates to:
  /// **'YOUR LIFE IN NUMBERS'**
  String get dashboardLifeInNumbersLabel;

  /// No description provided for @dashboardDidYouKnow.
  ///
  /// In en, this message translates to:
  /// **'DID YOU KNOW? · {activity}'**
  String dashboardDidYouKnow(String activity);

  /// No description provided for @dashboardEmotionJoy.
  ///
  /// In en, this message translates to:
  /// **'Joy'**
  String get dashboardEmotionJoy;

  /// No description provided for @dashboardEmotionHappiness.
  ///
  /// In en, this message translates to:
  /// **'Happiness'**
  String get dashboardEmotionHappiness;

  /// No description provided for @dashboardEmotionSadness.
  ///
  /// In en, this message translates to:
  /// **'Sadness'**
  String get dashboardEmotionSadness;

  /// No description provided for @dashboardEmotionAnger.
  ///
  /// In en, this message translates to:
  /// **'Anger'**
  String get dashboardEmotionAnger;

  /// No description provided for @dashboardEmotionFear.
  ///
  /// In en, this message translates to:
  /// **'Fear'**
  String get dashboardEmotionFear;

  /// No description provided for @dashboardEmotionDisgust.
  ///
  /// In en, this message translates to:
  /// **'Disgust'**
  String get dashboardEmotionDisgust;

  /// No description provided for @dashboardEmotionSurprise.
  ///
  /// In en, this message translates to:
  /// **'Surprise'**
  String get dashboardEmotionSurprise;

  /// No description provided for @addMomentTitle.
  ///
  /// In en, this message translates to:
  /// **'ADD A MOMENT'**
  String get addMomentTitle;

  /// No description provided for @addMomentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What have you been up to?'**
  String get addMomentSubtitle;

  /// No description provided for @addSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search your activities...'**
  String get addSearchHint;

  /// No description provided for @addAllCategories.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get addAllCategories;

  /// No description provided for @addActivityCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No activities · Tap to record} one{1 activity · Tap to record} other{{count} activities · Tap to record}}'**
  String addActivityCount(int count);

  /// No description provided for @addClosingMessage.
  ///
  /// In en, this message translates to:
  /// **'Every little moment adds to your story.'**
  String get addClosingMessage;

  /// No description provided for @addNothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing found.'**
  String get addNothingFound;

  /// No description provided for @addStoryStartsHere.
  ///
  /// In en, this message translates to:
  /// **'Your story starts here.'**
  String get addStoryStartsHere;

  /// No description provided for @addTryAnotherSearch.
  ///
  /// In en, this message translates to:
  /// **'Try another search or category.'**
  String get addTryAnotherSearch;

  /// No description provided for @addNoActivitiesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No activities are currently available.'**
  String get addNoActivitiesAvailable;

  /// No description provided for @addMomentRecorded.
  ///
  /// In en, this message translates to:
  /// **'{name} added'**
  String addMomentRecorded(String name);

  /// No description provided for @moodTitle.
  ///
  /// In en, this message translates to:
  /// **'LOG A FEELING'**
  String get moodTitle;

  /// No description provided for @moodSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling right now?'**
  String get moodSubtitle;

  /// No description provided for @moodFeelingRecorded.
  ///
  /// In en, this message translates to:
  /// **'{name} recorded'**
  String moodFeelingRecorded(String name);

  /// No description provided for @moodUndo.
  ///
  /// In en, this message translates to:
  /// **'UNDO'**
  String get moodUndo;

  /// No description provided for @moodDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this feeling?'**
  String get moodDeleteTitle;

  /// No description provided for @moodDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'This feeling will be removed from your history.'**
  String get moodDeleteDescription;

  /// No description provided for @moodCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get moodCancel;

  /// No description provided for @moodDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get moodDelete;

  /// No description provided for @moodRecordedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} recorded'**
  String moodRecordedCount(int count);

  /// No description provided for @moodDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete feeling'**
  String get moodDeleteTooltip;

  /// No description provided for @moodTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap an emotion to record it.'**
  String get moodTapHint;

  /// No description provided for @moodHistoryCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No feelings recorded} =1{1 feeling recorded} other{{count} feelings recorded}}'**
  String moodHistoryCount(int count);

  /// No description provided for @moodEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your emotional story starts here.'**
  String get moodEmptyTitle;

  /// No description provided for @moodEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Record a feeling to start discovering your patterns.'**
  String get moodEmptyDescription;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'STATISTICS'**
  String get statisticsTitle;

  /// No description provided for @statisticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your life, seen through numbers.'**
  String get statisticsSubtitle;

  /// No description provided for @statisticsOverview.
  ///
  /// In en, this message translates to:
  /// **'Your life at a glance'**
  String get statisticsOverview;

  /// No description provided for @statisticsAllTime.
  ///
  /// In en, this message translates to:
  /// **'ALL-TIME'**
  String get statisticsAllTime;

  /// No description provided for @statisticsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'THIS MONTH'**
  String get statisticsThisMonth;

  /// No description provided for @statisticsLast7.
  ///
  /// In en, this message translates to:
  /// **'LAST 7 DAYS'**
  String get statisticsLast7;

  /// No description provided for @statisticsToday.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get statisticsToday;

  /// No description provided for @statisticsTotalMoments.
  ///
  /// In en, this message translates to:
  /// **'Total moments'**
  String get statisticsTotalMoments;

  /// No description provided for @statisticsMomentsRecorded.
  ///
  /// In en, this message translates to:
  /// **'Moments recorded'**
  String get statisticsMomentsRecorded;

  /// No description provided for @statisticsMomentsToday.
  ///
  /// In en, this message translates to:
  /// **'Moments today'**
  String get statisticsMomentsToday;

  /// No description provided for @statisticsMoments.
  ///
  /// In en, this message translates to:
  /// **'MOMENTS'**
  String get statisticsMoments;

  /// No description provided for @statisticsMomentsHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe to explore your activity patterns.'**
  String get statisticsMomentsHint;

  /// No description provided for @statisticsEmptyMoments.
  ///
  /// In en, this message translates to:
  /// **'No moments recorded yet.'**
  String get statisticsEmptyMoments;

  /// No description provided for @statisticsEmptyMomentWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Log moments to discover your weekday activity mix.'**
  String get statisticsEmptyMomentWeekdays;

  /// No description provided for @statisticsEmptyMomentMonths.
  ///
  /// In en, this message translates to:
  /// **'Log moments to discover your monthly activity mix.'**
  String get statisticsEmptyMomentMonths;

  /// No description provided for @statisticsFeelingsHint.
  ///
  /// In en, this message translates to:
  /// **'The emotions you have recorded, independently of moments.'**
  String get statisticsFeelingsHint;

  /// No description provided for @statisticsFeelingsRecorded.
  ///
  /// In en, this message translates to:
  /// **'Feelings recorded'**
  String get statisticsFeelingsRecorded;

  /// No description provided for @statisticsFeelingsToday.
  ///
  /// In en, this message translates to:
  /// **'Feelings today'**
  String get statisticsFeelingsToday;

  /// No description provided for @statisticsFeelingsMonth.
  ///
  /// In en, this message translates to:
  /// **'Feelings this month'**
  String get statisticsFeelingsMonth;

  /// No description provided for @statisticsEmptyFeelings.
  ///
  /// In en, this message translates to:
  /// **'Record your first feeling to see your emotional patterns.'**
  String get statisticsEmptyFeelings;

  /// No description provided for @statisticsEmptyFeelingWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Log feelings to discover your weekday emotion mix.'**
  String get statisticsEmptyFeelingWeekdays;

  /// No description provided for @statisticsEmptyFeelingMonths.
  ///
  /// In en, this message translates to:
  /// **'Log feelings to discover your monthly emotion mix.'**
  String get statisticsEmptyFeelingMonths;

  /// No description provided for @statisticsMomentsFeelings.
  ///
  /// In en, this message translates to:
  /// **'MOMENTS & FEELINGS'**
  String get statisticsMomentsFeelings;

  /// No description provided for @statisticsInsightHint.
  ///
  /// In en, this message translates to:
  /// **'Patterns found across your recorded moments and feelings.'**
  String get statisticsInsightHint;

  /// No description provided for @statisticsInsufficientTitle.
  ///
  /// In en, this message translates to:
  /// **'Your patterns are taking shape.'**
  String get statisticsInsufficientTitle;

  /// No description provided for @statisticsInsufficientMessage.
  ///
  /// In en, this message translates to:
  /// **'Log moments and feelings on more days to reveal meaningful same-day patterns. No conclusions are generated from too little data.'**
  String get statisticsInsufficientMessage;

  /// No description provided for @statisticsPreviousChart.
  ///
  /// In en, this message translates to:
  /// **'Previous chart'**
  String get statisticsPreviousChart;

  /// No description provided for @statisticsNextChart.
  ///
  /// In en, this message translates to:
  /// **'Next chart'**
  String get statisticsNextChart;

  /// No description provided for @statisticsCompareHint.
  ///
  /// In en, this message translates to:
  /// **'Choose one or more to compare. Tap a day or month for details.'**
  String get statisticsCompareHint;

  /// No description provided for @statisticsTop3.
  ///
  /// In en, this message translates to:
  /// **'Top 3'**
  String get statisticsTop3;

  /// No description provided for @statisticsEmptyPeriod.
  ///
  /// In en, this message translates to:
  /// **'No records for this period.'**
  String get statisticsEmptyPeriod;

  /// No description provided for @statisticsBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get statisticsBreakdown;

  /// No description provided for @statisticsWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays'**
  String get statisticsWeekdays;

  /// No description provided for @statisticsOverTime.
  ///
  /// In en, this message translates to:
  /// **'Over time'**
  String get statisticsOverTime;

  /// No description provided for @statisticsMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get statisticsMon;

  /// No description provided for @statisticsTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get statisticsTue;

  /// No description provided for @statisticsWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get statisticsWed;

  /// No description provided for @statisticsThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get statisticsThu;

  /// No description provided for @statisticsFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get statisticsFri;

  /// No description provided for @statisticsSat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get statisticsSat;

  /// No description provided for @statisticsSun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get statisticsSun;

  /// No description provided for @statisticsPeriodCount.
  ///
  /// In en, this message translates to:
  /// **'{period} · {count} recorded'**
  String statisticsPeriodCount(String period, int count);

  /// No description provided for @statisticsMonthsShort.
  ///
  /// In en, this message translates to:
  /// **'{count}M'**
  String statisticsMonthsShort(int count);

  /// No description provided for @activityCoffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get activityCoffee;

  /// No description provided for @activityShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get activityShopping;

  /// No description provided for @activityReading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get activityReading;

  /// No description provided for @activitySport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get activitySport;

  /// No description provided for @activityGaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get activityGaming;

  /// No description provided for @activityMeditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get activityMeditation;

  /// No description provided for @activityRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get activityRestaurant;

  /// No description provided for @activityCinema.
  ///
  /// In en, this message translates to:
  /// **'TV / Cinema'**
  String get activityCinema;

  /// No description provided for @activityWalking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get activityWalking;

  /// No description provided for @activitySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get activitySocial;

  /// No description provided for @categoryConsumption.
  ///
  /// In en, this message translates to:
  /// **'Consumption'**
  String get categoryConsumption;

  /// No description provided for @categoryExperiences.
  ///
  /// In en, this message translates to:
  /// **'Experiences'**
  String get categoryExperiences;

  /// No description provided for @categoryHobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get categoryHobbies;

  /// No description provided for @categoryWellness.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get categoryWellness;

  /// No description provided for @categorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get categorySocial;

  /// No description provided for @categoryFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get categoryFitness;

  /// No description provided for @weekdayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get weekdayMonday;

  /// No description provided for @weekdayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get weekdayTuesday;

  /// No description provided for @weekdayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get weekdayWednesday;

  /// No description provided for @weekdayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get weekdayThursday;

  /// No description provided for @weekdayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get weekdayFriday;

  /// No description provided for @weekdaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get weekdaySaturday;

  /// No description provided for @weekdaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get weekdaySunday;

  /// No description provided for @highlightStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your story starts here'**
  String get highlightStartTitle;

  /// No description provided for @highlightStartMessage.
  ///
  /// In en, this message translates to:
  /// **'Record your first moment to start discovering your patterns.'**
  String get highlightStartMessage;

  /// No description provided for @highlightTopTitle.
  ///
  /// In en, this message translates to:
  /// **'Your top activity'**
  String get highlightTopTitle;

  /// No description provided for @highlightTopMessage.
  ///
  /// In en, this message translates to:
  /// **'{activity} leads your recorded moments this month, with {count} {count, plural, one{record} other{records}}.'**
  String highlightTopMessage(String activity, int count);

  /// No description provided for @highlightTieTitle.
  ///
  /// In en, this message translates to:
  /// **'A shared first place'**
  String get highlightTieTitle;

  /// No description provided for @highlightTieMessage.
  ///
  /// In en, this message translates to:
  /// **'{activities} are tied this month, with {count} {count, plural, one{record} other{records}} each.'**
  String highlightTieMessage(String activities, int count);

  /// No description provided for @highlightMultipleTieMessage.
  ///
  /// In en, this message translates to:
  /// **'{activitiesCount} activities share first place this month, with {count} records each.'**
  String highlightMultipleTieMessage(int activitiesCount, int count);

  /// No description provided for @highlightVarietyTitle.
  ///
  /// In en, this message translates to:
  /// **'A little variety'**
  String get highlightVarietyTitle;

  /// No description provided for @highlightVarietyMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ve recorded {activitiesCount} different activities this month, across {momentsCount} moments.'**
  String highlightVarietyMessage(int activitiesCount, int momentsCount);

  /// No description provided for @highlightWeekdayTitle.
  ///
  /// In en, this message translates to:
  /// **'Your most recorded day'**
  String get highlightWeekdayTitle;

  /// No description provided for @highlightWeekdayMessage.
  ///
  /// In en, this message translates to:
  /// **'{day} leads your recorded moments so far, with {count} {count, plural, one{record} other{records}}.'**
  String highlightWeekdayMessage(String day, int count);

  /// No description provided for @highlightMoreTitle.
  ///
  /// In en, this message translates to:
  /// **'More moments recorded'**
  String get highlightMoreTitle;

  /// No description provided for @highlightMoreMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ve logged {currentCount} moments in the last 7 days, compared with {previousCount} in the 7 days before that.'**
  String highlightMoreMessage(int currentCount, int previousCount);

  /// No description provided for @highlightRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Your recent activity'**
  String get highlightRecentTitle;

  /// No description provided for @highlightRecentMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ve logged {currentCount} moments in the last 7 days, compared with {previousCount} in the previous 7 days.'**
  String highlightRecentMessage(int currentCount, int previousCount);

  /// No description provided for @highlightMilestoneTitle.
  ///
  /// In en, this message translates to:
  /// **'A personal milestone'**
  String get highlightMilestoneTitle;

  /// No description provided for @highlightMilestoneMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ve passed {count} recorded moments. Your personal history is growing, one moment at a time.'**
  String highlightMilestoneMessage(int count);

  /// No description provided for @highlightGrowingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your story is growing'**
  String get highlightGrowingTitle;

  /// No description provided for @highlightGrowingMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ve recorded {count} {count, plural, one{moment} other{moments}} so far. Keep building your personal timeline.'**
  String highlightGrowingMessage(int count);

  /// No description provided for @dashboardHighlightsLifeLabel.
  ///
  /// In en, this message translates to:
  /// **'YOUR LIFE IN NUMBERS'**
  String get dashboardHighlightsLifeLabel;

  /// No description provided for @dashboardHighlightsFactLabel.
  ///
  /// In en, this message translates to:
  /// **'DID YOU KNOW? · {activity}'**
  String dashboardHighlightsFactLabel(String activity);

  /// No description provided for @dashboardHighlightSource.
  ///
  /// In en, this message translates to:
  /// **'Source: {source}'**
  String dashboardHighlightSource(String source);

  /// No description provided for @factWalking01Title.
  ///
  /// In en, this message translates to:
  /// **'Every step counts'**
  String get factWalking01Title;

  /// No description provided for @factWalking01Message.
  ///
  /// In en, this message translates to:
  /// **'You don\'t need a perfect workout to benefit from movement. The World Health Organization emphasizes that some physical activity is better than none, and walking is one way to be active.'**
  String get factWalking01Message;

  /// No description provided for @factWalking02Title.
  ///
  /// In en, this message translates to:
  /// **'Small beginnings matter'**
  String get factWalking02Title;

  /// No description provided for @factWalking02Message.
  ///
  /// In en, this message translates to:
  /// **'People who are inactive can begin with small amounts of physical activity and gradually increase their time and intensity. Consistency can start with something simple.'**
  String get factWalking02Message;

  /// No description provided for @factSocial01Title.
  ///
  /// In en, this message translates to:
  /// **'Connection matters'**
  String get factSocial01Title;

  /// No description provided for @factSocial01Message.
  ///
  /// In en, this message translates to:
  /// **'Supportive social relationships are associated with better physical and mental health. Feeling connected is an important part of wellbeing.'**
  String get factSocial01Message;

  /// No description provided for @factSocial02Title.
  ///
  /// In en, this message translates to:
  /// **'Little connections count'**
  String get factSocial02Title;

  /// No description provided for @factSocial02Message.
  ///
  /// In en, this message translates to:
  /// **'Meaningful social connections do not always require big plans. Small gestures, such as checking in with someone, can help strengthen relationships.'**
  String get factSocial02Message;

  /// No description provided for @manageTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage activities'**
  String get manageTitle;

  /// No description provided for @manageNewActivity.
  ///
  /// In en, this message translates to:
  /// **'New activity'**
  String get manageNewActivity;

  /// No description provided for @manageEditActivity.
  ///
  /// In en, this message translates to:
  /// **'Edit activity'**
  String get manageEditActivity;

  /// No description provided for @manageActivityName.
  ///
  /// In en, this message translates to:
  /// **'Activity name'**
  String get manageActivityName;

  /// No description provided for @manageCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get manageCategory;

  /// No description provided for @manageCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get manageCancel;

  /// No description provided for @manageSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get manageSave;

  /// No description provided for @manageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose what you want to track. Disabled activities keep their history.'**
  String get manageDescription;

  /// No description provided for @manageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load activities.'**
  String get manageLoadError;

  /// No description provided for @manageCreated.
  ///
  /// In en, this message translates to:
  /// **'Activity created.'**
  String get manageCreated;

  /// No description provided for @manageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Activity updated.'**
  String get manageUpdated;

  /// No description provided for @manageSaveError.
  ///
  /// In en, this message translates to:
  /// **'Unable to save activity.'**
  String get manageSaveError;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get navAdd;

  /// No description provided for @navMood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get navMood;

  /// No description provided for @navStatistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get navStatistics;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'PT':
            return AppLocalizationsPtPt();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
