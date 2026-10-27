// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get welcomeHello => 'Hallo!';

  @override
  String get welcomeTitle => 'Willkommen bei Life in Numbers.';

  @override
  String get welcomeDescription =>
      'Jeder kleine Moment zählt.\nMach diesen Ort zu deinem.';

  @override
  String get welcomeNameHint => 'Wie dürfen wir dich nennen?';

  @override
  String get welcomeContinue => 'Weiter';

  @override
  String get welcomeNameRequired => 'Bitte gib deinen Namen ein.';

  @override
  String get welcomeSaveError =>
      'Dein Name konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageDescription =>
      'Wähle die Sprache für Life in Numbers.';

  @override
  String get settingsSystemDefault => 'Automatisch (System)';

  @override
  String get dashboardGoodMorning => 'Guten Morgen';

  @override
  String get dashboardGoodAfternoon => 'Guten Tag';

  @override
  String get dashboardGoodEvening => 'Guten Abend';

  @override
  String get dashboardSubtitle =>
      'Deine Momente. Deine Gefühle. Deine Geschichte.';

  @override
  String dashboardMomentsRecorded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Momente erfasst',
      one: 'Moment erfasst',
    );
    return '$_temp0';
  }

  @override
  String get dashboardActivitiesTracked => 'Erfasste Aktivitäten';

  @override
  String get dashboardAllTimeMoments => 'Momente insgesamt';

  @override
  String get dashboardFeelingsThisMonth => 'Gefühle diesen Monat';

  @override
  String get dashboardAllTimeFeelings => 'Gefühle insgesamt';

  @override
  String get dashboardYourActivities => 'DEINE AKTIVITÄTEN';

  @override
  String get dashboardYourFeelings => 'DEINE GEFÜHLE';

  @override
  String get dashboardSeeAll => 'Alle anzeigen';

  @override
  String get dashboardActivitiesSubtitle => 'Ein Tippen. Ein weiterer Moment.';

  @override
  String get dashboardFeelingsSubtitle => 'Ein kurzer Check-in mit dir selbst.';

  @override
  String get dashboardNoFeelings =>
      'Noch keine Gefühle erfasst. Tippe auf „Alle anzeigen“, um dein erstes Gefühl einzutragen.';

  @override
  String get dashboardHighlights => 'HIGHLIGHTS';

  @override
  String dashboardSource(String source) {
    return 'Quelle: $source';
  }

  @override
  String get dashboardPreviousHighlight => 'Vorheriges Highlight';

  @override
  String get dashboardNextHighlight => 'Nächstes Highlight';

  @override
  String dashboardRecorded(int count) {
    return '$count erfasst';
  }

  @override
  String get dashboardManageMoments => 'Erfasste Momente verwalten';

  @override
  String get dashboardNoActivities =>
      'Noch keine Momente erfasst. Tippe auf „Alle anzeigen“, um deine erste Aktivität einzutragen.';

  @override
  String get dashboardLifeInNumbersLabel => 'DEIN LEBEN IN ZAHLEN';

  @override
  String dashboardDidYouKnow(String activity) {
    return 'WUSSTEST DU SCHON? · $activity';
  }

  @override
  String get dashboardEmotionJoy => 'Freude';

  @override
  String get dashboardEmotionHappiness => 'Glück';

  @override
  String get dashboardEmotionSadness => 'Traurigkeit';

  @override
  String get dashboardEmotionAnger => 'Wut';

  @override
  String get dashboardEmotionFear => 'Angst';

  @override
  String get dashboardEmotionDisgust => 'Ekel';

  @override
  String get dashboardEmotionSurprise => 'Überraschung';

  @override
  String get addMomentTitle => 'MOMENT HINZUFÜGEN';

  @override
  String get addMomentSubtitle => 'Was hast du unternommen?';

  @override
  String get addSearchHint => 'Aktivitäten suchen...';

  @override
  String get addAllCategories => 'Alle';

  @override
  String addActivityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Aktivitäten · Tippe zum Erfassen',
      one: '1 Aktivität · Tippe zum Erfassen',
      zero: 'Keine Aktivitäten · Tippe zum Erfassen',
    );
    return '$_temp0';
  }

  @override
  String get addClosingMessage =>
      'Jeder kleine Moment ist Teil deiner Geschichte.';

  @override
  String get addNothingFound => 'Nichts gefunden.';

  @override
  String get addStoryStartsHere => 'Deine Geschichte beginnt hier.';

  @override
  String get addTryAnotherSearch =>
      'Versuche eine andere Suche oder Kategorie.';

  @override
  String get addNoActivitiesAvailable =>
      'Zurzeit sind keine Aktivitäten verfügbar.';

  @override
  String addMomentRecorded(String name) {
    return '$name hinzugefügt';
  }

  @override
  String get moodTitle => 'GEFÜHL FESTHALTEN';

  @override
  String get moodSubtitle => 'Wie fühlst du dich gerade?';

  @override
  String moodFeelingRecorded(String name) {
    return '$name erfasst';
  }

  @override
  String get moodUndo => 'RÜCKGÄNGIG';

  @override
  String get moodDeleteTitle => 'Dieses Gefühl löschen?';

  @override
  String get moodDeleteDescription =>
      'Dieses Gefühl wird aus deinem Verlauf entfernt.';

  @override
  String get moodCancel => 'Abbrechen';

  @override
  String get moodDelete => 'Löschen';

  @override
  String moodRecordedCount(int count) {
    return '$count erfasst';
  }

  @override
  String get moodDeleteTooltip => 'Gefühl löschen';

  @override
  String get moodTapHint => 'Tippe auf ein Gefühl, um es zu erfassen.';

  @override
  String moodHistoryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Gefühle erfasst',
      one: '1 Gefühl erfasst',
      zero: 'Keine Gefühle erfasst',
    );
    return '$_temp0';
  }

  @override
  String get moodEmptyTitle => 'Deine emotionale Geschichte beginnt hier.';

  @override
  String get moodEmptyDescription =>
      'Erfasse ein Gefühl, um deine Muster zu entdecken.';

  @override
  String get statisticsTitle => 'STATISTIKEN';

  @override
  String get statisticsSubtitle => 'Dein Leben in Zahlen.';

  @override
  String get statisticsOverview => 'Dein Leben auf einen Blick';

  @override
  String get statisticsAllTime => 'INSGESAMT';

  @override
  String get statisticsThisMonth => 'DIESEN MONAT';

  @override
  String get statisticsLast7 => 'LETZTE 7 TAGE';

  @override
  String get statisticsToday => 'HEUTE';

  @override
  String get statisticsTotalMoments => 'Momente insgesamt';

  @override
  String get statisticsMomentsRecorded => 'Erfasste Momente';

  @override
  String get statisticsMomentsToday => 'Momente heute';

  @override
  String get statisticsMoments => 'MOMENTE';

  @override
  String get statisticsMomentsHint =>
      'Wische, um deine Aktivitätsmuster zu entdecken.';

  @override
  String get statisticsEmptyMoments => 'Noch keine Momente erfasst.';

  @override
  String get statisticsEmptyMomentWeekdays =>
      'Erfasse Momente, um deine Aktivitäten nach Wochentagen zu entdecken.';

  @override
  String get statisticsEmptyMomentMonths =>
      'Erfasse Momente, um deine Aktivitäten nach Monaten zu entdecken.';

  @override
  String get statisticsFeelingsHint =>
      'Deine Gefühle, unabhängig von Momenten erfasst.';

  @override
  String get statisticsFeelingsRecorded => 'Erfasste Gefühle';

  @override
  String get statisticsFeelingsToday => 'Gefühle heute';

  @override
  String get statisticsFeelingsMonth => 'Gefühle diesen Monat';

  @override
  String get statisticsEmptyFeelings =>
      'Erfasse dein erstes Gefühl, um emotionale Muster zu sehen.';

  @override
  String get statisticsEmptyFeelingWeekdays =>
      'Erfasse Gefühle, um deine Verteilung nach Wochentagen zu entdecken.';

  @override
  String get statisticsEmptyFeelingMonths =>
      'Erfasse Gefühle, um deine monatliche Verteilung zu entdecken.';

  @override
  String get statisticsMomentsFeelings => 'MOMENTE & GEFÜHLE';

  @override
  String get statisticsInsightHint =>
      'Muster in deinen erfassten Momenten und Gefühlen.';

  @override
  String get statisticsInsufficientTitle => 'Deine Muster zeichnen sich ab.';

  @override
  String get statisticsInsufficientMessage =>
      'Erfasse Momente und Gefühle an weiteren Tagen, um Muster am selben Tag zu erkennen. Aus zu wenigen Daten ziehen wir keine Schlüsse.';

  @override
  String get statisticsPreviousChart => 'Vorheriges Diagramm';

  @override
  String get statisticsNextChart => 'Nächstes Diagramm';

  @override
  String get statisticsCompareHint =>
      'Wähle eine oder mehrere Optionen zum Vergleichen. Tippe auf einen Tag oder Monat für Details.';

  @override
  String get statisticsTop3 => 'Top 3';

  @override
  String get statisticsEmptyPeriod => 'Keine Einträge für diesen Zeitraum.';

  @override
  String get statisticsBreakdown => 'Verteilung';

  @override
  String get statisticsWeekdays => 'Wochentage';

  @override
  String get statisticsOverTime => 'Im Zeitverlauf';

  @override
  String get statisticsMon => 'Mo';

  @override
  String get statisticsTue => 'Di';

  @override
  String get statisticsWed => 'Mi';

  @override
  String get statisticsThu => 'Do';

  @override
  String get statisticsFri => 'Fr';

  @override
  String get statisticsSat => 'Sa';

  @override
  String get statisticsSun => 'So';

  @override
  String statisticsPeriodCount(String period, int count) {
    return '$period · $count erfasst';
  }

  @override
  String statisticsMonthsShort(int count) {
    return '${count}M';
  }

  @override
  String get activityCoffee => 'Kaffee';

  @override
  String get activityShopping => 'Einkaufen';

  @override
  String get activityReading => 'Lesen';

  @override
  String get activitySport => 'Sport';

  @override
  String get activityGaming => 'Gaming';

  @override
  String get activityMeditation => 'Meditation';

  @override
  String get activityRestaurant => 'Restaurant';

  @override
  String get activityCinema => 'TV / Kino';

  @override
  String get activityWalking => 'Spazieren';

  @override
  String get activitySocial => 'Soziale Aktivitäten';

  @override
  String get categoryConsumption => 'Konsum';

  @override
  String get categoryExperiences => 'Erlebnisse';

  @override
  String get categoryHobbies => 'Hobbys';

  @override
  String get categoryWellness => 'Wohlbefinden';

  @override
  String get categorySocial => 'Soziales';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get weekdayMonday => 'Montag';

  @override
  String get weekdayTuesday => 'Dienstag';

  @override
  String get weekdayWednesday => 'Mittwoch';

  @override
  String get weekdayThursday => 'Donnerstag';

  @override
  String get weekdayFriday => 'Freitag';

  @override
  String get weekdaySaturday => 'Samstag';

  @override
  String get weekdaySunday => 'Sonntag';

  @override
  String get highlightStartTitle => 'Deine Geschichte beginnt hier';

  @override
  String get highlightStartMessage =>
      'Halte deinen ersten Moment fest, um deine Muster zu entdecken.';

  @override
  String get highlightTopTitle => 'Deine häufigste Aktivität';

  @override
  String highlightTopMessage(String activity, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Einträgen',
      one: 'Eintrag',
    );
    return '$activity führt deine Einträge in diesem Monat mit $count $_temp0 an.';
  }

  @override
  String get highlightTieTitle => 'Gemeinsam auf Platz eins';

  @override
  String highlightTieMessage(String activities, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Einträgen',
      one: 'Eintrag',
    );
    return '$activities liegen diesen Monat mit jeweils $count $_temp0 gleichauf.';
  }

  @override
  String highlightMultipleTieMessage(int activitiesCount, int count) {
    return '$activitiesCount Aktivitäten teilen sich diesen Monat Platz eins mit jeweils $count Einträgen.';
  }

  @override
  String get highlightVarietyTitle => 'Ein bisschen Abwechslung';

  @override
  String highlightVarietyMessage(int activitiesCount, int momentsCount) {
    return 'Du hast diesen Monat $activitiesCount verschiedene Aktivitäten in insgesamt $momentsCount Momenten festgehalten.';
  }

  @override
  String get highlightWeekdayTitle => 'Dein häufigster Wochentag';

  @override
  String highlightWeekdayMessage(String day, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Einträge',
      one: 'Eintrag',
    );
    return '$day ist bisher der Tag mit den meisten Einträgen: $count $_temp0.';
  }

  @override
  String get highlightMoreTitle => 'Mehr Momente festgehalten';

  @override
  String highlightMoreMessage(int currentCount, int previousCount) {
    return 'Du hast in den letzten 7 Tagen $currentCount Momente erfasst, gegenüber $previousCount in den 7 Tagen davor.';
  }

  @override
  String get highlightRecentTitle => 'Deine jüngste Aktivität';

  @override
  String highlightRecentMessage(int currentCount, int previousCount) {
    return 'Du hast in den letzten 7 Tagen $currentCount Momente erfasst, gegenüber $previousCount in den 7 Tagen davor.';
  }

  @override
  String get highlightMilestoneTitle => 'Ein persönlicher Meilenstein';

  @override
  String highlightMilestoneMessage(int count) {
    return 'Du hast die Marke von $count festgehaltenen Momenten überschritten. Deine persönliche Geschichte wächst mit jedem Moment.';
  }

  @override
  String get highlightGrowingTitle => 'Deine Geschichte wächst';

  @override
  String highlightGrowingMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Momente',
      one: 'Moment',
    );
    return 'Du hast bisher $count $_temp0 festgehalten. Baue deine persönliche Chronik weiter aus.';
  }

  @override
  String get dashboardHighlightsLifeLabel => 'DEIN LEBEN IN ZAHLEN';

  @override
  String dashboardHighlightsFactLabel(String activity) {
    return 'WUSSTEST DU SCHON? · $activity';
  }

  @override
  String dashboardHighlightSource(String source) {
    return 'Quelle: $source';
  }

  @override
  String get factWalking01Title => 'Jeder Schritt zählt';

  @override
  String get factWalking01Message =>
      'Du brauchst kein perfektes Training, um von Bewegung zu profitieren. Die Weltgesundheitsorganisation betont, dass etwas körperliche Aktivität besser ist als gar keine. Spazierengehen ist eine Möglichkeit, aktiv zu sein.';

  @override
  String get factWalking02Title => 'Kleine Anfänge zählen';

  @override
  String get factWalking02Message =>
      'Wer bisher wenig aktiv war, kann mit kurzen Bewegungseinheiten beginnen und Dauer und Intensität allmählich steigern. Regelmäßigkeit kann ganz einfach anfangen.';

  @override
  String get factSocial01Title => 'Verbundenheit ist wichtig';

  @override
  String get factSocial01Message =>
      'Unterstützende soziale Beziehungen stehen mit besserer körperlicher und psychischer Gesundheit in Verbindung. Sich verbunden zu fühlen, ist wichtig für das Wohlbefinden.';

  @override
  String get factSocial02Title => 'Auch kleine Begegnungen zählen';

  @override
  String get factSocial02Message =>
      'Bedeutsame soziale Kontakte brauchen nicht immer große Pläne. Kleine Gesten, etwa nachzufragen, wie es jemandem geht, können Beziehungen stärken.';

  @override
  String get manageTitle => 'Aktivitäten verwalten';

  @override
  String get manageNewActivity => 'Neue Aktivität';

  @override
  String get manageEditActivity => 'Aktivität bearbeiten';

  @override
  String get manageActivityName => 'Name der Aktivität';

  @override
  String get manageCategory => 'Kategorie';

  @override
  String get manageCancel => 'Abbrechen';

  @override
  String get manageSave => 'Speichern';

  @override
  String get manageDescription =>
      'Wähle aus, was du erfassen möchtest. Deaktivierte Aktivitäten behalten ihren Verlauf.';

  @override
  String get manageLoadError => 'Aktivitäten konnten nicht geladen werden.';

  @override
  String get manageCreated => 'Aktivität erstellt.';

  @override
  String get manageUpdated => 'Aktivität aktualisiert.';

  @override
  String get manageSaveError => 'Aktivität konnte nicht gespeichert werden.';

  @override
  String get navHome => 'Start';

  @override
  String get navAdd => 'Hinzufügen';

  @override
  String get navMood => 'Gefühle';

  @override
  String get navStatistics => 'Statistik';
}
