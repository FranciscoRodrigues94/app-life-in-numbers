import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_in_numbers/l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';
import '../models/default_emotions.dart';
import '../models/life_activity.dart';
import '../models/life_event.dart';
import '../models/life_mood_entry.dart';
import '../services/statistics_service.dart';
import '../services/statistics_insights_service.dart';
import '../services/display_name_service.dart';

class StatisticsPage extends StatefulWidget {
  final List<LifeEvent> events;
  final List<LifeActivity> activities;
  final List<LifeMoodEntry> feelings;

  const StatisticsPage({
    super.key,
    required this.events,
    required this.activities,
    this.feelings = const [],
  });

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final PageController _momentsController = PageController();
  final PageController _feelingsController = PageController();
  final PageStorageBucket _chartPageStorage = PageStorageBucket();
  int _momentsPage = 0;
  int _feelingsPage = 0;
  int _momentWeekdaySelection = 0;
  int _momentMonthSelection = 0;
  int _feelingWeekdaySelection = 0;
  int _feelingMonthSelection = 0;
  int _momentMonths = 6;
  int _feelingMonths = 6;
  Set<String> _momentChartFilters = <String>{};
  Set<String> _feelingChartFilters = <String>{};

  static const List<Color> _activityColors = [
    AppColors.accent,
    Color(0xFF7296BD),
    Color(0xFFD79F86),
    Color(0xFFA59CBF),
    Color(0xFFB3A17C),
    Color(0xFF78B6B1),
    Color(0xFFB889AD),
    Color(0xFFE0BA69),
    Color(0xFF7D9F8A),
    Color(0xFF9FA9CE),
  ];
  static const Map<String, Color> _feelingColors = {
    'happiness': Color(0xFFF0C963),
    'joy': Color(0xFFF0C963),
    'sadness': Color(0xFF89B6DB),
    'anger': Color(0xFFD89082),
    'fear': Color(0xFFB8A3D5),
    'disgust': Color(0xFF9FBF85),
    'surprise': Color(0xFF88C5C9),
  };

  @override
  void dispose() {
    _momentsController.dispose();
    _feelingsController.dispose();
    super.dispose();
  }

  String _translatedEmotion(AppLocalizations l10n, String id, String fallback) {
    switch (id) {
      case 'joy': return l10n.dashboardEmotionJoy;
      case 'happiness': return l10n.dashboardEmotionHappiness;
      case 'sadness': return l10n.dashboardEmotionSadness;
      case 'anger': return l10n.dashboardEmotionAnger;
      case 'fear': return l10n.dashboardEmotionFear;
      case 'disgust': return l10n.dashboardEmotionDisgust;
      case 'surprise': return l10n.dashboardEmotionSurprise;
      default: return fallback;
    }
  }

  String _activityName(String id) {
    final l10n = AppLocalizations.of(context)!;
    for (final activity in widget.activities) {
      if (activity.id == id) return DisplayNameService.activity(activity, l10n);
    }
    return id;
  }

  String _monthLabel(DateTime date, String locale) => DateFormat('MMM yy', locale).format(date);

  Color _activityColor(String id, List<String> ids) => _activityColors[ids.indexOf(id) % _activityColors.length];
  Color _emotionColor(String id) => _feelingColors[id] ?? AppColors.accent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    const statistics = StatisticsService();
    final now = DateTime.now();
    final total = statistics.totalEvents(widget.events);
    final today = statistics.totalToday(widget.events, now: now);
    final thisMonth = statistics.totalThisMonth(widget.events, now: now);
    final start7 = DateTime(now.year, now.month, now.day - 6);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final last7 = widget.events.where((event) {
      final date = event.occurredAt.toLocal();
      return !date.isBefore(start7) && date.isBefore(tomorrow);
    }).length;

    final activityCounts = statistics.eventsByActivity(widget.events);
    final sortedActivities = activityCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value) != 0 ? b.value.compareTo(a.value) : a.key.compareTo(b.key));
    final activityIds = <String>{
      ...widget.activities.map((activity) => activity.id),
      ...widget.events.map((event) => event.activityId),
    }.toList();
    final activityNames = {for (final id in activityIds) id: _activityName(id)};

    final feelingCounts = <String, int>{};
    for (final entry in widget.feelings) {
      feelingCounts.update(entry.primaryEmotionId, (value) => value + 1, ifAbsent: () => 1);
    }
    final emotionIds = <String>{
      ...DefaultEmotions.primary.map((emotion) => emotion.id),
      ...widget.feelings.map((entry) => entry.primaryEmotionId),
    }.toList();
    final emotionNames = {
      for (final emotion in DefaultEmotions.primary) emotion.id: _translatedEmotion(l10n, emotion.id, emotion.name),
      for (final id in emotionIds)
        if (!DefaultEmotions.primary.any((emotion) => emotion.id == id)) id: id,
    };
    final feelingsToday = widget.feelings.where((entry) {
      final date = entry.occurredAt.toLocal();
      return date.year == now.year && date.month == now.month && date.day == now.day;
    }).length;
    final feelingsMonth = widget.feelings.where((entry) {
      final date = entry.occurredAt.toLocal();
      return date.year == now.year && date.month == now.month;
    }).length;

    final momentWeekdays = List.generate(7, (_) => <String, int>{});
    final feelingWeekdays = List.generate(7, (_) => <String, int>{});
    for (final event in widget.events) {
      final group = momentWeekdays[event.occurredAt.toLocal().weekday - 1];
      group.update(event.activityId, (value) => value + 1, ifAbsent: () => 1);
    }
    for (final entry in widget.feelings) {
      final group = feelingWeekdays[entry.occurredAt.toLocal().weekday - 1];
      group.update(entry.primaryEmotionId, (value) => value + 1, ifAbsent: () => 1);
    }

    ({List<String> labels, List<Map<String, int>> groups}) monthlyGroups(int months, bool feelings) {
      final starts = List.generate(months, (i) => DateTime(now.year, now.month - months + i + 1));
      final groups = List.generate(months, (_) => <String, int>{});
      final first = starts.first;
      if (feelings) {
        for (final entry in widget.feelings) {
          final date = entry.occurredAt.toLocal();
          final index = (date.year - first.year) * 12 + date.month - first.month;
          if (index >= 0 && index < months) {
            groups[index].update(entry.primaryEmotionId, (value) => value + 1, ifAbsent: () => 1);
          }
        }
      } else {
        for (final event in widget.events) {
          final date = event.occurredAt.toLocal();
          final index = (date.year - first.year) * 12 + date.month - first.month;
          if (index >= 0 && index < months) {
            groups[index].update(event.activityId, (value) => value + 1, ifAbsent: () => 1);
          }
        }
      }
      return (labels: starts.map((date) => _monthLabel(date, locale)).toList(), groups: groups);
    }

    final momentMonthly = monthlyGroups(_momentMonths, false);
    final feelingMonthly = monthlyGroups(_feelingMonths, true);
    final insights = const StatisticsInsightsService().generate(
      events: widget.events,
      feelings: widget.feelings,
      activities: widget.activities,
    );

    return ListView(
      key: const Key('statistics_page'),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        LayoutBuilder(builder: (context, constraints) {
          final mascotSize = (constraints.maxWidth * 0.38).clamp(105.0, 155.0);
          return SizedBox(
            height: math.max(190.0, mascotSize + 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: mascotSize - 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LIFE IN NUMBERS', style: AppTypography.caption.copyWith(
                        color: AppColors.accent, letterSpacing: 2.5, fontWeight: FontWeight.w800,
                      )),
                      const SizedBox(height: 12),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(l10n.statisticsTitle,
                          style: AppTypography.section.copyWith(fontSize: 39, height: 1.05)),
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.statisticsSubtitle,
                        style: AppTypography.body.copyWith(color: AppColors.mutedText)),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/mascot/mascot_stats.png',
                    width: mascotSize,
                    height: mascotSize,
                    fit: BoxFit.contain,
                    semanticLabel: 'Statistics mascot',
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 30),
        Text(l10n.statisticsOverview, style: AppTypography.hero.copyWith(fontSize: 27)),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (context, constraints) {
          const spacing = 12.0;
          final columns = constraints.maxWidth >= 650 ? 4 : 2;
          final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
          return Wrap(spacing: spacing, runSpacing: spacing, children: [
            SizedBox(width: width, child: _metricCard(key: const Key('statistics_total_card'), label: l10n.statisticsAllTime,
              value: '$total', description: l10n.statisticsTotalMoments, icon: Icons.auto_awesome_rounded, background: AppColors.navy, dark: true)),
            SizedBox(width: width, child: _metricCard(key: const Key('statistics_month_card'), label: l10n.statisticsThisMonth,
              value: '$thisMonth', description: l10n.statisticsMomentsRecorded, icon: Icons.calendar_today_outlined, background: AppColors.sky)),
            SizedBox(width: width, child: _metricCard(key: const Key('statistics_last7_card'), label: l10n.statisticsLast7,
              value: '$last7', description: l10n.statisticsMomentsRecorded, icon: Icons.date_range_rounded, background: AppColors.peach)),
            SizedBox(width: width, child: _metricCard(key: const Key('statistics_today_card'), label: l10n.statisticsToday,
              value: '$today', description: l10n.statisticsMomentsToday, icon: Icons.wb_sunny_outlined, background: AppColors.sage)),
          ]);
        }),
        const SizedBox(height: 34),
        Text(l10n.statisticsMoments, style: AppTypography.section.copyWith(fontSize: 25)),
        const SizedBox(height: 8),
        Text(l10n.statisticsMomentsHint, style: AppTypography.caption),
        const SizedBox(height: 16),
        _chartCarousel(storageId: 'moments_carousel', controller: _momentsController, selectedPage: _momentsPage,
          labels: [l10n.statisticsBreakdown, l10n.statisticsWeekdays, l10n.statisticsOverTime],
          onPageChanged: (index) => setState(() => _momentsPage = index),
          children: [
            Container(key: const Key('statistics_breakdown'), padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
              child: sortedActivities.isEmpty ? _emptyText(l10n.statisticsEmptyMoments) : Column(children: [
                for (var i = 0; i < sortedActivities.length; i++) ...[
                  _progressRow(label: _activityName(sortedActivities[i].key), count: sortedActivities[i].value,
                    total: total, color: _activityColor(sortedActivities[i].key, activityIds)),
                  if (i < sortedActivities.length - 1) const SizedBox(height: 20),
                ],
              ])),
            _verticalCompositionCard(key: const Key('statistics_weekday_breakdown'),
              labels: [l10n.statisticsMon, l10n.statisticsTue, l10n.statisticsWed, l10n.statisticsThu, l10n.statisticsFri, l10n.statisticsSat, l10n.statisticsSun], groups: momentWeekdays,
              ids: activityIds, names: activityNames, colorFor: (id) => _activityColor(id, activityIds),
              selectedIndex: _momentWeekdaySelection,
              selectedIds: _momentChartFilters, onSelectionChanged: (ids) => setState(() => _momentChartFilters = ids),
              onSelected: (index) => setState(() => _momentWeekdaySelection = index),
              emptyMessage: l10n.statisticsEmptyMomentWeekdays),
            _monthlyPanel(key: const Key('statistics_moments_monthly'), count: _momentMonths,
              onCountChanged: (count) => setState(() { _momentMonths = count; _momentMonthSelection = count - 1; }),
              chart: _verticalCompositionCard(labels: momentMonthly.labels, groups: momentMonthly.groups,
                ids: activityIds, names: activityNames, colorFor: (id) => _activityColor(id, activityIds),
                selectedIndex: _momentMonthSelection,
                selectedIds: _momentChartFilters, onSelectionChanged: (ids) => setState(() => _momentChartFilters = ids),
                onSelected: (index) => setState(() => _momentMonthSelection = index),
                emptyMessage: l10n.statisticsEmptyMomentMonths)),
          ]),
        const SizedBox(height: 34),
        Text(l10n.dashboardYourFeelings, style: AppTypography.section.copyWith(fontSize: 25)),
        const SizedBox(height: 8),
        Text(l10n.statisticsFeelingsHint, style: AppTypography.caption),
        const SizedBox(height: 18),
        LayoutBuilder(builder: (context, constraints) {
          const spacing = 12.0;
          final columns = constraints.maxWidth >= 650 ? 3 : 2;
          final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
          return Wrap(spacing: spacing, runSpacing: spacing, children: [
            SizedBox(width: width, child: _metricCard(key: const Key('statistics_feelings_total'), label: l10n.statisticsAllTime,
              value: '${widget.feelings.length}', description: l10n.statisticsFeelingsRecorded,
              icon: Icons.favorite_rounded, background: AppColors.peach)),
            SizedBox(width: width, child: _metricCard(key: const Key('statistics_feelings_today'), label: l10n.statisticsToday,
              value: '$feelingsToday', description: l10n.statisticsFeelingsToday, icon: Icons.today_rounded, background: AppColors.sage)),
            SizedBox(width: width, child: _metricCard(key: const Key('statistics_feelings_month'), label: l10n.statisticsThisMonth,
              value: '$feelingsMonth', description: l10n.statisticsFeelingsMonth, icon: Icons.calendar_month_rounded, background: AppColors.sky)),
          ]);
        }),
        const SizedBox(height: 28),
        _chartCarousel(storageId: 'feelings_carousel', controller: _feelingsController, selectedPage: _feelingsPage,
          labels: [l10n.statisticsBreakdown, l10n.statisticsWeekdays, l10n.statisticsOverTime],
          onPageChanged: (index) => setState(() => _feelingsPage = index),
          children: [
            Container(key: const Key('statistics_emotion_breakdown'), padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
              child: widget.feelings.isEmpty ? _emptyText(l10n.statisticsEmptyFeelings)
                  : Column(children: [
                      for (var i = 0; i < emotionIds.length; i++) ...[
                        _progressRow(label: emotionNames[emotionIds[i]] ?? emotionIds[i],
                          count: feelingCounts[emotionIds[i]] ?? 0, total: widget.feelings.length,
                          color: _emotionColor(emotionIds[i])),
                        if (i < emotionIds.length - 1) const SizedBox(height: 20),
                      ],
                    ])),
            _verticalCompositionCard(key: const Key('statistics_feelings_weekdays'),
              labels: [l10n.statisticsMon, l10n.statisticsTue, l10n.statisticsWed, l10n.statisticsThu, l10n.statisticsFri, l10n.statisticsSat, l10n.statisticsSun], groups: feelingWeekdays,
              ids: emotionIds, names: emotionNames, colorFor: _emotionColor,
              selectedIndex: _feelingWeekdaySelection,
              selectedIds: _feelingChartFilters, onSelectionChanged: (ids) => setState(() => _feelingChartFilters = ids),
              onSelected: (index) => setState(() => _feelingWeekdaySelection = index),
              emptyMessage: l10n.statisticsEmptyFeelingWeekdays),
            _monthlyPanel(key: const Key('statistics_feelings_monthly'), count: _feelingMonths,
              onCountChanged: (count) => setState(() { _feelingMonths = count; _feelingMonthSelection = count - 1; }),
              chart: _verticalCompositionCard(labels: feelingMonthly.labels, groups: feelingMonthly.groups,
                ids: emotionIds, names: emotionNames, colorFor: _emotionColor,
                selectedIndex: _feelingMonthSelection,
                selectedIds: _feelingChartFilters, onSelectionChanged: (ids) => setState(() => _feelingChartFilters = ids),
                onSelected: (index) => setState(() => _feelingMonthSelection = index),
                emptyMessage: l10n.statisticsEmptyFeelingMonths)),
          ]),
        const SizedBox(height: 34),
        Text(l10n.statisticsMomentsFeelings, style: AppTypography.section.copyWith(fontSize: 25)),
        const SizedBox(height: 8),
        Text(l10n.statisticsInsightHint, style: AppTypography.caption),
        const SizedBox(height: 14),
        if (insights.isEmpty)
          Container(
            key: const Key('statistics_highlight'),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(24)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.insights_rounded, color: AppColors.navy, size: 27),
              const SizedBox(height: 14),
              Text(l10n.statisticsInsufficientTitle, style: AppTypography.hero.copyWith(fontSize: 25)),
              const SizedBox(height: 8),
              Text(l10n.statisticsInsufficientMessage,
                style: AppTypography.body.copyWith(color: AppColors.mutedText, height: 1.5)),
            ]),
          )
        else
          for (var i = 0; i < insights.length; i++) ...[
            Container(
              key: i == 0 ? const Key('statistics_highlight') : Key('statistics_insight_$i'),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: [AppColors.sand, AppColors.sage, AppColors.sky][i % 3],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.insights_rounded, color: AppColors.navy, size: 27),
                const SizedBox(height: 14),
                Text(insights[i].label, style: AppTypography.caption.copyWith(
                  color: AppColors.accent, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
                const SizedBox(height: 8),
                Text(insights[i].title, style: AppTypography.hero.copyWith(fontSize: 27)),
                const SizedBox(height: 8),
                Text(insights[i].message, style: AppTypography.body.copyWith(
                  color: AppColors.mutedText, height: 1.5)),
              ]),
            ),
            if (i < insights.length - 1) const SizedBox(height: 12),
          ],
      ],
    );
  }

  Widget _chartCarousel({required String storageId, required PageController controller, required int selectedPage,
    required List<String> labels, required ValueChanged<int> onPageChanged, required List<Widget> children}) {
    final l10n = AppLocalizations.of(context)!;
    return Column(children: [
      Row(children: [
        IconButton(tooltip: l10n.statisticsPreviousChart, onPressed: selectedPage == 0 ? null : () => controller.animateToPage(
          selectedPage - 1, duration: const Duration(milliseconds: 260), curve: Curves.easeInOut),
          icon: const Icon(Icons.chevron_left_rounded)),
        Expanded(child: Text(labels[selectedPage], textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w800))),
        IconButton(tooltip: l10n.statisticsNextChart, onPressed: selectedPage == children.length - 1 ? null : () => controller.animateToPage(
          selectedPage + 1, duration: const Duration(milliseconds: 260), curve: Curves.easeInOut),
          icon: const Icon(Icons.chevron_right_rounded)),
      ]),
      const SizedBox(height: 8),
      SizedBox(
        height: 420,
        child: PageStorage(
          bucket: _chartPageStorage,
          child: PageView(
            key: PageStorageKey<String>(storageId),
            controller: controller,
            onPageChanged: onPageChanged,
            children: [
              for (var i = 0; i < children.length; i++)
                SingleChildScrollView(
                  key: PageStorageKey<String>('${storageId}_content_$i'),
                  primary: false,
                  child: children[i],
                ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (var i = 0; i < children.length; i++) AnimatedContainer(
          duration: const Duration(milliseconds: 180), margin: const EdgeInsets.symmetric(horizontal: 4),
          width: selectedPage == i ? 20 : 7, height: 7,
          decoration: BoxDecoration(color: selectedPage == i ? AppColors.navy : AppColors.mutedText.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10))),
      ]),
    ]);
  }

  Widget _monthlyPanel({required Key key, required int count, required ValueChanged<int> onCountChanged,
    required Widget chart}) {
    return Container(key: key, padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (final months in [3, 6, 12]) Padding(padding: const EdgeInsets.symmetric(horizontal: 3),
            child: ChoiceChip(label: Text(AppLocalizations.of(context)!.statisticsMonthsShort(months)), selected: count == months,
              onSelected: (_) => onCountChanged(months),
              selectedColor: AppColors.sage, labelStyle: AppTypography.caption.copyWith(color: AppColors.navy))),
        ]),
        const SizedBox(height: 12),
        chart,
      ]));
  }

  Widget _verticalCompositionCard({
    Key? key,
    required List<String> labels,
    required List<Map<String, int>> groups,
    required List<String> ids,
    required Map<String, String> names,
    required Color Function(String) colorFor,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
    required String emptyMessage,
    required Set<String> selectedIds,
    required ValueChanged<Set<String>> onSelectionChanged,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final totals = groups.map((group) => group.values.fold<int>(0, (a, b) => a + b)).toList();
    if (totals.every((total) => total == 0)) {
      return Container(key: key, padding: const EdgeInsets.all(16), child: _emptyText(emptyMessage));
    }
    final rankedIds = ids.where((id) => groups.any((group) => (group[id] ?? 0) > 0)).toList()
      ..sort((a, b) {
        final aTotal = groups.fold<int>(0, (sum, group) => sum + (group[a] ?? 0));
        final bTotal = groups.fold<int>(0, (sum, group) => sum + (group[b] ?? 0));
        final difference = bTotal.compareTo(aTotal);
        return difference != 0 ? difference : (names[a] ?? a).compareTo(names[b] ?? b);
      });
    // Empty selection shows the three most frequent series; otherwise show all selected series.
    final displayedIds = selectedIds.isEmpty
        ? rankedIds.take(3).toList()
        : rankedIds.where(selectedIds.contains).toList();
    final maxValue = math.max(1, groups.fold<int>(0, (max, group) {
      final groupMax = displayedIds.fold<int>(0, (current, id) => math.max(current, group[id] ?? 0));
      return math.max(max, groupMax);
    }));
    final safeIndex = selectedIndex.clamp(0, groups.length - 1);
    final selectedGroup = groups[safeIndex];
    const chartHeight = 158.0;
    final minGroupWidth = math.max(67.0, displayedIds.length * 23.0 + 14.0);

    return Container(
      key: key,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l10n.statisticsCompareHint,
          style: AppTypography.caption.copyWith(color: AppColors.mutedText)),
        const SizedBox(height: 9),
        // Filter chips support multiple selected activities or emotions.
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          Padding(padding: const EdgeInsets.only(right: 6), child: ChoiceChip(
            label: Text(l10n.statisticsTop3), selected: selectedIds.isEmpty,
            onSelected: (_) => onSelectionChanged(<String>{}),
            selectedColor: AppColors.sage,
            labelStyle: AppTypography.caption.copyWith(color: AppColors.navy))),
          for (final id in rankedIds) Padding(padding: const EdgeInsets.only(right: 6), child: ChoiceChip(
            label: Text(names[id] ?? id), selected: selectedIds.contains(id),
            onSelected: (_) {
              final next = Set<String>.of(selectedIds);
              if (!next.add(id)) next.remove(id);
              onSelectionChanged(next);
            },
            selectedColor: colorFor(id).withValues(alpha: 0.28),
            labelStyle: AppTypography.caption.copyWith(color: AppColors.navy))),
        ])),
        const SizedBox(height: 14),
        LayoutBuilder(builder: (context, constraints) {
          final width = math.max(constraints.maxWidth, groups.length * minGroupWidth);
          final groupWidth = width / groups.length;
          return SingleChildScrollView(scrollDirection: Axis.horizontal, child: SizedBox(
            width: width,
            height: chartHeight + 39,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              for (var i = 0; i < groups.length; i++) SizedBox(
                width: groupWidth,
                child: InkWell(
                  onTap: () => onSelected(i),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: Column(children: [
                    SizedBox(height: chartHeight, child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final id in displayedIds) Flexible(child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Tooltip(
                            message: '${names[id] ?? id}: ${groups[i][id] ?? 0}',
                            child: Container(
                              height: math.max(2.0, chartHeight * (groups[i][id] ?? 0) / maxValue),
                              decoration: BoxDecoration(
                                color: (groups[i][id] ?? 0) == 0
                                    ? const Color(0xFFEBEEF0)
                                    : colorFor(id),
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                                border: i == safeIndex ? Border.all(color: AppColors.navy.withValues(alpha: 0.3)) : null,
                              ),
                            ),
                          ),
                        )),
                      ],
                    )),
                    const SizedBox(height: 8),
                    SizedBox(height: 24, child: FittedBox(fit: BoxFit.scaleDown, child: Text(
                      labels[i], style: AppTypography.caption.copyWith(
                        fontWeight: i == safeIndex ? FontWeight.w800 : FontWeight.w500,
                        color: AppColors.navy,
                      ),
                    ))),
                  ])),
                ),
              ),
            ]),
          ));
        }),
        const SizedBox(height: 12),
        Text(l10n.statisticsPeriodCount(labels[safeIndex], totals[safeIndex]),
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        if (totals[safeIndex] == 0)
          Text(l10n.statisticsEmptyPeriod, style: AppTypography.caption)
        else
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final id in rankedIds)
              if ((selectedGroup[id] ?? 0) > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorFor(id).withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(10)),
                  child: Text('${names[id] ?? id} ${selectedGroup[id]}',
                    style: AppTypography.caption.copyWith(fontWeight: FontWeight.w700, color: AppColors.navy)),
                ),
          ]),
        const SizedBox(height: 10),
        Wrap(spacing: 9, runSpacing: 6, children: [
          for (final id in displayedIds) Row(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: colorFor(id), shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Text(names[id] ?? id, style: AppTypography.caption.copyWith(fontSize: 10)),
          ]),
        ]),
      ]),
    );
  }

  Widget _metricCard({required Key key, required String label, required String value,
    required String description, required IconData icon, required Color background, bool dark = false}) {
    final foreground = dark ? Colors.white : AppColors.navy;
    final secondary = dark ? const Color(0xFFBBCAD8) : AppColors.mutedText;
    return Container(key: key, height: 168, padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(22)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(color: secondary, fontSize: 10,
              fontWeight: FontWeight.w800, letterSpacing: 0.9))),
          Icon(icon, color: foreground, size: 19),
        ]),
        const Spacer(),
        FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
          child: Text(value, style: AppTypography.hero.copyWith(fontSize: 43, height: 1, color: foreground))),
        const SizedBox(height: 9),
        Text(description, maxLines: 2, overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(color: secondary, fontWeight: FontWeight.w600)),
      ]));
  }

  Widget _progressRow({required String label, required int count, required int total, required Color color}) {
    final percentage = total == 0 ? 0.0 : count / total;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w800))),
        const SizedBox(width: 8),
        Text('$count  ·  ${(percentage * 100).toStringAsFixed(1)}%', style: AppTypography.caption),
      ]),
      const SizedBox(height: 10),
      ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(
        value: percentage, minHeight: 10, backgroundColor: const Color(0xFFEBEEF0), color: color)),
    ]);
  }

  Widget _emptyText(String value) => Text(value,
    style: AppTypography.body.copyWith(color: AppColors.mutedText));
}
