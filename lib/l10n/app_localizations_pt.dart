// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get welcomeHello => 'Olá!';

  @override
  String get welcomeTitle => 'Boas-vindas à Life in Numbers.';

  @override
  String get welcomeDescription =>
      'Cada pequeno momento conta.\nVamos tornar este espaço teu.';

  @override
  String get welcomeNameHint => 'Como te devemos chamar?';

  @override
  String get welcomeContinue => 'Continuar';

  @override
  String get welcomeNameRequired => 'Introduz o teu nome.';

  @override
  String get welcomeSaveError =>
      'Não foi possível guardar o teu nome. Tenta novamente.';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDescription =>
      'Escolhe o idioma da Life in Numbers.';

  @override
  String get settingsSystemDefault => 'Automático (Sistema)';

  @override
  String get dashboardGoodMorning => 'Bom dia';

  @override
  String get dashboardGoodAfternoon => 'Boa tarde';

  @override
  String get dashboardGoodEvening => 'Boa noite';

  @override
  String get dashboardSubtitle =>
      'Os teus momentos. As tuas emoções. A tua história.';

  @override
  String dashboardMomentsRecorded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'momentos registados',
      one: 'momento registado',
    );
    return '$_temp0';
  }

  @override
  String get dashboardActivitiesTracked => 'Atividades acompanhadas';

  @override
  String get dashboardAllTimeMoments => 'Momentos no total';

  @override
  String get dashboardFeelingsThisMonth => 'Emoções este mês';

  @override
  String get dashboardAllTimeFeelings => 'Emoções no total';

  @override
  String get dashboardYourActivities => 'AS TUAS ATIVIDADES';

  @override
  String get dashboardYourFeelings => 'AS TUAS EMOÇÕES';

  @override
  String get dashboardSeeAll => 'Ver tudo';

  @override
  String get dashboardActivitiesSubtitle => 'Um toque. Mais um momento.';

  @override
  String get dashboardFeelingsSubtitle => 'Um pequeno momento para ti.';

  @override
  String get dashboardNoFeelings =>
      'Ainda não registaste emoções. Toca em «Ver tudo» para registares a primeira.';

  @override
  String get dashboardHighlights => 'DESTAQUES';

  @override
  String dashboardSource(String source) {
    return 'Fonte: $source';
  }

  @override
  String get dashboardPreviousHighlight => 'Destaque anterior';

  @override
  String get dashboardNextHighlight => 'Destaque seguinte';

  @override
  String dashboardRecorded(int count) {
    return '$count registados';
  }

  @override
  String get dashboardManageMoments => 'Gerir momentos registados';

  @override
  String get dashboardNoActivities =>
      'Ainda não registaste momentos. Toca em «Ver tudo» para registares a primeira atividade.';

  @override
  String get dashboardLifeInNumbersLabel => 'A TUA VIDA EM NÚMEROS';

  @override
  String dashboardDidYouKnow(String activity) {
    return 'SABIAS QUE? · $activity';
  }

  @override
  String get dashboardEmotionJoy => 'Alegria';

  @override
  String get dashboardEmotionHappiness => 'Felicidade';

  @override
  String get dashboardEmotionSadness => 'Tristeza';

  @override
  String get dashboardEmotionAnger => 'Raiva';

  @override
  String get dashboardEmotionFear => 'Medo';

  @override
  String get dashboardEmotionDisgust => 'Nojo';

  @override
  String get dashboardEmotionSurprise => 'Surpresa';

  @override
  String get addMomentTitle => 'ADICIONAR UM MOMENTO';

  @override
  String get addMomentSubtitle => 'O que tens feito?';

  @override
  String get addSearchHint => 'Pesquisar atividades...';

  @override
  String get addAllCategories => 'Todas';

  @override
  String addActivityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atividades · Toca para registar',
      one: '1 atividade · Toca para registar',
      zero: 'Sem atividades · Toca para registar',
    );
    return '$_temp0';
  }

  @override
  String get addClosingMessage =>
      'Cada pequeno momento faz parte da tua história.';

  @override
  String get addNothingFound => 'Nenhum resultado.';

  @override
  String get addStoryStartsHere => 'A tua história começa aqui.';

  @override
  String get addTryAnotherSearch => 'Experimenta outra pesquisa ou categoria.';

  @override
  String get addNoActivitiesAvailable =>
      'Não existem atividades disponíveis neste momento.';

  @override
  String get moodTitle => 'REGISTAR UMA EMOÇÃO';

  @override
  String get moodSubtitle => 'Como te sentes neste momento?';

  @override
  String moodFeelingRecorded(String name) {
    return '$name registada';
  }

  @override
  String get moodUndo => 'ANULAR';

  @override
  String get moodDeleteTitle => 'Eliminar esta emoção?';

  @override
  String get moodDeleteDescription =>
      'Esta emoção será removida do teu histórico.';

  @override
  String get moodCancel => 'Cancelar';

  @override
  String get moodDelete => 'Eliminar';

  @override
  String moodRecordedCount(int count) {
    return '$count registos';
  }

  @override
  String get moodDeleteTooltip => 'Eliminar emoção';

  @override
  String get moodTapHint => 'Toca numa emoção para a registar.';

  @override
  String moodHistoryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count emoções registadas',
      one: '1 emoção registada',
      zero: 'Nenhuma emoção registada',
    );
    return '$_temp0';
  }

  @override
  String get moodEmptyTitle => 'A tua história emocional começa aqui.';

  @override
  String get moodEmptyDescription =>
      'Regista uma emoção para começares a descobrir os teus padrões.';

  @override
  String get statisticsTitle => 'ESTATÍSTICAS';

  @override
  String get statisticsSubtitle => 'A tua vida vista através dos números.';

  @override
  String get statisticsOverview => 'A tua vida num relance';

  @override
  String get statisticsAllTime => 'TOTAL';

  @override
  String get statisticsThisMonth => 'ESTE MÊS';

  @override
  String get statisticsLast7 => 'ÚLTIMOS 7 DIAS';

  @override
  String get statisticsToday => 'HOJE';

  @override
  String get statisticsTotalMoments => 'Total de momentos';

  @override
  String get statisticsMomentsRecorded => 'Momentos registados';

  @override
  String get statisticsMomentsToday => 'Momentos de hoje';

  @override
  String get statisticsMoments => 'MOMENTOS';

  @override
  String get statisticsMomentsHint =>
      'Desliza para explorar os teus padrões de atividade.';

  @override
  String get statisticsEmptyMoments => 'Ainda não há momentos registados.';

  @override
  String get statisticsEmptyMomentWeekdays =>
      'Regista momentos para descobrires as tuas atividades por dia da semana.';

  @override
  String get statisticsEmptyMomentMonths =>
      'Regista momentos para descobrires as tuas atividades por mês.';

  @override
  String get statisticsFeelingsHint =>
      'As emoções que registaste independentemente dos momentos.';

  @override
  String get statisticsFeelingsRecorded => 'Emoções registadas';

  @override
  String get statisticsFeelingsToday => 'Emoções de hoje';

  @override
  String get statisticsFeelingsMonth => 'Emoções deste mês';

  @override
  String get statisticsEmptyFeelings =>
      'Regista a primeira emoção para veres os teus padrões emocionais.';

  @override
  String get statisticsEmptyFeelingWeekdays =>
      'Regista emoções para descobrires a distribuição semanal.';

  @override
  String get statisticsEmptyFeelingMonths =>
      'Regista emoções para descobrires a distribuição mensal.';

  @override
  String get statisticsMomentsFeelings => 'MOMENTOS E EMOÇÕES';

  @override
  String get statisticsInsightHint =>
      'Padrões encontrados nos teus momentos e emoções.';

  @override
  String get statisticsInsufficientTitle =>
      'Os teus padrões estão a ganhar forma.';

  @override
  String get statisticsInsufficientMessage =>
      'Regista momentos e emoções em mais dias para identificar padrões no mesmo dia. Não tiramos conclusões com poucos dados.';

  @override
  String get statisticsPreviousChart => 'Gráfico anterior';

  @override
  String get statisticsNextChart => 'Gráfico seguinte';

  @override
  String get statisticsCompareHint =>
      'Seleciona uma ou mais opções para comparar. Toca num dia ou mês para ver detalhes.';

  @override
  String get statisticsTop3 => 'Top 3';

  @override
  String get statisticsEmptyPeriod => 'Sem registos neste período.';

  @override
  String get statisticsBreakdown => 'Distribuição';

  @override
  String get statisticsWeekdays => 'Dias da semana';

  @override
  String get statisticsOverTime => 'Ao longo do tempo';

  @override
  String get statisticsMon => 'Seg';

  @override
  String get statisticsTue => 'Ter';

  @override
  String get statisticsWed => 'Qua';

  @override
  String get statisticsThu => 'Qui';

  @override
  String get statisticsFri => 'Sex';

  @override
  String get statisticsSat => 'Sáb';

  @override
  String get statisticsSun => 'Dom';

  @override
  String statisticsPeriodCount(String period, int count) {
    return '$period · $count registos';
  }

  @override
  String statisticsMonthsShort(int count) {
    return '${count}M';
  }

  @override
  String get activityCoffee => 'Café';

  @override
  String get activityShopping => 'Compras';

  @override
  String get activityReading => 'Leitura';

  @override
  String get activitySport => 'Desporto';

  @override
  String get activityGaming => 'Videojogos';

  @override
  String get activityMeditation => 'Meditação';

  @override
  String get activityRestaurant => 'Restaurante';

  @override
  String get activityCinema => 'TV / Cinema';

  @override
  String get activityWalking => 'Caminhada';

  @override
  String get activitySocial => 'Vida social';

  @override
  String get categoryConsumption => 'Consumo';

  @override
  String get categoryExperiences => 'Experiências';

  @override
  String get categoryHobbies => 'Passatempos';

  @override
  String get categoryWellness => 'Bem-estar';

  @override
  String get categorySocial => 'Vida social';

  @override
  String get categoryFitness => 'Atividade física';

  @override
  String get weekdayMonday => 'segunda-feira';

  @override
  String get weekdayTuesday => 'terça-feira';

  @override
  String get weekdayWednesday => 'quarta-feira';

  @override
  String get weekdayThursday => 'quinta-feira';

  @override
  String get weekdayFriday => 'sexta-feira';

  @override
  String get weekdaySaturday => 'sábado';

  @override
  String get weekdaySunday => 'domingo';

  @override
  String get highlightStartTitle => 'A tua história começa aqui';

  @override
  String get highlightStartMessage =>
      'Regista o teu primeiro momento para começares a descobrir os teus padrões.';

  @override
  String get highlightTopTitle => 'A tua atividade mais frequente';

  @override
  String highlightTopMessage(String activity, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registos',
      one: 'registo',
    );
    return '$activity lidera os registos deste mês, com $count $_temp0.';
  }

  @override
  String get highlightTieTitle => 'Um primeiro lugar partilhado';

  @override
  String highlightTieMessage(String activities, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registos',
      one: 'registo',
    );
    return '$activities estão empatadas este mês, com $count $_temp0 cada.';
  }

  @override
  String highlightMultipleTieMessage(int activitiesCount, int count) {
    return '$activitiesCount atividades partilham o primeiro lugar este mês, com $count registos cada.';
  }

  @override
  String get highlightVarietyTitle => 'Um pouco de variedade';

  @override
  String highlightVarietyMessage(int activitiesCount, int momentsCount) {
    return 'Registaste $activitiesCount atividades diferentes este mês, num total de $momentsCount momentos.';
  }

  @override
  String get highlightWeekdayTitle => 'O teu dia com mais registos';

  @override
  String highlightWeekdayMessage(String day, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registos',
      one: 'registo',
    );
    return '$day é o dia com mais momentos registados até agora, com $count $_temp0.';
  }

  @override
  String get highlightMoreTitle => 'Mais momentos registados';

  @override
  String highlightMoreMessage(int currentCount, int previousCount) {
    return 'Registaste $currentCount momentos nos últimos 7 dias, face a $previousCount nos 7 dias anteriores.';
  }

  @override
  String get highlightRecentTitle => 'A tua atividade recente';

  @override
  String highlightRecentMessage(int currentCount, int previousCount) {
    return 'Registaste $currentCount momentos nos últimos 7 dias, face a $previousCount nos 7 dias anteriores.';
  }

  @override
  String get highlightMilestoneTitle => 'Uma conquista pessoal';

  @override
  String highlightMilestoneMessage(int count) {
    return 'Ultrapassaste os $count momentos registados. A tua história continua a crescer, momento a momento.';
  }

  @override
  String get highlightGrowingTitle => 'A tua história está a crescer';

  @override
  String highlightGrowingMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'momentos',
      one: 'momento',
    );
    return 'Já registaste $count $_temp0. Continua a construir a tua linha do tempo.';
  }

  @override
  String get dashboardHighlightsLifeLabel => 'A TUA VIDA EM NÚMEROS';

  @override
  String dashboardHighlightsFactLabel(String activity) {
    return 'SABIAS QUE? · $activity';
  }

  @override
  String dashboardHighlightSource(String source) {
    return 'Fonte: $source';
  }

  @override
  String get factWalking01Title => 'Cada passo conta';

  @override
  String get factWalking01Message =>
      'Não precisas de um treino perfeito para beneficiar do movimento. A Organização Mundial da Saúde salienta que alguma atividade física é melhor do que nenhuma, e caminhar é uma forma de te manteres ativo.';

  @override
  String get factWalking02Title => 'Começar devagar também conta';

  @override
  String get factWalking02Message =>
      'Quem é fisicamente inativo pode começar com pequenas quantidades de atividade e aumentar gradualmente a duração e a intensidade. A consistência pode começar com algo simples.';

  @override
  String get factSocial01Title => 'As ligações fazem a diferença';

  @override
  String get factSocial01Message =>
      'As relações sociais de apoio estão associadas a uma melhor saúde física e mental. Sentir ligação aos outros é importante para o bem-estar.';

  @override
  String get factSocial02Title => 'As pequenas ligações contam';

  @override
  String get factSocial02Message =>
      'As relações significativas nem sempre exigem grandes planos. Pequenos gestos, como perguntar a alguém como está, podem fortalecer as relações.';

  @override
  String get manageTitle => 'Gerir atividades';

  @override
  String get manageNewActivity => 'Nova atividade';

  @override
  String get manageEditActivity => 'Editar atividade';

  @override
  String get manageActivityName => 'Nome da atividade';

  @override
  String get manageCategory => 'Categoria';

  @override
  String get manageCancel => 'Cancelar';

  @override
  String get manageSave => 'Guardar';

  @override
  String get manageDescription =>
      'Escolhe o que queres registar. As atividades desativadas mantêm o seu histórico.';

  @override
  String get manageLoadError => 'Não foi possível carregar as atividades.';

  @override
  String get manageCreated => 'Atividade criada.';

  @override
  String get manageUpdated => 'Atividade atualizada.';

  @override
  String get manageSaveError => 'Não foi possível guardar a atividade.';

  @override
  String get navHome => 'Início';

  @override
  String get navAdd => 'Adicionar';

  @override
  String get navMood => 'Emoções';

  @override
  String get navStatistics => 'Estatísticas';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get welcomeHello => 'Olá!';

  @override
  String get welcomeTitle => 'Boas-vindas à Life in Numbers.';

  @override
  String get welcomeDescription =>
      'Cada pequeno momento conta.\nVamos tornar este espaço teu.';

  @override
  String get welcomeNameHint => 'Como te devemos chamar?';

  @override
  String get welcomeContinue => 'Continuar';

  @override
  String get welcomeNameRequired => 'Introduz o teu nome.';

  @override
  String get welcomeSaveError =>
      'Não foi possível guardar o teu nome. Tenta novamente.';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDescription =>
      'Escolhe o idioma da Life in Numbers.';

  @override
  String get settingsSystemDefault => 'Automático (Sistema)';

  @override
  String get dashboardGoodMorning => 'Bom dia';

  @override
  String get dashboardGoodAfternoon => 'Boa tarde';

  @override
  String get dashboardGoodEvening => 'Boa noite';

  @override
  String get dashboardSubtitle =>
      'Os teus momentos. As tuas emoções. A tua história.';

  @override
  String dashboardMomentsRecorded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'momentos registados',
      one: 'momento registado',
    );
    return '$_temp0';
  }

  @override
  String get dashboardActivitiesTracked => 'Atividades acompanhadas';

  @override
  String get dashboardAllTimeMoments => 'Momentos no total';

  @override
  String get dashboardFeelingsThisMonth => 'Emoções este mês';

  @override
  String get dashboardAllTimeFeelings => 'Emoções no total';

  @override
  String get dashboardYourActivities => 'AS TUAS ATIVIDADES';

  @override
  String get dashboardYourFeelings => 'AS TUAS EMOÇÕES';

  @override
  String get dashboardSeeAll => 'Ver tudo';

  @override
  String get dashboardActivitiesSubtitle => 'Um toque. Mais um momento.';

  @override
  String get dashboardFeelingsSubtitle => 'Um pequeno momento para ti.';

  @override
  String get dashboardNoFeelings =>
      'Ainda não registaste emoções. Toca em «Ver tudo» para registares a primeira.';

  @override
  String get dashboardHighlights => 'DESTAQUES';

  @override
  String dashboardSource(String source) {
    return 'Fonte: $source';
  }

  @override
  String get dashboardPreviousHighlight => 'Destaque anterior';

  @override
  String get dashboardNextHighlight => 'Destaque seguinte';

  @override
  String dashboardRecorded(int count) {
    return '$count registados';
  }

  @override
  String get dashboardManageMoments => 'Gerir momentos registados';

  @override
  String get dashboardNoActivities =>
      'Ainda não registaste momentos. Toca em «Ver tudo» para registares a primeira atividade.';

  @override
  String get dashboardLifeInNumbersLabel => 'A TUA VIDA EM NÚMEROS';

  @override
  String dashboardDidYouKnow(String activity) {
    return 'SABIAS QUE? · $activity';
  }

  @override
  String get dashboardEmotionJoy => 'Alegria';

  @override
  String get dashboardEmotionHappiness => 'Felicidade';

  @override
  String get dashboardEmotionSadness => 'Tristeza';

  @override
  String get dashboardEmotionAnger => 'Raiva';

  @override
  String get dashboardEmotionFear => 'Medo';

  @override
  String get dashboardEmotionDisgust => 'Nojo';

  @override
  String get dashboardEmotionSurprise => 'Surpresa';

  @override
  String get addMomentTitle => 'ADICIONAR UM MOMENTO';

  @override
  String get addMomentSubtitle => 'O que tens feito?';

  @override
  String get addSearchHint => 'Pesquisar atividades...';

  @override
  String get addAllCategories => 'Todas';

  @override
  String addActivityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atividades · Toca para registar',
      one: '1 atividade · Toca para registar',
      zero: 'Sem atividades · Toca para registar',
    );
    return '$_temp0';
  }

  @override
  String get addClosingMessage =>
      'Cada pequeno momento faz parte da tua história.';

  @override
  String get addNothingFound => 'Nenhum resultado.';

  @override
  String get addStoryStartsHere => 'A tua história começa aqui.';

  @override
  String get addTryAnotherSearch => 'Experimenta outra pesquisa ou categoria.';

  @override
  String get addNoActivitiesAvailable =>
      'Não existem atividades disponíveis neste momento.';

  @override
  String get moodTitle => 'REGISTAR UMA EMOÇÃO';

  @override
  String get moodSubtitle => 'Como te sentes neste momento?';

  @override
  String moodFeelingRecorded(String name) {
    return '$name registada';
  }

  @override
  String get moodUndo => 'ANULAR';

  @override
  String get moodDeleteTitle => 'Eliminar esta emoção?';

  @override
  String get moodDeleteDescription =>
      'Esta emoção será removida do teu histórico.';

  @override
  String get moodCancel => 'Cancelar';

  @override
  String get moodDelete => 'Eliminar';

  @override
  String moodRecordedCount(int count) {
    return '$count registos';
  }

  @override
  String get moodDeleteTooltip => 'Eliminar emoção';

  @override
  String get moodTapHint => 'Toca numa emoção para a registar.';

  @override
  String moodHistoryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count emoções registadas',
      one: '1 emoção registada',
      zero: 'Nenhuma emoção registada',
    );
    return '$_temp0';
  }

  @override
  String get moodEmptyTitle => 'A tua história emocional começa aqui.';

  @override
  String get moodEmptyDescription =>
      'Regista uma emoção para começares a descobrir os teus padrões.';

  @override
  String get statisticsTitle => 'ESTATÍSTICAS';

  @override
  String get statisticsSubtitle => 'A tua vida vista através dos números.';

  @override
  String get statisticsOverview => 'A tua vida num relance';

  @override
  String get statisticsAllTime => 'TOTAL';

  @override
  String get statisticsThisMonth => 'ESTE MÊS';

  @override
  String get statisticsLast7 => 'ÚLTIMOS 7 DIAS';

  @override
  String get statisticsToday => 'HOJE';

  @override
  String get statisticsTotalMoments => 'Total de momentos';

  @override
  String get statisticsMomentsRecorded => 'Momentos registados';

  @override
  String get statisticsMomentsToday => 'Momentos de hoje';

  @override
  String get statisticsMoments => 'MOMENTOS';

  @override
  String get statisticsMomentsHint =>
      'Desliza para explorar os teus padrões de atividade.';

  @override
  String get statisticsEmptyMoments => 'Ainda não há momentos registados.';

  @override
  String get statisticsEmptyMomentWeekdays =>
      'Regista momentos para descobrires as tuas atividades por dia da semana.';

  @override
  String get statisticsEmptyMomentMonths =>
      'Regista momentos para descobrires as tuas atividades por mês.';

  @override
  String get statisticsFeelingsHint =>
      'As emoções que registaste independentemente dos momentos.';

  @override
  String get statisticsFeelingsRecorded => 'Emoções registadas';

  @override
  String get statisticsFeelingsToday => 'Emoções de hoje';

  @override
  String get statisticsFeelingsMonth => 'Emoções deste mês';

  @override
  String get statisticsEmptyFeelings =>
      'Regista a primeira emoção para veres os teus padrões emocionais.';

  @override
  String get statisticsEmptyFeelingWeekdays =>
      'Regista emoções para descobrires a distribuição semanal.';

  @override
  String get statisticsEmptyFeelingMonths =>
      'Regista emoções para descobrires a distribuição mensal.';

  @override
  String get statisticsMomentsFeelings => 'MOMENTOS E EMOÇÕES';

  @override
  String get statisticsInsightHint =>
      'Padrões encontrados nos teus momentos e emoções.';

  @override
  String get statisticsInsufficientTitle =>
      'Os teus padrões estão a ganhar forma.';

  @override
  String get statisticsInsufficientMessage =>
      'Regista momentos e emoções em mais dias para identificar padrões no mesmo dia. Não tiramos conclusões com poucos dados.';

  @override
  String get statisticsPreviousChart => 'Gráfico anterior';

  @override
  String get statisticsNextChart => 'Gráfico seguinte';

  @override
  String get statisticsCompareHint =>
      'Seleciona uma ou mais opções para comparar. Toca num dia ou mês para ver detalhes.';

  @override
  String get statisticsTop3 => 'Top 3';

  @override
  String get statisticsEmptyPeriod => 'Sem registos neste período.';

  @override
  String get statisticsBreakdown => 'Distribuição';

  @override
  String get statisticsWeekdays => 'Dias da semana';

  @override
  String get statisticsOverTime => 'Ao longo do tempo';

  @override
  String get statisticsMon => 'Seg';

  @override
  String get statisticsTue => 'Ter';

  @override
  String get statisticsWed => 'Qua';

  @override
  String get statisticsThu => 'Qui';

  @override
  String get statisticsFri => 'Sex';

  @override
  String get statisticsSat => 'Sáb';

  @override
  String get statisticsSun => 'Dom';

  @override
  String statisticsPeriodCount(String period, int count) {
    return '$period · $count registos';
  }

  @override
  String statisticsMonthsShort(int count) {
    return '${count}M';
  }

  @override
  String get activityCoffee => 'Café';

  @override
  String get activityShopping => 'Compras';

  @override
  String get activityReading => 'Leitura';

  @override
  String get activitySport => 'Desporto';

  @override
  String get activityGaming => 'Videojogos';

  @override
  String get activityMeditation => 'Meditação';

  @override
  String get activityRestaurant => 'Restaurante';

  @override
  String get activityCinema => 'TV / Cinema';

  @override
  String get activityWalking => 'Caminhada';

  @override
  String get activitySocial => 'Vida social';

  @override
  String get categoryConsumption => 'Consumo';

  @override
  String get categoryExperiences => 'Experiências';

  @override
  String get categoryHobbies => 'Passatempos';

  @override
  String get categoryWellness => 'Bem-estar';

  @override
  String get categorySocial => 'Vida social';

  @override
  String get categoryFitness => 'Atividade física';

  @override
  String get weekdayMonday => 'segunda-feira';

  @override
  String get weekdayTuesday => 'terça-feira';

  @override
  String get weekdayWednesday => 'quarta-feira';

  @override
  String get weekdayThursday => 'quinta-feira';

  @override
  String get weekdayFriday => 'sexta-feira';

  @override
  String get weekdaySaturday => 'sábado';

  @override
  String get weekdaySunday => 'domingo';

  @override
  String get highlightStartTitle => 'A tua história começa aqui';

  @override
  String get highlightStartMessage =>
      'Regista o teu primeiro momento para começares a descobrir os teus padrões.';

  @override
  String get highlightTopTitle => 'A tua atividade mais frequente';

  @override
  String highlightTopMessage(String activity, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registos',
      one: 'registo',
    );
    return '$activity lidera os registos deste mês, com $count $_temp0.';
  }

  @override
  String get highlightTieTitle => 'Um primeiro lugar partilhado';

  @override
  String highlightTieMessage(String activities, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registos',
      one: 'registo',
    );
    return '$activities estão empatadas este mês, com $count $_temp0 cada.';
  }

  @override
  String highlightMultipleTieMessage(int activitiesCount, int count) {
    return '$activitiesCount atividades partilham o primeiro lugar este mês, com $count registos cada.';
  }

  @override
  String get highlightVarietyTitle => 'Um pouco de variedade';

  @override
  String highlightVarietyMessage(int activitiesCount, int momentsCount) {
    return 'Registaste $activitiesCount atividades diferentes este mês, num total de $momentsCount momentos.';
  }

  @override
  String get highlightWeekdayTitle => 'O teu dia com mais registos';

  @override
  String highlightWeekdayMessage(String day, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'registos',
      one: 'registo',
    );
    return '$day é o dia com mais momentos registados até agora, com $count $_temp0.';
  }

  @override
  String get highlightMoreTitle => 'Mais momentos registados';

  @override
  String highlightMoreMessage(int currentCount, int previousCount) {
    return 'Registaste $currentCount momentos nos últimos 7 dias, face a $previousCount nos 7 dias anteriores.';
  }

  @override
  String get highlightRecentTitle => 'A tua atividade recente';

  @override
  String highlightRecentMessage(int currentCount, int previousCount) {
    return 'Registaste $currentCount momentos nos últimos 7 dias, face a $previousCount nos 7 dias anteriores.';
  }

  @override
  String get highlightMilestoneTitle => 'Uma conquista pessoal';

  @override
  String highlightMilestoneMessage(int count) {
    return 'Ultrapassaste os $count momentos registados. A tua história continua a crescer, momento a momento.';
  }

  @override
  String get highlightGrowingTitle => 'A tua história está a crescer';

  @override
  String highlightGrowingMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'momentos',
      one: 'momento',
    );
    return 'Já registaste $count $_temp0. Continua a construir a tua linha do tempo.';
  }

  @override
  String get dashboardHighlightsLifeLabel => 'A TUA VIDA EM NÚMEROS';

  @override
  String dashboardHighlightsFactLabel(String activity) {
    return 'SABIAS QUE? · $activity';
  }

  @override
  String dashboardHighlightSource(String source) {
    return 'Fonte: $source';
  }

  @override
  String get factWalking01Title => 'Cada passo conta';

  @override
  String get factWalking01Message =>
      'Não precisas de um treino perfeito para beneficiar do movimento. A Organização Mundial da Saúde salienta que alguma atividade física é melhor do que nenhuma, e caminhar é uma forma de te manteres ativo.';

  @override
  String get factWalking02Title => 'Começar devagar também conta';

  @override
  String get factWalking02Message =>
      'Quem é fisicamente inativo pode começar com pequenas quantidades de atividade e aumentar gradualmente a duração e a intensidade. A consistência pode começar com algo simples.';

  @override
  String get factSocial01Title => 'As ligações fazem a diferença';

  @override
  String get factSocial01Message =>
      'As relações sociais de apoio estão associadas a uma melhor saúde física e mental. Sentir ligação aos outros é importante para o bem-estar.';

  @override
  String get factSocial02Title => 'As pequenas ligações contam';

  @override
  String get factSocial02Message =>
      'As relações significativas nem sempre exigem grandes planos. Pequenos gestos, como perguntar a alguém como está, podem fortalecer as relações.';

  @override
  String get manageTitle => 'Gerir atividades';

  @override
  String get manageNewActivity => 'Nova atividade';

  @override
  String get manageEditActivity => 'Editar atividade';

  @override
  String get manageActivityName => 'Nome da atividade';

  @override
  String get manageCategory => 'Categoria';

  @override
  String get manageCancel => 'Cancelar';

  @override
  String get manageSave => 'Guardar';

  @override
  String get manageDescription =>
      'Escolhe o que queres registar. As atividades desativadas mantêm o seu histórico.';

  @override
  String get manageLoadError => 'Não foi possível carregar as atividades.';

  @override
  String get manageCreated => 'Atividade criada.';

  @override
  String get manageUpdated => 'Atividade atualizada.';

  @override
  String get manageSaveError => 'Não foi possível guardar a atividade.';

  @override
  String get navHome => 'Início';

  @override
  String get navAdd => 'Adicionar';

  @override
  String get navMood => 'Emoções';

  @override
  String get navStatistics => 'Estatísticas';
}
