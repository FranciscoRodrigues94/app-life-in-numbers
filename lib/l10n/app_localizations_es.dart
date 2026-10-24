// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeHello => '¡Hola!';

  @override
  String get welcomeTitle => 'Te damos la bienvenida a Life in Numbers.';

  @override
  String get welcomeDescription =>
      'Cada pequeño momento cuenta.\nHaz tuyo este espacio.';

  @override
  String get welcomeNameHint => '¿Cómo quieres que te llamemos?';

  @override
  String get welcomeContinue => 'Continuar';

  @override
  String get welcomeNameRequired => 'Introduce tu nombre.';

  @override
  String get welcomeSaveError =>
      'No se ha podido guardar tu nombre. Inténtalo de nuevo.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDescription =>
      'Elige el idioma de Life in Numbers.';

  @override
  String get settingsSystemDefault => 'Automático (Sistema)';

  @override
  String get dashboardGoodMorning => 'Buenos días';

  @override
  String get dashboardGoodAfternoon => 'Buenas tardes';

  @override
  String get dashboardGoodEvening => 'Buenas noches';

  @override
  String get dashboardSubtitle => 'Tus momentos. Tus emociones. Tu historia.';

  @override
  String dashboardMomentsRecorded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'momentos registrados',
      one: 'momento registrado',
    );
    return '$_temp0';
  }

  @override
  String get dashboardActivitiesTracked => 'Actividades registradas';

  @override
  String get dashboardAllTimeMoments => 'Momentos en total';

  @override
  String get dashboardFeelingsThisMonth => 'Emociones este mes';

  @override
  String get dashboardAllTimeFeelings => 'Emociones en total';

  @override
  String get dashboardYourActivities => 'TUS ACTIVIDADES';

  @override
  String get dashboardYourFeelings => 'TUS EMOCIONES';

  @override
  String get dashboardSeeAll => 'Ver todo';

  @override
  String get dashboardActivitiesSubtitle => 'Un toque. Un momento más.';

  @override
  String get dashboardFeelingsSubtitle => 'Un momento para conectar contigo.';

  @override
  String get dashboardNoFeelings =>
      'Todavía no has registrado emociones. Pulsa «Ver todo» para registrar la primera.';

  @override
  String get dashboardHighlights => 'DESTACADOS';

  @override
  String dashboardSource(String source) {
    return 'Fuente: $source';
  }

  @override
  String get dashboardPreviousHighlight => 'Destacado anterior';

  @override
  String get dashboardNextHighlight => 'Siguiente destacado';

  @override
  String dashboardRecorded(int count) {
    return '$count registrados';
  }

  @override
  String get dashboardManageMoments => 'Gestionar momentos registrados';

  @override
  String get dashboardNoActivities =>
      'Todavía no has registrado momentos. Pulsa «Ver todo» para registrar tu primera actividad.';

  @override
  String get dashboardLifeInNumbersLabel => 'TU VIDA EN NÚMEROS';

  @override
  String dashboardDidYouKnow(String activity) {
    return '¿SABÍAS QUE...? · $activity';
  }

  @override
  String get dashboardEmotionJoy => 'Alegría';

  @override
  String get dashboardEmotionHappiness => 'Felicidad';

  @override
  String get dashboardEmotionSadness => 'Tristeza';

  @override
  String get dashboardEmotionAnger => 'Enfado';

  @override
  String get dashboardEmotionFear => 'Miedo';

  @override
  String get dashboardEmotionDisgust => 'Asco';

  @override
  String get dashboardEmotionSurprise => 'Sorpresa';

  @override
  String get addMomentTitle => 'AÑADIR UN MOMENTO';

  @override
  String get addMomentSubtitle => '¿Qué has estado haciendo?';

  @override
  String get addSearchHint => 'Buscar actividades...';

  @override
  String get addAllCategories => 'Todas';

  @override
  String addActivityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actividades · Toca para registrar',
      one: '1 actividad · Toca para registrar',
      zero: 'No hay actividades · Toca para registrar',
    );
    return '$_temp0';
  }

  @override
  String get addClosingMessage =>
      'Cada pequeño momento forma parte de tu historia.';

  @override
  String get addNothingFound => 'No se encontraron resultados.';

  @override
  String get addStoryStartsHere => 'Tu historia empieza aquí.';

  @override
  String get addTryAnotherSearch => 'Prueba otra búsqueda o categoría.';

  @override
  String get addNoActivitiesAvailable =>
      'No hay actividades disponibles por ahora.';

  @override
  String get moodTitle => 'REGISTRAR UNA EMOCIÓN';

  @override
  String get moodSubtitle => '¿Cómo te sientes ahora mismo?';

  @override
  String moodFeelingRecorded(String name) {
    return '$name: registro guardado';
  }

  @override
  String get moodUndo => 'DESHACER';

  @override
  String get moodDeleteTitle => '¿Eliminar esta emoción?';

  @override
  String get moodDeleteDescription =>
      'Esta emoción se eliminará de tu historial.';

  @override
  String get moodCancel => 'Cancelar';

  @override
  String get moodDelete => 'Eliminar';

  @override
  String moodRecordedCount(int count) {
    return '$count registros';
  }

  @override
  String get moodDeleteTooltip => 'Eliminar emoción';

  @override
  String get moodTapHint => 'Toca una emoción para registrarla.';

  @override
  String moodHistoryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count emociones registradas',
      one: '1 emoción registrada',
      zero: 'No hay emociones registradas',
    );
    return '$_temp0';
  }

  @override
  String get moodEmptyTitle => 'Tu historia emocional comienza aquí.';

  @override
  String get moodEmptyDescription =>
      'Registra una emoción para empezar a descubrir tus patrones.';

  @override
  String get statisticsTitle => 'ESTADÍSTICAS';

  @override
  String get statisticsSubtitle => 'Tu vida vista a través de los números.';

  @override
  String get statisticsOverview => 'Tu vida de un vistazo';

  @override
  String get statisticsAllTime => 'TOTAL';

  @override
  String get statisticsThisMonth => 'ESTE MES';

  @override
  String get statisticsLast7 => 'ÚLTIMOS 7 DÍAS';

  @override
  String get statisticsToday => 'HOY';

  @override
  String get statisticsTotalMoments => 'Momentos totales';

  @override
  String get statisticsMomentsRecorded => 'Momentos registrados';

  @override
  String get statisticsMomentsToday => 'Momentos de hoy';

  @override
  String get statisticsMoments => 'MOMENTOS';

  @override
  String get statisticsMomentsHint =>
      'Desliza para explorar tus patrones de actividad.';

  @override
  String get statisticsEmptyMoments => 'Aún no hay momentos registrados.';

  @override
  String get statisticsEmptyMomentWeekdays =>
      'Registra momentos para descubrir tu actividad por día de la semana.';

  @override
  String get statisticsEmptyMomentMonths =>
      'Registra momentos para descubrir tu actividad por mes.';

  @override
  String get statisticsFeelingsHint =>
      'Las emociones que has registrado independientemente de los momentos.';

  @override
  String get statisticsFeelingsRecorded => 'Emociones registradas';

  @override
  String get statisticsFeelingsToday => 'Emociones de hoy';

  @override
  String get statisticsFeelingsMonth => 'Emociones de este mes';

  @override
  String get statisticsEmptyFeelings =>
      'Registra tu primera emoción para ver tus patrones emocionales.';

  @override
  String get statisticsEmptyFeelingWeekdays =>
      'Registra emociones para descubrir su distribución semanal.';

  @override
  String get statisticsEmptyFeelingMonths =>
      'Registra emociones para descubrir su distribución mensual.';

  @override
  String get statisticsMomentsFeelings => 'MOMENTOS Y EMOCIONES';

  @override
  String get statisticsInsightHint =>
      'Patrones encontrados en tus momentos y emociones.';

  @override
  String get statisticsInsufficientTitle => 'Tus patrones están tomando forma.';

  @override
  String get statisticsInsufficientMessage =>
      'Registra momentos y emociones en más días para detectar patrones del mismo día. No sacamos conclusiones con pocos datos.';

  @override
  String get statisticsPreviousChart => 'Gráfico anterior';

  @override
  String get statisticsNextChart => 'Gráfico siguiente';

  @override
  String get statisticsCompareHint =>
      'Elige una o varias opciones para comparar. Toca un día o mes para ver detalles.';

  @override
  String get statisticsTop3 => 'Top 3';

  @override
  String get statisticsEmptyPeriod => 'No hay registros en este período.';

  @override
  String get statisticsBreakdown => 'Distribución';

  @override
  String get statisticsWeekdays => 'Días de la semana';

  @override
  String get statisticsOverTime => 'A lo largo del tiempo';

  @override
  String get statisticsMon => 'Lun';

  @override
  String get statisticsTue => 'Mar';

  @override
  String get statisticsWed => 'Mié';

  @override
  String get statisticsThu => 'Jue';

  @override
  String get statisticsFri => 'Vie';

  @override
  String get statisticsSat => 'Sáb';

  @override
  String get statisticsSun => 'Dom';

  @override
  String statisticsPeriodCount(String period, int count) {
    return '$period · $count registros';
  }

  @override
  String statisticsMonthsShort(int count) {
    return '$count m';
  }

  @override
  String get activityCoffee => 'Café';

  @override
  String get activityShopping => 'Compras';

  @override
  String get activityReading => 'Lectura';

  @override
  String get activitySport => 'Deporte';

  @override
  String get activityGaming => 'Videojuegos';

  @override
  String get activityMeditation => 'Meditación';

  @override
  String get activityRestaurant => 'Restaurante';

  @override
  String get activityCinema => 'TV / Cine';

  @override
  String get activityWalking => 'Caminar';

  @override
  String get activitySocial => 'Vida social';

  @override
  String get categoryConsumption => 'Consumo';

  @override
  String get categoryExperiences => 'Experiencias';

  @override
  String get categoryHobbies => 'Aficiones';

  @override
  String get categoryWellness => 'Bienestar';

  @override
  String get categorySocial => 'Vida social';

  @override
  String get categoryFitness => 'Actividad física';

  @override
  String get weekdayMonday => 'lunes';

  @override
  String get weekdayTuesday => 'martes';

  @override
  String get weekdayWednesday => 'miércoles';

  @override
  String get weekdayThursday => 'jueves';

  @override
  String get weekdayFriday => 'viernes';

  @override
  String get weekdaySaturday => 'sábado';

  @override
  String get weekdaySunday => 'domingo';

  @override
  String get highlightStartTitle => 'Tu historia comienza aquí';

  @override
  String get highlightStartMessage =>
      'Registra tu primer momento para empezar a descubrir tus patrones.';

  @override
  String get highlightTopTitle => 'Tu actividad más frecuente';

  @override
  String highlightTopMessage(String activity, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registros',
      one: 'registro',
    );
    return '$activity encabeza tus registros de este mes, con $count $_temp0.';
  }

  @override
  String get highlightTieTitle => 'Primer puesto compartido';

  @override
  String highlightTieMessage(String activities, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registros',
      one: 'registro',
    );
    return '$activities están empatadas este mes, con $count $_temp0 cada una.';
  }

  @override
  String highlightMultipleTieMessage(int activitiesCount, int count) {
    return '$activitiesCount actividades comparten el primer puesto este mes, con $count registros cada una.';
  }

  @override
  String get highlightVarietyTitle => 'Un poco de variedad';

  @override
  String highlightVarietyMessage(int activitiesCount, int momentsCount) {
    return 'Has registrado $activitiesCount actividades diferentes este mes, en un total de $momentsCount momentos.';
  }

  @override
  String get highlightWeekdayTitle => 'Tu día con más registros';

  @override
  String highlightWeekdayMessage(String day, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registros',
      one: 'registro',
    );
    return '$day es el día con más momentos registrados hasta ahora, con $count $_temp0.';
  }

  @override
  String get highlightMoreTitle => 'Más momentos registrados';

  @override
  String highlightMoreMessage(int currentCount, int previousCount) {
    return 'Has registrado $currentCount momentos en los últimos 7 días, frente a $previousCount en los 7 días anteriores.';
  }

  @override
  String get highlightRecentTitle => 'Tu actividad reciente';

  @override
  String highlightRecentMessage(int currentCount, int previousCount) {
    return 'Has registrado $currentCount momentos en los últimos 7 días, frente a $previousCount en los 7 días anteriores.';
  }

  @override
  String get highlightMilestoneTitle => 'Un logro personal';

  @override
  String highlightMilestoneMessage(int count) {
    return 'Has superado los $count momentos registrados. Tu historia personal sigue creciendo, momento a momento.';
  }

  @override
  String get highlightGrowingTitle => 'Tu historia está creciendo';

  @override
  String highlightGrowingMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'momentos',
      one: 'momento',
    );
    return 'Hasta ahora has registrado $count $_temp0. Sigue construyendo tu historia.';
  }

  @override
  String get dashboardHighlightsLifeLabel => 'TU VIDA EN NÚMEROS';

  @override
  String dashboardHighlightsFactLabel(String activity) {
    return '¿SABÍAS QUE...? · $activity';
  }

  @override
  String dashboardHighlightSource(String source) {
    return 'Fuente: $source';
  }

  @override
  String get factWalking01Title => 'Cada paso cuenta';

  @override
  String get factWalking01Message =>
      'No necesitas un entrenamiento perfecto para beneficiarte del movimiento. La Organización Mundial de la Salud destaca que algo de actividad física es mejor que ninguna, y caminar es una forma de mantenerse activo.';

  @override
  String get factWalking02Title => 'Los pequeños comienzos importan';

  @override
  String get factWalking02Message =>
      'Las personas inactivas pueden comenzar con pequeñas cantidades de actividad física y aumentar gradualmente la duración y la intensidad. La constancia puede empezar con algo sencillo.';

  @override
  String get factSocial01Title => 'La conexión importa';

  @override
  String get factSocial01Message =>
      'Las relaciones sociales de apoyo se asocian con una mejor salud física y mental. Sentirse conectado es importante para el bienestar.';

  @override
  String get factSocial02Title => 'Las pequeñas conexiones cuentan';

  @override
  String get factSocial02Message =>
      'Las conexiones sociales significativas no siempre requieren grandes planes. Pequeños gestos, como preguntar a alguien cómo está, pueden ayudar a fortalecer las relaciones.';

  @override
  String get manageTitle => 'Gestionar actividades';

  @override
  String get manageNewActivity => 'Nueva actividad';

  @override
  String get manageEditActivity => 'Editar actividad';

  @override
  String get manageActivityName => 'Nombre de la actividad';

  @override
  String get manageCategory => 'Categoría';

  @override
  String get manageCancel => 'Cancelar';

  @override
  String get manageSave => 'Guardar';

  @override
  String get manageDescription =>
      'Elige lo que quieres registrar. Las actividades desactivadas conservan su historial.';

  @override
  String get manageLoadError => 'No se pudieron cargar las actividades.';

  @override
  String get manageCreated => 'Actividad creada.';

  @override
  String get manageUpdated => 'Actividad actualizada.';

  @override
  String get manageSaveError => 'No se pudo guardar la actividad.';

  @override
  String get navHome => 'Inicio';

  @override
  String get navAdd => 'Añadir';

  @override
  String get navMood => 'Emociones';

  @override
  String get navStatistics => 'Estadísticas';
}
